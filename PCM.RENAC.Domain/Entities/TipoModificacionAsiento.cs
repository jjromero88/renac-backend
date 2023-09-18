using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PCM.RENAC.Domain.Entities
{
    public class TipoModificacionAsiento : EntidadBase
    {
        public int? idTipoModificacionAsiento { get; set; }
        public string? descripcion { get; set; }
    }
}
