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
    public class NormaController : Controller
    {
        private readonly INormaApplication _normaApplication;
        private readonly IMapper _mapper;

        public NormaController(INormaApplication normaApplication, IMapper mapper)
        {
            _normaApplication = normaApplication ?? throw new ArgumentNullException(nameof(normaApplication));
            _mapper = mapper ?? throw new ArgumentNullException(nameof(mapper));
        }

        [HttpGet("GetList")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<NormaListResponse>))]
        public IActionResult GetList([FromQuery] NormaFiltrosRequest normaFiltrosRequest)
        {
            if (normaFiltrosRequest == null)
                return BadRequest();

            var normaDTO = _mapper.Map<NormaDto>(normaFiltrosRequest);

            var response = _normaApplication.GetList(new Request<NormaDto>() { entidad = normaDTO });

            if (response.IsSuccess)
            {
                return Ok(
                    new Response<List<NormaResponse>>
                    {
                        Data = _mapper.Map<List<NormaResponse>>(response.Data) ?? new List<NormaResponse>(),
                        IsSuccess = response.IsSuccess,
                        Message = response.Message
                    });
            }

            return new BadRequestObjectResult(response);
        }

    }
}
