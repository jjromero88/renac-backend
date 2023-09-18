using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PCM.RENAC.Domain.Entities
{
    public class ConstanciaAnotacion
    {
        public int? idInformeRenac { get; set; }
        public DateTime? fecha_informe { get; set; }
        public string? der_sub_ssatdot { get; set; }
        public string? der_esp_ssatdot { get; set; }
        public string? der_sub_ssiat { get; set; }
        public string? informe_renac_registro { get; set; }
        public string? asientos_desc { get; set; }
        public string? circ_desc { get; set; }
        public string? circ_asientos { get; set; }
        public string? circ_entidad { get; set; }
        public string? circ_nombre { get; set; }
        public string? analista_nombres { get; set; }
        public string? circ_titulo { get; set; }
        public string? circ_subtitulo { get; set; }
        public string? circ_secc { get; set; }
        public string? circ_cod { get; set; }
        public List<ConstanciaAnotacionAsientos>? lista_asientos { get; set; }
    }
}
