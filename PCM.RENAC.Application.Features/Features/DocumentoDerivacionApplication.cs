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
    public class DocumentoDerivacionApplication : IDocumentoDerivacionApplication
    {
        private readonly IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;
        private readonly IAppLogger<DocumentoDerivacionApplication> _logger;
        private readonly DocumentoDerivacionValidationManager _documentoDerivacionValidationManager;
        public string TokenSesion { get; set; }

        public DocumentoDerivacionApplication(IUnitOfWork unitOfWork, IMapper mapper, IAppLogger<DocumentoDerivacionApplication> logger, DocumentoDerivacionValidationManager documentoDerivacionManager)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
            _logger = logger;
            _documentoDerivacionValidationManager = documentoDerivacionManager;
        }

        public Response<bool> Insert(Request<DocumentoDerivacionDto> request)
        {
            var response = new Response<bool>();

            var validation = _documentoDerivacionValidationManager.Validate(_mapper.Map<DocumentoDerivacionInsertRequest>(request.entidad));

            if (!validation.IsValid)
            {
                response.Message = Validation.InvalidMessage;
                response.Errors = validation.Errors;
                return response;
            }
            try
            {
                DocumentoDerivacion entidad = _mapper.Map<DocumentoDerivacion>(request.entidad);

                entidad.usuarioReg = string.IsNullOrEmpty(TokenSesion) ? AuthenticationMessage.DefaultUserId : BaseControl.IdUsuarioAuditoria(TokenSesion);
                entidad.activo = EstadosAuditoria.activo;

                var result = _unitOfWork.DocumentoDerivacion.Insert(entidad);

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

        public Response<bool> Update(Request<DocumentoDerivacionDto> request)
        {
            var response = new Response<bool>();

            var validation = _documentoDerivacionValidationManager.Validate(_mapper.Map<DocumentoDerivacionUpdateRequest>(request.entidad));

            if (!validation.IsValid)
            {
                response.Message = Validation.InvalidMessage;
                response.Errors = validation.Errors;
                return response;
            }

            try
            {
                var entidad = _mapper.Map<DocumentoDerivacion>(request.entidad);

                entidad.usuarioMod = string.IsNullOrEmpty(TokenSesion) ? AuthenticationMessage.DefaultUserId : BaseControl.IdUsuarioAuditoria(TokenSesion);
                entidad.activo = EstadosAuditoria.activo;

                var result = _unitOfWork.DocumentoDerivacion.Update(entidad);

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

        public Response<bool> Delete(Request<DocumentoDerivacionDto> request)
        {
            var response = new Response<bool>();

            var validation = _documentoDerivacionValidationManager.Validate(_mapper.Map<DocumentoDerivacionIdRequest>(request.entidad));

            if (!validation.IsValid)
            {
                response.Message = Validation.InvalidMessage;
                response.Errors = validation.Errors;
                return response;
            }

            try
            {
                var entidad = _mapper.Map<DocumentoDerivacion>(request.entidad);

                entidad.usuarioMod = string.IsNullOrEmpty(TokenSesion) ? AuthenticationMessage.DefaultUserId : BaseControl.IdUsuarioAuditoria(TokenSesion);
                var result = _unitOfWork.DocumentoDerivacion.Delete(entidad);

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

        public Response<DocumentoDerivacionDto> GetById(Request<DocumentoDerivacionDto> request)
        {
            var response = new Response<DocumentoDerivacionDto>();
            var validation = _documentoDerivacionValidationManager.Validate(_mapper.Map<DocumentoDerivacionIdRequest>(request.entidad));

            try
            {
                if (!validation.IsValid)
                {
                    response.Message = Validation.InvalidMessage;
                    response.Errors = validation.Errors;
                    return response;
                }

                var entidad = _mapper.Map<DocumentoDerivacion>(request.entidad);
                var result = _unitOfWork.DocumentoDerivacion.GetById(entidad);

                if (result.Error)
                {
                    response.IsSuccess = false;
                    response.Message = result.Message;
                    _logger.LogError(result.Message ?? string.Empty);
                    return response;
                }

                if (result.Data != null)
                {
                    entidad = new DocumentoDerivacion
                    {
                        idDocumentoDerivacion = result.Data.iddocumentoderivacion,
                        idDerivacionRenac = result.Data.idderivacionrenac,
                        idTipoDocumentoRenac = result.Data.idtipodocumentorenac,
                        rutaDocumento = result.Data.rutadocumento,
                        nombreDocumento = result.Data.nombredocumento,
                        fechaDocumento = result.Data.fechaDocumento,
                        numeroDocumento = result.Data.numeroDocumento,
                        activo = result.Data.activo,
                        fechaReg = result.Data.fechareg,
                        fechaMod = result.Data.fechamod,
                        usuarioReg = result.Data.usuarioreg,
                        usuarioMod = result.Data.usuariomod
                    };
                }

                response.IsSuccess = true;
                response.Data = _mapper.Map<DocumentoDerivacionDto>(entidad);
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

        public Response<List<DocumentoDerivacionDto>> GetList(Request<DocumentoDerivacionDto> request)
        {
            var response = new Response<List<DocumentoDerivacionDto>>();

            try
            {
                var entidad = _mapper.Map<DocumentoDerivacion>(request.entidad);
                var result = _unitOfWork.DocumentoDerivacion.GetList(entidad);

                if (result.Data != null)
                {
                    List<DocumentoDerivacion> lista = result.Data.Select(row =>
                    {
                        var item = new DocumentoDerivacion
                        {
                            idDocumentoDerivacion = row.idDocumentoDerivacion,
                            idDerivacionRenac = row.idDerivacionRenac,
                            idTipoDocumentoRenac = row.idTipoDocumentoRenac,
                            rutaDocumento = row.rutaDocumento,
                            nombreDocumento = row.nombreDocumento,
                            fechaDocumento = row.fechaDocumento,
                            numeroDocumento = row.numeroDocumento,
                            activo = row.activo,
                            fechaReg = row.fechaReg,
                            fechaMod = row.fechaMod,
                            usuarioReg = row.usuarioReg,
                            usuarioMod = row.usuarioMod
                        };
                        return item;
                    }).ToList();

                    response.Data = _mapper.Map<List<DocumentoDerivacionDto>>(lista);
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

        public Response<List<DocumentoDerivacionDto>> GetListPaginated(Request<DocumentoDerivacionDto> request, out int PageSize, out int PageNumber, out int TotalReg)
        {
            PageSize = 0;
            PageNumber = 0;
            TotalReg = 0;

            var response = new Response<List<DocumentoDerivacionDto>>();

            try
            {
                var entidad = _mapper.Map<DocumentoDerivacion>(request.entidad);
                var result = _unitOfWork.DocumentoDerivacion.GetListPaginated(entidad, out PageSize, out PageNumber, out TotalReg);

                if (result.Data != null && result.Data.Count > 0)
                {
                    List<DocumentoDerivacion> Lista = new List<DocumentoDerivacion>();

                    foreach (var item in result.Data)
                    {
                        Lista.Add(new DocumentoDerivacion()
                        {
                            idDocumentoDerivacion = item.idDocumentoDerivacion,
                            idDerivacionRenac = item.idDerivacionRenac,
                            idTipoDocumentoRenac = item.idTipoDocumentoRenac,
                            rutaDocumento = item.rutaDocumento,
                            nombreDocumento = item.nombreDocumento,
                            fechaDocumento = item.fechaDocumento,
                            numeroDocumento = item.numeroDocumento,
                            activo = item.activo,
                            fechaReg = item.fechaReg,
                            fechaMod = item.fechaMod,
                            usuarioReg = item.usuarioReg,
                            usuarioMod = item.usuarioMod,
                            rownum = item.rownum,
                            TotalReg = item.totalreg == null ? 0 : Convert.ToInt32(item.totalreg)
                        });
                    }

                    response.Data = _mapper.Map<List<DocumentoDerivacionDto>>(Lista);
                    TotalReg = UtilApplication.GetTotalReg(Lista);
                }

                response.IsSuccess = true;
                _logger.LogInformation(TransactionMessage.QuerySuccess);
                response.Message = TransactionMessage.QuerySuccess;
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
