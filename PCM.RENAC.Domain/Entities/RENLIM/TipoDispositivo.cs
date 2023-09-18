using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PCM.RENAC.Domain.Entities
{
    public class TipoDispositivo: EntidadBase
    {
        public int? Id { get; set; }
        public string? Descripcion { get; set; }
        public string? Abreviado { get; set; }
        public int? Grupo { get; set; }
        public int? Orden { get; set; }
    }
}
