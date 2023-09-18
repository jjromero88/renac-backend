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
    public class CircunscripcionOrigenDestinoApplication : ICircunscripcionOrigenDestinoApplication
    {
        private readonly IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;
        private readonly IAppLogger<CircunscripcionOrigenDestinoApplication> _logger;
        private readonly CircunscripcionOrigenDestinoValidationManager _circunscripcionOrigenDestinoValidationManager;

        public string TokenSesion { get; set; }

        public CircunscripcionOrigenDestinoApplication(IUnitOfWork unitOfWork, IMapper mapper, IAppLogger<CircunscripcionOrigenDestinoApplication> logger, CircunscripcionOrigenDestinoValidationManager circunscripcionOrigenDestinoManager)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
            _logger = logger;
            _circunscripcionOrigenDestinoValidationManager = circunscripcionOrigenDestinoManager;
        }
        public Response<bool> Insert(Request<CircunscripcionOrigenDestinoDto> request)
        {
            var response = new Response<bool>();

            var validation = _circunscripcionOrigenDestinoValidationManager.Validate(_mapper.Map<CircunscripcionOrigenDestinoInsertRequest>(request.entidad));

            if (!validation.IsValid)
            {
                response.Message = Validation.InvalidMessage;
                response.Errors = validation.Errors;
                return response;
            }
            try
            {
                CircunscripcionOrigenDestino entidad = _mapper.Map<CircunscripcionOrigenDestino>(request.entidad);

                entidad.usuarioReg = string.IsNullOrEmpty(TokenSesion) ? AuthenticationMessage.DefaultUserId : BaseControl.IdUsuarioAuditoria(TokenSesion);
                entidad.activo = EstadosAuditoria.activo;

                var result = _unitOfWork.CircunscripcionOrigenDestino.Insert(entidad);

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

        public Response<bool> Update(Request<CircunscripcionOrigenDestinoDto> request)
        {
            var response = new Response<bool>();

            var validation = _circunscripcionOrigenDestinoValidationManager.Validate(_mapper.Map<CircunscripcionOrigenDestinoUpdateRequest>(request.entidad));

            if (!validation.IsValid)
            {
                response.Message = Validation.InvalidMessage;
                response.Errors = validation.Errors;
                return response;
            }

            try
            {
                var entidad = _mapper.Map<CircunscripcionOrigenDestino>(request.entidad);

                entidad.idCircunscripcionOrigenDestino = request.entidad.idCircunscripcionOrigenDestino;
                entidad.usuarioMod = string.IsNullOrEmpty(TokenSesion) ? AuthenticationMessage.DefaultUserId : BaseControl.IdUsuarioAuditoria(TokenSesion);
                entidad.activo = EstadosAuditoria.activo;

                var result = _unitOfWork.CircunscripcionOrigenDestino.Update(entidad);

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
        public Response<bool> Delete(Request<CircunscripcionOrigenDestinoDto> request)
        {
            var response = new Response<bool>();

            var validation = _circunscripcionOrigenDestinoValidationManager.Validate(_mapper.Map<CircunscripcionOrigenDestinoIdRequest>(request.entidad));

            if (!validation.IsValid)
            {
                response.Message = Validation.InvalidMessage;
                response.Errors = validation.Errors;
                return response;
            }

            try
            {
                var entidad = _mapper.Map<CircunscripcionOrigenDestino>(request.entidad);

                entidad.idCircunscripcionOrigenDestino = request.entidad.idCircunscripcionOrigenDestino;
                entidad.usuarioMod = string.IsNullOrEmpty(TokenSesion) ? AuthenticationMessage.DefaultUserId : BaseControl.IdUsuarioAuditoria(TokenSesion);

                var result = _unitOfWork.CircunscripcionOrigenDestino.Delete(entidad);

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

        public Response<CircunscripcionOrigenDestinoDto> GetById(Request<CircunscripcionOrigenDestinoDto> request)
        {
            var response = new Response<CircunscripcionOrigenDestinoDto>();

            var validation = _circunscripcionOrigenDestinoValidationManager.Validate(_mapper.Map<CircunscripcionOrigenDestinoIdRequest>(request.entidad));

            try
            {
                if (!validation.IsValid)
                {
                    response.Message = Validation.InvalidMessage;
                    response.Errors = validation.Errors;
                    return response;
                }

                var entidad = _mapper.Map<CircunscripcionOrigenDestino>(request.entidad);

                entidad.idCircunscripcionOrigenDestino = request.entidad.idCircunscripcionOrigenDestino;

                var result = _unitOfWork.CircunscripcionOrigenDestino.GetById(entidad);

                if (result.Error)
                {
                    response.IsSuccess = false;
                    response.Message = result.Message;
                    _logger.LogError(result.Message);
                    return response;
                }

                response.IsSuccess = true;
                response.Data = _mapper.Map<CircunscripcionOrigenDestinoDto>(result.Data);
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

        public Response<List<CircunscripcionOrigenDestinoDto>> GetList(Request<CircunscripcionOrigenDestinoDto> request)
        {
            var response = new Response<List<CircunscripcionOrigenDestinoDto>>();

            try
            {
                var entidad = _mapper.Map<CircunscripcionOrigenDestino>(request.entidad);

                var result = _unitOfWork.CircunscripcionOrigenDestino.GetList(entidad);

                if (result.Data != null)
                {
                    List<CircunscripcionOrigenDestino> Lista = new List<CircunscripcionOrigenDestino>();

                    foreach (var item in result.Data)
                    {
                        Lista.Add(new CircunscripcionOrigenDestino()
                        {
                            idCircunscripcionOrigenDestino = item.idCircunscripcionOrigenDestino,
                            idAsientoCircunscripcion = item.idAsientoCircunscripcion,
                            nombreCircunscripcion = item.nombreCircunscripcion,
                            origenDestino = item.origenDestino,
                            activo = item.activo
                        });
                    }

                    response.Data = _mapper.Map<List<CircunscripcionOrigenDestinoDto>>(Lista);
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

        public Response<List<CircunscripcionOrigenDestinoDto>> GetListPaginated(Request<CircunscripcionOrigenDestinoDto> request, out int PageSize, out int PageNumber, out int TotalReg)
        {
            PageSize = 0;
            PageNumber = 0;
            TotalReg = 0;

            var response = new Response<List<CircunscripcionOrigenDestinoDto>>();

            try
            {
                var entidad = _mapper.Map<CircunscripcionOrigenDestino>(request.entidad);

                var result = _unitOfWork.CircunscripcionOrigenDestino.GetListPaginated(entidad, out PageSize, out PageNumber, out TotalReg);

                if (result.Data != null && result.Data.Count > 0)
                {
                    List<CircunscripcionOrigenDestino> Lista = new List<CircunscripcionOrigenDestino>();

                    foreach (var item in result.Data)
                    {
                        Lista.Add(new CircunscripcionOrigenDestino()
                        {
                            idCircunscripcionOrigenDestino = item.idCircunscripcionOrigenDestino,
                            idAsientoCircunscripcion = item.idAsientoCircunscripcion,
                            nombreCircunscripcion = item.nombreCircunscripcion,
                            origenDestino = item.origenDestino,
                            activo = item.activo,
                            rownum = item.rownum,
                            TotalReg = item.totalreg == null ? 0 : Convert.ToInt32(item.totalreg)
                        });
                    }

                    response.Data = _mapper.Map<List<CircunscripcionOrigenDestinoDto>>(Lista);
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
