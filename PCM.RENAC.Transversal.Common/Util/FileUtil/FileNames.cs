using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PCM.RENAC.Transversal.Common.Util.FileUtil
{
    public static class FileNames
    {
        public static string GenerateInformeSsiatFileName(string fileName)
        {
            if (string.IsNullOrEmpty(fileName))
                return string.Empty;

            string fileExtension = Path.GetExtension(fileName) ?? "";
            string timestamp = DateTime.Now.ToString("yyyyMMddHHmmss");

            return $"{"INFORMESSIAT"}_{timestamp}{fileExtension}";
        }

        public static string GenerateDocumentoMemoSsiatFileName(string fileName)
        {
            if (string.IsNullOrEmpty(fileName))
                return string.Empty;

            string fileExtension = Path.GetExtension(fileName) ?? "";
            string timestamp = DateTime.Now.ToString("yyyyMMddHHmmss");

            return $"{"INFORMESSIAT"}_{timestamp}{fileExtension}";
        }

    }
}
