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
    public class TipoModificacionAsientoApplication : ITipoModificacionAsientoApplication
    {
        private readonly IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;
        private readonly IAppLogger<TipoModificacionAsientoApplication> _logger;
        private readonly TipoModificacionAsientoValidationManager _tipoModificacionAsientoValidationManager;
        public string TokenSesion { get; set; }

        public TipoModificacionAsientoApplication(IUnitOfWork unitOfWork, IMapper mapper, IAppLogger<TipoModificacionAsientoApplication> logger, TipoModificacionAsientoValidationManager tipoModificacionAsientoManager)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
            _logger = logger;
            _tipoModificacionAsientoValidationManager = tipoModificacionAsientoManager;
        }

        public Response<bool> Insert(Request<TipoModificacionAsientoDto> request)
        {
            var response = new Response<bool>();

            var validation = _tipoModificacionAsientoValidationManager.Validate(_mapper.Map<TipoModificacionAsientoInsertRequest>(request.entidad));

            if (!validation.IsValid)
            {
                response.Message = Validation.InvalidMessage;
                response.Errors = validation.Errors;
                return response;
            }
            try
            {
                TipoModificacionAsiento entidad = _mapper.Map<TipoModificacionAsiento>(request.entidad);

                entidad.usuarioReg = string.IsNullOrEmpty(TokenSesion) ? AuthenticationMessage.DefaultUserId : BaseControl.IdUsuarioAuditoria(TokenSesion);
                entidad.activo = EstadosAuditoria.activo;

                var result = _unitOfWork.TipoModificacionAsiento.Insert(entidad);

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

        public Response<bool> Update(Request<TipoModificacionAsientoDto> request)
        {
            var response = new Response<bool>();

            var validation = _tipoModificacionAsientoValidationManager.Validate(_mapper.Map<TipoModificacionAsientoUpdateRequest>(request.entidad));

            if (!validation.IsValid)
            {
                response.Message = Validation.InvalidMessage;
                response.Errors = validation.Errors;
                return response;
            }

            try
            {
                var entidad = _mapper.Map<TipoModificacionAsiento>(request.entidad);

                entidad.idTipoModificacionAsiento = request.entidad.idTipoModificacionAsiento;
                entidad.usuarioMod = string.IsNullOrEmpty(TokenSesion) ? AuthenticationMessage.DefaultUserId : BaseControl.IdUsuarioAuditoria(TokenSesion);
                entidad.activo = EstadosAuditoria.activo;

                var result = _unitOfWork.TipoModificacionAsiento.Update(entidad);

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

        public Response<bool> Delete(Request<TipoModificacionAsientoDto> request)
        {
            var response = new Response<bool>();

            var validation = _tipoModificacionAsientoValidationManager.Validate(_mapper.Map<TipoModificacionAsientoIdRequest>(request.entidad));

            if (!validation.IsValid)
            {
                response.Message = Validation.InvalidMessage;
                response.Errors = validation.Errors;
                return response;
            }

            try
            {
                var entidad = _mapper.Map<TipoModificacionAsiento>(request.entidad);

                entidad.idTipoModificacionAsiento = request.entidad.idTipoModificacionAsiento;
                entidad.usuarioMod = string.IsNullOrEmpty(TokenSesion) ? AuthenticationMessage.DefaultUserId : BaseControl.IdUsuarioAuditoria(TokenSesion);

                var result = _unitOfWork.TipoModificacionAsiento.Delete(entidad);

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

        public Response<TipoModificacionAsientoDto> GetById(Request<TipoModificacionAsientoDto> request)
        {
            var response = new Response<TipoModificacionAsientoDto>();

            var validation = _tipoModificacionAsientoValidationManager.Validate(_mapper.Map<TipoModificacionAsientoIdRequest>(request.entidad));

            try
            {
                if (!validation.IsValid)
                {
                    response.Message = Validation.InvalidMessage;
                    response.Errors = validation.Errors;
                    return response;
                }

                var entidad = _mapper.Map<TipoModificacionAsiento>(request.entidad);

                entidad.idTipoModificacionAsiento = request.entidad.idTipoModificacionAsiento;

                var result = _unitOfWork.TipoModificacionAsiento.GetById(entidad);

                if (result.Error)
                {
                    response.IsSuccess = false;
                    response.Message = result.Message;
                    _logger.LogError(result.Message);
                    return response;
                }

                response.IsSuccess = true;
                response.Data = _mapper.Map<TipoModificacionAsientoDto>(result.Data);
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

        public Response<List<TipoModificacionAsientoDto>> GetList(Request<TipoModificacionAsientoDto> request)
        {
            var response = new Response<List<TipoModificacionAsientoDto>>();

            try
            {
                var entidad = _mapper.Map<TipoModificacionAsiento>(request.entidad);

                var result = _unitOfWork.TipoModificacionAsiento.GetList(entidad);

                if (result.Data != null)
                {
                    List<TipoModificacionAsiento> Lista = new List<TipoModificacionAsiento>();

                    foreach (var item in result.Data)
                    {
                        Lista.Add(new TipoModificacionAsiento()
                        {
                            idTipoModificacionAsiento = item.idTipoModificacionAsiento,
                            descripcion = item.descripcion,
                            activo = item.activo
                        });
                    }

                    response.Data = _mapper.Map<List<TipoModificacionAsientoDto>>(Lista);
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

        public Response<List<TipoModificacionAsientoDto>> GetListPaginated(Request<TipoModificacionAsientoDto> request, out int PageSize, out int PageNumber, out int TotalReg)
        {
            PageSize = 0;
            PageNumber = 0;
            TotalReg = 0;

            var response = new Response<List<TipoModificacionAsientoDto>>();

            try
            {
                var entidad = _mapper.Map<TipoModificacionAsiento>(request.entidad);

                var result = _unitOfWork.TipoModificacionAsiento.GetListPaginated(entidad, out PageSize, out PageNumber, out TotalReg);

                if (result.Data != null && result.Data.Count > 0)
                {
                    List<TipoModificacionAsiento> Lista = new List<TipoModificacionAsiento>();

                    foreach (var item in result.Data)
                    {
                        Lista.Add(new TipoModificacionAsiento()
                        {
                            idTipoModificacionAsiento = item.idTipoModificacionAsiento,
                            descripcion = item.descripcion,
                            activo = item.activo,
                            fechaReg = item.fechaReg,
                            rownum = item.rownum,
                            TotalReg = item.totalreg == null ? 0 : Convert.ToInt32(item.totalreg)
                        });
                    }

                    response.Data = _mapper.Map<List<TipoModificacionAsientoDto>>(Lista);
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
