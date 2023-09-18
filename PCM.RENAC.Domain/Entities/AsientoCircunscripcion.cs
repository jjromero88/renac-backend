using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PCM.RENAC.Domain.Entities
{
    public class AsientoCircunscripcion : EntidadBase
    {
        public int? idAsientoCircunscripcion { get; set; }
        public int? idInformeRenac { get; set; }
        public int? idTipoAsiento { get; set; }
        public int? idDispositivo { get; set; }
        public string? numeroAsiento { get; set; }
        public string? descripcion { get; set; }
        public string? nombreCircunscripcion { get; set; }
        public string? nombreCapital { get; set; }
        public string? nombreProvincia { get; set; }
        public string? nombreDepartamento { get; set; }
        public string? informacionComplementaria { get; set; }
        public DateTime? fechaAnotacion { get; set; }
        public string? detalle_modificacion { get; set; }
        public string? detallesModificacion { get; set; }
        public string? circunscripcionOrigenes { get; set; }
        public string? circunscripcionDestinos { get; set; }
        public InformeRenac? InformeRenac { get; set; }
        public TipoAsiento? TipoAsiento { get; set; }
        public Norma? Norma { get; set; }
    }
}
