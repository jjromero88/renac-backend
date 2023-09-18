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
    public class AsientoModificacionController : Controller
    {
        private readonly IAsientoModificacionApplication _asientoModificacionApplication;
        private readonly IMapper _mapper;

        public AsientoModificacionController(IAsientoModificacionApplication asientoModificacionApplication, IMapper mapper)
        {
            _asientoModificacionApplication = asientoModificacionApplication ?? throw new ArgumentNullException(nameof(asientoModificacionApplication));
            _mapper = mapper ?? throw new ArgumentNullException(nameof(mapper));
        }

        [HttpPost("Insert")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<AsientoModificacionResponse>))]
        public IActionResult Insert([FromBody] AsientoModificacionInsertRequest asientoModificacionRequest)
        {
            if (asientoModificacionRequest == null)
                return BadRequest();

            var asientoModificacionDTO = _mapper.Map<AsientoModificacionDto>(asientoModificacionRequest);
            var response = _asientoModificacionApplication.Insert(new Request<AsientoModificacionDto>() { entidad = asientoModificacionDTO });

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<AsientoModificacionResponse>
                    {
                        IsSuccess = response.IsSuccess,
                        Message = response.Message,
                        Errors = response.Errors
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpPut("Update")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<AsientoModificacionResponse>))]
        public IActionResult Update([FromBody] AsientoModificacionUpdateRequest asientoModificacionRequest)
        {
            if (asientoModificacionRequest == null)
                return BadRequest();

            var asientoModificacionDto = _mapper.Map<AsientoModificacionDto>(asientoModificacionRequest);

            var response = _asientoModificacionApplication.Update(new Request<AsientoModificacionDto>() { entidad = asientoModificacionDto });

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<AsientoModificacionResponse>
                    {
                        IsSuccess = response.IsSuccess,
                        Message = response.Message,
                        Errors = response.Errors
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpDelete("Delete")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<AsientoModificacionResponse>))]
        public IActionResult Delete([FromBody] AsientoModificacionIdRequest asientoModificacionIdRequest)
        {
            if (asientoModificacionIdRequest == null)
                return BadRequest();

            var asientoModificacionDTO = _mapper.Map<AsientoModificacionDto>(asientoModificacionIdRequest);
            var response = _asientoModificacionApplication.Delete(new Request<AsientoModificacionDto>() { entidad = asientoModificacionDTO });

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<AsientoModificacionResponse>
                    {
                        IsSuccess = response.IsSuccess,
                        Message = response.Message,
                        Errors = response.Errors
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpGet("GetById")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<AsientoModificacionResponse>))]
        public IActionResult GetById([FromQuery] AsientoModificacionIdRequest asientoModificacionIdRequest)
        {
            if (asientoModificacionIdRequest == null)
                return BadRequest();

            var asientoModificacionDto = _mapper.Map<AsientoModificacionDto>(asientoModificacionIdRequest);

            var response = _asientoModificacionApplication.GetById(new Request<AsientoModificacionDto>() { entidad = asientoModificacionDto });

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<AsientoModificacionResponse>
                    {
                        Data = _mapper.Map<AsientoModificacionResponse>(response.Data) ?? new AsientoModificacionResponse(),
                        IsSuccess = response.IsSuccess,
                        Message = response.Message
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpGet("GetList")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<AsientoModificacionListResponse>))]
        public IActionResult GetList([FromQuery] AsientoModificacionFiltrosRequest asientoModificacionFiltrosRequest)
        {
            if (asientoModificacionFiltrosRequest == null)
                return BadRequest();

            var asientoModificacionDTO = _mapper.Map<AsientoModificacionDto>(asientoModificacionFiltrosRequest);
            var response = _asientoModificacionApplication.GetList(new Request<AsientoModificacionDto>() { entidad = asientoModificacionDTO });

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<List<AsientoModificacionResponse>>
                    {
                        Data = _mapper.Map<List<AsientoModificacionResponse>>(response.Data) ?? new List<AsientoModificacionResponse>(),
                        IsSuccess = response.IsSuccess,
                        Message = response.Message
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpGet("GetListPaginated")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<AsientoModificacionListPaginatedResponse>))]
        public IActionResult GetListPaginated([FromQuery] AsientoModificacionPaginacionFiltroRequest paginacionFiltroRequest)
        {
            if (paginacionFiltroRequest == null)
                return BadRequest();

            var asientoModificacionDTO = _mapper.Map<AsientoModificacionDto>(paginacionFiltroRequest);
            var response = _asientoModificacionApplication.GetListPaginated(new Request<AsientoModificacionDto>() { entidad = asientoModificacionDTO },
                                                                out int PageSize, out int PageNumber, out int TotalReg);
            if (response.IsSuccess)
            {
                return Ok(
                    new Response<AsientoModificacionListPaginatedResponse>
                    {
                        Data = new AsientoModificacionListPaginatedResponse
                        {
                            AsientoModificacion = _mapper.Map<List<AsientoModificacionResponse>>(response.Data) ?? new List<AsientoModificacionResponse>(),
                            Paginacion = new PaginacionResponse
                            {
                                totalReg = TotalReg,
                                rowsPerPage = PageSize,
                                currentPage = PageNumber
                            } ?? new PaginacionResponse()
                        },
                        IsSuccess = response.IsSuccess,
                        Message = response.Message
                    }
                    );
            }

            return new BadRequestObjectResult(response);
        }

    }
}
