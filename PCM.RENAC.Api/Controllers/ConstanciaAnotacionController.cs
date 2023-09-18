using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using Org.BouncyCastle.Asn1.Ocsp;
using PCM.RENAC.Application.Dto;
using PCM.RENAC.Application.Interface.Features;
using PCM.RENAC.Transversal.Common;
using PCM.RENAC.Transversal.Common.Util;
using System.Net;

namespace PCM.RENAC.Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ConstanciaAnotacionController : Controller
    {
        private readonly IConstanciaAnotacionApplication _constanciaAnotacionApplication;
        private readonly IMapper _mapper;

        public ConstanciaAnotacionController(IConstanciaAnotacionApplication constanciaAnotacionApplication, IMapper mapper)
        {
            _constanciaAnotacionApplication = constanciaAnotacionApplication ?? throw new ArgumentNullException(nameof(constanciaAnotacionApplication));
            _mapper = mapper ?? throw new ArgumentNullException(nameof(mapper));
        }

        [HttpGet("GenerateDocumentConstanciaAnotacion")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<GenerarConstanciaAnotacionResponse>))]
        public ActionResult<string> GenerarConstanciaAnotacion([FromQuery] GenerarConstanciaAnotacionRequest request)
        {            
            if (request == null)
                return BadRequest();

            var response = _constanciaAnotacionApplication.GenerarConstanciaAnotacion(new Request<ConstanciaAnotacionDto>() { entidad = _mapper.Map<ConstanciaAnotacionDto>(request) });
           
            if (response.IsSuccess)
            {
                return Ok(
                    new Response<GenerarConstanciaAnotacionResponse>
                    {
                        Data = response.Data,
                        IsSuccess = response.IsSuccess,
                        Message = response.Message,
                        Errors = response.Errors
                    });
            }

            return new BadRequestObjectResult(response);
        }

    }
}
