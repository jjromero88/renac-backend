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
    public class TipoDispositivoController : Controller
    {
        private readonly ITipoDispositivoApplication _tipoDispositivoApplication;
        private readonly IMapper _mapper;

        public TipoDispositivoController(ITipoDispositivoApplication tipoDispositivoApplication, IMapper mapper)
        {
            _tipoDispositivoApplication = tipoDispositivoApplication ?? throw new ArgumentNullException(nameof(tipoDispositivoApplication));
            _mapper = mapper ?? throw new ArgumentNullException(nameof(mapper));
        }

        [HttpGet("GetList")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<TipoDispositivoListResponse>))]
        public IActionResult GetList([FromQuery] TipoDispositivoFiltrosRequest tipoDispositivoFiltrosRequest)
        {
            if (tipoDispositivoFiltrosRequest == null)
                return BadRequest();

            var tipoDispositivoDTO = _mapper.Map<TipoDispositivoDto>(tipoDispositivoFiltrosRequest);

            var response = _tipoDispositivoApplication.GetList(new Request<TipoDispositivoDto>() { entidad = tipoDispositivoDTO });

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<List<TipoDispositivoResponse>>
                    {
                        Data = _mapper.Map<List<TipoDispositivoResponse>>(response.Data) ?? new List<TipoDispositivoResponse>(),
                        IsSuccess = response.IsSuccess,
                        Message = response.Message
                    });
            }

            return new BadRequestObjectResult(response);
        }

    }
}
