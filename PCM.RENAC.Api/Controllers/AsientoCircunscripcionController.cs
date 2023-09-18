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
    public class AsientoCircunscripcionController : Controller
    {
        private readonly IAsientoCircunscripcionApplication _asientoCircunscripcionApplication;
        private readonly IMapper _mapper;

        public AsientoCircunscripcionController(IAsientoCircunscripcionApplication asientoCircunscripcionApplication, IMapper mapper)
        {
            _asientoCircunscripcionApplication = asientoCircunscripcionApplication ?? throw new ArgumentNullException(nameof(asientoCircunscripcionApplication));
            _mapper = mapper ?? throw new ArgumentNullException(nameof(mapper));
        }

        [HttpPost("Insert")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<AsientoCircunscripcionResponse>))]
        public IActionResult Insert([FromBody] AsientoCircunscripcionInsertRequest asientoCircunscripcionRequest)
        {
            if (asientoCircunscripcionRequest == null)
                return BadRequest();

            var asientoCircunscripcionDTO = _mapper.Map<AsientoCircunscripcionDto>(asientoCircunscripcionRequest);

            var response = _asientoCircunscripcionApplication.Insert(new Request<AsientoCircunscripcionDto>() { entidad = asientoCircunscripcionDTO });

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<AsientoCircunscripcionResponse>
                    {
                        IsSuccess = response.IsSuccess,
                        Message = response.Message,
                        Errors = response.Errors
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpPut("Update")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<AsientoCircunscripcionResponse>))]
        public IActionResult Update([FromBody] AsientoCircunscripcionUpdateRequest asientoCircunscripcionRequest)
        {
            if (asientoCircunscripcionRequest == null)
                return BadRequest();

            var asientoCircunscripcionRequestDTO = _mapper.Map<AsientoCircunscripcionDto>(asientoCircunscripcionRequest);

            var response = _asientoCircunscripcionApplication.Update(new Request<AsientoCircunscripcionDto>() { entidad = asientoCircunscripcionRequestDTO });

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<AsientoCircunscripcionResponse>
                    {
                        IsSuccess = response.IsSuccess,
                        Message = response.Message,
                        Errors = response.Errors
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpDelete("Delete")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<AsientoCircunscripcionResponse>))]
        public IActionResult Delete([FromBody] AsientoCircunscripcionIdRequest asientoCircunscripcionIdRequest)
        {
            if (asientoCircunscripcionIdRequest == null)
                return BadRequest();

            var asientoCircunscripcionDTO = _mapper.Map<AsientoCircunscripcionDto>(asientoCircunscripcionIdRequest);

            var response = _asientoCircunscripcionApplication.Delete(new Request<AsientoCircunscripcionDto>() { entidad = asientoCircunscripcionDTO });

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<AsientoCircunscripcionResponse>
                    {
                        IsSuccess = response.IsSuccess,
                        Message = response.Message,
                        Errors = response.Errors
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpGet("GetById")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<AsientoCircunscripcionResponse>))]
        public IActionResult GetById([FromQuery] AsientoCircunscripcionIdRequest asientoCircunscripcionIdRequest)
        {
            if (asientoCircunscripcionIdRequest == null)
                return BadRequest();

            var asientoCircunscripcionDto = _mapper.Map<AsientoCircunscripcionDto>(asientoCircunscripcionIdRequest);

            var response = _asientoCircunscripcionApplication.GetById(new Request<AsientoCircunscripcionDto>() { entidad = asientoCircunscripcionDto });

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<AsientoCircunscripcionResponse>
                    {
                        Data = _mapper.Map<AsientoCircunscripcionResponse>(response.Data) ?? new AsientoCircunscripcionResponse(),
                        IsSuccess = response.IsSuccess,
                        Message = response.Message
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpGet("GetList")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<AsientoCircunscripcionListResponse>))]
        public IActionResult GetList([FromQuery] AsientoCircunscripcionFiltrosRequest asientoCircunscripcionFiltrosRequest)
        {
            if (asientoCircunscripcionFiltrosRequest == null)
                return BadRequest();

            var asientoCircunscripcionDTO = _mapper.Map<AsientoCircunscripcionDto>(asientoCircunscripcionFiltrosRequest);
            var response = _asientoCircunscripcionApplication.GetList(new Request<AsientoCircunscripcionDto>() { entidad = asientoCircunscripcionDTO });

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<List<AsientoCircunscripcionResponse>>
                    {
                        Data = _mapper.Map<List<AsientoCircunscripcionResponse>>(response.Data) ?? new List<AsientoCircunscripcionResponse>(),
                        IsSuccess = response.IsSuccess,
                        Message = response.Message
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpGet("GetListPaginated")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<AsientoCircunscripcionListPaginatedResponse>))]
        public IActionResult GetListPaginated([FromQuery] AsientoCircunscripcionPaginacionFiltroRequest asientoCircunscripcionPaginacionFiltroRequest)
        {
            if (asientoCircunscripcionPaginacionFiltroRequest == null)
                return BadRequest();

            var asientoCircunscripcionDTO = _mapper.Map<AsientoCircunscripcionDto>(asientoCircunscripcionPaginacionFiltroRequest);

            var response = _asientoCircunscripcionApplication.GetListPaginated(new Request<AsientoCircunscripcionDto>() { entidad = asientoCircunscripcionDTO },
                                                                out int PageSize, out int PageNumber, out int TotalReg);

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<AsientoCircunscripcionListPaginatedResponse>
                    {
                        Data = new AsientoCircunscripcionListPaginatedResponse
                        {
                            AsientoCircunscripcion = _mapper.Map<List<AsientoCircunscripcionResponse>>(response.Data) ?? new List<AsientoCircunscripcionResponse>(),
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

        [HttpGet("InformacionSsiatAsientos")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<InformacionSsiatAsientosListResponse>))]
        public IActionResult GetListInformacionSsiatAsientos([FromQuery] InformacionSsiatAsientosRequest request)
        {
            if (request == null)
                return BadRequest();

            var entidad = _mapper.Map<AsientoCircunscripcionDto>(request);
            var response = _asientoCircunscripcionApplication.InformacionSsiatAsientosList(new Request<AsientoCircunscripcionDto>() { entidad = entidad });

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<InformacionSsiatAsientosListResponse>
                    {
                        Data = new InformacionSsiatAsientosListResponse
                        {
                            lista = _mapper.Map<List<InformacionSsiatAsientosResponse>>(response.Data) ?? new List<InformacionSsiatAsientosResponse>()
                        },
                        IsSuccess = response.IsSuccess,
                        Message = response.Message
                    });
            }

            return new BadRequestObjectResult(response);
        }

    }
}
