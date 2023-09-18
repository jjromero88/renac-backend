using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PCM.RENAC.Domain.Entities
{
    public class TipoDocumentoRenac : EntidadBase
    {
        public int? idTipoDocumentoRenac { get; set; }
        public int? codigo { get; set; }
        public string? descripcion { get; set; }
    }
}
