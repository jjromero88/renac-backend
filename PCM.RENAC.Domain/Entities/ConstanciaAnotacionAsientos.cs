using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PCM.RENAC.Domain.Entities
{
    public class ConstanciaAnotacionAsientos
    {
        public int? idInformeRenac { get; set; }
        public string? asiento_titulo { get; set; }
        public string? asiento_subtitulo { get; set; }
        public string? asiento_datos_titulo { get; set; }
        public string? asiento_numero { get; set; }
        public string? norma_titulo { get; set; }
        public string? norma_tipo { get; set; }
        public string? norma_numero { get; set; }
        public DateTime? norma_fecha { get; set; }
        public string? circ_informacion_titulo { get; set; }
        public string? circ_nombre { get; set; }
        public string? circ_capital { get; set; }
        public string? circ_departamento { get; set; }
        public string? circ_provincia { get; set; }
        public string? info_complementaria_titulo { get; set; }
        public string? circ_infocomplementaria { get; set; }
    }
}
