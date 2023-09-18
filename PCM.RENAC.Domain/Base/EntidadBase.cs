using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PCM.RENAC.Domain
{
    public class EntidadBase
    {
        public bool? activo { get; set; }
        public string? usuarioReg { get; set; }
        public DateTime? fechaReg { get; set; }
        public string? usuarioMod { get; set; }
        public DateTime? fechaMod { get; set; }
        public string? filtro { get; set; }
        public long rownum { get; set; }
        public int PageSize { get; set; }
        public int PageNumber { get; set; }
        public int TotalReg { get; set; }
    }
}
