using AutoMapper;
using PCM.RENAC.Application.Control.Util;
using PCM.RENAC.Application.Dto;
using PCM.RENAC.Application.Interface.Features;
using PCM.RENAC.Application.Interface.Persistence;
using PCM.RENAC.Domain.Entities;
using PCM.RENAC.Transversal.Common;

namespace PCM.RENAC.Application.Features
{
    public class TipoDispositivoApplication : ITipoDispositivoApplication
    {
        private readonly IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;
        private readonly IAppLogger<TipoDispositivoApplication> _logger;
        public string TokenSesion { get; set; }

        public TipoDispositivoApplication(IUnitOfWork unitOfWork, IMapper mapper, IAppLogger<TipoDispositivoApplication> logger)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
            _logger = logger;
        }

        public Response<bool> Delete(Request<TipoDispositivoDto> request)
        {
            throw new NotImplementedException();
        }

        public Response<TipoDispositivoDto> GetById(Request<TipoDispositivoDto> request)
        {
            throw new NotImplementedException();
        }

        public Response<List<TipoDispositivoDto>> GetList(Request<TipoDispositivoDto> request)
        {
            var response = new Response<List<TipoDispositivoDto>>();

            try
            {
                var entidad = _mapper.Map<TipoDispositivo>(request.entidad);

                var result = _unitOfWork.TipoDispositivo.GetList(entidad);

                if (result.Data != null)
                {
                    var Lista = result.Data.Select(item => new TipoDispositivo
                    {
                        Id = item.IdTabla,
                        Descripcion = item.Descripcion,
                        Abreviado = item.Abreviado
                    }).ToList();

                    response.IsSuccess = true;
                    response.Data = _mapper.Map<List<TipoDispositivoDto>>(Lista);
                    response.Message = TransactionMessage.QuerySuccess;
                    _logger.LogInformation(TransactionMessage.QuerySuccess);
                }
            }
            catch (Exception ex)
            {
                response.Message = ex.Message;
                _logger.LogError(ex.Message);
            }

            return response;
        }

        public Response<List<TipoDispositivoDto>> GetListPaginated(Request<TipoDispositivoDto> request, out int PageSize, out int PageNumber, out int TotalReg)
        {
            throw new NotImplementedException();
        }

        public Response<bool> Insert(Request<TipoDispositivoDto> request)
        {
            throw new NotImplementedException();
        }

        public Response<bool> Update(Request<TipoDispositivoDto> request)
        {
            throw new NotImplementedException();
        }
    }
}
