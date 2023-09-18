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
    public class TipoModificacionAsientoController : Controller
    {
        private readonly ITipoModificacionAsientoApplication _tipoModificacionAsientoApplication;
        private readonly IMapper _mapper;

        public TipoModificacionAsientoController(ITipoModificacionAsientoApplication tipoModificacionAsientoApplication, IMapper mapper)
        {
            _tipoModificacionAsientoApplication = tipoModificacionAsientoApplication ?? throw new ArgumentNullException(nameof(tipoModificacionAsientoApplication));
            _mapper = mapper ?? throw new ArgumentNullException(nameof(mapper));
        }

        [HttpPost("Insert")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<TipoModificacionAsientoResponse>))]
        public IActionResult Insert([FromBody] TipoModificacionAsientoInsertRequest tipoModificacionAsientoRequest)
        {
            if (tipoModificacionAsientoRequest == null)
                return BadRequest();

            var tipoModificacionAsientoDTO = _mapper.Map<TipoModificacionAsientoDto>(tipoModificacionAsientoRequest);

            var response = _tipoModificacionAsientoApplication.Insert(new Request<TipoModificacionAsientoDto>() { entidad = tipoModificacionAsientoDTO });

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
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<TipoModificacionAsientoResponse>))]
        public IActionResult Update([FromBody] TipoModificacionAsientoUpdateRequest tipoModificacionAsientoRequest)
        {
            if (tipoModificacionAsientoRequest == null)
                return BadRequest();

            var tipoModificacionAsientoDTO = _mapper.Map<TipoModificacionAsientoDto>(tipoModificacionAsientoRequest);

            var response = _tipoModificacionAsientoApplication.Update(new Request<TipoModificacionAsientoDto>() { entidad = tipoModificacionAsientoDTO });

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
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<TipoModificacionAsientoResponse>))]
        public IActionResult Delete([FromBody] TipoModificacionAsientoIdRequest tipoModificacionAsientoIdRequest)
        {
            if (tipoModificacionAsientoIdRequest == null)
                return BadRequest();

            var tipoModificacionAsientoDTO = _mapper.Map<TipoModificacionAsientoDto>(tipoModificacionAsientoIdRequest);

            var response = _tipoModificacionAsientoApplication.Delete(new Request<TipoModificacionAsientoDto>() { entidad = tipoModificacionAsientoDTO });

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
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<TipoModificacionAsientoResponse>))]
        public IActionResult GetById([FromQuery] TipoModificacionAsientoIdRequest tipoModificacionAsientoIdRequest)
        {
            if (tipoModificacionAsientoIdRequest == null)
                return BadRequest();

            var tipoModificacionAsientoDto = _mapper.Map<TipoModificacionAsientoDto>(tipoModificacionAsientoIdRequest);

            var response = _tipoModificacionAsientoApplication.GetById(new Request<TipoModificacionAsientoDto>() { entidad = tipoModificacionAsientoDto });

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<TipoModificacionAsientoResponse>
                    {
                        Data = _mapper.Map<TipoModificacionAsientoResponse>(response.Data) ?? new TipoModificacionAsientoResponse(),
                        IsSuccess = response.IsSuccess,
                        Message = response.Message
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpGet("GetList")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<TipoModificacionAsientoListResponse>))]
        public IActionResult GetList([FromQuery] TipoModificacionAsientoFiltrosRequest tipoModificacionAsientoFiltrosRequest)
        {
            if (tipoModificacionAsientoFiltrosRequest == null)
                return BadRequest();

            var tipoModificacionAsientoDTO = _mapper.Map<TipoModificacionAsientoDto>(tipoModificacionAsientoFiltrosRequest);

            var response = _tipoModificacionAsientoApplication.GetList(new Request<TipoModificacionAsientoDto>() { entidad = tipoModificacionAsientoDTO });

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<List<TipoModificacionAsientoResponse>>
                    {
                        Data = _mapper.Map<List<TipoModificacionAsientoResponse>>(response.Data) ?? new List<TipoModificacionAsientoResponse>(),
                        IsSuccess = response.IsSuccess,
                        Message = response.Message
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpGet("GetListPaginated")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<TipoModificacionAsientoListPaginatedResponse>))]
        public IActionResult GetListPaginated([FromQuery] TipoModificacionAsientoPaginacionFiltroRequest tipoModificacionAsientoPaginacionFiltroRequest)
        {
            if (tipoModificacionAsientoPaginacionFiltroRequest == null)
                return BadRequest();

            var tipoModificacionAsientoDTO = _mapper.Map<TipoModificacionAsientoDto>(tipoModificacionAsientoPaginacionFiltroRequest);

            var response = _tipoModificacionAsientoApplication.GetListPaginated(new Request<TipoModificacionAsientoDto>() { entidad = tipoModificacionAsientoDTO },
                                                                out int PageSize, out int PageNumber, out int TotalReg);

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<TipoModificacionAsientoListPaginatedResponse>
                    {
                        Data = new TipoModificacionAsientoListPaginatedResponse
                        {
                            TipoModificacionAsiento = _mapper.Map<List<TipoModificacionAsientoResponse>>(response.Data) ?? new List<TipoModificacionAsientoResponse>(),
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

    }
}
