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
    public class TipoAsientoApplication : ITipoAsientoApplication
    {
        private readonly IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;
        private readonly IAppLogger<TipoAsientoApplication> _logger;
        private readonly TipoAsientoValidationManager _tipoAsientoValidationManager;
        public string TokenSesion { get; set; }

        public TipoAsientoApplication(IUnitOfWork unitOfWork, IMapper mapper, IAppLogger<TipoAsientoApplication> logger, TipoAsientoValidationManager tipoAsientoManager)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
            _logger = logger;
            _tipoAsientoValidationManager = tipoAsientoManager;
        }

        public Response<bool> Insert(Request<TipoAsientoDto> request)
        {
            var response = new Response<bool>();

            var validation = _tipoAsientoValidationManager.Validate(_mapper.Map<TipoAsientoInsertRequest>(request.entidad));

            if (!validation.IsValid)
            {
                response.Message = Validation.InvalidMessage;
                response.Errors = validation.Errors;
                return response;
            }
            try
            {
                TipoAsiento entidad = _mapper.Map<TipoAsiento>(request.entidad);

                entidad.usuarioReg = string.IsNullOrEmpty(TokenSesion) ? AuthenticationMessage.DefaultUserId : BaseControl.IdUsuarioAuditoria(TokenSesion);
                entidad.activo = EstadosAuditoria.activo;

                var result = _unitOfWork.TipoAsiento.Insert(entidad);

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

        public Response<bool> Update(Request<TipoAsientoDto> request)
        {
            var response = new Response<bool>();

            var validation = _tipoAsientoValidationManager.Validate(_mapper.Map<TipoAsientoUpdateRequest>(request.entidad));

            if (!validation.IsValid)
            {
                response.Message = Validation.InvalidMessage;
                response.Errors = validation.Errors;
                return response;
            }

            try
            {
                var entidad = _mapper.Map<TipoAsiento>(request.entidad);

                entidad.idTipoAsiento = request.entidad.idTipoAsiento;
                entidad.usuarioMod = string.IsNullOrEmpty(TokenSesion) ? AuthenticationMessage.DefaultUserId : BaseControl.IdUsuarioAuditoria(TokenSesion);
                entidad.activo = EstadosAuditoria.activo;

                var result = _unitOfWork.TipoAsiento.Update(entidad);

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

        public Response<bool> Delete(Request<TipoAsientoDto> request)
        {
            var response = new Response<bool>();

            var validation = _tipoAsientoValidationManager.Validate(_mapper.Map<TipoAsientoIdRequest>(request.entidad));

            if (!validation.IsValid)
            {
                response.Message = Validation.InvalidMessage;
                response.Errors = validation.Errors;
                return response;
            }

            try
            {
                var entidad = _mapper.Map<TipoAsiento>(request.entidad);

                entidad.idTipoAsiento = request.entidad.idTipoAsiento;
                entidad.usuarioMod = string.IsNullOrEmpty(TokenSesion) ? AuthenticationMessage.DefaultUserId : BaseControl.IdUsuarioAuditoria(TokenSesion);

                var result = _unitOfWork.TipoAsiento.Delete(entidad);

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

        public Response<TipoAsientoDto> GetById(Request<TipoAsientoDto> request)
        {
            var response = new Response<TipoAsientoDto>();

            var validation = _tipoAsientoValidationManager.Validate(_mapper.Map<TipoAsientoIdRequest>(request.entidad));

            try
            {
                if (!validation.IsValid)
                {
                    response.Message = Validation.InvalidMessage;
                    response.Errors = validation.Errors;
                    return response;
                }

                var entidad = _mapper.Map<TipoAsiento>(request.entidad);

                entidad.idTipoAsiento = request.entidad.idTipoAsiento;

                var result = _unitOfWork.TipoAsiento.GetById(entidad);

                if (result.Error)
                {
                    response.IsSuccess = false;
                    response.Message = result.Message;
                    _logger.LogError(result.Message);
                    return response;
                }

                response.IsSuccess = true;
                response.Data = _mapper.Map<TipoAsientoDto>(result.Data);
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

        public Response<List<TipoAsientoDto>> GetList(Request<TipoAsientoDto> request)
        {
            var response = new Response<List<TipoAsientoDto>>();

            try
            {
                var entidad = _mapper.Map<TipoAsiento>(request.entidad);

                var result = _unitOfWork.TipoAsiento.GetList(entidad);

                if (result.Data != null)
                {
                    List<TipoAsiento> Lista = new List<TipoAsiento>();

                    foreach (var item in result.Data)
                    {
                        Lista.Add(new TipoAsiento()
                        {
                            idTipoAsiento = item.idTipoAsiento,
                            codigo = item.codigo,
                            descripcion = item.descripcion,
                            activo = item.activo
                        });
                    }
                    response.Data = _mapper.Map<List<TipoAsientoDto>>(Lista);
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

        public Response<List<TipoAsientoDto>> GetListPaginated(Request<TipoAsientoDto> request, out int PageSize, out int PageNumber, out int TotalReg)
        {
            PageSize = 0;
            PageNumber = 0;
            TotalReg = 0;

            var response = new Response<List<TipoAsientoDto>>();

            try
            {
                var entidad = _mapper.Map<TipoAsiento>(request.entidad);

                var result = _unitOfWork.TipoAsiento.GetListPaginated(entidad, out PageSize, out PageNumber, out TotalReg);

                if (result.Data != null && result.Data.Count > 0)
                {
                    List<TipoAsiento> Lista = new List<TipoAsiento>();

                    foreach (var item in result.Data)
                    {
                        Lista.Add(new TipoAsiento()
                        {
                            idTipoAsiento = item.idTipoAsiento,
                            codigo = item.codigo,
                            descripcion = item.descripcion,
                            activo = item.activo,
                            rownum = item.rownum,
                            fechaReg = item.fechaReg,
                            TotalReg = item.totalreg == null ? 0 : Convert.ToInt32(item.totalreg)
                        });
                    }

                   
                    response.Data = _mapper.Map<List<TipoAsientoDto>>(Lista);                    
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
