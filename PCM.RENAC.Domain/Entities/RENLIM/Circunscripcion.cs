using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PCM.RENAC.Domain.Entities
{
    public class Circunscripcion : EntidadBase
    {
        public int? CodCircunscripcion { get; set; }
        public string? NombreCircunscripcion { get; set; }
        public string? NomCircunscripcion { get; set; }
        public int? TipCircunscripcion { get; set; }
        public int? CodDepCircunscripcion { get; set; }
        public int? CodProvCircunscripcion { get; set; }
        public TipoCircunscripcion? TipoCircunscripcion { get; set; }
    }
}
