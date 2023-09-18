using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PCM.RENAC.Domain.Entities
{
    public class AsientoModificacion : EntidadBase
    {
        public int? idAsientoModificacion { get; set; }
        public int? idAsientoCircunscripcion { get; set; }
        public int? idTipoModificacionAsiento { get; set; }
        public AsientoCircunscripcion? AsientoCircunscripcion { get; set; }
        public TipoModificacionAsiento? TipoModificacionAsiento { get; set; }
    }
}
