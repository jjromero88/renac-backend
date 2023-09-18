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
    public class ParametricasRenacApplication : IParametricasRenacApplication
    {
        private readonly IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;
        private readonly IAppLogger<ParametricasRenacApplication> _logger;
        private readonly ParametricasRenacValidationManager _parametricasRenacValidationManager;
        public string TokenSesion { get; set; }

        public ParametricasRenacApplication(IUnitOfWork unitOfWork, IMapper mapper, IAppLogger<ParametricasRenacApplication> logger, ParametricasRenacValidationManager parametricasRenacValidationManager)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
            _logger = logger;
            _parametricasRenacValidationManager = parametricasRenacValidationManager;
        }

        public Response<bool> Insert(Request<ParametricasRenacDto> request)
        {
            var response = new Response<bool>();

            var validation = _parametricasRenacValidationManager.Validate(_mapper.Map<ParametricasRenacInsertRequest>(request.entidad));

            if (!validation.IsValid)
            {
                response.Message = Validation.InvalidMessage;
                response.Errors = validation.Errors;
                return response;
            }
            try
            {
                ParametricasRenac entidad = _mapper.Map<ParametricasRenac>(request.entidad);

                entidad.usuarioReg = string.IsNullOrEmpty(TokenSesion) ? AuthenticationMessage.DefaultUserId : BaseControl.IdUsuarioAuditoria(TokenSesion);
                entidad.activo = EstadosAuditoria.activo;

                var result = _unitOfWork.ParametricasRenac.Insert(entidad);

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

        public Response<bool> Update(Request<ParametricasRenacDto> request)
        {
            var response = new Response<bool>();

            var validation = _parametricasRenacValidationManager.Validate(_mapper.Map<ParametricasRenacUpdateRequest>(request.entidad));

            if (!validation.IsValid)
            {
                response.Message = Validation.InvalidMessage;
                response.Errors = validation.Errors;
                return response;
            }

            try
            {
                var entidad = _mapper.Map<ParametricasRenac>(request.entidad);

                entidad.usuarioMod = string.IsNullOrEmpty(TokenSesion) ? AuthenticationMessage.DefaultUserId : BaseControl.IdUsuarioAuditoria(TokenSesion);
                entidad.activo = EstadosAuditoria.activo;

                var result = _unitOfWork.ParametricasRenac.Update(entidad);

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

        public Response<bool> Delete(Request<ParametricasRenacDto> request)
        {
            var response = new Response<bool>();

            var validation = _parametricasRenacValidationManager.Validate(_mapper.Map<ParametricasRenacIdRequest>(request.entidad));

            if (!validation.IsValid)
            {
                response.Message = Validation.InvalidMessage;
                response.Errors = validation.Errors;
                return response;
            }

            try
            {
                var entidad = _mapper.Map<ParametricasRenac>(request.entidad);

                entidad.usuarioMod = string.IsNullOrEmpty(TokenSesion) ? AuthenticationMessage.DefaultUserId : BaseControl.IdUsuarioAuditoria(TokenSesion);

                var result = _unitOfWork.ParametricasRenac.Delete(entidad);

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

        public Response<ParametricasRenacDto> GetById(Request<ParametricasRenacDto> request)
        {
            var response = new Response<ParametricasRenacDto>();
            var validation = _parametricasRenacValidationManager.Validate(_mapper.Map<ParametricasRenacIdRequest>(request.entidad));

            try
            {
                if (!validation.IsValid)
                {
                    response.Message = Validation.InvalidMessage;
                    response.Errors = validation.Errors;
                    return response;
                }

                var entidad = _mapper.Map<ParametricasRenac>(request.entidad);
                var result = _unitOfWork.ParametricasRenac.GetById(entidad);

                if (result.Error)
                {
                    response.IsSuccess = false;
                    response.Message = result.Message;
                    _logger.LogError(result.Message ?? string.Empty);
                    return response;
                }

                if (result.Data != null)
                {
                    entidad = new ParametricasRenac
                    {
                        idParametricasRenac = result.Data.idParametricasRenac,
                        idPadre = result.Data.idPadre,
                        idGrupo = result.Data.idGrupo,
                        codigo = result.Data.codigo,
                        descripcion = result.Data.descripcion,
                        activo = result.Data.activo,
                        fechaReg = result.Data.fechaReg,
                        fechaMod = result.Data.fechaMod,
                        usuarioReg = result.Data.usuarioReg,
                        usuarioMod = result.Data.usuarioMod
                    };
                }

                response.IsSuccess = true;
                response.Data = _mapper.Map<ParametricasRenacDto>(entidad);
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

        public Response<List<ParametricasRenacDto>> GetList(Request<ParametricasRenacDto> request)
        {
            var response = new Response<List<ParametricasRenacDto>>();

            try
            {
                var entidad = _mapper.Map<ParametricasRenac>(request.entidad);
                var result = _unitOfWork.ParametricasRenac.GetList(entidad);

                if (result.Data != null)
                {
                    List<ParametricasRenac> lista = result.Data.Select(row =>
                    {
                        var item = new ParametricasRenac
                        {
                            idParametricasRenac = row.idParametricasRenac,
                            idPadre = row.idPadre,
                            idGrupo = row.idGrupo,
                            codigo = row.codigo,
                            descripcion = row.descripcion,
                            activo = row.activo,
                            fechaReg = row.fechaReg,
                            fechaMod = row.fechaMod,
                            usuarioReg = row.usuarioReg,
                            usuarioMod = row.usuarioMod
                        };
                        return item;
                    }).ToList();

                    response.Data = _mapper.Map<List<ParametricasRenacDto>>(lista);
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

        public Response<List<ParametricasRenacDto>> GetListPaginated(Request<ParametricasRenacDto> request, out int PageSize, out int PageNumber, out int TotalReg)
        {
            PageSize = 0;
            PageNumber = 0;
            TotalReg = 0;

            var response = new Response<List<ParametricasRenacDto>>();

            try
            {
                var entidad = _mapper.Map<ParametricasRenac>(request.entidad);
                var result = _unitOfWork.ParametricasRenac.GetListPaginated(entidad, out PageSize, out PageNumber, out TotalReg);

                if (result.Data != null && result.Data.Count > 0)
                {
                    List<ParametricasRenac> Lista = new List<ParametricasRenac>();

                    foreach (var item in result.Data)
                    {
                        Lista.Add(new ParametricasRenac()
                        {
                            TotalReg = item.totalreg == null ? 0 : Convert.ToInt32(item.totalreg),
                            rownum = item.rownum,
                            idParametricasRenac = item.idParametricasRenac,
                            idPadre = item.idPadre,
                            idGrupo = item.idGrupo,
                            codigo = item.codigo,
                            descripcion = item.descripcion,
                            activo = item.activo,
                            fechaReg = item.fechaReg,
                            fechaMod = item.fechaMod,
                            usuarioReg = item.usuarioReg,
                            usuarioMod = item.usuarioMod
                        });
                    }

                    response.Data = _mapper.Map<List<ParametricasRenacDto>>(Lista);
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
