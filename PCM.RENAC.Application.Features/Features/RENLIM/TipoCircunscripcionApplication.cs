using AutoMapper;
using PCM.RENAC.Application.Control.Util;
using PCM.RENAC.Application.Dto;
using PCM.RENAC.Application.Interface.Features;
using PCM.RENAC.Application.Interface.Persistence;
using PCM.RENAC.Domain.Entities;
using PCM.RENAC.Transversal.Common;

namespace PCM.RENAC.Application.Features
{
    public class TipoCircunscripcionApplication : ITipoCircunscripcionApplication
    {
        private readonly IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;
        private readonly IAppLogger<TipoCircunscripcionApplication> _logger;

        public string TokenSesion { get; set; }

        public TipoCircunscripcionApplication(IUnitOfWork unitOfWork, IMapper mapper, IAppLogger<TipoCircunscripcionApplication> logger)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
            _logger = logger;
        }
        public Response<bool> Insert(Request<TipoCircunscripcionDto> request)
        {
            throw new NotImplementedException();
        }

        public Response<bool> Update(Request<TipoCircunscripcionDto> request)
        {
            throw new NotImplementedException();
        }
        public Response<bool> Delete(Request<TipoCircunscripcionDto> request)
        {
            throw new NotImplementedException();
        }

        public Response<TipoCircunscripcionDto> GetById(Request<TipoCircunscripcionDto> request)
        {
            throw new NotImplementedException();
        }

        public Response<List<TipoCircunscripcionDto>> GetList(Request<TipoCircunscripcionDto> request)
        {
            var response = new Response<List<TipoCircunscripcionDto>>();

            try
            {
                var entidad = _mapper.Map<TipoCircunscripcion>(request.entidad);

                var result = _unitOfWork.TipoCircunscripcion.GetList(entidad);

                if (result.Data != null)
                {
                    var Lista = result.Data.Select(item => new TipoCircunscripcion
                    {
                        Id = item.IdTabla,
                        Descripcion = item.Descripcion,
                        Abreviado = item.Abreviado,
                        Grupo = item.Grupo,
                        Orden = item.Orden
                    }).ToList();

                    response.IsSuccess = true;
                    response.Data = _mapper.Map<List<TipoCircunscripcionDto>>(Lista);
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

        public Response<List<TipoCircunscripcionDto>> GetListPaginated(Request<TipoCircunscripcionDto> request, out int PageSize, out int PageNumber, out int TotalReg)
        {
            throw new NotImplementedException();
        }
       
    }
}
