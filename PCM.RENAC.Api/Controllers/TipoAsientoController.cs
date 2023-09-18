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
    public class TipoAsientoController : Controller
    {
        private readonly ITipoAsientoApplication _tipoAsientoApplication;
        private readonly IMapper _mapper;

        public TipoAsientoController(ITipoAsientoApplication tipoAsientoApplication, IMapper mapper)
        {
            _tipoAsientoApplication = tipoAsientoApplication ?? throw new ArgumentNullException(nameof(tipoAsientoApplication));
            _mapper = mapper ?? throw new ArgumentNullException(nameof(mapper));
        }

        [HttpPost("Insert")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<TipoAsientoResponse>))]
        public IActionResult Insert([FromBody] TipoAsientoInsertRequest tipoAsientoRequest)
        {
            if (tipoAsientoRequest == null)
                return BadRequest();

            var tipoAsientoDTO = _mapper.Map<TipoAsientoDto>(tipoAsientoRequest);

            var response = _tipoAsientoApplication.Insert(new Request<TipoAsientoDto>() { entidad = tipoAsientoDTO });

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<AsientoModificacionResponse>
                    {
                        IsSuccess = response.IsSuccess,
                        Message = response.Message,
                        Errors = response.Errors
                    }
                    );
            }

            return new BadRequestObjectResult(response);
        }

        [HttpPut("Update")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<TipoAsientoResponse>))]
        public IActionResult Update([FromBody] TipoAsientoUpdateRequest tipoAsientoRequest)
        {
            if (tipoAsientoRequest == null)
                return BadRequest();

            var tipoAsientoDTO = _mapper.Map<TipoAsientoDto>(tipoAsientoRequest);

            var response = _tipoAsientoApplication.Update(new Request<TipoAsientoDto>() { entidad = tipoAsientoDTO });

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
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<TipoAsientoResponse>))]
        public IActionResult Delete([FromBody] TipoAsientoIdRequest tipoAsientoIdRequest)
        {
            if (tipoAsientoIdRequest == null)
                return BadRequest();

            var tipoAsientoDTO = _mapper.Map<TipoAsientoDto>(tipoAsientoIdRequest);

            var response = _tipoAsientoApplication.Delete(new Request<TipoAsientoDto>() { entidad = tipoAsientoDTO });

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
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<TipoAsientoResponse>))]
        public IActionResult GetById([FromQuery] TipoAsientoIdRequest tipoAsientoIdRequest)
        {
            if (tipoAsientoIdRequest == null)
                return BadRequest();

            var tipoAsientoDto = _mapper.Map<TipoAsientoDto>(tipoAsientoIdRequest);

            var response = _tipoAsientoApplication.GetById(new Request<TipoAsientoDto>() { entidad = tipoAsientoDto });

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<TipoAsientoResponse>
                    {
                        Data = _mapper.Map<TipoAsientoResponse>(response.Data) ?? new TipoAsientoResponse(),
                        IsSuccess = response.IsSuccess,
                        Message = response.Message
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpGet("GetList")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<TipoAsientoListResponse>))]
        public IActionResult GetList([FromQuery] TipoAsientoFiltrosRequest tipoasientoFiltrosRequest)
        {
            if (tipoasientoFiltrosRequest == null)
                return BadRequest();

            var tipoAsientoDTO = _mapper.Map<TipoAsientoDto>(tipoasientoFiltrosRequest);

            var response = _tipoAsientoApplication.GetList(new Request<TipoAsientoDto>() { entidad = tipoAsientoDTO });

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<List<TipoAsientoResponse>>
                    {
                        Data = _mapper.Map<List<TipoAsientoResponse>>(response.Data) ?? new List<TipoAsientoResponse>(),
                        IsSuccess = response.IsSuccess,
                        Message = response.Message
                    }
                    );
            }

            return new BadRequestObjectResult(response);
        }

        [HttpGet("GetListPaginated")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<TipoAsientoListPaginatedResponse>))]
        public IActionResult GetListPaginated([FromQuery] TipoAsientoPaginacionFiltroRequest tipoAsientoPaginacionFiltroRequest)
        {
            if (tipoAsientoPaginacionFiltroRequest == null)
                return BadRequest();

            var tipoAsientoDTO = _mapper.Map<TipoAsientoDto>(tipoAsientoPaginacionFiltroRequest);

            var response = _tipoAsientoApplication.GetListPaginated(new Request<TipoAsientoDto>() { entidad = tipoAsientoDTO },
                                                                out int PageSize, out int PageNumber, out int TotalReg);

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<TipoAsientoListPaginatedResponse>
                    {
                        Data = new TipoAsientoListPaginatedResponse
                        {
                            TipoAsiento = _mapper.Map<List<TipoAsientoResponse>>(response.Data) ?? new List<TipoAsientoResponse>(),
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
