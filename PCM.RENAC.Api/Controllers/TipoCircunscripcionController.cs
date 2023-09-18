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
    public class TipoCircunscripcionController : Controller
    {
        private readonly ITipoCircunscripcionApplication _tipoCircunscripcionApplication;
        private readonly IMapper _mapper;

        public TipoCircunscripcionController(ITipoCircunscripcionApplication tipoCircunscripcionApplication, IMapper mapper)
        {
            _tipoCircunscripcionApplication = tipoCircunscripcionApplication ?? throw new ArgumentNullException(nameof(tipoCircunscripcionApplication));
            _mapper = mapper ?? throw new ArgumentNullException(nameof(mapper));
        }

        [HttpGet("GetList")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<TipoCircunscripcionListResponse>))]
        public IActionResult GetList([FromQuery] TipoCircunscripcionFiltrosRequest tipocircunscripcionFiltrosRequest)
        {
            if (tipocircunscripcionFiltrosRequest == null)
                return BadRequest();

            var tipoCircunscripcionDTO = _mapper.Map<TipoCircunscripcionDto>(tipocircunscripcionFiltrosRequest);

            var response = _tipoCircunscripcionApplication.GetList(new Request<TipoCircunscripcionDto>() { entidad = tipoCircunscripcionDTO });

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<List<TipoCircunscripcionResponse>>
                    {
                        Data = _mapper.Map<List<TipoCircunscripcionResponse>>(response.Data) ?? new List<TipoCircunscripcionResponse>(),
                        IsSuccess = response.IsSuccess,
                        Message = response.Message
                    });
            }

            return new BadRequestObjectResult(response);
        }

    }
}
