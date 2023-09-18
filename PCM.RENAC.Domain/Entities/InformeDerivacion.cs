using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PCM.RENAC.Domain.Entities
{
    public class InformeDerivacion : EntidadBase
    {
        public int? idInformeDerivacion { get; set; }
        public int? idInformeRenac { get; set; }
        public int? idDerivacionRenac { get; set; }
        public InformeRenac? InformeRenac { get; set; }
        public DerivacionRenac? DerivacionRenac { get; set; }
    }
}
