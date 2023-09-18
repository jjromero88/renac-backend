using AutoMapper;
using PCM.RENAC.Application.Control.Base;
using PCM.RENAC.Application.Control.Util;
using PCM.RENAC.Application.Dto;
using PCM.RENAC.Application.Interface.Features;
using PCM.RENAC.Application.Interface.Persistence;
using PCM.RENAC.Application.Validator;
using PCM.RENAC.Domain.Entities;
using PCM.RENAC.Transversal.Common;

namespace PCM.RENAC.Application.Features
{
    public class AsientoCircunscripcionApplication : IAsientoCircunscripcionApplication
    {
        private readonly IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;
        private readonly IAppLogger<AsientoCircunscripcionApplication> _logger;
        private readonly AsientoCircunscripcionValidationManager _asientoCircunscripcionValidationManager;
        public string TokenSesion { get; set; }

        public AsientoCircunscripcionApplication(IUnitOfWork unitOfWork, IMapper mapper, IAppLogger<AsientoCircunscripcionApplication> logger, AsientoCircunscripcionValidationManager asientoCircunscripcionManager)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
            _logger = logger;
            _asientoCircunscripcionValidationManager = asientoCircunscripcionManager;
        }
        public Response<bool> Insert(Request<AsientoCircunscripcionDto> request)
        {
            var response = new Response<bool>();

            var validation = _asientoCircunscripcionValidationManager.Validate(_mapper.Map<AsientoCircunscripcionInsertRequest>(request.entidad));

            if (!validation.IsValid)
            {
                response.Message = Validation.InvalidMessage;
                response.Errors = validation.Errors;
                return response;
            }
            try
            {
                AsientoCircunscripcion entidad = _mapper.Map<AsientoCircunscripcion>(request.entidad);

                entidad.usuarioReg = string.IsNullOrEmpty(TokenSesion) ? AuthenticationMessage.DefaultUserId : BaseControl.IdUsuarioAuditoria(TokenSesion);
                entidad.activo = EstadosAuditoria.activo;

                var result = _unitOfWork.AsientoCircunscripcion.Insert(entidad);

                if (result.Error)
                {
                    response.IsSuccess = false;
                    response.Message = result.Message;
                    _logger.LogError(result.Message);
                    return response;
                }

                response.IsSuccess = true;
                response.Message = TransactionMessage.SaveSuccess;
                _logger.LogInformation(TransactionMessage.SaveSuccess);
            }
            catch (Exception ex)
            {
                response.Message = ex.Message;
                _logger.LogError(ex.Message);
            }

            return response;
        }

        public Response<bool> Update(Request<AsientoCircunscripcionDto> request)
        {
            var response = new Response<bool>();

            var validation = _asientoCircunscripcionValidationManager.Validate(_mapper.Map<AsientoCircunscripcionUpdateRequest>(request.entidad));

            if (!validation.IsValid)
            {
                response.Message = Validation.InvalidMessage;
                response.Errors = validation.Errors;
                return response;
            }

            try
            {
                var entidad = _mapper.Map<AsientoCircunscripcion>(request.entidad);

                entidad.idAsientoCircunscripcion = request.entidad.idAsientoCircunscripcion;
                entidad.usuarioMod = string.IsNullOrEmpty(TokenSesion) ? AuthenticationMessage.DefaultUserId : BaseControl.IdUsuarioAuditoria(TokenSesion);
                entidad.activo = EstadosAuditoria.activo;

                var result = _unitOfWork.AsientoCircunscripcion.Update(entidad);

                if (result.Error)
                {
                    response.IsSuccess = false;
                    response.Message = result.Message;
                    _logger.LogError(result.Message);
                    return response;
                }

                response.IsSuccess = true;
                response.Message = TransactionMessage.UpdateSuccess;
                _logger.LogInformation(TransactionMessage.UpdateSuccess);
            }
            catch (Exception ex)
            {
                response.Message = ex.Message;
                _logger.LogError(ex.Message);
            }

            return response;
        }

