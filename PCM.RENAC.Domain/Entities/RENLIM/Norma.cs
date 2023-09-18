using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PCM.RENAC.Domain.Entities
{
    public class Norma : EntidadBase
    {
        public int? CodNorma { get; set; }
        public int? Tipo { get; set; }
        public string? Numero { get; set; }
        public DateTime? Fecha { get; set; }
        public string? Archivo { get; set; }
        public TipoDispositivo? TipoDispositivo { get; set; }
    }
}
