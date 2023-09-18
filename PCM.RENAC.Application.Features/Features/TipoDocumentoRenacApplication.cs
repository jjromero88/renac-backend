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
    public class TipoDocumentoRenacApplication : ITipoDocumentoRenacApplication
    {
        private readonly IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;
        private readonly IAppLogger<TipoDocumentoRenacApplication> _logger;
        private readonly TipoDocumentoRenacValidationManager _tipoDocumentoRenacValidationManager;

        public string TokenSesion { get; set; }

        public TipoDocumentoRenacApplication(IUnitOfWork unitOfWork, IMapper mapper, IAppLogger<TipoDocumentoRenacApplication> logger, TipoDocumentoRenacValidationManager tipoDocumentoRenacManager)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
            _logger = logger;
            _tipoDocumentoRenacValidationManager = tipoDocumentoRenacManager;
        }

        public Response<bool> Insert(Request<TipoDocumentoRenacDto> request)
        {
            var response = new Response<bool>();
            var responseFile = new ResponseFile();

            var validation = _tipoDocumentoRenacValidationManager.Validate(_mapper.Map<TipoDocumentoRenacInsertRequest>(request.entidad));

            if (!validation.IsValid)
            {
                response.Message = Validation.InvalidMessage;
                response.Errors = validation.Errors;
                return response;
            }
            try
            {
                TipoDocumentoRenac entidad = _mapper.Map<TipoDocumentoRenac>(request.entidad);

                entidad.usuarioReg = string.IsNullOrEmpty(TokenSesion) ? AuthenticationMessage.DefaultUserId : BaseControl.IdUsuarioAuditoria(TokenSesion);
                entidad.activo = EstadosAuditoria.activo;

                var result = _unitOfWork.TipoDocumentoRenac.Insert(entidad);

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

        public Response<bool> Update(Request<TipoDocumentoRenacDto> request)
        {
            var response = new Response<bool>();
            var responseFile = new ResponseFile();

            var validation = _tipoDocumentoRenacValidationManager.Validate(_mapper.Map<TipoDocumentoRenacUpdateRequest>(request.entidad));

            if (!validation.IsValid)
            {
                response.Message = Validation.InvalidMessage;
                response.Errors = validation.Errors;
                return response;
            }

            try
            {
                var entidad = _mapper.Map<TipoDocumentoRenac>(request.entidad);

                entidad.usuarioMod = string.IsNullOrEmpty(TokenSesion) ? AuthenticationMessage.DefaultUserId : BaseControl.IdUsuarioAuditoria(TokenSesion);
                entidad.activo = EstadosAuditoria.activo;

                var result = _unitOfWork.TipoDocumentoRenac.Update(entidad);

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

        public Response<bool> Delete(Request<TipoDocumentoRenacDto> request)
        {
            var response = new Response<bool>();

            var validation = _tipoDocumentoRenacValidationManager.Validate(_mapper.Map<TipoDocumentoRenacIdRequest>(request.entidad));

            if (!validation.IsValid)
            {
                response.Message = Validation.InvalidMessage;
                response.Errors = validation.Errors;
                return response;
            }

            try
            {
                var entidad = _mapper.Map<TipoDocumentoRenac>(request.entidad);

                entidad.usuarioMod = string.IsNullOrEmpty(TokenSesion) ? AuthenticationMessage.DefaultUserId : BaseControl.IdUsuarioAuditoria(TokenSesion);

                var result = _unitOfWork.TipoDocumentoRenac.Delete(entidad);

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

        public Response<TipoDocumentoRenacDto> GetById(Request<TipoDocumentoRenacDto> request)
        {
            var response = new Response<TipoDocumentoRenacDto>();

            var validation = _tipoDocumentoRenacValidationManager.Validate(_mapper.Map<TipoDocumentoRenacIdRequest>(request.entidad));

            try
            {
                if (!validation.IsValid)
                {
                    response.Message = Validation.InvalidMessage;
                    response.Errors = validation.Errors;
                    return response;
                }

                var entidad = _mapper.Map<TipoDocumentoRenac>(request.entidad);

                var result = _unitOfWork.TipoDocumentoRenac.GetById(entidad);

                if (result.Error)
                {
                    response.IsSuccess = false;
                    response.Message = result.Message;
                    _logger.LogError(result.Message);
                    return response;
                }

                if (result.Data != null)
                {
                    entidad = new TipoDocumentoRenac
                    {
                        idTipoDocumentoRenac = result.Data.idtipodocumentorenac,
                        codigo = result.Data.codigo,
                        descripcion= result.Data.descripcion,
                        activo = result.Data.activo,
                        fechaReg = result.Data.fechareg,
                        fechaMod = result.Data.fechamod,
                        usuarioReg = result.Data.usuarioreg,
                        usuarioMod = result.Data.usuariomod
                    };
                }

                response.IsSuccess = true;
                response.Data = _mapper.Map<TipoDocumentoRenacDto>(entidad);
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

        public Response<List<TipoDocumentoRenacDto>> GetList(Request<TipoDocumentoRenacDto> request)
        {
            var response = new Response<List<TipoDocumentoRenacDto>>();

            try
            {
                var entidad = _mapper.Map<TipoDocumentoRenac>(request.entidad);

                var result = _unitOfWork.TipoDocumentoRenac.GetList(entidad);

                if (result.Data != null)
                {
                    List<TipoDocumentoRenac> Lista = new List<TipoDocumentoRenac>();

                    foreach (var item in result.Data)
                    {
                        Lista.Add(new TipoDocumentoRenac()
                        {
                            idTipoDocumentoRenac = item.idTipoDocumentoRenac,
                            codigo = item.codigo,
                            descripcion = item.descripcion,
                            activo = item.activo,
                            fechaReg = item.fechaReg,
                            fechaMod = item.fechaMod,
                            usuarioReg = item.usuarioReg,
                            usuarioMod = item.usuarioMod
                        });
                    }

                    response.Data = _mapper.Map<List<TipoDocumentoRenacDto>>(Lista);
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

        public Response<List<TipoDocumentoRenacDto>> GetListPaginated(Request<TipoDocumentoRenacDto> request, out int PageSize, out int PageNumber, out int TotalReg)
        {
            PageSize = 0;
            PageNumber = 0;
            TotalReg = 0;

            var response = new Response<List<TipoDocumentoRenacDto>>();

            try
            {
                var entidad = _mapper.Map<TipoDocumentoRenac>(request.entidad);

                var result = _unitOfWork.TipoDocumentoRenac.GetListPaginated(entidad, out PageSize, out PageNumber, out TotalReg);

                if (result.Data != null && result.Data.Count > 0)
                {
                    List<TipoDocumentoRenac> Lista = new List<TipoDocumentoRenac>();

                    foreach (var item in result.Data)
                    {
                        Lista.Add(new TipoDocumentoRenac()
                        {
                            idTipoDocumentoRenac = item.idTipoDocumentoRenac,
                            codigo = item.codigo,
                            descripcion = item.descripcion,
                            activo = item.activo,
                            fechaReg = item.fechaReg,
                            fechaMod = item.fechaMod,
                            usuarioReg = item.usuarioReg,
                            usuarioMod = item.usuarioMod,
                            rownum = item.rownum,
                            TotalReg = item.totalreg == null ? 0 : Convert.ToInt32(item.totalreg)
                        });
                    }

                    response.Data = _mapper.Map<List<TipoDocumentoRenacDto>>(Lista);
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
     
    }
}
