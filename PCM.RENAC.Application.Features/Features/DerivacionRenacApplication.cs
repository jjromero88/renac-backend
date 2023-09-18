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
    public class DerivacionRenacApplication : IDerivacionRenacApplication
    {
        private readonly IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;
        private readonly IAppLogger<DerivacionRenacApplication> _logger;
        private readonly DerivacionRenacValidationManager _DerivacionRenacValidationManager;

        public string TokenSesion { get; set; }

        public DerivacionRenacApplication(IUnitOfWork unitOfWork, IMapper mapper, IAppLogger<DerivacionRenacApplication> logger, DerivacionRenacValidationManager derivacionRenacManager)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
            _logger = logger;
            _DerivacionRenacValidationManager = derivacionRenacManager;
        }

        public Response<bool> Insert(Request<DerivacionRenacDto> request)
        {
            var response = new Response<bool>();
            var responseFile = new ResponseFile();

            var validation = _DerivacionRenacValidationManager.Validate(_mapper.Map<DerivacionRenacInsertRequest>(request.entidad));

            if (!validation.IsValid)
            {
                response.Message = Validation.InvalidMessage;
                response.Errors = validation.Errors;
                return response;
            }
            try
            {
                DerivacionRenac entidad = _mapper.Map<DerivacionRenac>(request.entidad);

                entidad.usuarioReg = string.IsNullOrEmpty(TokenSesion) ? AuthenticationMessage.DefaultUserId : BaseControl.IdUsuarioAuditoria(TokenSesion);
                entidad.activo = EstadosAuditoria.activo;

                var result = _unitOfWork.DerivacionRenac.Insert(entidad);

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

        public Response<bool> Update(Request<DerivacionRenacDto> request)
        {
            var response = new Response<bool>();

            var validation = _DerivacionRenacValidationManager.Validate(_mapper.Map<DerivacionRenacUpdateRequest>(request.entidad));

            if (!validation.IsValid)
            {
                response.Message = Validation.InvalidMessage;
                response.Errors = validation.Errors;
                return response;
            }

            try
            {
                var entidad = _mapper.Map<DerivacionRenac>(request.entidad);

                entidad.usuarioMod = string.IsNullOrEmpty(TokenSesion) ? AuthenticationMessage.DefaultUserId : BaseControl.IdUsuarioAuditoria(TokenSesion);
                entidad.activo = EstadosAuditoria.activo;

                var result = _unitOfWork.DerivacionRenac.Update(entidad);

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

        public Response<bool> Delete(Request<DerivacionRenacDto> request)
        {
            var response = new Response<bool>();

            var validation = _DerivacionRenacValidationManager.Validate(_mapper.Map<DerivacionRenacIdRequest>(request.entidad));

            if (!validation.IsValid)
            {
                response.Message = Validation.InvalidMessage;
                response.Errors = validation.Errors;
                return response;
            }

            try
            {
                var entidad = _mapper.Map<DerivacionRenac>(request.entidad);

                entidad.usuarioMod = string.IsNullOrEmpty(TokenSesion) ? AuthenticationMessage.DefaultUserId : BaseControl.IdUsuarioAuditoria(TokenSesion);

                var result = _unitOfWork.DerivacionRenac.Delete(entidad);

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

        public Response<DerivacionRenacDto> GetById(Request<DerivacionRenacDto> request)
        {
            var response = new Response<DerivacionRenacDto>();

            var validation = _DerivacionRenacValidationManager.Validate(_mapper.Map<DerivacionRenacIdRequest>(request.entidad));

            try
            {
                if (!validation.IsValid)
                {
                    response.Message = Validation.InvalidMessage;
                    response.Errors = validation.Errors;
                    return response;
                }

                var entidad = _mapper.Map<DerivacionRenac>(request.entidad);

                var result = _unitOfWork.DerivacionRenac.GetById(entidad);

                if (result.Error)
                {
                    response.IsSuccess = false;
                    response.Message = result.Message;
                    _logger.LogError(result.Message);
                    return response;
                }

                if (result.Data != null)
                {
                    entidad = new DerivacionRenac
                    {
                        idDerivacionRenac = result.Data.idderivacionrenac,
                        idDerivacionOrigen = result.Data.idderivacionorigen,
                        idDerivacionDestino = result.Data.idderivaciondestino,
                        idEspecialistaSsatdot = result.Data.idespecialistassatdot,
                        fechaDerivacion = result.Data.fechaderivacion,
                        usuarioOrigen = result.Data.usuarioorigen,
                        usuarioDestino = result.Data.usuariodestino,
                        observacion = result.Data.observacion,
                        esRetorno = result.Data.esretorno,
                        activo = result.Data.activo,
                        fechaReg = result.Data.fechareg,
                        fechaMod = result.Data.fechamod,
                        usuarioReg = result.Data.usuarioreg,
                        usuarioMod = result.Data.usuariomod
                    };
                }

                response.IsSuccess = true;
                response.Data = _mapper.Map<DerivacionRenacDto>(entidad);
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

        public Response<List<DerivacionRenacDto>> GetList(Request<DerivacionRenacDto> request)
        {
            var response = new Response<List<DerivacionRenacDto>>();

            try
            {
                var entidad = _mapper.Map<DerivacionRenac>(request.entidad);

                var result = _unitOfWork.DerivacionRenac.GetList(entidad);

                if (result.Data != null)
                {
                    List<DerivacionRenac> Lista = new List<DerivacionRenac>();

                    foreach (var item in result.Data)
                    {
                        Lista.Add(new DerivacionRenac()
                        {
                            idDerivacionRenac = item.idDerivacionRenac,
                            idDerivacionOrigen = item.Data.idDerivacionOrigen,
                            idDerivacionDestino = item.Data.idDerivacionDestino,
                            idEspecialistaSsatdot = item.Data.idEspecialistaSsatdot,
                            fechaDerivacion = item.fechaDerivacion,
                            usuarioOrigen = item.usuarioOrigen,
                            usuarioDestino = item.usuarioDestino,
                            observacion = item.observacion,
                            esRetorno = item.esRetorno,
                            activo = item.activo,
                            fechaReg = item.fechaReg,
                            fechaMod = item.fechaMod,
                            usuarioReg = item.usuarioReg,
                            usuarioMod = item.usuarioMod
                        });
                    }

                    response.Data = _mapper.Map<List<DerivacionRenacDto>>(Lista);
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

        public Response<List<DerivacionRenacDto>> GetListPaginated(Request<DerivacionRenacDto> request, out int PageSize, out int PageNumber, out int TotalReg)
        {
            PageSize = 0;
            PageNumber = 0;
            TotalReg = 0;

            var response = new Response<List<DerivacionRenacDto>>();

            try
            {
                var entidad = _mapper.Map<DerivacionRenac>(request.entidad);

                var result = _unitOfWork.DerivacionRenac.GetListPaginated(entidad, out PageSize, out PageNumber, out TotalReg);

                if (result.Data != null && result.Data.Count > 0)
                {
                    List<DerivacionRenac> Lista = new List<DerivacionRenac>();

                    foreach (var item in result.Data)
                    {
                        Lista.Add(new DerivacionRenac()
                        {
                            idDerivacionRenac = item.idDerivacionRenac,
                            idDerivacionOrigen = item.idDerivacionOrigen,
                            idDerivacionDestino = item.idDerivacionDestino,
                            idEspecialistaSsatdot = item.idEspecialistaSsatdot,
                            fechaDerivacion = item.fechaDerivacion,
                            usuarioOrigen = item.usuarioOrigen,
                            usuarioDestino = item.usuarioDestino,
                            observacion = item.observacion,
                            esRetorno = item.esRetorno,
                            activo = item.activo,
                            fechaReg = item.fechaReg,
                            fechaMod = item.fechaMod,
                            usuarioReg = item.usuarioReg,
                            usuarioMod = item.usuarioMod,
                            rownum = item.rownum,
                            TotalReg = item.totalreg == null ? 0 : Convert.ToInt32(item.totalreg)
                        });
                    }

                    response.Data = _mapper.Map<List<DerivacionRenacDto>>(Lista);
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

        public Response<bool> DerivacionEspecialistaSSIAT(Request<DerivacionRenacDto> request)
        {
            var response = new Response<bool>();
            var responseFile = new ResponseFile();

            var validation = _DerivacionRenacValidationManager.Validate(_mapper.Map<DerivacionEspecialistaSSIATRequest>(request.entidad));

            if (!validation.IsValid)
            {
                response.Message = Validation.InvalidMessage;
                response.Errors = validation.Errors;
                return response;
            }

            try
            {
                string pathDocumentoMemo = FileApplicationKeys.PathDocumentoMemoEspecialistaSsiat.ToString();
                responseFile = FileUploadUtility.SaveBase64File(request.entidad.documentoMemoBase64, request.entidad.documentoMemoNombre, pathDocumentoMemo, FilesName.DocumentoMemoSsiat);

                if (responseFile.Error)
                {
                    response.IsSuccess = false;
                    response.Message = responseFile.MessageException;
                    _logger.LogError(responseFile.Message ?? string.Empty);
                    return response;
                }

                var entidad = _mapper.Map<DerivacionRenac>(request.entidad);

                entidad.documentoMemoRuta = responseFile.PathFile;
                entidad.documentoMemoNombre = responseFile.FileName;
                entidad.usuarioMod = string.IsNullOrEmpty(TokenSesion) ? AuthenticationMessage.DefaultUserId : BaseControl.IdUsuarioAuditoria(TokenSesion);
                entidad.activo = EstadosAuditoria.activo;

                var result = _unitOfWork.DerivacionRenac.DerivacionEspecialistaSSIAT(entidad);

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

        public Response<bool> DerivacionSubsecretarioSSIAT(Request<DerivacionRenacDto> request)
        {
            var response = new Response<bool>();
            var responseFile = new ResponseFile();

            var validation = _DerivacionRenacValidationManager.Validate(_mapper.Map<DerivacionSubsecretarioSSIATRequest>(request.entidad));

            if (!validation.IsValid)
            {
                response.Message = Validation.InvalidMessage;
                response.Errors = validation.Errors;
                return response;
            }

            try
            {
                string pathDocumentoMemo = FileApplicationKeys.PathDocumentoMemoSubsecretarioSsiat.ToString();
                responseFile = FileUploadUtility.SaveBase64File(request.entidad.documentoMemoBase64, request.entidad.documentoMemoNombre, pathDocumentoMemo, FilesName.DocumentoMemoSsiat);

                if (responseFile.Error)
                {
                    response.IsSuccess = false;
                    response.Message = responseFile.MessageException;
                    _logger.LogError(responseFile.Message ?? string.Empty);
                    return response;
                }

                var entidad = _mapper.Map<DerivacionRenac>(request.entidad);

                entidad.documentoMemoRuta = responseFile.PathFile;
                entidad.documentoMemoNombre = responseFile.FileName;
                entidad.usuarioMod = string.IsNullOrEmpty(TokenSesion) ? AuthenticationMessage.DefaultUserId : BaseControl.IdUsuarioAuditoria(TokenSesion);
                entidad.activo = EstadosAuditoria.activo;

                var result = _unitOfWork.DerivacionRenac.DerivacionSubsecretarioSSIAT(entidad);

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

        public Response<bool> DerivacionAjustesSubsecretarioSSIAT(Request<DerivacionRenacDto> request)
        {
            var response = new Response<bool>();

            var validation = _DerivacionRenacValidationManager.Validate(_mapper.Map<DerivacionAjustesSubsecretarioSsiatRequest>(request.entidad));

            if (!validation.IsValid)
            {
                response.Message = Validation.InvalidMessage;
                response.Errors = validation.Errors;
                return response;
            }

            try
            {
                var entidad = _mapper.Map<DerivacionRenac>(request.entidad);

                entidad.usuarioMod = string.IsNullOrEmpty(TokenSesion) ? AuthenticationMessage.DefaultUserId : BaseControl.IdUsuarioAuditoria(TokenSesion);
                entidad.activo = EstadosAuditoria.activo;

                var result = _unitOfWork.DerivacionRenac.DerivacionAjustesSubsecretarioSSIAT(entidad);

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

        public Response<bool> DerivacionSubsecretarioSSATDOT(Request<DerivacionRenacDto> request)
        {
            var response = new Response<bool>();

            var validation = _DerivacionRenacValidationManager.Validate(_mapper.Map<DerivacionSubsecretarioSSATDOTRequest>(request.entidad));

            if (!validation.IsValid)
            {
                response.Message = Validation.InvalidMessage;
                response.Errors = validation.Errors;
                return response;
            }

            try
            {
                var entidad = _mapper.Map<DerivacionRenac>(request.entidad);

                entidad.usuarioMod = string.IsNullOrEmpty(TokenSesion) ? AuthenticationMessage.DefaultUserId : BaseControl.IdUsuarioAuditoria(TokenSesion);
                entidad.activo = EstadosAuditoria.activo;

                var result = _unitOfWork.DerivacionRenac.DerivacionSubsecretarioSSATDOT(entidad);

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

        public Response<bool> DerivacionEspecialistaSSATDOT(Request<DerivacionRenacDto> request)
        {
            var response = new Response<bool>();
            var responseFile = new ResponseFile();

            var validation = _DerivacionRenacValidationManager.Validate(_mapper.Map<DerivacionEspecialistaSSATDOTRequest>(request.entidad));

            if (!validation.IsValid)
            {
                response.Message = Validation.InvalidMessage;
                response.Errors = validation.Errors;
                return response;
            }

            try
            {
                string pathDocumentoMemo = FileApplicationKeys.PathProyectoMemoEspecialistaSsatdot.ToString();
                responseFile = FileUploadUtility.SaveBase64File(request.entidad.documentoMemoBase64, request.entidad.documentoMemoNombre, pathDocumentoMemo, FilesName.DocumentoMemoSsiat);

                if (responseFile.Error)
                {
                    response.IsSuccess = false;
                    response.Message = responseFile.MessageException;
                    _logger.LogError(responseFile.Message ?? string.Empty);
                    return response;
                }

                var entidad = _mapper.Map<DerivacionRenac>(request.entidad);

                entidad.documentoMemoRuta = responseFile.PathFile;
                entidad.documentoMemoNombre = responseFile.FileName;
                entidad.usuarioMod = string.IsNullOrEmpty(TokenSesion) ? AuthenticationMessage.DefaultUserId : BaseControl.IdUsuarioAuditoria(TokenSesion);
                entidad.activo = EstadosAuditoria.activo;

                var result = _unitOfWork.DerivacionRenac.DerivacionEspecialistaSSATDOT(entidad);

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

        public Response<bool> DerivacionAjustesEspecialistaSSATDOT(Request<DerivacionRenacDto> request)
        {
            var response = new Response<bool>();

            var validation = _DerivacionRenacValidationManager.Validate(_mapper.Map<DerivacionAjustesEspecialistaSsatdotRequest>(request.entidad));

            if (!validation.IsValid)
            {
                response.Message = Validation.InvalidMessage;
                response.Errors = validation.Errors;
                return response;
            }

            try
            {
                var entidad = _mapper.Map<DerivacionRenac>(request.entidad);

                entidad.usuarioMod = string.IsNullOrEmpty(TokenSesion) ? AuthenticationMessage.DefaultUserId : BaseControl.IdUsuarioAuditoria(TokenSesion);
                entidad.activo = EstadosAuditoria.activo;

                var result = _unitOfWork.DerivacionRenac.DerivacionAjustesEspecialistaSSATDOT(entidad);

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

        public Response<bool> DerivacionAjustesSubsecretarioSSATDOT(Request<DerivacionRenacDto> request)
        {
            var response = new Response<bool>();

            var validation = _DerivacionRenacValidationManager.Validate(_mapper.Map<DerivacionAjustesSubsecretarioSsatdotRequest>(request.entidad));

            if (!validation.IsValid)
            {
                response.Message = Validation.InvalidMessage;
                response.Errors = validation.Errors;
                return response;
            }

            try
            {
                var entidad = _mapper.Map<DerivacionRenac>(request.entidad);

                entidad.usuarioMod = string.IsNullOrEmpty(TokenSesion) ? AuthenticationMessage.DefaultUserId : BaseControl.IdUsuarioAuditoria(TokenSesion);
                entidad.activo = EstadosAuditoria.activo;

                var result = _unitOfWork.DerivacionRenac.DerivacionAjustesSubsecretarioSSATDOT(entidad);

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

        public Response<bool> DerivacionInformesSubsecretarioSSATDOT(Request<DerivacionRenacDto> request)
        {
            var response = new Response<bool>();
            var responseFile = new ResponseFile();

            var validation = _DerivacionRenacValidationManager.Validate(_mapper.Map<DerivacionInformesSubsecretarioSsatdotRequest>(request.entidad));

            if (!validation.IsValid)
            {
                response.Message = Validation.InvalidMessage;
                response.Errors = validation.Errors;
                return response;
            }

            try
            {
                string pathDocumentoMemo = FileApplicationKeys.PathDocumentosSubsecretarioSsatdot.ToString();
                responseFile = FileUploadUtility.SaveBase64File(request.entidad.documentoMemoBase64, request.entidad.documentoMemoNombre, pathDocumentoMemo, FilesName.DocumentoMemoSsatdot);

                if (responseFile.Error)
                {
                    response.IsSuccess = false;
                    response.Message = responseFile.MessageException;
                    _logger.LogError(responseFile.Message ?? string.Empty);
                    return response;
                }

                var entidad = _mapper.Map<DerivacionRenac>(request.entidad);

                entidad.documentoMemoRuta = responseFile.PathFile;
                entidad.documentoMemoNombre = responseFile.FileName;
                entidad.usuarioMod = string.IsNullOrEmpty(TokenSesion) ? AuthenticationMessage.DefaultUserId : BaseControl.IdUsuarioAuditoria(TokenSesion);
                entidad.activo = EstadosAuditoria.activo;

                var result = _unitOfWork.DerivacionRenac.DerivacionInformesSubsecretarioSSATDOT(entidad);

                if (result.Error)
                {
                    response.IsSuccess = false;
                    response.Message = result.Message;
                    _logger.LogError(result.Message ?? TransactionMessage.GenericErrorMessage);
                    return response;
                }

                response.IsSuccess = true;
                response.Message = result.Message ?? TransactionMessage.UpdateSuccess;
                _logger.LogInformation(result.Message ?? TransactionMessage.UpdateSuccess);
            }
            catch (Exception ex)
            {
                response.Message = ex.Message;
                _logger.LogError(ex.Message);
            }

            return response;
        }

        public Response<bool> DerivacionInformesResponsableArchivo(Request<DerivacionRenacDto> request)
        {
            var response = new Response<bool>();

            var validation = _DerivacionRenacValidationManager.Validate(_mapper.Map<DerivacionInformesResponsableArchivoRequest>(request.entidad));

            if (!validation.IsValid)
            {
                response.Message = Validation.InvalidMessage;
                response.Errors = validation.Errors;
                return response;
            }

            try
            {
                var entidad = _mapper.Map<DerivacionRenac>(request.entidad);

                entidad.usuarioMod = string.IsNullOrEmpty(TokenSesion) ? AuthenticationMessage.DefaultUserId : BaseControl.IdUsuarioAuditoria(TokenSesion);
                entidad.activo = EstadosAuditoria.activo;

                var result = _unitOfWork.DerivacionRenac.DerivacionInformesResponsableArchivo(entidad);

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

        public Response<bool> DerivacionModificacionEspecialistaSSIAT(Request<DerivacionRenacDto> request)
        {
            var response = new Response<bool>();

            var validation = _DerivacionRenacValidationManager.Validate(_mapper.Map<DerivacionModificacionEspecialistaSsiatRequest>(request.entidad));

            if (!validation.IsValid)
            {
                response.Message = Validation.InvalidMessage;
                response.Errors = validation.Errors;
                return response;
            }

            try
            {
                var entidad = _mapper.Map<DerivacionRenac>(request.entidad);

                entidad.usuarioMod = string.IsNullOrEmpty(TokenSesion) ? AuthenticationMessage.DefaultUserId : BaseControl.IdUsuarioAuditoria(TokenSesion);
                entidad.activo = EstadosAuditoria.activo;

                var result = _unitOfWork.DerivacionRenac.DerivacionModificacionEspecialistaSSIAT(entidad);

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

        public Response<bool> DerivacionParaAnotacionEspecialistaSSIAT(Request<DerivacionRenacDto> request)
        {
            var response = new Response<bool>();
            var responseFile = new ResponseFile();

            var validation = _DerivacionRenacValidationManager.Validate(_mapper.Map<DerivacionParaAnotacionEspecialistaSsiatRequest>(request.entidad));

            if (!validation.IsValid)
            {
                response.Message = Validation.InvalidMessage;
                response.Errors = validation.Errors;
                return response;
            }

            try
            {
                responseFile = FileUploadUtility.SaveBase64File(request.entidad.documentoMemoBase64, 
                                                                request.entidad.documentoMemoNombre,
                                                                FileApplicationKeys.PathDocumentoDerivacionAnotacionEspecialistaSsiat, 
                                                                FilesName.DocumentoMemoSsiat);

                if (responseFile.Error)
                {
                    response.IsSuccess = false;
                    response.Message = responseFile.MessageException;
                    _logger.LogError(responseFile.Message ?? string.Empty);
                    return response;
                }

                var entidad = _mapper.Map<DerivacionRenac>(request.entidad);

                entidad.documentoMemoRuta = responseFile.PathFile;
                entidad.documentoMemoNombre = responseFile.FileName;
                entidad.usuarioMod = string.IsNullOrEmpty(TokenSesion) ? AuthenticationMessage.DefaultUserId : BaseControl.IdUsuarioAuditoria(TokenSesion);
                entidad.activo = EstadosAuditoria.activo;

                var result = _unitOfWork.DerivacionRenac.DerivacionParaAnotacionEspecialistaSSIAT(entidad);

                if (result.Error)
                {
                    response.IsSuccess = false;
                    response.Message = result.Message;
                    _logger.LogError(result.Message ?? TransactionMessage.GenericErrorMessage);
                    return response;
                }

                response.IsSuccess = true;
                response.Message = result.Message ?? TransactionMessage.UpdateSuccess;
                _logger.LogInformation(result.Message ?? TransactionMessage.UpdateSuccess);
            }
            catch (Exception ex)
            {
                response.Message = ex.Message;
                _logger.LogError(ex.Message);
            }

            return response;
        }

        public Response<bool> DerivacionParaAnotacionSubsecretarioSSIAT(Request<DerivacionRenacDto> request)
        {
            var response = new Response<bool>();
            var responseFile = new ResponseFile();

            var validation = _DerivacionRenacValidationManager.Validate(_mapper.Map<DerivacionParaAnotacionSubsecretarioSsiatRequest>(request.entidad));

            if (!validation.IsValid)
            {
                response.Message = Validation.InvalidMessage;
                response.Errors = validation.Errors;
                return response;
            }

            try
            {
                responseFile = FileUploadUtility.SaveBase64File(request.entidad.documentoMemoBase64,
                                                                request.entidad.documentoMemoNombre,
                                                                FileApplicationKeys.PathDocumentoDerivacionAnotacionSubsecretarioSsiat,
                                                                FilesName.documentoAnotacion);

                if (responseFile.Error)
                {
                    response.IsSuccess = false;
                    response.Message = responseFile.MessageException;
                    _logger.LogError(responseFile.Message ?? string.Empty);
                    return response;
                }

                var entidad = _mapper.Map<DerivacionRenac>(request.entidad);

                entidad.documentoMemoRuta = responseFile.PathFile;
                entidad.documentoMemoNombre = responseFile.FileName;
                entidad.usuarioMod = string.IsNullOrEmpty(TokenSesion) ? AuthenticationMessage.DefaultUserId : BaseControl.IdUsuarioAuditoria(TokenSesion);
                entidad.activo = EstadosAuditoria.activo;

                var result = _unitOfWork.DerivacionRenac.DerivacionParaAnotacionSubsecretarioSSIAT(entidad);

                if (result.Error)
                {
                    response.IsSuccess = false;
                    response.Message = result.Message;
                    _logger.LogError(result.Message ?? TransactionMessage.GenericErrorMessage);
                    return response;
                }

                response.IsSuccess = true;
                response.Message = result.Message ?? TransactionMessage.UpdateSuccess;
                _logger.LogInformation(result.Message ?? TransactionMessage.UpdateSuccess);
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
