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
    public class InformeDerivacionController : Controller
    {
        private readonly IInformeDerivacionApplication _informeDerivacionApplication;
        private readonly IMapper _mapper;

        public InformeDerivacionController(IInformeDerivacionApplication informeDerivacionApplication, IMapper mapper)
        {
            _informeDerivacionApplication = informeDerivacionApplication ?? throw new ArgumentNullException(nameof(informeDerivacionApplication));
            _mapper = mapper ?? throw new ArgumentNullException(nameof(mapper));
        }

        [HttpPost("Insert")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<InformeDerivacionResponse>))]
        public IActionResult Insert([FromBody] InformeDerivacionInsertRequest informeDerivacionRequest)
        {
            if (informeDerivacionRequest == null)
                return BadRequest();

            var informeDerivacionDTO = _mapper.Map<InformeDerivacionDto>(informeDerivacionRequest);

            var response = _informeDerivacionApplication.Insert(new Request<InformeDerivacionDto>() { entidad = informeDerivacionDTO });

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<InformeDerivacionResponse>
                    {
                        IsSuccess = response.IsSuccess,
                        Message = response.Message,
                        Errors = response.Errors
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpPut("Update")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<InformeDerivacionResponse>))]
        public IActionResult Update([FromBody] InformeDerivacionUpdateRequest informeDerivacionRequest)
        {
            if (informeDerivacionRequest == null)
                return BadRequest();

            var informeDerivacionRequestDTO = _mapper.Map<InformeDerivacionDto>(informeDerivacionRequest);

            var response = _informeDerivacionApplication.Update(new Request<InformeDerivacionDto>() { entidad = informeDerivacionRequestDTO });

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<InformeDerivacionResponse>
                    {
                        IsSuccess = response.IsSuccess,
                        Message = response.Message,
                        Errors = response.Errors
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpDelete("Delete")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<InformeDerivacionResponse>))]
        public IActionResult Delete([FromBody] InformeDerivacionIdRequest informeDerivacionIdRequest)
        {
            if (informeDerivacionIdRequest == null)
                return BadRequest();

            var informeDerivacionDTO = _mapper.Map<InformeDerivacionDto>(informeDerivacionIdRequest);

            var response = _informeDerivacionApplication.Delete(new Request<InformeDerivacionDto>() { entidad = informeDerivacionDTO });

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<InformeDerivacionResponse>
                    {
                        IsSuccess = response.IsSuccess,
                        Message = response.Message,
                        Errors = response.Errors
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpGet("GetById")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<InformeDerivacionResponse>))]
        public IActionResult GetById([FromQuery] InformeDerivacionIdRequest informeDerivacionIdRequest)
        {
            if (informeDerivacionIdRequest == null)
                return BadRequest();

            var informeDerivacionDto = _mapper.Map<InformeDerivacionDto>(informeDerivacionIdRequest);

            var response = _informeDerivacionApplication.GetById(new Request<InformeDerivacionDto>() { entidad = informeDerivacionDto });

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<InformeDerivacionResponse>
                    {
                        Data = _mapper.Map<InformeDerivacionResponse>(response.Data) ?? new InformeDerivacionResponse(),
                        IsSuccess = response.IsSuccess,
                        Message = response.Message
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpGet("GetList")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<InformeDerivacionListResponse>))]
        public IActionResult GetList([FromQuery] InformeDerivacionFiltrosRequest informeDerivacionFiltrosRequest)
        {
            if (informeDerivacionFiltrosRequest == null)
                return BadRequest();

            var informeDerivacionDTO = _mapper.Map<InformeDerivacionDto>(informeDerivacionFiltrosRequest);
            var response = _informeDerivacionApplication.GetList(new Request<InformeDerivacionDto>() { entidad = informeDerivacionDTO });

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<List<InformeDerivacionResponse>>
                    {
                        Data = _mapper.Map<List<InformeDerivacionResponse>>(response.Data) ?? new List<InformeDerivacionResponse>(),
                        IsSuccess = response.IsSuccess,
                        Message = response.Message
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpGet("GetListPaginated")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<InformeDerivacionListPaginatedResponse>))]
        public IActionResult GetListPaginated([FromQuery] InformeDerivacionPaginacionFiltroRequest informeDerivacionPaginacionFiltroRequest)
        {
            if (informeDerivacionPaginacionFiltroRequest == null)
                return BadRequest();

            var informeDerivacionDTO = _mapper.Map<InformeDerivacionDto>(informeDerivacionPaginacionFiltroRequest);

            var response = _informeDerivacionApplication.GetListPaginated(new Request<InformeDerivacionDto>() { entidad = informeDerivacionDTO },
                                                                out int PageSize, out int PageNumber, out int TotalReg);

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<InformeDerivacionListPaginatedResponse>
                    {
                        Data = new InformeDerivacionListPaginatedResponse
                        {
                            InformeDerivacion = _mapper.Map<List<InformeDerivacionResponse>>(response.Data) ?? new List<InformeDerivacionResponse>(),
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
