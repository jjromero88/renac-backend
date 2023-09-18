using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PCM.RENAC.Domain.Entities
{
    public class ParametricasRenac : EntidadBase
    {
        public int? idParametricasRenac { get; set; }
        public int? idPadre { get; set; }
        public int? idGrupo { get; set; }
        public string? codigo { get; set; }
        public string? descripcion { get; set; }
    }
}
