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
    public class CircunscripcionController : Controller
    {
        private readonly ICircunscripcionApplication _circunscripcionApplication;
        private readonly IMapper _mapper;

        public CircunscripcionController(ICircunscripcionApplication circunscripcionApplication, IMapper mapper)
        {
            _circunscripcionApplication = circunscripcionApplication ?? throw new ArgumentNullException(nameof(circunscripcionApplication));
            _mapper = mapper ?? throw new ArgumentNullException(nameof(mapper));
        }

        [HttpGet("GetList")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<CircunscripcionListResponse>))]
        public IActionResult GetList([FromQuery] CircunscripcionFiltrosRequest circunscripcionFiltrosRequest)
        {
            if (circunscripcionFiltrosRequest == null)
                return BadRequest();

            var circunscripcionDTO = _mapper.Map<CircunscripcionDto>(circunscripcionFiltrosRequest);

            var response = _circunscripcionApplication.GetList(new Request<CircunscripcionDto>() { entidad = circunscripcionDTO });

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<List<CircunscripcionResponse>>
                    {
                        Data = _mapper.Map<List<CircunscripcionResponse>>(response.Data) ?? new List<CircunscripcionResponse>(),
                        IsSuccess = response.IsSuccess,
                        Message = response.Message
                    });
            }

            return new BadRequestObjectResult(response);
        }

    }
}