        public Response<bool> Delete(Request<AsientoCircunscripcionDto> request)
        {
            var response = new Response<bool>();

            var validation = _asientoCircunscripcionValidationManager.Validate(_mapper.Map<AsientoCircunscripcionIdRequest>(request.entidad));

            if (!validation.IsValid)
            {
                response.Message = Validation.InvalidMessage;
                response.Errors = validation.Errors;
                return response;
            }

            try
            {
                var entidad = _mapper.Map<AsientoCircunscripcion>(request.entidad);

                entidad.idAsientoCircunscripcion = request.entidad.idAsientoCircunscripcion;
                entidad.usuarioMod = string.IsNullOrEmpty(TokenSesion) ? AuthenticationMessage.DefaultUserId : BaseControl.IdUsuarioAuditoria(TokenSesion);

                var result = _unitOfWork.AsientoCircunscripcion.Delete(entidad);

                if (result.Error)
                {
                    response.IsSuccess = false;
                    response.Message = result.Message;
                    _logger.LogError(result.Message);
                    return response;
                }

                response.IsSuccess = true;
                response.Message = TransactionMessage.DeleteSuccess;
                _logger.LogInformation(TransactionMessage.DeleteSuccess);
            }
            catch (Exception ex)
            {
                response.Message = ex.Message;
                _logger.LogError(ex.Message);
            }

            return response;
        }

        public Response<AsientoCircunscripcionDto> GetById(Request<AsientoCircunscripcionDto> request)
        {
            var response = new Response<AsientoCircunscripcionDto>();
            var validation = _asientoCircunscripcionValidationManager.Validate(_mapper.Map<AsientoCircunscripcionIdRequest>(request.entidad));

            try
            {
                if (!validation.IsValid)
                {
                    response.Message = Validation.InvalidMessage;
                    response.Errors = validation.Errors;
                    return response;
                }

                var entidad = _mapper.Map<AsientoCircunscripcion>(request.entidad);
                var result = _unitOfWork.AsientoCircunscripcion.GetById(entidad);

                if (result.Error)
                {
                    response.IsSuccess = false;
                    response.Message = result.Message;
                    _logger.LogError(result.Message ?? string.Empty);
                    return response;
                }

                if (result.Data != null)
                {
                    entidad = new AsientoCircunscripcion
                    {
                        idAsientoCircunscripcion = result.Data.idasientocircunscripcion,
                        idInformeRenac = result.Data.idinformerenac,
                        idTipoAsiento = result.Data.idtipoasiento,
                        idDispositivo = result.Data.iddispositivo,
                        numeroAsiento = result.Data.numeroasiento,
                        descripcion = result.Data.descripcion,
                        nombreCircunscripcion = result.Data.nombrecircunscripcion,
                        nombreCapital = result.Data.nombrecapital,
                        nombreProvincia = result.Data.nombreprovincia,
                        nombreDepartamento = result.Data.nombredepartamento,
                        informacionComplementaria = result.Data.informacioncomplementaria,
                        fechaAnotacion = result.Data.fechaanotacion,
                        activo = result.Data.activo,
                        fechaReg = result.Data.fechareg,
                        fechaMod = result.Data.fechamod,
                        usuarioReg = result.Data.usuarioreg,
                        usuarioMod = result.Data.usuariomod,
                        InformeRenac = new InformeRenac
                        {
                            idInformeRenac = result.Data.informerenac_idinformerenac,
                            idCircunscripcion = result.Data.informerenac_idcircunscripcion,
                            numero = result.Data.informerenac_numero,
                            fecha = result.Data.informerenac_fecha,
                            descripcion = result.Data.informerenac_descripcion
                        },
                        TipoAsiento = new TipoAsiento
                        {
                            idTipoAsiento = result.Data.tipoasiento_idtipoasiento,
                            codigo = result.Data.tipoasiento_codigo,
                            descripcion = result.Data.tipoasiento_descripcion
                        },
                        Norma = new Norma
                        {
                            CodNorma = result.Data.norma_codnorma,
                            Tipo = result.Data.norma_tipo,
                            Numero = result.Data.norma_numero,
                            Archivo = result.Data.norma_archivo,
                            Fecha = result.Data.norma_fecha,
                            TipoDispositivo = new TipoDispositivo
                            {
                                Descripcion = result.Data.tipodispositivo_descripcion
                            }
                        },
                        detallesModificacion = result.Data.detallesmodificacion
                    };
                }

                response.IsSuccess = true;
                response.Data = _mapper.Map<AsientoCircunscripcionDto>(entidad);
                response.Message = TransactionMessage.QuerySuccess;
                _logger.LogInformation(TransactionMessage.QuerySuccess);
            }
            catch (Exception ex)
            {
                response.IsSuccess = false;
                response.Message = ex.Message;
                _logger.LogError(ex.Message);
            }

            return response;
        }

