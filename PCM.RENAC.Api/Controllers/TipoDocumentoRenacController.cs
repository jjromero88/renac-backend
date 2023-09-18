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
    public class TipoDocumentoRenacController : Controller
    {
        private readonly ITipoDocumentoRenacApplication _tipoDocumentoRenacApplication;
        private readonly IMapper _mapper;

        public TipoDocumentoRenacController(ITipoDocumentoRenacApplication tipoDocumentoRenacApplication, IMapper mapper)
        {
            _tipoDocumentoRenacApplication = tipoDocumentoRenacApplication ?? throw new ArgumentNullException(nameof(tipoDocumentoRenacApplication));
            _mapper = mapper ?? throw new ArgumentNullException(nameof(mapper));
        }

        [HttpPost("Insert")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<TipoDocumentoRenacResponse>))]
        public IActionResult Insert([FromBody] TipoDocumentoRenacInsertRequest tipoDocumentoRenacRequest)
        {
            if (tipoDocumentoRenacRequest == null)
                return BadRequest();

            var tipoDocumentoRenacDTO = _mapper.Map<TipoDocumentoRenacDto>(tipoDocumentoRenacRequest);

            var response = _tipoDocumentoRenacApplication.Insert(new Request<TipoDocumentoRenacDto>() { entidad = tipoDocumentoRenacDTO });

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<TipoDocumentoRenacResponse>
                    {
                        IsSuccess = response.IsSuccess,
                        Message = response.Message,
                        Errors = response.Errors
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpPut("Update")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<TipoDocumentoRenacResponse>))]
        public IActionResult Update([FromBody] TipoDocumentoRenacUpdateRequest tipoDocumentoRenacRequest)
        {
            if (tipoDocumentoRenacRequest == null)
                return BadRequest();

            var tipoDocumentoRenacRequestDTO = _mapper.Map<TipoDocumentoRenacDto>(tipoDocumentoRenacRequest);

            var response = _tipoDocumentoRenacApplication.Update(new Request<TipoDocumentoRenacDto>() { entidad = tipoDocumentoRenacRequestDTO });

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<TipoDocumentoRenacResponse>
                    {
                        IsSuccess = response.IsSuccess,
                        Message = response.Message,
                        Errors = response.Errors
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpDelete("Delete")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<TipoDocumentoRenacResponse>))]
        public IActionResult Delete([FromBody] TipoDocumentoRenacIdRequest tipoDocumentoRenacIdRequest)
        {
            if (tipoDocumentoRenacIdRequest == null)
                return BadRequest();

            var tipoDocumentoRenacDTO = _mapper.Map<TipoDocumentoRenacDto>(tipoDocumentoRenacIdRequest);

            var response = _tipoDocumentoRenacApplication.Delete(new Request<TipoDocumentoRenacDto>() { entidad = tipoDocumentoRenacDTO });

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<TipoDocumentoRenacResponse>
                    {
                        IsSuccess = response.IsSuccess,
                        Message = response.Message,
                        Errors = response.Errors
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpGet("GetById")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<TipoDocumentoRenacResponse>))]
        public IActionResult GetById([FromQuery] TipoDocumentoRenacIdRequest tipoDocumentoRenacIdRequest)
        {
            if (tipoDocumentoRenacIdRequest == null)
                return BadRequest();

            var tipoDocumentoRenacDto = _mapper.Map<TipoDocumentoRenacDto>(tipoDocumentoRenacIdRequest);

            var response = _tipoDocumentoRenacApplication.GetById(new Request<TipoDocumentoRenacDto>() { entidad = tipoDocumentoRenacDto });

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<TipoDocumentoRenacResponse>
                    {
                        Data = _mapper.Map<TipoDocumentoRenacResponse>(response.Data) ?? new TipoDocumentoRenacResponse(),
                        IsSuccess = response.IsSuccess,
                        Message = response.Message
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpGet("GetList")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<TipoDocumentoRenacListResponse>))]
        public IActionResult GetList([FromQuery] TipoDocumentoRenacFiltrosRequest tipoDocumentoRenacFiltrosRequest)
        {
            if (tipoDocumentoRenacFiltrosRequest == null)
                return BadRequest();

            var tipoDocumentoRenacDTO = _mapper.Map<TipoDocumentoRenacDto>(tipoDocumentoRenacFiltrosRequest);
            var response = _tipoDocumentoRenacApplication.GetList(new Request<TipoDocumentoRenacDto>() { entidad = tipoDocumentoRenacDTO });

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<List<TipoDocumentoRenacResponse>>
                    {
                        Data = _mapper.Map<List<TipoDocumentoRenacResponse>>(response.Data) ?? new List<TipoDocumentoRenacResponse>(),
                        IsSuccess = response.IsSuccess,
                        Message = response.Message
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpGet("GetListPaginated")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<TipoDocumentoRenacListPaginatedResponse>))]
        public IActionResult GetListPaginated([FromQuery] TipoDocumentoRenacPaginacionFiltroRequest tipoDocumentoRenacPaginacionFiltroRequest)
        {
            if (tipoDocumentoRenacPaginacionFiltroRequest == null)
                return BadRequest();

            var tipoDocumentoRenacDTO = _mapper.Map<TipoDocumentoRenacDto>(tipoDocumentoRenacPaginacionFiltroRequest);

            var response = _tipoDocumentoRenacApplication.GetListPaginated(new Request<TipoDocumentoRenacDto>() { entidad = tipoDocumentoRenacDTO },
                                                                out int PageSize, out int PageNumber, out int TotalReg);

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<TipoDocumentoRenacListPaginatedResponse>
                    {
                        Data = new TipoDocumentoRenacListPaginatedResponse
                        {
                            TipoDocumentoRenac = _mapper.Map<List<TipoDocumentoRenacResponse>>(response.Data) ?? new List<TipoDocumentoRenacResponse>(),
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
