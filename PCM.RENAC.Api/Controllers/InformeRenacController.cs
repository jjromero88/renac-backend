using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using PCM.RENAC.Application.Dto;
using PCM.RENAC.Application.Interface.Features;
using PCM.RENAC.Transversal.Common;
using System.Net;

namespace PCM.RENAC.Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class InformeRenacController : Controller
    {
        private readonly IInformeRenacApplication _informeRenacApplication;
        private readonly IMapper _mapper;

        public InformeRenacController(IInformeRenacApplication informeRenacApplication, IMapper mapper)
        {
            _informeRenacApplication = informeRenacApplication ?? throw new ArgumentNullException(nameof(informeRenacApplication));
            _mapper = mapper ?? throw new ArgumentNullException(nameof(mapper));
        }

        [HttpPost("Insert")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<InformeRenacResponse>))]
        public IActionResult Insert([FromForm] InformeRenacInsertRequest informeRenacRequest)
        {
            if (informeRenacRequest == null)
                return BadRequest();

            var InformeRenacDTO = _mapper.Map<InformeRenacDto>(informeRenacRequest);

            var response = _informeRenacApplication.Insert(new Request<InformeRenacDto>() { entidad = InformeRenacDTO });

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<InformeRenacResponse>
                    {
                        IsSuccess = response.IsSuccess,
                        Message = response.Message,
                        Errors = response.Errors
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpPut("Update")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<InformeRenacResponse>))]
        public IActionResult Update([FromForm] InformeRenacUpdateRequest informeRenac)
        {
            if (informeRenac == null)
                return BadRequest();

            var informeRenacDto = _mapper.Map<InformeRenacDto>(informeRenac);

            var response = _informeRenacApplication.Update(new Request<InformeRenacDto>() { entidad = informeRenacDto });

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<InformeRenacResponse>
                    {
                        IsSuccess = response.IsSuccess,
                        Message = response.Message,
                        Errors = response.Errors
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpDelete("Delete")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<InformeRenacResponse>))]
        public IActionResult Delete([FromBody] InformeRenacIdRequest informeRenacIdRequest)
        {
            if (informeRenacIdRequest == null)
                return BadRequest();

            var informeRenacDTO = _mapper.Map<InformeRenacDto>(informeRenacIdRequest);

            var response = _informeRenacApplication.Delete(new Request<InformeRenacDto>() { entidad = informeRenacDTO });

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<InformeRenacResponse>
                    {
                        IsSuccess = response.IsSuccess,
                        Message = response.Message,
                        Errors = response.Errors
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpGet("GetById")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<InformeRenacResponse>))]
        public IActionResult GetById([FromQuery] InformeRenacIdRequest informeRenacIdRequest)
        {
            if (informeRenacIdRequest == null)
                return BadRequest();

            var InformeRenacDto = _mapper.Map<InformeRenacDto>(informeRenacIdRequest);

            var response = _informeRenacApplication.GetById(new Request<InformeRenacDto>() { entidad = InformeRenacDto });

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<InformeRenacResponse>
                    {
                        Data = _mapper.Map<InformeRenacResponse>(response.Data) ?? new InformeRenacResponse(),
                        IsSuccess = response.IsSuccess,
                        Message = response.Message
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpGet("GetList")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<InformeRenacListResponse>))]
        public IActionResult GetList([FromQuery] InformeRenacFiltrosRequest informeRenacFiltrosRequest)
        {
            if (informeRenacFiltrosRequest == null)
                return BadRequest();

            var informeRenacDTO = _mapper.Map<InformeRenacDto>(informeRenacFiltrosRequest);

            var response = _informeRenacApplication.GetList(new Request<InformeRenacDto>() { entidad = informeRenacDTO });

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<List<InformeRenacResponse>>
                    {
                        Data = _mapper.Map<List<InformeRenacResponse>>(response.Data) ?? new List<InformeRenacResponse>(),
                        IsSuccess = response.IsSuccess,
                        Message = response.Message
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpGet("GetListPaginated")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<InformeRenacListPaginatedResponse>))]
        public IActionResult GetListPaginated([FromQuery] InformeRenacPaginacionFiltroRequest informeRenacPaginacionFiltroRequest)
        {
            if (informeRenacPaginacionFiltroRequest == null)
                return BadRequest();

            var informeRenacDTO = _mapper.Map<InformeRenacDto>(informeRenacPaginacionFiltroRequest);

            var response = _informeRenacApplication.GetListPaginated(new Request<InformeRenacDto>() { entidad = informeRenacDTO },
                                                                out int PageSize, out int PageNumber, out int TotalReg);

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<InformeRenacListPaginatedResponse>
                    {
                        Data = new InformeRenacListPaginatedResponse
                        {
                            InformeRenac = _mapper.Map<List<InformeRenacResponse>>(response.Data) ?? new List<InformeRenacResponse>(),
                            Paginacion = new PaginacionResponse
                            {
                                totalReg = TotalReg,
                                rowsPerPage = PageSize,
                                currentPage = PageNumber
                            } ?? new PaginacionResponse()
                        },
                        IsSuccess = response.IsSuccess,
                        Message = response.Message
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpGet("EspecialistaSsiatPaginated")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<EspecialistaSsiatListPaginatedResponse>))]
        public IActionResult GetListEspecialistaSsiatPaginated([FromQuery] EspecialistaSsiatPaginatedFilterRequest request)
        {
            if (request == null)
                return BadRequest();

            var response = _informeRenacApplication.GetListEspecialistaSsiatPaginated(new Request<InformeRenacDto>() { entidad = _mapper.Map<InformeRenacDto>(request) },
                                                                out int PageSize, out int PageNumber, out int TotalReg);

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<EspecialistaSsiatListPaginatedResponse>
                    {
                        Data = new EspecialistaSsiatListPaginatedResponse
                        {
                            lista = _mapper.Map<List<EspecialistaSsiatResponse>>(response.Data) ?? new List<EspecialistaSsiatResponse>(),
                            Paginacion = new PaginacionResponse
                            {
                                totalReg = TotalReg,
                                rowsPerPage = PageSize,
                                currentPage = PageNumber
                            } ?? new PaginacionResponse()
                        },
                        IsSuccess = response.IsSuccess,
                        Message = response.Message
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpGet("SubsecretarioSsiatPaginated")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<SubsecretarioSsiatListPaginatedResponse>))]
        public IActionResult GetListSubsecretarioSsiatPaginated([FromQuery] SubsecretarioSsiatPaginatedFilterRequest request)
        {
            if (request == null)
                return BadRequest();

            var entidad = _mapper.Map<InformeRenacDto>(request);

            var response = _informeRenacApplication.GetListSubsecretarioSsiatPaginated(new Request<InformeRenacDto>() { entidad = entidad },
                                                                out int PageSize, out int PageNumber, out int TotalReg);

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<SubsecretarioSsiatListPaginatedResponse>
                    {
                        Data = new SubsecretarioSsiatListPaginatedResponse
                        {
                            lista = _mapper.Map<List<SubsecretarioSsiatResponse>>(response.Data) ?? new List<SubsecretarioSsiatResponse>(),
                            Paginacion = new PaginacionResponse
                            {
                                totalReg = TotalReg,
                                rowsPerPage = PageSize,
                                currentPage = PageNumber
                            } ?? new PaginacionResponse()
                        },
                        IsSuccess = response.IsSuccess,
                        Message = response.Message
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpGet("SubsecretarioSsatdotPaginated")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<SubsecretarioSsatdotListPaginatedResponse>))]
        public IActionResult GetListSubsecretarioSsatdotPaginated([FromQuery] SubsecretarioSsatdotPaginatedFilterRequest request)
        {
            if (request == null)
                return BadRequest();

            var response = _informeRenacApplication.GetListSubsecretarioSsatdotPaginated(new Request<InformeRenacDto>() { entidad = _mapper.Map<InformeRenacDto>(request) },
                                                                out int PageSize, out int PageNumber, out int TotalReg);

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<SubsecretarioSsatdotListPaginatedResponse>
                    {
                        Data = new SubsecretarioSsatdotListPaginatedResponse
                        {
                            lista = _mapper.Map<List<SubsecretarioSsatdotResponse>>(response.Data) ?? new List<SubsecretarioSsatdotResponse>(),
                            Paginacion = new PaginacionResponse
                            {
                                totalReg = TotalReg,
                                rowsPerPage = PageSize,
                                currentPage = PageNumber
                            } ?? new PaginacionResponse()
                        },
                        IsSuccess = response.IsSuccess,
                        Message = response.Message
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpGet("EspecialistaSsatdotPaginated")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<EspecialistaSsatdotListPaginatedResponse>))]
        public IActionResult GetListEspecialistaSsatdotPaginated([FromQuery] EspecialistaSsatdotPaginatedFilterRequest request)
        {
            if (request == null)
                return BadRequest();

            var response = _informeRenacApplication.GetListEspecialistaSsatdotPaginated(new Request<InformeRenacDto>() { entidad = _mapper.Map<InformeRenacDto>(request) },
                                                                out int PageSize, out int PageNumber, out int TotalReg);

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<EspecialistaSsatdotListPaginatedResponse>
                    {
                        Data = new EspecialistaSsatdotListPaginatedResponse
                        {
                            lista = _mapper.Map<List<EspecialistaSsatdotResponse>>(response.Data) ?? new List<EspecialistaSsatdotResponse>(),
                            Paginacion = new PaginacionResponse
                            {
                                totalReg = TotalReg,
                                rowsPerPage = PageSize,
                                currentPage = PageNumber
                            } ?? new PaginacionResponse()
                        },
                        IsSuccess = response.IsSuccess,
                        Message = response.Message
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpGet("SubsecretarioSsatdotDerivacionInformesPaginated")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<SubsecretarioSsatdotDerivacionInformesListPaginatedResponse>))]
        public IActionResult GetListSubsecretarioSsatdotDerivacionInformesPaginated([FromQuery] SubsecretarioSsatdotDerivacionInformesPaginatedFilterRequest request)
        {
            if (request == null)
                return BadRequest();

            var response = _informeRenacApplication.GetListSubsecretarioSsatdotDerivacionInformesPaginated(new Request<InformeRenacDto>() { entidad = _mapper.Map<InformeRenacDto>(request) },
                                                                out int PageSize, out int PageNumber, out int TotalReg);

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<SubsecretarioSsatdotDerivacionInformesListPaginatedResponse>
                    {
                        Data = new SubsecretarioSsatdotDerivacionInformesListPaginatedResponse
                        {
                            lista = _mapper.Map<List<SubsecretarioSsatdotDerivacionInformesResponse>>(response.Data) ?? new List<SubsecretarioSsatdotDerivacionInformesResponse>(),
                            Paginacion = new PaginacionResponse
                            {
                                totalReg = TotalReg,
                                rowsPerPage = PageSize,
                                currentPage = PageNumber
                            } ?? new PaginacionResponse()
                        },
                        IsSuccess = response.IsSuccess,
                        Message = response.Message
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpGet("InformacionSsiatDocumentos")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<InformacionSsiatDocumentosResponse>))]
        public IActionResult GetListInformacionSsiatDocumentos([FromQuery] InformacionSsiatDocumentosRequest request)
        {
            if (request == null)
                return BadRequest();

            var entidad = _mapper.Map<InformeRenacDto>(request);
            var response = _informeRenacApplication.GetListInformacionSsiatDocumentos(new Request<InformeRenacDto>() { entidad = entidad });

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<InformacionSsiatDocumentosResponse>
                    {
                        Data = _mapper.Map<InformacionSsiatDocumentosResponse>(response.Data) ?? new InformacionSsiatDocumentosResponse(),
                        IsSuccess = response.IsSuccess,
                        Message = response.Message
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpPut("UpdateEvaluacionFavorable")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response))]
        public IActionResult UpdateEvaluacionFavorable([FromForm] UpdateEvaluacionFavorableRequest request)
        {
            if (request == null)
                return BadRequest();

            var response = _informeRenacApplication.UpdateEvaluacionFavorable(new Request<InformeRenacDto>() { entidad = _mapper.Map<InformeRenacDto>(request) });

            if (response.IsSuccess)
            {
                return Ok(
                    new Response
                    {
                        IsSuccess = response.IsSuccess,
                        Message = response.Message,
                        Errors = response.Errors
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpPut("UpdateInformesOpinionFavorable")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response))]
        public IActionResult UpdateInformesOpinionFavorable([FromForm] UpdateInformesOpinionFavorableRequest request)
        {
            if (request == null)
                return BadRequest();

            var response = _informeRenacApplication.UpdateInformesOpinionFavorable(new Request<InformeRenacDto>() { entidad = _mapper.Map<InformeRenacDto>(request) });

            if (response.IsSuccess)
            {
                return Ok(
                    new Response
                    {
                        IsSuccess = response.IsSuccess,
                        Message = response.Message,
                        Errors = response.Errors
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpPut("ValidateInformeEvaluacionFavorable")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response))]
        public IActionResult VerificarInformeEvaluacionFavorable([FromForm] VerificarInformeEvaluacionFavorableRequest request)
        {
            if (request == null)
                return BadRequest();

            var response = _informeRenacApplication.VerificarInformeEvaluacionFavorable(new Request<InformeRenacDto>() { entidad = _mapper.Map<InformeRenacDto>(request) });

            if (response.IsSuccess)
            {
                return Ok(
                    new Response
                    {
                        IsSuccess = response.IsSuccess,
                        Message = response.Message,
                        Errors = response.Errors
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpGet("ResponsableArchivoSolicitudInformacionPaginated")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<ResponsableArchivoSolicitudInformacionListPaginatedResponse>))]
        public IActionResult GetListResponsableArchivoSolicitudInformacionPaginated([FromQuery] ResponsableArchivoSolicitudInformacionRequest request)
        {
            if (request == null)
                return BadRequest();

            var response = _informeRenacApplication.GetListResponsableArchivoSolicitudInformacionPaginated(new Request<InformeRenacDto>() { entidad = _mapper.Map<InformeRenacDto>(request) },
                                                                out int PageSize, out int PageNumber, out int TotalReg);

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<ResponsableArchivoSolicitudInformacionListPaginatedResponse>
                    {
                        Data = new ResponsableArchivoSolicitudInformacionListPaginatedResponse
                        {
                            lista = _mapper.Map<List<ResponsableArchivoSolicitudInformacionResponse>>(response.Data) ?? new List<ResponsableArchivoSolicitudInformacionResponse>(),
                            Paginacion = new PaginacionResponse
                            {
                                totalReg = TotalReg,
                                rowsPerPage = PageSize,
                                currentPage = PageNumber
                            } ?? new PaginacionResponse()
                        },
                        IsSuccess = response.IsSuccess,
                        Message = response.Message
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpPut("UpdateSolicitudInformacionInformeRenac")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response))]
        public IActionResult UpdateSolicitudInformacion([FromForm] UpdateSolicitudInformacionRequest request)
        {
            if (request == null)
                return BadRequest();

            var response = _informeRenacApplication.UpdateSolicitudInformacion(new Request<InformeRenacDto>() { entidad = _mapper.Map<InformeRenacDto>(request) });

            if (response.IsSuccess)
            {
                return Ok(
                    new Response
                    {
                        IsSuccess = response.IsSuccess,
                        Message = response.Message,
                        Errors = response.Errors
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpGet("EspecialistaSsiatRegistroFormatos")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<EspecialistaSsiatRegistroFormatosListPaginatedResponse>))]
        public IActionResult GetListEspecialistaSsiatRegistroFormatosPaginated([FromQuery] EspecialistaSsiatRegistroFormatosRequest request)
        {
            if (request == null)
                return BadRequest();

            var response = _informeRenacApplication.GetListEspecialistaSsiatRegistroFormatosPaginated(new Request<InformeRenacDto>() { entidad = _mapper.Map<InformeRenacDto>(request) },
                                                                out int PageSize, out int PageNumber, out int TotalReg);

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<EspecialistaSsiatRegistroFormatosListPaginatedResponse>
                    {
                        Data = new EspecialistaSsiatRegistroFormatosListPaginatedResponse
                        {
                            lista = _mapper.Map<List<EspecialistaSsiatRegistroFormatosResponse>>(response.Data) ?? new List<EspecialistaSsiatRegistroFormatosResponse>(),
                            Paginacion = new PaginacionResponse
                            {
                                totalReg = TotalReg,
                                rowsPerPage = PageSize,
                                currentPage = PageNumber
                            } ?? new PaginacionResponse()
                        },
                        IsSuccess = response.IsSuccess,
                        Message = response.Message
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpPut("UpdateConstanciaAnotacionResponsableArchivo")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response))]
        public IActionResult UpdateConstanciaAnotacion([FromForm] UpdateConstanciaAnotacionRequest request)
        {
            if (request == null)
                return BadRequest();

            var response = _informeRenacApplication.UpdateConstanciaAnotacion(new Request<InformeRenacDto>() { entidad = _mapper.Map<InformeRenacDto>(request) });

            if (response.IsSuccess)
            {
                return Ok(
                    new Response
                    {
                        IsSuccess = response.IsSuccess,
                        Message = response.Message,
                        Errors = response.Errors
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpPut("UpdateRespuestaGoreEspecialistaSsiat")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response))]
        public IActionResult UpdateRespuestaGore([FromForm] UpdateRespuestaGoreRequest request)
        {
            if (request == null)
                return BadRequest();

            var response = _informeRenacApplication.UpdateRespuestaGore(new Request<InformeRenacDto>() { entidad = _mapper.Map<InformeRenacDto>(request) });

            if (response.IsSuccess)
            {
                return Ok(
                    new Response
                    {
                        IsSuccess = response.IsSuccess,
                        Message = response.Message,
                        Errors = response.Errors
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpGet("GetListPaginatedSubsecretarioSsiatRegistroAnotacion")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<SubsecretarioSsiatRegistroAnotacionListPaginatedResponse>))]
        public IActionResult GetListSubsecretarioSsiatRegistroAnotacionPaginated([FromQuery] SubsecretarioSsiatRegistroAnotacionRequest request)
        {
            if (request == null)
                return BadRequest();

            var response = _informeRenacApplication.GetListSubsecretarioSsiatRegistroAnotacionPaginated(new Request<InformeRenacDto>() { entidad = _mapper.Map<InformeRenacDto>(request) },
                                                                out int PageSize, out int PageNumber, out int TotalReg);

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<SubsecretarioSsiatRegistroAnotacionListPaginatedResponse>
                    {
                        Data = new SubsecretarioSsiatRegistroAnotacionListPaginatedResponse
                        {
                            lista = _mapper.Map<List<SubsecretarioSsiatRegistroAnotacionResponse>>(response.Data) ?? new List<SubsecretarioSsiatRegistroAnotacionResponse>(),
                            Paginacion = new PaginacionResponse
                            {
                                totalReg = TotalReg,
                                rowsPerPage = PageSize,
                                currentPage = PageNumber
                            } ?? new PaginacionResponse()
                        },
                        IsSuccess = response.IsSuccess,
                        Message = response.Message
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpPut("UpdateRegistroAnotacionInformeRenac")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response))]
        public IActionResult UpdateRegistroAnotacion([FromForm] UpdateRegistroAnotacionRequest request)
        {
            if (request == null)
                return BadRequest();

            var response = _informeRenacApplication.UpdateRegistroAnotacion(new Request<InformeRenacDto>() { entidad = _mapper.Map<InformeRenacDto>(request) });

            if (response.IsSuccess)
            {
                return Ok(
                    new Response
                    {
                        IsSuccess = response.IsSuccess,
                        Message = response.Message,
                        Errors = response.Errors
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpPut("UpdateConstanciaAnotacionFirmada")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response))]
        public IActionResult UpdateConstanciaAnotacionFirmada([FromForm] UpdateConstanciaAnotacionFirmadaRequest request)
        {
            if (request == null)
                return BadRequest();

            var response = _informeRenacApplication.UpdateConstanciaAnotacionFirmada(new Request<InformeRenacDto>() { entidad = _mapper.Map<InformeRenacDto>(request) });

            if (response.IsSuccess)
            {
                return Ok(
                    new Response
                    {
                        IsSuccess = response.IsSuccess,
                        Message = response.Message,
                        Errors = response.Errors
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpGet("GetListResponsableArchivoRegistroAnotacionPaginated")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<ResponsableArchivoRegistroAnotacionListPaginatedResponse>))]
        public IActionResult GetListResponsableArchivoRegistroAnotacionPaginated([FromQuery] ResponsableArchivoRegistroAnotacionRequest request)
        {
            if (request == null)
                return BadRequest();

            var response = _informeRenacApplication.GetListResponsableArchivoRegistroAnotacionPaginated(new Request<InformeRenacDto>() { entidad = _mapper.Map<InformeRenacDto>(request) },
                                                                out int PageSize, out int PageNumber, out int TotalReg);

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<ResponsableArchivoRegistroAnotacionListPaginatedResponse>
                    {
                        Data = new ResponsableArchivoRegistroAnotacionListPaginatedResponse
                        {
                            lista = _mapper.Map<List<ResponsableArchivoRegistroAnotacionResponse>>(response.Data) ?? new List<ResponsableArchivoRegistroAnotacionResponse>(),
                            Paginacion = new PaginacionResponse
                            {
                                totalReg = TotalReg,
                                rowsPerPage = PageSize,
                                currentPage = PageNumber
                            } ?? new PaginacionResponse()
                        },
                        IsSuccess = response.IsSuccess,
                        Message = response.Message
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpPut("UpdateCerrarProcesoAnotacionInformeRenac")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response))]
        public IActionResult UpdateCerrarProcesoAnotacion([FromForm] CerrarProcesoAnotacionRequest request)
        {
            if (request == null)
                return BadRequest();

            var response = _informeRenacApplication.UpdateCerrarProcesoAnotacion(new Request<InformeRenacDto>() { entidad = _mapper.Map<InformeRenacDto>(request) });

            if (response.IsSuccess)
            {
                return Ok(
                    new Response
                    {
                        IsSuccess = response.IsSuccess,
                        Message = response.Message,
                        Errors = response.Errors
                    });
            }

            return new BadRequestObjectResult(response);
        }
    }
}
