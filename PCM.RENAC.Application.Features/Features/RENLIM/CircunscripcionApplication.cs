using AutoMapper;
using PCM.RENAC.Application.Control.Util;
using PCM.RENAC.Application.Dto;
using PCM.RENAC.Application.Interface.Features;
using PCM.RENAC.Application.Interface.Persistence;
using PCM.RENAC.Domain.Entities;
using PCM.RENAC.Transversal.Common;

namespace PCM.RENAC.Application.Features
{
    public class CircunscripcionApplication : ICircunscripcionApplication
    {
        private readonly IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;
        private readonly IAppLogger<CircunscripcionApplication> _logger;

        public string TokenSesion { get; set; }

        public CircunscripcionApplication(IUnitOfWork unitOfWork, IMapper mapper, IAppLogger<CircunscripcionApplication> logger)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
            _logger = logger;
        }

        public Response<bool> Insert(Request<CircunscripcionDto> request)
        {
            throw new NotImplementedException();
        }

        public Response<bool> Update(Request<CircunscripcionDto> request)
        {
            throw new NotImplementedException();
        }

        public Response<bool> Delete(Request<CircunscripcionDto> request)
        {
            throw new NotImplementedException();
        }

        public Response<CircunscripcionDto> GetById(Request<CircunscripcionDto> request)
        {
            throw new NotImplementedException();
        }

        public Response<List<CircunscripcionDto>> GetList(Request<CircunscripcionDto> request)
        {
            var response = new Response<List<CircunscripcionDto>>();

            try
            {
                var entidad = _mapper.Map<Circunscripcion>(request.entidad);

                var result = _unitOfWork.Circunscripcion.GetList(entidad);

                if (result.Data != null)
                {
                    var Lista = result.Data.Select(item => new Circunscripcion
                    {
                        CodCircunscripcion = item.iCodCircunscripcion,
                        NombreCircunscripcion = item.nombrecircunscripcion,
                        NomCircunscripcion = item.vNomCircunscripcion,
                        TipCircunscripcion = item.iTipCircunscripcion,
                        CodDepCircunscripcion = item.iCodDepCircunscripcion,
                        CodProvCircunscripcion = item.iCodProvCircunscripcion,
                        activo = item.bActivo
                    }).ToList();

                    response.IsSuccess = true;
                    response.Data = _mapper.Map<List<CircunscripcionDto>>(Lista);
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

        public Response<List<CircunscripcionDto>> GetListPaginated(Request<CircunscripcionDto> request, out int PageSize, out int PageNumber, out int TotalReg)
        {
            throw new NotImplementedException();
        }

    }
}
