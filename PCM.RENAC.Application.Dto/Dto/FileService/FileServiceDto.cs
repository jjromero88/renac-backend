using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PCM.RENAC.Application.Dto
{
    public class FileServiceDto
    {
        public string? FileName { get; set; }
        public string? PathFile { get; set; }
        public string? base64String { get; set; }
        public string? contentType { get; set; }
    }

    public class FileUploadResponse
    {
        public string? FileName { get; set; }
        public string? base64String { get; set; }
    }

    public class FileDownloadResponse
    {
        public string? FileName { get; set; }
        public string? base64String { get; set; }
        public string? contentType { get; set; }
    }

    public class FileDownloadRequest
    {
        public int? IdFolderPath { get; set; }
        public string? FileName { get; set; }
        public string? FilePath { get; set; }
    }

}