        public Response<List<AsientoCircunscripcionDto>> GetList(Request<AsientoCircunscripcionDto> request)
        {
            var response = new Response<List<AsientoCircunscripcionDto>>();

            try
            {
                var entidad = _mapper.Map<AsientoCircunscripcion>(request.entidad);
                var result = _unitOfWork.AsientoCircunscripcion.GetList(entidad);

                if (result.Data != null)
                {
                    List<AsientoCircunscripcion> lista = result.Data.Select(row =>
                    {
                        var item = new AsientoCircunscripcion
                        {
                            idAsientoCircunscripcion = row.idAsientoCircunscripcion,
                            idInformeRenac = row.idInformeRenac,
                            idTipoAsiento = row.idTipoAsiento,
                            idDispositivo = row.idDispositivo,
                            numeroAsiento = row.numeroAsiento,
                            descripcion = row.descripcion,
                            nombreCircunscripcion = row.nombreCircunscripcion,
                            nombreCapital = row.nombreCapital,
                            nombreProvincia = row.nombreProvincia,
                            nombreDepartamento = row.nombreDepartamento,
                            informacionComplementaria = row.informacionComplementaria,
                            fechaAnotacion = row.fechaAnotacion,
                            detalle_modificacion = row.detalle_modificacion,
                            activo = row.activo,
                            fechaReg = row.fechaReg,
                            fechaMod = row.fechaMod,
                            usuarioReg = row.usuarioReg,
                            usuarioMod = row.usuarioMod,
                            InformeRenac = new InformeRenac
                            {
                                idInformeRenac = row.informerenac_idinformeRenac,
                                idCircunscripcion = row.informerenac_idcircunscripcion,
                                numero = row.informerenac_numero,
                                fecha = row.informerenac_fecha,
                                descripcion = row.informerenac_descripcion
                            },
                            TipoAsiento = new TipoAsiento
                            {
                                idTipoAsiento = row.tipoasiento_idtipoasiento,
                                descripcion = row.tipoasiento_descripcion,
                                activo = row.tipoasiento_activo
                            },
                            Norma = new Norma
                            {
                                Numero = row.norma_numero,
                                Fecha = row.norma_fecha,
                                Archivo = row.norma_archivo,
                                TipoDispositivo = new TipoDispositivo
                                {
                                    Descripcion = row.tipodispositivo_descripcion
                                }
                            }
                        };
                        return item;
                    }).ToList();

                    response.Data = _mapper.Map<List<AsientoCircunscripcionDto>>(lista);
                }

                response.IsSuccess = true;
                response.Message = TransactionMessage.QuerySuccess;
                _logger.LogInformation(TransactionMessage.QuerySuccess);
            }
            catch (Exception ex)
            {
                response.Message = ex.Message;
                _logger.LogError(ex.Message);
            }

            return response;
        }

