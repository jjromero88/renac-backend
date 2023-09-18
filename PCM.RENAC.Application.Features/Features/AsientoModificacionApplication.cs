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
    public class AsientoModificacionApplication : IAsientoModificacionApplication
    {
        private readonly IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;
        private readonly IAppLogger<AsientoModificacionApplication> _logger;
        private readonly AsientoModificacionValidationManager _asientoModificacionValidationManager;
        public string TokenSesion { get; set; }

        public AsientoModificacionApplication(IUnitOfWork unitOfWork, IMapper mapper, IAppLogger<AsientoModificacionApplication> logger, AsientoModificacionValidationManager asientoModificacionManager)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
            _logger = logger;
            _asientoModificacionValidationManager = asientoModificacionManager;
        }

        public Response<bool> Insert(Request<AsientoModificacionDto> request)
        {
            var response = new Response<bool>();

            var validation = _asientoModificacionValidationManager.Validate(_mapper.Map<AsientoModificacionInsertRequest>(request.entidad));

            if (!validation.IsValid)
            {
                response.Message = Validation.InvalidMessage;
                response.Errors = validation.Errors;
                return response;
            }
            try
            {
                AsientoModificacion entidad = _mapper.Map<AsientoModificacion>(request.entidad);

                entidad.usuarioReg = string.IsNullOrEmpty(TokenSesion) ? AuthenticationMessage.DefaultUserId : BaseControl.IdUsuarioAuditoria(TokenSesion);
                entidad.activo = EstadosAuditoria.activo;

                var result = _unitOfWork.AsientoModificacion.Insert(entidad);

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

        public Response<bool> Update(Request<AsientoModificacionDto> request)
        {
            var response = new Response<bool>();

            var validation = _asientoModificacionValidationManager.Validate(_mapper.Map<AsientoModificacionUpdateRequest>(request.entidad));

            if (!validation.IsValid)
            {
                response.Message = Validation.InvalidMessage;
                response.Errors = validation.Errors;
                return response;
            }

            try
            {
                var entidad = _mapper.Map<AsientoModificacion>(request.entidad);

                entidad.idAsientoModificacion = request.entidad.idAsientoModificacion;
                entidad.usuarioMod = string.IsNullOrEmpty(TokenSesion) ? AuthenticationMessage.DefaultUserId : BaseControl.IdUsuarioAuditoria(TokenSesion);
                entidad.activo = EstadosAuditoria.activo;

                var result = _unitOfWork.AsientoModificacion.Update(entidad);

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

        public Response<bool> Delete(Request<AsientoModificacionDto> request)
        {
            var response = new Response<bool>();

            var validation = _asientoModificacionValidationManager.Validate(_mapper.Map<AsientoModificacionIdRequest>(request.entidad));

            if (!validation.IsValid)
            {
                response.Message = Validation.InvalidMessage;
                response.Errors = validation.Errors;
                return response;
            }

            try
            {
                var entidad = _mapper.Map<AsientoModificacion>(request.entidad);

                entidad.idAsientoModificacion = request.entidad.idAsientoModificacion;
                entidad.usuarioMod = string.IsNullOrEmpty(TokenSesion) ? AuthenticationMessage.DefaultUserId : BaseControl.IdUsuarioAuditoria(TokenSesion);

                var result = _unitOfWork.AsientoModificacion.Delete(entidad);

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

        public Response<AsientoModificacionDto> GetById(Request<AsientoModificacionDto> request)
        {
            var response = new Response<AsientoModificacionDto>();

            var validation = _asientoModificacionValidationManager.Validate(_mapper.Map<AsientoModificacionIdRequest>(request.entidad));

            try
            {
                if (!validation.IsValid)
                {
                    response.Message = Validation.InvalidMessage;
                    response.Errors = validation.Errors;
                    return response;
                }

                var entidad = _mapper.Map<AsientoModificacion>(request.entidad);

                entidad.idAsientoModificacion = request.entidad.idAsientoModificacion;

                var result = _unitOfWork.AsientoModificacion.GetById(entidad);

                if (result.Error)
                {
                    response.IsSuccess = false;
                    response.Message = result.Message;
                    _logger.LogError(result.Message);
                    return response;
                }

                response.IsSuccess = true;
                response.Data = _mapper.Map<AsientoModificacionDto>(result.Data);
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

        public Response<List<AsientoModificacionDto>> GetList(Request<AsientoModificacionDto> request)
        {
            var response = new Response<List<AsientoModificacionDto>>();

            try
            {
                var entidad = _mapper.Map<AsientoModificacion>(request.entidad);

                var result = _unitOfWork.AsientoModificacion.GetList(entidad);

                if (result.Data != null)
                {
                    List<AsientoModificacion> Lista = new List<AsientoModificacion>();

                    foreach (var item in result.Data)
                    {
                        Lista.Add(new AsientoModificacion()
                        {
                            idAsientoModificacion = item.idAsientoModificacion,
                            idAsientoCircunscripcion = item.idAsientoCircunscripcion,
                            idTipoModificacionAsiento = item.idTipoModificacionAsiento,
                            activo = item.activo
                        });
                    }

                    response.Data = _mapper.Map<List<AsientoModificacionDto>>(Lista);
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

        public Response<List<AsientoModificacionDto>> GetListPaginated(Request<AsientoModificacionDto> request, out int PageSize, out int PageNumber, out int TotalReg)
        {
            PageSize = 0;
            PageNumber = 0;
            TotalReg = 0;

            var response = new Response<List<AsientoModificacionDto>>();

            try
            {
                var entidad = _mapper.Map<AsientoModificacion>(request.entidad);

                var result = _unitOfWork.AsientoModificacion.GetListPaginated(entidad, out PageSize, out PageNumber, out TotalReg);

                if (result.Data != null && result.Data.Count > 0)
                {
                    List<AsientoModificacion> Lista = new List<AsientoModificacion>();

                    foreach (var item in result.Data)
                    {
                        Lista.Add(new AsientoModificacion()
                        {
                            idAsientoModificacion = item.idAsientoModificacion,
                            idAsientoCircunscripcion = item.idAsientoCircunscripcion,
                            idTipoModificacionAsiento = item.idTipoModificacionAsiento,
                            activo = item.activo,
                            rownum = item.rownum,
                            TotalReg = item.totalreg == null ? 0 : Convert.ToInt32(item.totalreg)
                        });
                    }

                    response.Data = _mapper.Map<List<AsientoModificacionDto>>(Lista);
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
