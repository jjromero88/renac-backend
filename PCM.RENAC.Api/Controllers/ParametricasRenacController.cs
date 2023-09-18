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
    public class ParametricasRenacController : Controller
    {
        private readonly IParametricasRenacApplication _parametricasRenacApplication;
        private readonly IMapper _mapper;

        public ParametricasRenacController(IParametricasRenacApplication parametricasRenacApplication, IMapper mapper)
        {
            _parametricasRenacApplication = parametricasRenacApplication ?? throw new ArgumentNullException(nameof(parametricasRenacApplication));
            _mapper = mapper ?? throw new ArgumentNullException(nameof(mapper));
        }

        [HttpPost("Insert")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<ParametricasRenacResponse>))]
        public IActionResult Insert([FromBody] ParametricasRenacInsertRequest request)
        {
            if (request == null)
                return BadRequest();

            var entidad = _mapper.Map<ParametricasRenacDto>(request);

            var response = _parametricasRenacApplication.Insert(new Request<ParametricasRenacDto>() { entidad = entidad });

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<ParametricasRenacResponse>
                    {
                        IsSuccess = response.IsSuccess,
                        Message = response.Message,
                        Errors = response.Errors
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpPut("Update")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<ParametricasRenacResponse>))]
        public IActionResult Update([FromBody] ParametricasRenacUpdateRequest request)
        {
            if (request == null)
                return BadRequest();

            var entidad = _mapper.Map<ParametricasRenacDto>(request);

            var response = _parametricasRenacApplication.Update(new Request<ParametricasRenacDto>() { entidad = entidad });

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<ParametricasRenacResponse>
                    {
                        IsSuccess = response.IsSuccess,
                        Message = response.Message,
                        Errors = response.Errors
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpDelete("Delete")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<ParametricasRenacResponse>))]
        public IActionResult Delete([FromBody] ParametricasRenacIdRequest request)
        {
            if (request == null)
                return BadRequest();

            var entidad = _mapper.Map<ParametricasRenacDto>(request);

            var response = _parametricasRenacApplication.Delete(new Request<ParametricasRenacDto>() { entidad = entidad });

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<ParametricasRenacResponse>
                    {
                        IsSuccess = response.IsSuccess,
                        Message = response.Message,
                        Errors = response.Errors
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpGet("GetById")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<ParametricasRenacResponse>))]
        public IActionResult GetById([FromQuery] ParametricasRenacIdRequest request)
        {
            if (request == null)
                return BadRequest();

            var entidad = _mapper.Map<ParametricasRenacDto>(request);

            var response = _parametricasRenacApplication.GetById(new Request<ParametricasRenacDto>() { entidad = entidad });

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<ParametricasRenacResponse>
                    {
                        Data = _mapper.Map<ParametricasRenacResponse>(response.Data) ?? new ParametricasRenacResponse(),
                        IsSuccess = response.IsSuccess,
                        Message = response.Message
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpGet("GetList")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<ParametricasRenacListResponse>))]
        public IActionResult GetList([FromQuery] ParametricasRenacFiltrosRequest request)
        {
            if (request == null)
                return BadRequest();

            var entidad = _mapper.Map<ParametricasRenacDto>(request);
            var response = _parametricasRenacApplication.GetList(new Request<ParametricasRenacDto>() { entidad = entidad });

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<List<ParametricasRenacResponse>>
                    {
                        Data = _mapper.Map<List<ParametricasRenacResponse>>(response.Data) ?? new List<ParametricasRenacResponse>(),
                        IsSuccess = response.IsSuccess,
                        Message = response.Message
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpGet("GetListPaginated")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<ParametricasRenacListPaginatedResponse>))]
        public IActionResult GetListPaginated([FromQuery] ParametricasRenacPaginacionFiltroRequest request)
        {
            if (request == null)
                return BadRequest();

            var entidad = _mapper.Map<ParametricasRenacDto>(request);

            var response = _parametricasRenacApplication.GetListPaginated(new Request<ParametricasRenacDto>() { entidad = entidad },
                                                                out int PageSize, out int PageNumber, out int TotalReg);

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<ParametricasRenacListPaginatedResponse>
                    {
                        Data = new ParametricasRenacListPaginatedResponse
                        {
                            ParametricasRenac = _mapper.Map<List<ParametricasRenacResponse>>(response.Data) ?? new List<ParametricasRenacResponse>(),
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
