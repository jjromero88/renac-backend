using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using PCM.RENAC.Application.Dto;
using PCM.RENAC.Application.Features;
using PCM.RENAC.Application.Interface.Features;
using PCM.RENAC.Transversal.Common;
using System.Net;

namespace PCM.RENAC.Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CircunscripcionOrigenDestinoController : Controller
    {
        private readonly ICircunscripcionOrigenDestinoApplication _circunscripcionOrigenDestinoApplication;
        private readonly IMapper _mapper;

        public CircunscripcionOrigenDestinoController(ICircunscripcionOrigenDestinoApplication circunscripcionOrigenDestinoApplication, IMapper mapper)
        {
            _circunscripcionOrigenDestinoApplication = circunscripcionOrigenDestinoApplication ?? throw new ArgumentNullException(nameof(circunscripcionOrigenDestinoApplication));
            _mapper = mapper ?? throw new ArgumentNullException(nameof(mapper));
        }

        [HttpPost("Insert")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<CircunscripcionOrigenDestinoResponse>))]
        public IActionResult Insert([FromBody] CircunscripcionOrigenDestinoInsertRequest circunscripcionOrigenDestinoRequest)
        {
            if (circunscripcionOrigenDestinoRequest == null)
                return BadRequest();

            var circunscripcionOrigenDestinoDTO = _mapper.Map<CircunscripcionOrigenDestinoDto>(circunscripcionOrigenDestinoRequest);

            var response = _circunscripcionOrigenDestinoApplication.Insert(new Request<CircunscripcionOrigenDestinoDto>() { entidad = circunscripcionOrigenDestinoDTO });

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<CircunscripcionOrigenDestinoResponse>
                    {
                        IsSuccess = response.IsSuccess,
                        Message = response.Message,
                        Errors = response.Errors
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpPut("Update")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<CircunscripcionOrigenDestinoResponse>))]
        public IActionResult Update([FromBody] CircunscripcionOrigenDestinoUpdateRequest CircunscripcionOrigenDestino)
        {
            if (CircunscripcionOrigenDestino == null)
                return BadRequest();

            var CircunscripcionOrigenDestinoDto = _mapper.Map<CircunscripcionOrigenDestinoDto>(CircunscripcionOrigenDestino);

            var response = _circunscripcionOrigenDestinoApplication.Update(new Request<CircunscripcionOrigenDestinoDto>() { entidad = CircunscripcionOrigenDestinoDto });

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<CircunscripcionOrigenDestinoResponse>
                    {
                        IsSuccess = response.IsSuccess,
                        Message = response.Message,
                        Errors = response.Errors
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpDelete("Delete")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<CircunscripcionOrigenDestinoResponse>))]
        public IActionResult Delete([FromBody] CircunscripcionOrigenDestinoIdRequest CircunscripcionOrigenDestinoIdRequest)
        {
            if (CircunscripcionOrigenDestinoIdRequest == null)
                return BadRequest();

            var CircunscripcionOrigenDestinoDTO = _mapper.Map<CircunscripcionOrigenDestinoDto>(CircunscripcionOrigenDestinoIdRequest);

            var response = _circunscripcionOrigenDestinoApplication.Delete(new Request<CircunscripcionOrigenDestinoDto>() { entidad = CircunscripcionOrigenDestinoDTO });

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<CircunscripcionOrigenDestinoResponse>
                    {
                        IsSuccess = response.IsSuccess,
                        Message = response.Message,
                        Errors = response.Errors
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpGet("GetById")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<CircunscripcionOrigenDestinoResponse>))]
        public IActionResult GetById([FromQuery] CircunscripcionOrigenDestinoIdRequest CircunscripcionOrigenDestinoIdRequest)
        {
            if (CircunscripcionOrigenDestinoIdRequest == null)
                return BadRequest();

            var CircunscripcionOrigenDestinoDto = _mapper.Map<CircunscripcionOrigenDestinoDto>(CircunscripcionOrigenDestinoIdRequest);

            var response = _circunscripcionOrigenDestinoApplication.GetById(new Request<CircunscripcionOrigenDestinoDto>() { entidad = CircunscripcionOrigenDestinoDto });

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<CircunscripcionOrigenDestinoResponse>
                    {
                        Data = _mapper.Map<CircunscripcionOrigenDestinoResponse>(response.Data) ?? new CircunscripcionOrigenDestinoResponse(),
                        IsSuccess = response.IsSuccess,
                        Message = response.Message
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpGet("GetList")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<CircunscripcionOrigenDestinoListResponse>))]
        public IActionResult GetList([FromQuery] CircunscripcionOrigenDestinoFiltrosRequest CircunscripcionOrigenDestinoFiltrosRequest)
        {
            if (CircunscripcionOrigenDestinoFiltrosRequest == null)
                return BadRequest();

            var CircunscripcionOrigenDestinoDTO = _mapper.Map<CircunscripcionOrigenDestinoDto>(CircunscripcionOrigenDestinoFiltrosRequest);

            var response = _circunscripcionOrigenDestinoApplication.GetList(new Request<CircunscripcionOrigenDestinoDto>() { entidad = CircunscripcionOrigenDestinoDTO });

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<List<CircunscripcionOrigenDestinoResponse>>
                    {
                        Data = _mapper.Map<List<CircunscripcionOrigenDestinoResponse>>(response.Data) ?? new List<CircunscripcionOrigenDestinoResponse>(),
                        IsSuccess = response.IsSuccess,
                        Message = response.Message
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpGet("GetListPaginated")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<CircunscripcionOrigenDestinoListPaginatedResponse>))]
        public IActionResult GetListPaginated([FromQuery] CircunscripcionOrigenDestinoPaginacionFiltroRequest CircunscripcionOrigenDestinoPaginacionFiltroRequest)
        {
            if (CircunscripcionOrigenDestinoPaginacionFiltroRequest == null)
                return BadRequest();

            var CircunscripcionOrigenDestinoDTO = _mapper.Map<CircunscripcionOrigenDestinoDto>(CircunscripcionOrigenDestinoPaginacionFiltroRequest);

            var response = _circunscripcionOrigenDestinoApplication.GetListPaginated(new Request<CircunscripcionOrigenDestinoDto>() { entidad = CircunscripcionOrigenDestinoDTO },
                                                                out int PageSize, out int PageNumber, out int TotalReg);

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<CircunscripcionOrigenDestinoListPaginatedResponse>
                    {
                        Data = new CircunscripcionOrigenDestinoListPaginatedResponse
                        {
                            CircunscripcionOrigenDestino = _mapper.Map<List<CircunscripcionOrigenDestinoResponse>>(response.Data) ?? new List<CircunscripcionOrigenDestinoResponse>(),
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