        public Response<List<AsientoCircunscripcionDto>> GetListPaginated(Request<AsientoCircunscripcionDto> request, out int PageSize, out int PageNumber, out int TotalReg)
        {
            PageSize = 0;
            PageNumber = 0;
            TotalReg = 0;

            var response = new Response<List<AsientoCircunscripcionDto>>();

            try
            {
                var entidad = _mapper.Map<AsientoCircunscripcion>(request.entidad);
                var result = _unitOfWork.AsientoCircunscripcion.GetListPaginated(entidad, out PageSize, out PageNumber, out TotalReg);

                if (result.Data != null && result.Data.Count > 0)
                {
                    List<AsientoCircunscripcion> Lista = new List<AsientoCircunscripcion>();

                    foreach (var item in result.Data)
                    {
                        Lista.Add(new AsientoCircunscripcion()
                        {
                            TotalReg = item.totalreg == null ? 0 : Convert.ToInt32(item.totalreg),
                            rownum = item.rownum,
                            idAsientoCircunscripcion = item.idAsientoCircunscripcion,
                            idInformeRenac = item.idInformeRenac,
                            idTipoAsiento = item.idTipoAsiento,
                            idDispositivo = item.idDispositivo,
                            numeroAsiento = item.numeroAsiento,
                            descripcion = item.descripcion,
                            nombreCircunscripcion = item.nombreCircunscripcion,
                            nombreCapital = item.nombreCapital,
                            nombreProvincia = item.nombreProvincia,
                            nombreDepartamento = item.nombreDepartamento,
                            informacionComplementaria = item.informacionComplementaria,
                            fechaAnotacion = item.fechaAnotacion,
                            detalle_modificacion = item.detalle_modificacion,
                            activo = item.activo,
                            fechaReg = item.fechaReg,
                            fechaMod = item.fechaMod,
                            usuarioReg = item.usuarioReg,
                            usuarioMod = item.usuarioMod,
                            InformeRenac = new InformeRenac
                            {
                                idInformeRenac = item.informerenac_idInformeRenac,
                                idCircunscripcion = item.informerenac_idcircunscripcion,
                                numero = item.informerenac_numero,
                                fecha = item.informerenac_fecha,
                                descripcion = item.informerenac_descripcion
                            },
                            TipoAsiento = new TipoAsiento
                            {
                                idTipoAsiento = item.tipoasiento_idtipoasiento,
                                descripcion = item.tipoasiento_descripcion,
                                activo = item.tipoasiento_activo
                            },
                            Norma = new Norma
                            {
                                Numero = item.norma_numero,
                                Fecha = item.norma_fecha,
                                Archivo = item.norma_archivo,
                                TipoDispositivo = new TipoDispositivo
                                {
                                    Descripcion = item.tipodispositivo_descripcion
                                }
                            }
                        });
                    }

                    response.Data = _mapper.Map<List<AsientoCircunscripcionDto>>(Lista);
                    TotalReg = UtilApplication.GetTotalReg(Lista);
                }
                response.IsSuccess = true;
                response.Message = TransactionMessage.QuerySuccess;
                _logger.LogInformation(TransactionMessage.QuerySuccess);
            }
            catch (Exception ex)
            {
                response.IsSuccess = false;
                response.Message = ex.Message;
                _logger.LogError(ex.Message);
            }

            return response;
        }

        public Response<List<AsientoCircunscripcionDto>> InformacionSsiatAsientosList(Request<AsientoCircunscripcionDto> request)
        {
            var response = new Response<List<AsientoCircunscripcionDto>>();

            try
            {
                var entidad = _mapper.Map<AsientoCircunscripcion>(request.entidad);
                var result = _unitOfWork.AsientoCircunscripcion.InformacionSsiatAsientosList(entidad);

                if (result.Data != null)
                {
                    List<AsientoCircunscripcion> lista = result.Data.Select(row =>
                    {
                        var item = new AsientoCircunscripcion
                        {
                            rownum = row.rownum,
                            idAsientoCircunscripcion = row.idAsientoCircunscripcion,
                            idInformeRenac = row.idInformeRenac,
                            idDispositivo = row.idDispositivo,
                            nombreCircunscripcion = row.nombreCircunscripcion,
                            fechaAnotacion = row.fechaAnotacion,
                            InformeRenac = new InformeRenac
                            {
                                idInformeRenac = row.informerenac_idinformeRenac,
                                numero = row.informerenac_numero
                            },
                            Norma = new Norma
                            {
                                Numero = row.norma_numero,
                                Fecha = row.norma_fecha,
                                Archivo = row.norma_archivo,
                                TipoDispositivo = new TipoDispositivo
                                {
                                    Descripcion = row.tipodispositivo_descripcion
                                }
                            }
                        };
                        return item;
                    }).ToList();

                    response.Data = _mapper.Map<List<AsientoCircunscripcionDto>>(lista);
                }

                response.IsSuccess = true;
                response.Message = TransactionMessage.QuerySuccess;
                _logger.LogInformation(TransactionMessage.QuerySuccess);
            }
            catch (Exception ex)
            {
                response.Message = ex.Message;
                _logger.LogError(ex.Message);
            }

            return response;
        }
    
    }
}
