using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PCM.RENAC.Domain.Entities
{
    public class TipoAsiento : EntidadBase
    {
        public int? idTipoAsiento { get; set; }
        public int? codigo { get; set; }
        public string? descripcion { get; set; }
    }
}
