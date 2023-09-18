using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PCM.RENAC.Domain.Entities
{
    public class DerivacionRenac : EntidadBase
    {
        public int? idDerivacionRenac { get; set; }
        public int? idDerivacionOrigen { get; set; }
        public int? idDerivacionDestino { get; set; }
        public string? idEspecialistaSsatdot { get; set; }
        public DateTime? fechaDerivacion { get; set; }
        public string? usuarioOrigen { get; set; }
        public string? usuarioDestino { get; set; }
        public string? observacion { get; set; }
        public bool? esRetorno { get; set; }
        public string? derivacioninformes { get; set; }
        public int? idTipoDocumento { get; set; }
        public string? documentoMemoRuta { get; set; }
        public string? documentoMemoNombre { get; set; }
        public string? numeroDocumento { get; set; }
        public DateTime? fechaDocumento { get; set; }
    }
}
