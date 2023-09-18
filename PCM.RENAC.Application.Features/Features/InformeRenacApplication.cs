using AutoMapper;
using PCM.RENAC.Application.Control.Base;
using PCM.RENAC.Application.Control.Util;
using PCM.RENAC.Application.Dto;
using PCM.RENAC.Application.Interface.Features;
using PCM.RENAC.Application.Interface.Persistence;
using PCM.RENAC.Application.Validator;
using PCM.RENAC.Domain.Entities;
using PCM.RENAC.Transversal.Common;
using PCM.RENAC.Transversal.Common.Util;

namespace PCM.RENAC.Application.Features
{
    public class InformeRenacApplication : IInformeRenacApplication
    {
        private readonly IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;
        private readonly IAppLogger<InformeRenacApplication> _logger;
        private readonly InformeRenacValidationManager _informeRenacValidationManager;

        public string TokenSesion { get; set; }

        public InformeRenacApplication(IUnitOfWork unitOfWork, IMapper mapper, IAppLogger<InformeRenacApplication> logger, InformeRenacValidationManager informeRenacManager)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
            _logger = logger;
            _informeRenacValidationManager = informeRenacManager;
        }

        public Response<bool> Insert(Request<InformeRenacDto> request)
        {
            var response = new Response<bool>();
            var responseFile = new ResponseFile();

            var validation = _informeRenacValidationManager.Validate(_mapper.Map<InformeRenacInsertRequest>(request.entidad));

            if (!validation.IsValid)
            {
                response.Message = Validation.InvalidMessage;
                response.Errors = validation.Errors;
                return response;
            }
            try
            {
                string pathInforme = FileApplicationKeys.PathInformeRenac.ToString();
                responseFile = FileUploadUtility.SaveBase64File(request.entidad.InformeAnotacionBase64, request.entidad.nombreinformesustento, pathInforme, FilesName.InformeSsiat);

                if (responseFile.Error)
                {
                    response.IsSuccess = false;
                    response.Message = responseFile.MessageException;
                    _logger.LogError(responseFile.Message ?? string.Empty);
                    return response;
                }

                InformeRenac entidad = _mapper.Map<InformeRenac>(request.entidad);

                entidad.urlinformesustento = responseFile.PathFile;
                entidad.nombreinformesustento = responseFile.FileName;
                entidad.usuarioReg = string.IsNullOrEmpty(TokenSesion) ? AuthenticationMessage.DefaultUserId : BaseControl.IdUsuarioAuditoria(TokenSesion);
                entidad.activo = EstadosAuditoria.activo;

                var result = _unitOfWork.InformeRenac.Insert(entidad);

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

        public Response<bool> Update(Request<InformeRenacDto> request)
        {
            var response = new Response<bool>();
            var responseFile = new ResponseFile();

            var validation = _informeRenacValidationManager.Validate(_mapper.Map<InformeRenacUpdateRequest>(request.entidad));

            if (!validation.IsValid)
            {
                response.Message = Validation.InvalidMessage;
                response.Errors = validation.Errors;
                return response;
            }

            try
            {
                var entidad = _mapper.Map<InformeRenac>(request.entidad);

                if (!string.IsNullOrEmpty(request.entidad.InformeAnotacionBase64))
                {
                    string pathInforme = FileApplicationKeys.PathInformeRenac.ToString();
                    responseFile = FileUploadUtility.SaveBase64File(request.entidad.InformeAnotacionBase64, request.entidad.nombreinformesustento, pathInforme, FilesName.InformeSsiat);

                    entidad.urlinformesustento = responseFile.PathFile;
                    entidad.nombreinformesustento = responseFile.FileName;

                    if (responseFile.Error)
                    {
                        response.IsSuccess = false;
                        response.Message = responseFile.MessageException;
                        _logger.LogError(responseFile.Message ?? string.Empty);
                        return response;
                    }
                }

                entidad.usuarioMod = string.IsNullOrEmpty(TokenSesion) ? AuthenticationMessage.DefaultUserId : BaseControl.IdUsuarioAuditoria(TokenSesion);
                entidad.activo = EstadosAuditoria.activo;

                var result = _unitOfWork.InformeRenac.Update(entidad);

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

        public Response<bool> Delete(Request<InformeRenacDto> request)
        {
            var response = new Response<bool>();

            var validation = _informeRenacValidationManager.Validate(_mapper.Map<InformeRenacIdRequest>(request.entidad));

            if (!validation.IsValid)
            {
                response.Message = Validation.InvalidMessage;
                response.Errors = validation.Errors;
                return response;
            }

            try
            {
                var entidad = _mapper.Map<InformeRenac>(request.entidad);

                entidad.idInformeRenac = request.entidad.idInformeRenac;
                entidad.usuarioMod = string.IsNullOrEmpty(TokenSesion) ? AuthenticationMessage.DefaultUserId : BaseControl.IdUsuarioAuditoria(TokenSesion);

                var result = _unitOfWork.InformeRenac.Delete(entidad);

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

        public Response<InformeRenacDto> GetById(Request<InformeRenacDto> request)
        {
            var response = new Response<InformeRenacDto>();

            var validation = _informeRenacValidationManager.Validate(_mapper.Map<InformeRenacIdRequest>(request.entidad));

            try
            {
                if (!validation.IsValid)
                {
                    response.Message = Validation.InvalidMessage;
                    response.Errors = validation.Errors;
                    return response;
                }

                var entidad = _mapper.Map<InformeRenac>(request.entidad);

                var result = _unitOfWork.InformeRenac.GetById(entidad);

                if (result.Error)
                {
                    response.IsSuccess = false;
                    response.Message = result.Message;
                    _logger.LogError(result.Message);
                    return response;
                }

                if (result.Data != null)
                {
                    entidad = new InformeRenac
                    {
                        idInformeRenac = result.Data.idinformerenac,
                        idCircunscripcion = result.Data.idcircunscripcion,
                        idEstadoDerivacion = result.Data.idEstadoDerivacion,
                        numero = result.Data.numero,
                        fecha = result.Data.fecha,
                        descripcion = result.Data.descripcion,
                        urlinformesustento = result.Data.urlinformesustento,
                        nombreinformesustento = result.Data.nombreinformesustento,
                        evaluacionFavorable = result.Data.evaluacionfavorable,
                        fechaSolicitudInformacion = result.Data.fechasolicitudinformacion,
                        oficioSolicitudNumero = result.Data.oficiosolicitudnumero,
                        oficioSolicitudFecha = result.Data.oficiosolicitudfecha,
                        oficioSolicitudArchivo = result.Data.oficiosolicitudarchivo,
                        evidenciaSolicitudFecha = result.Data.evidenciasolicitudfecha,
                        evidenciaSolicitudArchivo = result.Data.evidenciasolicitudarchivo,
                        oficioAnotacionNumero = result.Data.oficioanotacionnumero,
                        oficioAnotacionFecha = result.Data.oficioanotacionfecha,
                        oficioAnotacionArchivo = result.Data.oficioanotacionarchivo,
                        evidenciaAnotacionFecha = result.Data.evidenciaanotacionfecha,
                        evidenciaAnotacionArchivo = result.Data.evidenciaanotacionarchivo,
                        esDerivado = result.Data.esderivado,
                        solicitudDiasTranscurridos = result.Data.solicituddiastranscurridos,
                        constanciaAnotacionArchivo = result.Data.constanciaanotacionarchivo,
                        constanciaAnotacionFirmadaFecha = result.Data.constanciaanotacionfirmadafecha,
                        constanciaAnotacionFirmadaArchivo = result.Data.constanciaanotacionfirmadaarchivo,
                        respuestaGoreNumero = result.Data.respuestagorenumero,
                        respuestaGoreFecha = result.Data.respuestagorefecha,
                        respuestaGoreArchivo = result.Data.respuestagorearchivo,
                        archivado = result.Data.archivado,
                        Circunscripcion = new Circunscripcion
                        {
                            CodCircunscripcion = result.Data.idcircunscripcion,
                            NombreCircunscripcion = result.Data.nombrecircunscripcion,
                            NomCircunscripcion = result.Data.vnomcircunscripcion,
                            TipCircunscripcion = result.Data.itipcircunscripcion,
                            TipoCircunscripcion = new TipoCircunscripcion
                            {
                                Id = result.Data.tipocircunscripcion_id,
                                Descripcion = result.Data.tipocircunscripcion_descripcion,
                                Abreviado = result.Data.tipocircunscripcion_abreviatura
                            }
                        }
                    };
                }

                response.IsSuccess = true;
                response.Data = _mapper.Map<InformeRenacDto>(entidad);
                response.Message = TransactionMessage.QuerySuccess;
                _logger.LogInformation(TransactionMessage.QuerySuccess);
            }
            catch (Exception ex)
            {
                response.IsSuccess = false;
                response.Message = AuthenticationMessage.UserNoExists;
                _logger.LogError(ex.Message);
            }

            return response;
        }

        public Response<List<InformeRenacDto>> GetList(Request<InformeRenacDto> request)
        {
            var response = new Response<List<InformeRenacDto>>();

            try
            {
                var entidad = _mapper.Map<InformeRenac>(request.entidad);

                var result = _unitOfWork.InformeRenac.GetList(entidad);

                if (result.Data != null)
                {
                    List<InformeRenac> Lista = new List<InformeRenac>();

                    foreach (var item in result.Data)
                    {
                        Lista.Add(new InformeRenac()
                        {
                            idInformeRenac = item.idInformeRenac,
                            idCircunscripcion = item.idCircunscripcion,
                            idEstadoDerivacion = item.idEstadoDerivacion,
                            numero = item.numero,
                            fecha = item.fecha,
                            descripcion = item.descripcion,
                            urlinformesustento = item.urlinformesustento,
                            nombreinformesustento = item.nombreinformesustento,
                            evaluacionFavorable = item.evaluacionFavorable,
                            activo = item.activo
                        });
                    }

                    response.Data = _mapper.Map<List<InformeRenacDto>>(Lista);
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

        public Response<List<InformeRenacDto>> GetListPaginated(Request<InformeRenacDto> request, out int PageSize, out int PageNumber, out int TotalReg)
        {
            PageSize = 0;
            PageNumber = 0;
            TotalReg = 0;

            var response = new Response<List<InformeRenacDto>>();

            try
            {
                var entidad = _mapper.Map<InformeRenac>(request.entidad);

                var result = _unitOfWork.InformeRenac.GetListPaginated(entidad, out PageSize, out PageNumber, out TotalReg);

                if (result.Data != null && result.Data.Count > 0)
                {
                    List<InformeRenac> Lista = new List<InformeRenac>();

                    foreach (var item in result.Data)
                    {
                        Lista.Add(new InformeRenac()
                        {
                            idInformeRenac = item.idInformeRenac,
                            idCircunscripcion = item.idCircunscripcion,
                            idEstadoDerivacion = item.idEstadoDerivacion,
                            numero = item.numero,
                            fecha = item.fecha,
                            descripcion = item.descripcion,
                            urlinformesustento = item.urlinformesustento,
                            nombreinformesustento = item.nombreinformesustento,
                            estadoDerivacion = item.estadoderivacion,
                            evaluacionFavorable = item.evaluacionFavorable,
                            activo = item.activo,
                            rownum = item.rownum,
                            fechaReg = item.fechaReg,
                            TotalReg = item.totalreg == null ? 0 : Convert.ToInt32(item.totalreg),
                            Circunscripcion = new Circunscripcion()
                            {
                                NombreCircunscripcion = item.nombrecircunscripcion,
                                TipCircunscripcion = item.iTipCircunscripcion
                            }
                        });
                    }

                    response.Data = _mapper.Map<List<InformeRenacDto>>(Lista);
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

        public Response<List<InformeRenacDto>> GetListEspecialistaSsiatPaginated(Request<InformeRenacDto> request, out int PageSize, out int PageNumber, out int TotalReg)
        {
            PageSize = 0;
            PageNumber = 0;
            TotalReg = 0;

            var response = new Response<List<InformeRenacDto>>();

            try
            {
                var entidad = _mapper.Map<InformeRenac>(request.entidad);

                var result = _unitOfWork.InformeRenac.GetListEspecialistaSsiatPaginated(entidad, out PageSize, out PageNumber, out TotalReg);

                if (result.Data != null && result.Data.Count > 0)
                {
                    List<InformeRenac> Lista = new List<InformeRenac>();

                    foreach (var item in result.Data)
                    {
                        Lista.Add(new InformeRenac()
                        {
                            idInformeRenac = item.idInformeRenac,
                            idCircunscripcion = item.idCircunscripcion,
                            idEstadoDerivacion = item.idEstadoDerivacion,
                            numero = item.numero,
                            fecha = item.fecha,
                            descripcion = item.descripcion,
                            urlinformesustento = item.urlinformesustento,
                            nombreinformesustento = item.nombreinformesustento,
                            estadoDerivacion = item.estadoderivacion,
                            esDerivado = item.esderivado,
                            activo = item.activo,
                            rownum = item.rownum,
                            fechaReg = item.fechaReg,
                            TotalReg = item.totalreg == null ? 0 : Convert.ToInt32(item.totalreg),
                            Circunscripcion = new Circunscripcion()
                            {
                                NombreCircunscripcion = item.nombrecircunscripcion,
                                TipCircunscripcion = item.iTipCircunscripcion
                            }
                        });
                    }

                    response.Data = _mapper.Map<List<InformeRenacDto>>(Lista);
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

        public Response<List<InformeRenacDto>> GetListSubsecretarioSsiatPaginated(Request<InformeRenacDto> request, out int PageSize, out int PageNumber, out int TotalReg)
        {
            PageSize = 0;
            PageNumber = 0;
            TotalReg = 0;

            var response = new Response<List<InformeRenacDto>>();

            try
            {
                var entidad = _mapper.Map<InformeRenac>(request.entidad);

                var result = _unitOfWork.InformeRenac.GetListSubsecretarioSsiatPaginated(entidad, out PageSize, out PageNumber, out TotalReg);

                if (result.Data != null && result.Data.Count > 0)
                {
                    List<InformeRenac> Lista = new List<InformeRenac>();

                    foreach (var item in result.Data)
                    {
                        Lista.Add(new InformeRenac()
                        {
                            idInformeRenac = item.idInformeRenac,
                            idCircunscripcion = item.idCircunscripcion,
                            idEstadoDerivacion = item.idEstadoDerivacion,
                            numero = item.numero,
                            fecha = item.fecha,
                            descripcion = item.descripcion,
                            urlinformesustento = item.urlinformesustento,
                            nombreinformesustento = item.nombreinformesustento,
                            estadoSsiat = item.estadossiat,
                            estadoAnotacion = item.estadoanotacion,
                            Circunscripcion = new Circunscripcion()
                            {
                                NombreCircunscripcion = item.nombrecircunscripcion,
                                TipCircunscripcion = item.iTipCircunscripcion
                            },
                            activo = item.activo,
                            fechaReg = item.fechaReg,
                            usuarioReg = item.usuarioReg,
                            TotalReg = item.totalreg == null ? 0 : Convert.ToInt32(item.totalreg),
                            rownum = item.rownum
                        });
                    }

                    response.Data = _mapper.Map<List<InformeRenacDto>>(Lista);
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

        public Response<List<InformeRenacDto>> GetListSubsecretarioSsatdotPaginated(Request<InformeRenacDto> request, out int PageSize, out int PageNumber, out int TotalReg)
        {
            PageSize = 0;
            PageNumber = 0;
            TotalReg = 0;

            var response = new Response<List<InformeRenacDto>>();

            try
            {
                var entidad = _mapper.Map<InformeRenac>(request.entidad);

                var result = _unitOfWork.InformeRenac.GetListSubsecretarioSsatdotPaginated(entidad, out PageSize, out PageNumber, out TotalReg);

                if (result.Data != null && result.Data.Count > 0)
                {
                    List<InformeRenac> Lista = new List<InformeRenac>();

                    foreach (var item in result.Data)
                    {
                        Lista.Add(new InformeRenac()
                        {
                            rownum = item.rownum,
                            idInformeRenac = item.idInformeRenac,
                            idCircunscripcion = item.idCircunscripcion,
                            idEstadoDerivacion = item.idEstadoDerivacion,
                            numero = item.numero,
                            fecha = item.fecha,
                            descripcion = item.descripcion,
                            estadoDerivacion = item.estadoderivacion,
                            Circunscripcion = new Circunscripcion()
                            {
                                NombreCircunscripcion = item.nombrecircunscripcion,
                                TipCircunscripcion = item.iTipCircunscripcion
                            },
                            activo = item.activo,
                            fechaReg = item.fechaReg,
                            usuarioReg = item.usuarioReg,
                            TotalReg = item.totalreg == null ? 0 : Convert.ToInt32(item.totalreg)
                        });
                    }

                    response.Data = _mapper.Map<List<InformeRenacDto>>(Lista);
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

        public Response<List<InformeRenacDto>> GetListEspecialistaSsatdotPaginated(Request<InformeRenacDto> request, out int PageSize, out int PageNumber, out int TotalReg)
        {
            PageSize = 0;
            PageNumber = 0;
            TotalReg = 0;

            var response = new Response<List<InformeRenacDto>>();

            try
            {
                var entidad = _mapper.Map<InformeRenac>(request.entidad);

                var result = _unitOfWork.InformeRenac.GetListEspecialistaSsatdotPaginated(entidad, out PageSize, out PageNumber, out TotalReg);

                if (result.Data != null && result.Data.Count > 0)
                {
                    List<InformeRenac> Lista = new List<InformeRenac>();

                    foreach (var item in result.Data)
                    {
                        Lista.Add(new InformeRenac()
                        {
                            TotalReg = item.totalreg == null ? 0 : Convert.ToInt32(item.totalreg),
                            rownum = item.rownum,
                            idInformeRenac = item.idInformeRenac,
                            idCircunscripcion = item.idCircunscripcion,
                            idEstadoDerivacion = item.idEstadoDerivacion,
                            numero = item.numero,
                            estadoDerivacion = item.estadoderivacion,
                            Circunscripcion = new Circunscripcion()
                            {
                                NombreCircunscripcion = item.nombrecircunscripcion
                            }
                        });
                    }

                    response.Data = _mapper.Map<List<InformeRenacDto>>(Lista);
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

        public Response<InformeRenacDto> GetListInformacionSsiatDocumentos(Request<InformeRenacDto> request)
        {
            var response = new Response<InformeRenacDto>();

            try
            {
                var entidad = _mapper.Map<InformeRenac>(request.entidad);

                var result = _unitOfWork.InformeRenac.GetListInformacionSsiatDocumentos(entidad);

                if (result.Error)
                {
                    response.IsSuccess = false;
                    response.Message = result.Message;
                    _logger.LogError(result.Message);
                    return response;
                }

                if (result.Data != null)
                {
                    entidad = new InformeRenac
                    {
                        urlinformesustento = result.Data.informeanotacion,
                        urlProyectoMemoEspSsiat = result.Data.proyectomemo_espssiat,
                        urlProyectoMemoSubSsiat = result.Data.proyectomemo_subssiat,
                        numero = result.Data.numero_partida
                    };
                }

                response.IsSuccess = true;
                response.Data = _mapper.Map<InformeRenacDto>(entidad);
                response.Message = TransactionMessage.QuerySuccess;
                _logger.LogInformation(TransactionMessage.QuerySuccess);
            }
            catch (Exception ex)
            {
                response.IsSuccess = false;
                response.Message = AuthenticationMessage.UserNoExists;
                _logger.LogError(ex.Message);
            }

            return response;
        }

        public Response<bool> UpdateEvaluacionFavorable(Request<InformeRenacDto> request)
        {
            var response = new Response<bool>();

            var validation = _informeRenacValidationManager.Validate(_mapper.Map<UpdateEvaluacionFavorableRequest>(request.entidad));

            if (!validation.IsValid)
            {
                response.Message = Validation.InvalidMessage;
                response.Errors = validation.Errors;
                return response;
            }

            try
            {
                var entidad = _mapper.Map<InformeRenac>(request.entidad);

                entidad.usuarioMod = string.IsNullOrEmpty(TokenSesion) ? AuthenticationMessage.DefaultUserId : BaseControl.IdUsuarioAuditoria(TokenSesion);
                entidad.activo = EstadosAuditoria.activo;

                var result = _unitOfWork.InformeRenac.UpdateEvaluacionFavorable(entidad);

                if (result.Error)
                {
                    response.IsSuccess = false;
                    response.Message = result.Message;
                    _logger.LogError(result.Message ?? TransactionMessage.GenericErrorMessage);
                    return response;
                }

                response.IsSuccess = true;
                response.Message = result.Message;
                _logger.LogInformation(TransactionMessage.UpdateSuccess);
            }
            catch (Exception ex)
            {
                response.Message = ex.Message;
                _logger.LogError(ex.Message);
            }

            return response;
        }

        public Response<bool> UpdateInformesOpinionFavorable(Request<InformeRenacDto> request)
        {
            var response = new Response<bool>();
            var responseFile = new ResponseFile();

            var validation = _informeRenacValidationManager.Validate(_mapper.Map<UpdateInformesOpinionFavorableRequest>(request.entidad));

            if (!validation.IsValid)
            {
                response.Message = Validation.InvalidMessage;
                response.Errors = validation.Errors;
                return response;
            }
            try
            {
                string PathInformeOpinionFavorable = FileApplicationKeys.PathInformeOpinionFavorable.ToString();
                responseFile = FileUploadUtility.SaveBase64File(request.entidad.informeFavorableArchivoBase64, request.entidad.informeFavorableArchivo, PathInformeOpinionFavorable, FilesName.InformeOpinionFavorable);


                if (responseFile.Error)
                {
                    response.IsSuccess = false;
                    response.Message = responseFile.MessageException;
                    _logger.LogError(responseFile.Message ?? TransactionMessage.SaveSuccess);
                    return response;
                }

                InformeRenac entidad = _mapper.Map<InformeRenac>(request.entidad);

                entidad.informeFavorableArchivo = responseFile.PathFile;
                entidad.usuarioReg = string.IsNullOrEmpty(TokenSesion) ? AuthenticationMessage.DefaultUserId : BaseControl.IdUsuarioAuditoria(TokenSesion);
                entidad.activo = EstadosAuditoria.activo;

                var result = _unitOfWork.InformeRenac.UpdateInformesOpinionFavorable(entidad);

                if (result.Error)
                {
                    response.IsSuccess = false;
                    response.Message = result.Message;
                    _logger.LogError(result.Message ?? TransactionMessage.GenericErrorMessage);
                    return response;
                }

                response.IsSuccess = true;
                response.Message = response.Message;
                _logger.LogInformation(response.Message ?? TransactionMessage.SaveSuccess);
            }
            catch (Exception ex)
            {
                response.Message = ex.Message;
                _logger.LogError(ex.Message);
            }

            return response;
        }

        public Response<List<InformeRenacDto>> GetListSubsecretarioSsatdotDerivacionInformesPaginated(Request<InformeRenacDto> request, out int PageSize, out int PageNumber, out int TotalReg)
        {
            PageSize = 0;
            PageNumber = 0;
            TotalReg = 0;

            var response = new Response<List<InformeRenacDto>>();

            try
            {
                var entidad = _mapper.Map<InformeRenac>(request.entidad);

                var result = _unitOfWork.InformeRenac.GetListSubsecretarioSsatdotDerivacionInformesPaginated(entidad, out PageSize, out PageNumber, out TotalReg);

                if (result.Data != null && result.Data.Count > 0)
                {
                    List<InformeRenac> Lista = new List<InformeRenac>();

                    foreach (var item in result.Data)
                    {
                        Lista.Add(new InformeRenac()
                        {
                            TotalReg = item.totalreg == null ? 0 : Convert.ToInt32(item.totalreg),
                            rownum = item.rownum,
                            idInformeRenac = item.idInformeRenac,
                            idCircunscripcion = item.idCircunscripcion,
                            idEstadoDerivacion = item.idEstadoDerivacion,
                            numero = item.numero,
                            evaluacionFavorable = item.evaluacionFavorable,
                            estadoDerivacion = item.estadoderivacion,
                            esDerivado = item.esderivado,
                            Circunscripcion = new Circunscripcion()
                            {
                                NombreCircunscripcion = item.nombrecircunscripcion
                            }
                        });
                    }

                    response.Data = _mapper.Map<List<InformeRenacDto>>(Lista);
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

        public Response<bool> VerificarInformeEvaluacionFavorable(Request<InformeRenacDto> request)
        {
            var response = new Response<bool>();

            var validation = _informeRenacValidationManager.Validate(_mapper.Map<VerificarInformeEvaluacionFavorableRequest>(request.entidad));

            if (!validation.IsValid)
            {
                response.Message = Validation.InvalidMessage;
                response.Errors = validation.Errors;
                return response;
            }
            try
            {
                InformeRenac entidad = _mapper.Map<InformeRenac>(request.entidad);

                var result = _unitOfWork.InformeRenac.VerificarInformeEvaluacionFavorable(entidad);

                if (result.Error)
                {
                    response.IsSuccess = false;
                    response.Message = result.Message;
                    _logger.LogError(result.Message ?? TransactionMessage.GenericErrorMessage);
                    return response;
                }

                response.IsSuccess = true;
                response.Message = result.Message;
                _logger.LogInformation(result.Message ?? TransactionMessage.SaveSuccess);
            }
            catch (Exception ex)
            {
                response.Message = ex.Message;
                _logger.LogError(ex.Message);
            }

            return response;
        }

        public Response<List<InformeRenacDto>> GetListResponsableArchivoSolicitudInformacionPaginated(Request<InformeRenacDto> request, out int PageSize, out int PageNumber, out int TotalReg)
        {
            PageSize = 0;
            PageNumber = 0;
            TotalReg = 0;

            var response = new Response<List<InformeRenacDto>>();

            try
            {
                var entidad = _mapper.Map<InformeRenac>(request.entidad);

                var result = _unitOfWork.InformeRenac.GetListResponsableArchivoSolicitudInformacionPaginated(entidad, out PageSize, out PageNumber, out TotalReg);

                if (result.Data != null && result.Data.Count > 0)
                {
                    List<InformeRenac> Lista = new List<InformeRenac>();

                    foreach (var item in result.Data)
                    {
                        Lista.Add(new InformeRenac()
                        {
                            TotalReg = item.totalreg == null ? 0 : Convert.ToInt32(item.totalreg),
                            rownum = item.rownum,
                            idInformeRenac = item.idInformeRenac,
                            idCircunscripcion = item.idCircunscripcion,
                            idEstadoDerivacion = item.idEstadoDerivacion,
                            numero = item.numero,
                            evaluacionFavorable = item.evaluacionFavorable,
                            estadoDerivacion = item.estadoderivacion,
                            esDerivado = item.esderivado,
                            Circunscripcion = new Circunscripcion()
                            {
                                NombreCircunscripcion = item.nombrecircunscripcion
                            }
                        });
                    }

                    response.Data = _mapper.Map<List<InformeRenacDto>>(Lista);
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

        public Response<bool> UpdateSolicitudInformacion(Request<InformeRenacDto> request)
        {
            var response = new Response<bool>();

            var validation = _informeRenacValidationManager.Validate(_mapper.Map<UpdateSolicitudInformacionRequest>(request.entidad));

            if (!validation.IsValid)
            {
                response.Message = Validation.InvalidMessage;
                response.Errors = validation.Errors;
                return response;
            }
            try
            {
                InformeRenac entidad = _mapper.Map<InformeRenac>(request.entidad);

                if (!string.IsNullOrEmpty(request.entidad.oficioSolicitudArchivoBase64) && !string.IsNullOrEmpty(request.entidad.evidenciaSolicitudArchivoBase64))
                {

                    var responseOficioFile = new ResponseFile();
                    var responseEvidenciaFile = new ResponseFile();

                    responseOficioFile = FileUploadUtility.SaveBase64File(
                        request.entidad.oficioSolicitudArchivoBase64,
                        request.entidad.oficioSolicitudArchivo,
                        FileApplicationKeys.PathOficioSolicitudInformacion.ToString(),
                        FilesName.OficioSolicitudInformacion);

                    responseEvidenciaFile = FileUploadUtility.SaveBase64File(
                        request.entidad.evidenciaSolicitudArchivoBase64,
                        request.entidad.evidenciaSolicitudArchivo,
                        FileApplicationKeys.PathEvidenciaSolicitudInformacion.ToString(),
                        FilesName.EvidenciaSolicitudInformacion);

                    if (responseOficioFile.Error || responseEvidenciaFile.Error)
                    {
                        string exMessageFile = responseOficioFile.Error == true ? responseOficioFile.Message : responseEvidenciaFile.Error == true ? responseEvidenciaFile.Message : TransactionMessage.GenericErrorMessage;
                        response.IsSuccess = false;
                        response.Message = exMessageFile;
                        _logger.LogError(exMessageFile ?? TransactionMessage.SaveSuccess);
                        return response;
                    }

                    entidad.evidenciaSolicitudArchivo = responseEvidenciaFile.PathFile;
                    entidad.oficioSolicitudArchivo = responseOficioFile.PathFile;
                }

                entidad.usuarioReg = string.IsNullOrEmpty(TokenSesion) ? AuthenticationMessage.DefaultUserId : BaseControl.IdUsuarioAuditoria(TokenSesion);
                entidad.activo = EstadosAuditoria.activo;

                var result = _unitOfWork.InformeRenac.UpdateSolicitudInformacion(entidad);

                if (result.Error)
                {
                    response.IsSuccess = false;
                    response.Message = result.Message;
                    _logger.LogError(result.Message ?? TransactionMessage.GenericErrorMessage);
                    return response;
                }

                response.IsSuccess = true;
                response.Message = response.Message;
                _logger.LogInformation(response.Message ?? TransactionMessage.SaveSuccess);
            }
            catch (Exception ex)
            {
                response.Message = ex.Message;
                _logger.LogError(ex.Message);
            }

            return response;
        }

        public Response<List<InformeRenacDto>> GetListEspecialistaSsiatRegistroFormatosPaginated(Request<InformeRenacDto> request, out int PageSize, out int PageNumber, out int TotalReg)
        {
            PageSize = 0;
            PageNumber = 0;
            TotalReg = 0;

            var response = new Response<List<InformeRenacDto>>();

            try
            {
                var entidad = _mapper.Map<InformeRenac>(request.entidad);

                var result = _unitOfWork.InformeRenac.GetListEspecialistaSsiatRegistroFormatosPaginated(entidad, out PageSize, out PageNumber, out TotalReg);

                if (result.Data != null && result.Data.Count > 0)
                {
                    List<InformeRenac> Lista = new List<InformeRenac>();

                    foreach (var item in result.Data)
                    {
                        Lista.Add(new InformeRenac()
                        {
                            TotalReg = item.totalreg == null ? 0 : Convert.ToInt32(item.totalreg),
                            rownum = item.rownum,
                            idInformeRenac = item.idInformeRenac,
                            idCircunscripcion = item.idCircunscripcion,
                            idEstadoDerivacion = item.idEstadoDerivacion,
                            numero = item.numero,
                            evaluacionFavorable = item.evaluacionFavorable,
                            solicitudGore = item.solicitudGore,
                            estadoDerivacion = item.estadoderivacion,
                            esDerivado = item.esderivado,
                            solicitudDiasTranscurridos = item.solicituddiastranscurridos,
                            constanciaAnotacionArchivo = item.constanciaAnotacionArchivo,
                            respuestaGoreArchivo = item.respuestaGoreArchivo,
                            Circunscripcion = new Circunscripcion()
                            {
                                NombreCircunscripcion = item.nombrecircunscripcion
                            }
                        });
                    }

                    response.Data = _mapper.Map<List<InformeRenacDto>>(Lista);
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

        public Response<bool> UpdateConstanciaAnotacion(Request<InformeRenacDto> request)
        {
            var response = new Response<bool>();
            var responseFile = new ResponseFile();

            var validation = _informeRenacValidationManager.Validate(_mapper.Map<UpdateConstanciaAnotacionRequest>(request.entidad));

            if (!validation.IsValid)
            {
                response.Message = Validation.InvalidMessage;
                response.Errors = validation.Errors;
                return response;
            }
            try
            {

                responseFile = FileUploadUtility.SaveBase64File(request.entidad.constanciaAnotacionBase64,
                                                                request.entidad.constanciaAnotacionArchivo,
                                                                FileApplicationKeys.PathConstanciaAnotacion.ToString(),
                                                                FilesName.ConstanciaAnotacionRenac);

                if (responseFile.Error)
                {
                    response.IsSuccess = false;
                    response.Message = responseFile.MessageException;
                    _logger.LogError(responseFile.Message ?? TransactionMessage.SaveSuccess);
                    return response;
                }

                InformeRenac entidad = _mapper.Map<InformeRenac>(request.entidad);

                entidad.constanciaAnotacionArchivo = responseFile.PathFile;
                entidad.usuarioMod = string.IsNullOrEmpty(TokenSesion) ? AuthenticationMessage.DefaultUserId : BaseControl.IdUsuarioAuditoria(TokenSesion);
                entidad.activo = EstadosAuditoria.activo;

                var result = _unitOfWork.InformeRenac.UpdateConstanciaAnotacion(entidad);

                if (result.Error)
                {
                    response.IsSuccess = false;
                    response.Message = result.Message;
                    _logger.LogError(result.Message ?? TransactionMessage.GenericErrorMessage);
                    return response;
                }

                response.IsSuccess = true;
                response.Message = response.Message;
                _logger.LogInformation(response.Message ?? TransactionMessage.SaveSuccess);
            }
            catch (Exception ex)
            {
                response.Message = ex.Message;
                _logger.LogError(ex.Message);
            }

            return response;
        }

        public Response<bool> UpdateRespuestaGore(Request<InformeRenacDto> request)
        {
            var response = new Response<bool>();
            var responseFile = new ResponseFile();

            var validation = _informeRenacValidationManager.Validate(_mapper.Map<UpdateRespuestaGoreRequest>(request.entidad));

            if (!validation.IsValid)
            {
                response.Message = Validation.InvalidMessage;
                response.Errors = validation.Errors;
                return response;
            }
            try
            {
                InformeRenac entidad = _mapper.Map<InformeRenac>(request.entidad);

                if (!string.IsNullOrEmpty(request.entidad.respuestaGoreBase64))
                {
                    responseFile = FileUploadUtility.SaveBase64File(request.entidad.respuestaGoreBase64,
                                                                request.entidad.respuestaGoreArchivo,
                                                                FileApplicationKeys.PathRespuestaGore.ToString(),
                                                                FilesName.RespuestaGore);

                    if (responseFile.Error)
                    {
                        response.IsSuccess = false;
                        response.Message = responseFile.MessageException;
                        _logger.LogError(responseFile.Message ?? TransactionMessage.SaveSuccess);
                        return response;
                    }
                }

                entidad.respuestaGoreArchivo = string.IsNullOrEmpty(request.entidad.respuestaGoreBase64) ? null : responseFile.PathFile;
                entidad.usuarioReg = string.IsNullOrEmpty(TokenSesion) ? AuthenticationMessage.DefaultUserId : BaseControl.IdUsuarioAuditoria(TokenSesion);
                entidad.activo = EstadosAuditoria.activo;

                var result = _unitOfWork.InformeRenac.UpdateRespuestaGore(entidad);

                if (result.Error)
                {
                    response.IsSuccess = false;
                    response.Message = result.Message;
                    _logger.LogError(result.Message ?? TransactionMessage.GenericErrorMessage);
                    return response;
                }

                response.IsSuccess = true;
                response.Message = response.Message;
                _logger.LogInformation(response.Message ?? TransactionMessage.SaveSuccess);
            }
            catch (Exception ex)
            {
                response.Message = ex.Message;
                _logger.LogError(ex.Message);
            }

            return response;
        }

        public Response<List<InformeRenacDto>> GetListSubsecretarioSsiatRegistroAnotacionPaginated(Request<InformeRenacDto> request, out int PageSize, out int PageNumber, out int TotalReg)
        {
            PageSize = 0;
            PageNumber = 0;
            TotalReg = 0;

            var response = new Response<List<InformeRenacDto>>();

            try
            {
                var entidad = _mapper.Map<InformeRenac>(request.entidad);

                var result = _unitOfWork.InformeRenac.GetListSubsecretarioSsiatRegistroAnotacionPaginated(entidad, out PageSize, out PageNumber, out TotalReg);

                if (result.Data != null && result.Data.Count > 0)
                {
                    List<InformeRenac> Lista = new List<InformeRenac>();

                    foreach (var item in result.Data)
                    {
                        Lista.Add(new InformeRenac()
                        {
                            TotalReg = item.totalreg == null ? 0 : Convert.ToInt32(item.totalreg),
                            rownum = item.rownum,
                            idInformeRenac = item.idInformeRenac,
                            idCircunscripcion = item.idCircunscripcion,
                            idEstadoDerivacion = item.idEstadoDerivacion,
                            numero = item.numero,
                            evaluacionFavorable = item.evaluacionFavorable,
                            solicitudGore = item.solicitudGore,
                            constanciaAnotacionArchivo = item.constanciaAnotacionArchivo,
                            constanciaAnotacionFirmadaArchivo = item.constanciaAnotacionFirmadaArchivo,
                            respuestaGoreArchivo = item.respuestaGoreArchivo,
                            estadoDerivacion = item.estadoderivacion,
                            esDerivado = item.esderivado,
                            Circunscripcion = new Circunscripcion()
                            {
                                NombreCircunscripcion = item.nombrecircunscripcion
                            }
                        });
                    }

                    response.Data = _mapper.Map<List<InformeRenacDto>>(Lista);
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

        public Response<bool> UpdateRegistroAnotacion(Request<InformeRenacDto> request)
        {
            var response = new Response<bool>();

            var validation = _informeRenacValidationManager.Validate(_mapper.Map<UpdateRegistroAnotacionRequest>(request.entidad));

            if (!validation.IsValid)
            {
                response.Message = Validation.InvalidMessage;
                response.Errors = validation.Errors;
                return response;
            }
            try
            {
                InformeRenac entidad = _mapper.Map<InformeRenac>(request.entidad);

                if (!string.IsNullOrEmpty(request.entidad.oficioAnotacionArchivoBase64) && !string.IsNullOrEmpty(request.entidad.evidenciaAnotacionArchivoBase64))
                {

                    var responseOficioFile = new ResponseFile();
                    var responseEvidenciaFile = new ResponseFile();

                    responseOficioFile = FileUploadUtility.SaveBase64File(
                        request.entidad.oficioAnotacionArchivoBase64,
                        request.entidad.oficioAnotacionArchivo,
                        FileApplicationKeys.PathOficioAnotacion.ToString(),
                        FilesName.OficioAnotacion);

                    responseEvidenciaFile = FileUploadUtility.SaveBase64File(
                        request.entidad.evidenciaAnotacionArchivoBase64,
                        request.entidad.evidenciaAnotacionArchivo,
                        FileApplicationKeys.PathEvidenciaAnotacion.ToString(),
                        FilesName.EvidenciaAnotacion);

                    if (responseOficioFile.Error || responseEvidenciaFile.Error)
                    {
                        string exMessageFile = responseOficioFile.Error == true ? responseOficioFile.Message : responseEvidenciaFile.Error == true ? responseEvidenciaFile.Message : TransactionMessage.GenericErrorMessage;
                        response.IsSuccess = false;
                        response.Message = exMessageFile;
                        _logger.LogError(exMessageFile ?? TransactionMessage.SaveSuccess);
                        return response;
                    }

                    entidad.evidenciaAnotacionArchivo = responseEvidenciaFile.PathFile;
                    entidad.oficioAnotacionArchivo = responseOficioFile.PathFile;
                }

                entidad.usuarioReg = string.IsNullOrEmpty(TokenSesion) ? AuthenticationMessage.DefaultUserId : BaseControl.IdUsuarioAuditoria(TokenSesion);
                entidad.activo = EstadosAuditoria.activo;

                var result = _unitOfWork.InformeRenac.UpdateRegistroAnotacion(entidad);

                if (result.Error)
                {
                    response.IsSuccess = false;
                    response.Message = result.Message;
                    _logger.LogError(result.Message ?? TransactionMessage.GenericErrorMessage);
                    return response;
                }

                response.IsSuccess = true;
                response.Message = response.Message;
                _logger.LogInformation(response.Message ?? TransactionMessage.SaveSuccess);
            }
            catch (Exception ex)
            {
                response.Message = ex.Message;
                _logger.LogError(ex.Message);
            }

            return response;
        }

        public Response<bool> UpdateConstanciaAnotacionFirmada(Request<InformeRenacDto> request)
        {
            var response = new Response<bool>();
            var responseFile = new ResponseFile();

            var validation = _informeRenacValidationManager.Validate(_mapper.Map<UpdateConstanciaAnotacionFirmadaRequest>(request.entidad));

            if (!validation.IsValid)
            {
                response.Message = Validation.InvalidMessage;
                response.Errors = validation.Errors;
                return response;
            }
            try
            {
                InformeRenac entidad = _mapper.Map<InformeRenac>(request.entidad);

                if (!string.IsNullOrEmpty(request.entidad.constanciaAnotacionFirmadaArchivo64))
                {
                    responseFile = FileUploadUtility.SaveBase64File(request.entidad.constanciaAnotacionFirmadaArchivo64,
                                                                request.entidad.constanciaAnotacionFirmadaArchivo,
                                                                FileApplicationKeys.PathConstanciaAnotacionFirmada.ToString(),
                                                                FilesName.ConstanciaAnotacionFirmadaRenac);

                    if (responseFile.Error)
                    {
                        response.IsSuccess = false;
                        response.Message = responseFile.MessageException;
                        _logger.LogError(responseFile.Message ?? TransactionMessage.SaveSuccess);
                        return response;
                    }

                }

                entidad.constanciaAnotacionFirmadaArchivo = responseFile.PathFile;
                entidad.usuarioMod = string.IsNullOrEmpty(TokenSesion) ? AuthenticationMessage.DefaultUserId : BaseControl.IdUsuarioAuditoria(TokenSesion);
                entidad.activo = EstadosAuditoria.activo;

                var result = _unitOfWork.InformeRenac.UpdateConstanciaAnotacionFirmada(entidad);

                if (result.Error)
                {
                    response.IsSuccess = false;
                    response.Message = result.Message;
                    _logger.LogError(result.Message ?? TransactionMessage.GenericErrorMessage);
                    return response;
                }

                response.IsSuccess = true;
                response.Message = response.Message;
                _logger.LogInformation(response.Message ?? TransactionMessage.SaveSuccess);
            }
            catch (Exception ex)
            {
                response.Message = ex.Message;
                _logger.LogError(ex.Message);
            }

            return response;
        }

        public Response<List<InformeRenacDto>> GetListResponsableArchivoRegistroAnotacionPaginated(Request<InformeRenacDto> request, out int PageSize, out int PageNumber, out int TotalReg)
        {
            PageSize = 0;
            PageNumber = 0;
            TotalReg = 0;

            var response = new Response<List<InformeRenacDto>>();

            try
            {
                var entidad = _mapper.Map<InformeRenac>(request.entidad);

                var result = _unitOfWork.InformeRenac.GetListResponsableArchivoRegistroAnotacionPaginated(entidad, out PageSize, out PageNumber, out TotalReg);

                if (result.Data != null && result.Data.Count > 0)
                {
                    List<InformeRenac> Lista = new List<InformeRenac>();

                    foreach (var item in result.Data)
                    {
                        Lista.Add(new InformeRenac()
                        {
                            TotalReg = item.totalreg == null ? 0 : Convert.ToInt32(item.totalreg),
                            rownum = item.rownum,
                            idInformeRenac = item.idInformeRenac,
                            idCircunscripcion = item.idCircunscripcion,
                            idEstadoDerivacion = item.idEstadoDerivacion,
                            numero = item.numero,
                            solicitudGore = item.solicitudGore,
                            constanciaAnotacionArchivo = item.constanciaAnotacionArchivo,
                            constanciaAnotacionFirmadaArchivo = item.constanciaAnotacionFirmadaArchivo,
                            informeFavorableArchivo = item.informefavorablearchivo,
                            respuestaGoreArchivo = item.respuestaGoreArchivo,
                            evaluacionFavorable = item.evaluacionFavorable,
                            estadoDerivacion = item.estadoderivacion,
                            esDerivado = item.esderivado,
                            procesoAnotacionCerrado = item.procesoAnotacionCerrado,
                            Circunscripcion = new Circunscripcion()
                            {
                                NombreCircunscripcion = item.nombrecircunscripcion
                            }
                        });
                    }

                    response.Data = _mapper.Map<List<InformeRenacDto>>(Lista);
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

        public Response<bool> UpdateCerrarProcesoAnotacion(Request<InformeRenacDto> request)
        {
            var response = new Response<bool>();

            var validation = _informeRenacValidationManager.Validate(_mapper.Map<CerrarProcesoAnotacionRequest>(request.entidad));

            if (!validation.IsValid)
            {
                response.Message = Validation.InvalidMessage;
                response.Errors = validation.Errors;
                return response;
            }
            try
            {
                InformeRenac entidad = _mapper.Map<InformeRenac>(request.entidad);

                entidad.usuarioReg = string.IsNullOrEmpty(TokenSesion) ? AuthenticationMessage.DefaultUserId : BaseControl.IdUsuarioAuditoria(TokenSesion);
                entidad.activo = EstadosAuditoria.activo;

                var result = _unitOfWork.InformeRenac.UpdateCerrarProcesoAnotacion(entidad);

                if (result.Error)
                {
                    response.IsSuccess = false;
                    response.Message = result.Message;
                    _logger.LogError(result.Message ?? TransactionMessage.GenericErrorMessage);
                    return response;
                }

                response.IsSuccess = true;
                response.Message = response.Message;
                _logger.LogInformation(response.Message ?? TransactionMessage.SaveSuccess);
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
