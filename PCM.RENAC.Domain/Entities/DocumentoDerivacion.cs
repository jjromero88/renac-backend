using PCM.RENAC.Domain.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PCM.RENAC.Domain.Entities
{
    public class DocumentoDerivacion : EntidadBase
    {
        public int? idDocumentoDerivacion { get; set; }
        public int? idDerivacionRenac { get; set; }
        public int? idTipoDocumentoRenac { get; set; }
        public string? rutaDocumento { get; set; }
        public string? nombreDocumento { get; set; }
        public DateTime? fechaDocumento { get; set; }
        public string? numeroDocumento { get; set; }
        public DerivacionRenac? DerivacionRenac { get; set; }
        public TipoDocumentoRenac? TipoDocumentoRenac { get; set; }
    }
}
