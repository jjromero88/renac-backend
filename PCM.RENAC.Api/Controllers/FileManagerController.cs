using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using PCM.RENAC.Application.Dto;
using PCM.RENAC.Transversal.Common;
using PCM.RENAC.Transversal.Common.Util;
using System.Net;

namespace PCM.RENAC.Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class FileManagerController : Controller
    {
        private readonly IMapper _mapper;

        public FileManagerController(IMapper mapper)
        {
            _mapper = mapper ?? throw new ArgumentNullException(nameof(mapper));
        }

        [HttpGet("DownloadFile")]
        [ProducesResponseType((int)HttpStatusCode.OK, Type = typeof(Response<FileDownloadResponse>))]
        public IActionResult DownloadFile([FromQuery] FileDownloadRequest fileDownloadRequest)
        {
            if (fileDownloadRequest == null)
                return BadRequest();

            var rootPath = FileDirectory.GetDirectory(fileDownloadRequest.IdFolderPath ?? 0);
            var response = FileUploadUtility.DownloadAndConvertToBase64(rootPath, fileDownloadRequest.FilePath ?? string.Empty);

            if (!response.Error)
            {
                return Ok(
                    new Response<FileDownloadResponse>
                    {
                        Data = new FileDownloadResponse
                        {
                            FileName = response.FileName,
                            base64String = response.base64String,
                            contentType = response.contentType
                        },
                        IsSuccess = true,
                        Message = response.Message
                    });
            }

            return new BadRequestObjectResult(new Response<FileDownloadResponse>
            {
                IsSuccess = false,
                Error = true,
                Message = response.Message
            });

        }

    }
}
