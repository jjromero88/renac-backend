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
    public class DerivacionRenacController : Controller
    {
        private readonly IDerivacionRenacApplication _derivacionRenacApplication;
        private readonly IMapper _mapper;

        public DerivacionRenacController(IDerivacionRenacApplication derivacionRenacApplication, IMapper mapper)
        {
            _derivacionRenacApplication = derivacionRenacApplication ?? throw new ArgumentNullException(nameof(derivacionRenacApplication));
            _mapper = mapper ?? throw new ArgumentNullException(nameof(mapper));
        }

        // Metodos CRUD

        [HttpPost("Insert")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<DerivacionRenacResponse>))]
        public IActionResult Insert([FromBody] DerivacionRenacInsertRequest derivacionRenacRequest)
        {
            if (derivacionRenacRequest == null)
                return BadRequest();

            var derivacionRenacDTO = _mapper.Map<DerivacionRenacDto>(derivacionRenacRequest);

            var response = _derivacionRenacApplication.Insert(new Request<DerivacionRenacDto>() { entidad = derivacionRenacDTO });

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<DerivacionRenacResponse>
                    {
                        IsSuccess = response.IsSuccess,
                        Message = response.Message,
                        Errors = response.Errors
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpPut("Update")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<DerivacionRenacResponse>))]
        public IActionResult Update([FromBody] DerivacionRenacUpdateRequest derivacionRenac)
        {
            if (derivacionRenac == null)
                return BadRequest();

            var derivacionRenacDto = _mapper.Map<DerivacionRenacDto>(derivacionRenac);

            var response = _derivacionRenacApplication.Update(new Request<DerivacionRenacDto>() { entidad = derivacionRenacDto });

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<DerivacionRenacResponse>
                    {
                        IsSuccess = response.IsSuccess,
                        Message = response.Message,
                        Errors = response.Errors
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpDelete("Delete")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<DerivacionRenacResponse>))]
        public IActionResult Delete([FromBody] DerivacionRenacIdRequest derivacionRenacIdRequest)
        {
            if (derivacionRenacIdRequest == null)
                return BadRequest();

            var derivacionRenacDTO = _mapper.Map<DerivacionRenacDto>(derivacionRenacIdRequest);

            var response = _derivacionRenacApplication.Delete(new Request<DerivacionRenacDto>() { entidad = derivacionRenacDTO });

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<DerivacionRenacResponse>
                    {
                        IsSuccess = response.IsSuccess,
                        Message = response.Message,
                        Errors = response.Errors
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpGet("GetById")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<DerivacionRenacResponse>))]
        public IActionResult GetById([FromQuery] DerivacionRenacIdRequest derivacionRenacIdRequest)
        {
            if (derivacionRenacIdRequest == null)
                return BadRequest();

            var derivacionRenacDto = _mapper.Map<DerivacionRenacDto>(derivacionRenacIdRequest);

            var response = _derivacionRenacApplication.GetById(new Request<DerivacionRenacDto>() { entidad = derivacionRenacDto });

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<DerivacionRenacResponse>
                    {
                        Data = _mapper.Map<DerivacionRenacResponse>(response.Data) ?? new DerivacionRenacResponse(),
                        IsSuccess = response.IsSuccess,
                        Message = response.Message
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpGet("GetList")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<DerivacionRenacListResponse>))]
        public IActionResult GetList([FromQuery] DerivacionRenacFiltrosRequest derivacionRenacFiltrosRequest)
        {
            if (derivacionRenacFiltrosRequest == null)
                return BadRequest();

            var derivacionRenacDTO = _mapper.Map<DerivacionRenacDto>(derivacionRenacFiltrosRequest);

            var response = _derivacionRenacApplication.GetList(new Request<DerivacionRenacDto>() { entidad = derivacionRenacDTO });

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<List<DerivacionRenacResponse>>
                    {
                        Data = _mapper.Map<List<DerivacionRenacResponse>>(response.Data) ?? new List<DerivacionRenacResponse>(),
                        IsSuccess = response.IsSuccess,
                        Message = response.Message
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpGet("GetListPaginated")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<DerivacionRenacListPaginatedResponse>))]
        public IActionResult GetListPaginated([FromQuery] DerivacionRenacPaginacionFiltroRequest derivacionRenacPaginacionFiltroRequest)
        {
            if (derivacionRenacPaginacionFiltroRequest == null)
                return BadRequest();

            var derivacionRenacDTO = _mapper.Map<DerivacionRenacDto>(derivacionRenacPaginacionFiltroRequest);

            var response = _derivacionRenacApplication.GetListPaginated(new Request<DerivacionRenacDto>() { entidad = derivacionRenacDTO },
                                                                out int PageSize, out int PageNumber, out int TotalReg);

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<DerivacionRenacListPaginatedResponse>
                    {
                        Data = new DerivacionRenacListPaginatedResponse
                        {
                            DerivacionRenac = _mapper.Map<List<DerivacionRenacResponse>>(response.Data) ?? new List<DerivacionRenacResponse>(),
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


        //Metodos Derivacion

        [HttpPut("DerivacionEspecialistaSsiat")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<DerivacionRenacResponse>))]
        public IActionResult EspecialistaSsiat([FromBody] DerivacionEspecialistaSSIATRequest request)
        {
            if (request == null)
                return BadRequest();

            var entidad = _mapper.Map<DerivacionRenacDto>(request);

            var response = _derivacionRenacApplication.DerivacionEspecialistaSSIAT(new Request<DerivacionRenacDto>() { entidad = entidad });

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<DerivacionRenacResponse>
                    {
                        IsSuccess = response.IsSuccess,
                        Message = response.Message,
                        Errors = response.Errors
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpPut("DerivacionSubsecretarioSsiat")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<DerivacionRenacResponse>))]
        public IActionResult SubsecretarioSsiat([FromForm] DerivacionSubsecretarioSSIATRequest request)
        {
            if (request == null)
                return BadRequest();

            var entidad = _mapper.Map<DerivacionRenacDto>(request);

            var response = _derivacionRenacApplication.DerivacionSubsecretarioSSIAT(new Request<DerivacionRenacDto>() { entidad = entidad });

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<DerivacionRenacResponse>
                    {
                        IsSuccess = response.IsSuccess,
                        Message = response.Message,
                        Errors = response.Errors
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpPut("DerivacionSubsecretarioSsatdot")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<DerivacionRenacResponse>))]
        public IActionResult SubsecretarioSsatdot([FromForm] DerivacionSubsecretarioSSATDOTRequest request)
        {
            if (request == null)
                return BadRequest();

            var response = _derivacionRenacApplication.DerivacionSubsecretarioSSATDOT(new Request<DerivacionRenacDto>() { entidad = _mapper.Map<DerivacionRenacDto>(request) });

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<DerivacionRenacResponse>
                    {
                        IsSuccess = response.IsSuccess,
                        Message = response.Message,
                        Errors = response.Errors
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpPut("DerivacionEspecialistaSsatdot")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response))]
        public IActionResult DerivacionEspecialistaSSATDOT([FromForm] DerivacionEspecialistaSSATDOTRequest request)
        {
            if (request == null)
                return BadRequest();

            var response = _derivacionRenacApplication.DerivacionEspecialistaSSATDOT(new Request<DerivacionRenacDto>() { entidad = _mapper.Map<DerivacionRenacDto>(request) });

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

        [HttpPut("DerivacionInformesSubsecretarioSsatdot")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response))]
        public IActionResult DerivacionInformesSubsecretarioSSATDOT([FromForm] DerivacionInformesSubsecretarioSsatdotRequest request)
        {
            if (request == null)
                return BadRequest();

            var response = _derivacionRenacApplication.DerivacionInformesSubsecretarioSSATDOT(new Request<DerivacionRenacDto>() { entidad = _mapper.Map<DerivacionRenacDto>(request) });

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

        [HttpPut("DerivacionAjustesSubsecretarioSsiat")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<DerivacionRenacResponse>))]
        public IActionResult DerivacionAjustesSubsecretarioSSIAT([FromBody] DerivacionAjustesSubsecretarioSsiatRequest request)
        {
            if (request == null)
                return BadRequest();

            var entidad = _mapper.Map<DerivacionRenacDto>(request);

            var response = _derivacionRenacApplication.DerivacionAjustesSubsecretarioSSIAT(new Request<DerivacionRenacDto>() { entidad = entidad });

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<DerivacionRenacResponse>
                    {
                        IsSuccess = response.IsSuccess,
                        Message = response.Message,
                        Errors = response.Errors
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpPut("DerivacionAjustesEspecialistaSSATDOT")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response))]
        public IActionResult DerivacionAjustesEspecialistaSSATDOT([FromBody] DerivacionAjustesEspecialistaSsatdotRequest request)
        {
            if (request == null)
                return BadRequest();

            var response = _derivacionRenacApplication.DerivacionAjustesEspecialistaSSATDOT(new Request<DerivacionRenacDto>() { entidad = _mapper.Map<DerivacionRenacDto>(request) });

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

        [HttpPut("DerivacionAjustesSubsecretarioSSATDOT")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response))]
        public IActionResult DerivacionAjustesSubsecretarioSSATDOT([FromBody] DerivacionAjustesSubsecretarioSsatdotRequest request)
        {
            if (request == null)
                return BadRequest();

            var response = _derivacionRenacApplication.DerivacionAjustesSubsecretarioSSATDOT(new Request<DerivacionRenacDto>() { entidad = _mapper.Map<DerivacionRenacDto>(request) });

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

        [HttpPut("DerivacionInformesResponsableArchivo")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response))]
        public IActionResult DerivacionInformesResponsableArchivo([FromBody] DerivacionInformesResponsableArchivoRequest request)
        {
            if (request == null)
                return BadRequest();

            var response = _derivacionRenacApplication.DerivacionInformesResponsableArchivo(new Request<DerivacionRenacDto>() { entidad = _mapper.Map<DerivacionRenacDto>(request) });

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

        [HttpPut("RetornarInformeModificacionEspSsiat")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<DerivacionRenacResponse>))]
        public IActionResult DerivacionModificacionEspecialistaSSIAT([FromBody] DerivacionModificacionEspecialistaSsiatRequest request)
        {
            if (request == null)
                return BadRequest();

            var response = _derivacionRenacApplication.DerivacionModificacionEspecialistaSSIAT(new Request<DerivacionRenacDto>() { entidad = _mapper.Map<DerivacionRenacDto>(request) });

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<DerivacionRenacResponse>
                    {
                        IsSuccess = response.IsSuccess,
                        Message = response.Message,
                        Errors = response.Errors
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpPut("DerivarInformesParaAnotacionEspecialistaSSIAT")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response))]
        public IActionResult DerivacionParaAnotacionEspecialistaSSIAT([FromBody] DerivacionParaAnotacionEspecialistaSsiatRequest request)
        {
            if (request == null)
                return BadRequest();

            var response = _derivacionRenacApplication.DerivacionParaAnotacionEspecialistaSSIAT(new Request<DerivacionRenacDto>() { entidad = _mapper.Map<DerivacionRenacDto>(request) });

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

        [HttpPut("DerivarInformesParaAnotacionSubsecretarioSsiat")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response))]
        public IActionResult DerivacionParaAnotacionSubsecretarioSSIAT([FromForm] DerivacionParaAnotacionSubsecretarioSsiatRequest request)
        {
            if (request == null)
                return BadRequest();

            var response = _derivacionRenacApplication.DerivacionParaAnotacionSubsecretarioSSIAT(new Request<DerivacionRenacDto>() { entidad = _mapper.Map<DerivacionRenacDto>(request) });

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
