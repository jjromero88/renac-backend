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
    public class DocumentoDerivacionController : Controller
    {
        private readonly IDocumentoDerivacionApplication _documentoDerivacionApplication;
        private readonly IMapper _mapper;

        public DocumentoDerivacionController(IDocumentoDerivacionApplication documentoDerivacionApplication, IMapper mapper)
        {
            _documentoDerivacionApplication = documentoDerivacionApplication ?? throw new ArgumentNullException(nameof(documentoDerivacionApplication));
            _mapper = mapper ?? throw new ArgumentNullException(nameof(mapper));
        }

        [HttpPost("Insert")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<DocumentoDerivacionResponse>))]
        public IActionResult Insert([FromBody] DocumentoDerivacionInsertRequest documentoDerivacionRequest)
        {
            if (documentoDerivacionRequest == null)
                return BadRequest();

            var documentoDerivacionDTO = _mapper.Map<DocumentoDerivacionDto>(documentoDerivacionRequest);

            var response = _documentoDerivacionApplication.Insert(new Request<DocumentoDerivacionDto>() { entidad = documentoDerivacionDTO });

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<DocumentoDerivacionResponse>
                    {
                        IsSuccess = response.IsSuccess,
                        Message = response.Message,
                        Errors = response.Errors
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpPut("Update")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<DocumentoDerivacionResponse>))]
        public IActionResult Update([FromBody] DocumentoDerivacionUpdateRequest documentoDerivacionRequest)
        {
            if (documentoDerivacionRequest == null)
                return BadRequest();

            var documentoDerivacionRequestDTO = _mapper.Map<DocumentoDerivacionDto>(documentoDerivacionRequest);
            var response = _documentoDerivacionApplication.Update(new Request<DocumentoDerivacionDto>() { entidad = documentoDerivacionRequestDTO });

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<DocumentoDerivacionResponse>
                    {
                        IsSuccess = response.IsSuccess,
                        Message = response.Message,
                        Errors = response.Errors
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpDelete("Delete")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<DocumentoDerivacionResponse>))]
        public IActionResult Delete([FromBody] DocumentoDerivacionIdRequest documentoDerivacionIdRequest)
        {
            if (documentoDerivacionIdRequest == null)
                return BadRequest();

            var documentoDerivacionDTO = _mapper.Map<DocumentoDerivacionDto>(documentoDerivacionIdRequest);

            var response = _documentoDerivacionApplication.Delete(new Request<DocumentoDerivacionDto>() { entidad = documentoDerivacionDTO });

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<DocumentoDerivacionResponse>
                    {
                        IsSuccess = response.IsSuccess,
                        Message = response.Message,
                        Errors = response.Errors
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpGet("GetById")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<DocumentoDerivacionResponse>))]
        public IActionResult GetById([FromQuery] DocumentoDerivacionIdRequest documentoDerivacionIdRequest)
        {
            if (documentoDerivacionIdRequest == null)
                return BadRequest();

            var documentoDerivacionDto = _mapper.Map<DocumentoDerivacionDto>(documentoDerivacionIdRequest);

            var response = _documentoDerivacionApplication.GetById(new Request<DocumentoDerivacionDto>() { entidad = documentoDerivacionDto });

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<DocumentoDerivacionResponse>
                    {
                        Data = _mapper.Map<DocumentoDerivacionResponse>(response.Data) ?? new DocumentoDerivacionResponse(),
                        IsSuccess = response.IsSuccess,
                        Message = response.Message
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpGet("GetList")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<DocumentoDerivacionListResponse>))]
        public IActionResult GetList([FromQuery] DocumentoDerivacionFiltrosRequest documentoDerivacionFiltrosRequest)
        {
            if (documentoDerivacionFiltrosRequest == null)
                return BadRequest();

            var documentoDerivacionDTO = _mapper.Map<DocumentoDerivacionDto>(documentoDerivacionFiltrosRequest);
            var response = _documentoDerivacionApplication.GetList(new Request<DocumentoDerivacionDto>() { entidad = documentoDerivacionDTO });

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<List<DocumentoDerivacionResponse>>
                    {
                        Data = _mapper.Map<List<DocumentoDerivacionResponse>>(response.Data) ?? new List<DocumentoDerivacionResponse>(),
                        IsSuccess = response.IsSuccess,
                        Message = response.Message
                    });
            }

            return new BadRequestObjectResult(response);
        }

        [HttpGet("GetListPaginated")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<DocumentoDerivacionListPaginatedResponse>))]
        public IActionResult GetListPaginated([FromQuery] DocumentoDerivacionPaginacionFiltroRequest documentoDerivacionPaginacionFiltroRequest)
        {
            if (documentoDerivacionPaginacionFiltroRequest == null)
                return BadRequest();

            var documentoDerivacionDTO = _mapper.Map<DocumentoDerivacionDto>(documentoDerivacionPaginacionFiltroRequest);

            var response = _documentoDerivacionApplication.GetListPaginated(new Request<DocumentoDerivacionDto>() { entidad = documentoDerivacionDTO },
                                                                out int PageSize, out int PageNumber, out int TotalReg);

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<DocumentoDerivacionListPaginatedResponse>
                    {
                        Data = new DocumentoDerivacionListPaginatedResponse
                        {
                            DocumentoDerivacion = _mapper.Map<List<DocumentoDerivacionResponse>>(response.Data) ?? new List<DocumentoDerivacionResponse>(),
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
