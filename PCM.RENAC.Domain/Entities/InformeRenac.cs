using System;
using System.Collections.Generic;
using System.Formats.Asn1;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PCM.RENAC.Domain.Entities
{
    public class InformeRenac : EntidadBase
    {
        public int? idInformeRenac { get; set; }
        public int? idCircunscripcion { get; set; }
        public int? idEstadoDerivacion { get; set; }
        public string? numero { get; set; }
        public DateTime? fecha { get; set; }
        public string? descripcion { get; set; }
        public string? urlinformesustento { get; set; }
        public string? nombreinformesustento { get; set; }
        public bool? evaluacionFavorable { get; set; }
        public bool? solicitudGore { get; set; }
        public string? informeFavorableArchivo { get; set; }
        public string? informeFavorableNumero { get; set; }
        public DateTime? informeFavorableFecha { get; set; }
        public DateTime? fechaSolicitudInformacion { get; set; }
        public string? oficioSolicitudNumero { get; set; }
        public DateTime? oficioSolicitudFecha { get; set; }
        public string? oficioSolicitudArchivo { get; set; }
        public DateTime? evidenciaSolicitudFecha { get; set; }
        public string? evidenciaSolicitudArchivo { get; set; }
        public string? oficioAnotacionNumero { get; set; }
        public DateTime? oficioAnotacionFecha { get; set; }
        public string? oficioAnotacionArchivo { get; set; }
        public DateTime? evidenciaAnotacionFecha { get; set; }
        public string? evidenciaAnotacionArchivo { get; set; }
        public string? constanciaAnotacionArchivo { get; set; }
        public DateTime? constanciaAnotacionFirmadaFecha { get; set; }
        public string? constanciaAnotacionFirmadaArchivo { get; set; }
        public string? respuestaGoreNumero { get; set; }
        public DateTime? respuestaGoreFecha { get; set; }
        public string? respuestaGoreArchivo { get; set; }
        public bool? archivado { get; set; }
        public bool? procesoAnotacionCerrado { get; set; }
        public string? solicitudDiasTranscurridos { get; set; }
        public string? estadoDerivacion { get; set; }
        public string? estadoSsiat { get; set; }
        public string? estadoAnotacion { get; set; }
        public string? urlProyectoMemoEspSsiat { get; set; }
        public string? urlProyectoMemoSubSsiat { get; set; }
        public string? urlRespuestaGore { get; set; }
        public bool? esDerivado { get; set; }
        public string? listaInformesRenac { get; set; }
        public Circunscripcion? Circunscripcion { get; set; }
    }
}
