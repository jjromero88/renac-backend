using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PCM.RENAC.Domain.Entities
{
    public class CircunscripcionOrigenDestino : EntidadBase
    {
        public int? idCircunscripcionOrigenDestino { get; set; }
        public int? idAsientoCircunscripcion { get; set; }
        public string? nombreCircunscripcion { get; set; }
        public string? origenDestino { get; set; }
        public AsientoCircunscripcion? AsientoCircunscripcion { get; set; }
    }
}
