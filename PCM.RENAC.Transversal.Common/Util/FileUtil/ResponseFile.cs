using FluentValidation.Results;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PCM.RENAC.Transversal.Common.Util
{
    public class ResponseFile
    {
        public string? PathFile { get; set; }
        public string? FileName { get; set; }
        public string? base64String { get; set; }
        public string? contentType { get; set; }
        public bool Error { get; set; }
        public string? Message { get; set; }
        public string? MessageException { get; set; }
    }
}
