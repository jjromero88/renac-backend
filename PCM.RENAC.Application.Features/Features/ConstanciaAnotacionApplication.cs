using AutoMapper;
using PCM.RENAC.Application.Control.Util;
using PCM.RENAC.Application.Dto;
using PCM.RENAC.Application.Interface.Features;
using PCM.RENAC.Application.Interface.Persistence;
using PCM.RENAC.Domain.Entities;
using PCM.RENAC.Transversal.Common;
using PCM.RENAC.Transversal.Common.Util;

namespace PCM.RENAC.Application.Features
{
    public class ConstanciaAnotacionApplication : IConstanciaAnotacionApplication
    {
        private readonly IUnitOfWork _unitOfWork;
        private readonly IMapper _mapper;
        private readonly IAppLogger<ConstanciaAnotacionApplication> _logger;
        public string TokenSesion { get; set; }

        public ConstanciaAnotacionApplication(IUnitOfWork unitOfWork, IMapper mapper, IAppLogger<ConstanciaAnotacionApplication> logger)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;
            _logger = logger;
        }

        public Response<GenerarConstanciaAnotacionResponse> GenerarConstanciaAnotacion(Request<ConstanciaAnotacionDto> request)
        {
            var response = new Response<GenerarConstanciaAnotacionResponse>();

            try
            {
                ConstanciaAnotacion entidad = new ConstanciaAnotacion();

                var result = _unitOfWork.ConstanciaAnotacion.GetConstanciaAnotacion(_mapper.Map<ConstanciaAnotacion>(request.entidad));

                if (result.Data != null)
                {
                    entidad = new ConstanciaAnotacion
                    {
                        fecha_informe = result.Data.fecha_informe,
                        der_sub_ssatdot = result.Data.der_sub_ssatdot,
                        der_esp_ssatdot = result.Data.der_esp_ssatdot,
                        der_sub_ssiat = result.Data.der_sub_ssiat,
                        informe_renac_registro = result.Data.informe_renac_registro,
                        asientos_desc = result.Data.asientos_desc,
                        circ_desc = result.Data.circ_desc,
                        circ_asientos = result.Data.circ_asientos,
                        circ_entidad = result.Data.circ_entidad,
                        circ_nombre = result.Data.circ_nombre,
                        analista_nombres = result.Data.analista_nombres,
                        circ_titulo = result.Data.circ_titulo,
                        circ_subtitulo = result.Data.circ_subtitulo,
                        circ_secc = result.Data.circ_secc,
                        circ_cod = result.Data.circ_cod
                    };

                    entidad.lista_asientos = new List<ConstanciaAnotacionAsientos>();

                    var resultAsientos = _unitOfWork.ConstanciaAnotacion.GetConstanciaAnotacionAsientos(_mapper.Map<ConstanciaAnotacion>(request.entidad));

                    if (resultAsientos.Data != null)
                    {
                        foreach (var item in resultAsientos.Data)
                        {
                            entidad.lista_asientos.Add(new ConstanciaAnotacionAsientos()
                            {
                                asiento_titulo = item.asiento_titulo,
                                asiento_subtitulo = item.asiento_subtitulo,
                                asiento_datos_titulo = item.asiento_datos_titulo,
                                asiento_numero = item.asiento_numero,
                                norma_titulo = item.norma_titulo,
                                norma_tipo = item.norma_tipo,
                                norma_numero = item.norma_numero,
                                norma_fecha = item.norma_fecha,
                                circ_informacion_titulo = item.circ_informacion_titulo,
                                circ_nombre = item.circ_nombre,
                                circ_capital = item.circ_capital,
                                circ_departamento = item.circ_departamento,
                                circ_provincia = item.circ_provincia,
                                info_complementaria_titulo = item.info_complementaria_titulo,
                                circ_infocomplementaria = item.circ_infocomplementaria
                            });
                        }
                    }
                }

                var resultado = ExportDocument.ExportarFormato(entidad);

                if (resultado.Error)
                {
                    response.IsSuccess = false;
                    response.Message = resultado.MessageException;
                    _logger.LogError(resultado.Message ?? TransactionMessage.GenericErrorMessage);
                    return response;
                }

                response.IsSuccess = true;
                response.Message = resultado.Message;
                response.Data = new GenerarConstanciaAnotacionResponse
                {
                    FileName = resultado.FileName,
                    base64String = resultado.base64String,
                    contentType = resultado.contentType
                };
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
