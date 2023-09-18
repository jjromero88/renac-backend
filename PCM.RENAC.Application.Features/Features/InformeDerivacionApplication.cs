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
using System;

namespace PCM.RENAC.Application.Features
{
    public class InformeDerivacionApplication : IInformeDerivacionApplication
    {
        private readonly IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;
        private readonly IAppLogger<InformeDerivacionApplication> _logger;
        private readonly InformeDerivacionValidationManager _informeDerivacionValidationManager;

        public string TokenSesion { get; set; }

        public InformeDerivacionApplication(IUnitOfWork unitOfWork, IMapper mapper, IAppLogger<InformeDerivacionApplication> logger, InformeDerivacionValidationManager informeDerivacionManager)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
            _logger = logger;
            _informeDerivacionValidationManager = informeDerivacionManager;
        }

        public Response<bool> Insert(Request<InformeDerivacionDto> request)
        {
            var response = new Response<bool>();
            var responseFile = new ResponseFile();

            var validation = _informeDerivacionValidationManager.Validate(_mapper.Map<InformeDerivacionInsertRequest>(request.entidad));

            if (!validation.IsValid)
            {
                response.Message = Validation.InvalidMessage;
                response.Errors = validation.Errors;
                return response;
            }
            try
            {
                InformeDerivacion entidad = _mapper.Map<InformeDerivacion>(request.entidad);

                entidad.usuarioReg = string.IsNullOrEmpty(TokenSesion) ? AuthenticationMessage.DefaultUserId : BaseControl.IdUsuarioAuditoria(TokenSesion);
                entidad.activo = EstadosAuditoria.activo;

                var result = _unitOfWork.InformeDerivacion.Insert(entidad);

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

        public Response<bool> Update(Request<InformeDerivacionDto> request)
        {
            var response = new Response<bool>();
            var responseFile = new ResponseFile();

            var validation = _informeDerivacionValidationManager.Validate(_mapper.Map<InformeDerivacionUpdateRequest>(request.entidad));

            if (!validation.IsValid)
            {
                response.Message = Validation.InvalidMessage;
                response.Errors = validation.Errors;
                return response;
            }

            try
            {
                var entidad = _mapper.Map<InformeDerivacion>(request.entidad);

                entidad.usuarioMod = string.IsNullOrEmpty(TokenSesion) ? AuthenticationMessage.DefaultUserId : BaseControl.IdUsuarioAuditoria(TokenSesion);
                entidad.activo = EstadosAuditoria.activo;

                var result = _unitOfWork.InformeDerivacion.Update(entidad);

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

        public Response<bool> Delete(Request<InformeDerivacionDto> request)
        {
            var response = new Response<bool>();

            var validation = _informeDerivacionValidationManager.Validate(_mapper.Map<InformeDerivacionIdRequest>(request.entidad));

            if (!validation.IsValid)
            {
                response.Message = Validation.InvalidMessage;
                response.Errors = validation.Errors;
                return response;
            }

            try
            {
                var entidad = _mapper.Map<InformeDerivacion>(request.entidad);

                entidad.usuarioMod = string.IsNullOrEmpty(TokenSesion) ? AuthenticationMessage.DefaultUserId : BaseControl.IdUsuarioAuditoria(TokenSesion);

                var result = _unitOfWork.InformeDerivacion.Delete(entidad);

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

        public Response<InformeDerivacionDto> GetById(Request<InformeDerivacionDto> request)
        {
            var response = new Response<InformeDerivacionDto>();

            var validation = _informeDerivacionValidationManager.Validate(_mapper.Map<InformeDerivacionIdRequest>(request.entidad));

            try
            {
                if (!validation.IsValid)
                {
                    response.Message = Validation.InvalidMessage;
                    response.Errors = validation.Errors;
                    return response;
                }

                var entidad = _mapper.Map<InformeDerivacion>(request.entidad);

                var result = _unitOfWork.InformeDerivacion.GetById(entidad);

                if (result.Error)
                {
                    response.IsSuccess = false;
                    response.Message = result.Message;
                    _logger.LogError(result.Message);
                    return response;
                }

                if (result.Data != null)
                {
                    entidad = new InformeDerivacion
                    {
                        idInformeDerivacion = result.Data.idinformederivacion,
                        idInformeRenac = result.Data.idinformerenac,
                        idDerivacionRenac = result.Data.idderivacionrenac,
                        activo = result.Data.activo,
                        fechaReg = result.Data.fechareg,
                        fechaMod = result.Data.fechamod,
                        usuarioReg = result.Data.usuarioreg,
                        usuarioMod = result.Data.usuariomod
                    };
                }

                response.IsSuccess = true;
                response.Data = _mapper.Map<InformeDerivacionDto>(entidad);
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

        public Response<List<InformeDerivacionDto>> GetList(Request<InformeDerivacionDto> request)
        {
            var response = new Response<List<InformeDerivacionDto>>();

            try
            {
                var entidad = _mapper.Map<InformeDerivacion>(request.entidad);

                var result = _unitOfWork.InformeDerivacion.GetList(entidad);

                if (result.Data != null)
                {
                    List<InformeDerivacion> Lista = new List<InformeDerivacion>();

                    foreach (var item in result.Data)
                    {
                        Lista.Add(new InformeDerivacion()
                        {
                            idInformeDerivacion = item.idInformeDerivacion,
                            idInformeRenac = item.idInformeRenac,
                            idDerivacionRenac = item.idDerivacionRenac,
                            activo = item.activo,
                            fechaReg = item.fechaReg,
                            fechaMod = item.fechaMod,
                            usuarioReg = item.usuarioReg,
                            usuarioMod = item.usuarioMod
                        });
                    }

                    response.Data = _mapper.Map<List<InformeDerivacionDto>>(Lista);
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

        public Response<List<InformeDerivacionDto>> GetListPaginated(Request<InformeDerivacionDto> request, out int PageSize, out int PageNumber, out int TotalReg)
        {
            PageSize = 0;
            PageNumber = 0;
            TotalReg = 0;

            var response = new Response<List<InformeDerivacionDto>>();

            try
            {
                var entidad = _mapper.Map<InformeDerivacion>(request.entidad);

                var result = _unitOfWork.InformeDerivacion.GetListPaginated(entidad, out PageSize, out PageNumber, out TotalReg);

                if (result.Data != null && result.Data.Count > 0)
                {
                    List<InformeDerivacion> Lista = new List<InformeDerivacion>();

                    foreach (var item in result.Data)
                    {
                        Lista.Add(new InformeDerivacion()
                        {
                            idInformeDerivacion = item.idInformeDerivacion,
                            idInformeRenac = item.idInformeRenac,
                            idDerivacionRenac = item.idDerivacionRenac,
                            activo = item.activo,
                            fechaReg = item.fechaReg,
                            fechaMod = item.fechaMod,
                            usuarioReg = item.usuarioReg,
                            usuarioMod = item.usuarioMod,
                            rownum = item.rownum,
                            TotalReg = item.totalreg == null ? 0 : Convert.ToInt32(item.totalreg)
                        });
                    }

                    response.Data = _mapper.Map<List<InformeDerivacionDto>>(Lista);
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
