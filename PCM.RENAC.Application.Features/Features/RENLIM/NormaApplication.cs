using AutoMapper;
using PCM.RENAC.Application.Control.Util;
using PCM.RENAC.Application.Dto;
using PCM.RENAC.Application.Interface.Features;
using PCM.RENAC.Application.Interface.Persistence;
using PCM.RENAC.Domain.Entities;
using PCM.RENAC.Transversal.Common;

namespace PCM.RENAC.Application.Features
{
    public class NormaApplication : INormaApplication
    {
        private readonly IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;
        private readonly IAppLogger<NormaApplication> _logger;
        public string TokenSesion { get; set; }

        public NormaApplication(IUnitOfWork unitOfWork, IMapper mapper, IAppLogger<NormaApplication> logger)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
            _logger = logger;
        }

        public Response<bool> Insert(Request<NormaDto> request)
        {
            throw new NotImplementedException();
        }

        public Response<bool> Update(Request<NormaDto> request)
        {
            throw new NotImplementedException();
        }

        public Response<bool> Delete(Request<NormaDto> request)
        {
            throw new NotImplementedException();
        }

        public Response<NormaDto> GetById(Request<NormaDto> request)
        {
            throw new NotImplementedException();
        }

        public Response<List<NormaDto>> GetList(Request<NormaDto> request)
        {
            var response = new Response<List<NormaDto>>();

            try
            {
                var entidad = _mapper.Map<Norma>(request.entidad);

                var result = _unitOfWork.Norma.GetList(entidad);

                if (result.Data != null)
                {
                    var Lista = result.Data.Select(item => new Norma
                    {
                        CodNorma = item.iCodNorma,
                        Tipo = item.iTipo,
                        Numero = item.vNumero,
                        Fecha = item.dFecha,
                        Archivo = item.vArchivo,                        
                        activo = item.bActivo,
                        TipoDispositivo = new TipoDispositivo
                        {
                            Id = item.IdTabla,
                            Descripcion = item.Descripcion,
                            Abreviado = item.Abreviado
                        }
                    }).ToList();

                    response.IsSuccess = true;
                    response.Data = _mapper.Map<List<NormaDto>>(Lista);
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

        public Response<List<NormaDto>> GetListPaginated(Request<NormaDto> request, out int PageSize, out int PageNumber, out int TotalReg)
        {
            throw new NotImplementedException();
        }       
    }
}
