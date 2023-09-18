using Microsoft.AspNetCore.Http;
using System.ComponentModel.DataAnnotations;

namespace PCM.RENAC.Application.Dto
{
    public class InformeRenacDto : EntidadBase
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
        public string? respuestaGoreBase64 { get; set; }
        public string? constanciaAnotacionBase64 { get; set; }
        public string? oficioSolicitudArchivoBase64 { get; set; }
        public string? evidenciaSolicitudArchivoBase64 { get; set; }
        public string? informeFavorableArchivoBase64 { get; set; }
        public string? InformeAnotacionBase64 { get; set; }
        public string? oficioAnotacionArchivoBase64 { get; set; }
        public string? evidenciaAnotacionArchivoBase64 { get; set; }
        public string? constanciaAnotacionFirmadaArchivo64 { get; set; }
        public string? solicitudDiasTranscurridos { get; set; }
        public string? estadoDerivacion { get; set; }
        public string? estadoSsiat { get; set; }
        public string? estadoAnotacion { get; set; }
        public string? urlProyectoMemoEspSsiat { get; set; }
        public string? urlProyectoMemoSubSsiat { get; set; }
        public string? urlRespuestaGore { get; set; }
        public bool? esDerivado { get; set; }
        public string? listaInformesRenac { get; set; }
        public CircunscripcionDto? Circunscripcion { get; set; }
    }

    public class InformeRenacInsertRequest
    {
        public int? idCircunscripcion { get; set; }
        public int? idEstadoDerivacion { get; set; }
        public string? numero { get; set; }
        public DateTime? fecha { get; set; }
        public string? descripcion { get; set; }
        public string? nombreinformesustento { get; set; }
        public string? InformeAnotacionBase64 { get; set; }
    }

    public class InformeRenacUpdateRequest
    {
        public int? idInformeRenac { get; set; }
        public int? idCircunscripcion { get; set; }
        public int? idEstadoDerivacion { get; set; }
        public string? numero { get; set; }
        public DateTime? fecha { get; set; }
        public string? descripcion { get; set; }
        public string? nombreinformesustento { get; set; }
        public string? InformeAnotacionBase64 { get; set; }
    }

    public class InformeRenacFiltrosRequest
    {
        public int? idInformeRenac { get; set; }
        public int? idCircunscripcion { get; set; }
        public bool? activo { get; set; }
        public string? filtro { get; set; }
    }

    public class InformeRenacPaginacionFiltroRequest : PaginacionFiltroRequest
    {
        public bool? activo { get; set; }
        public string? filtro { get; set; }
    }

    public class InformeRenacIdRequest
    {
        public int? idInformeRenac { get; set; }
    }

    public class InformeRenacResponse
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
        public bool? esDerivado { get; set; }
        public string? solicitudDiasTranscurridos { get; set; }
        public string? constanciaAnotacionArchivo { get; set; }
        public DateTime? constanciaAnotacionFirmadaFecha { get; set; }
        public string? constanciaAnotacionFirmadaArchivo { get; set; }
        public string? respuestaGoreNumero { get; set; }
        public DateTime? respuestaGoreFecha { get; set; }
        public string? respuestaGoreArchivo { get; set; }
        public long rownum { get; set; }
        public bool? archivado { get; set; }
        public bool? activo { get; set; }
        public DateTime? fechaReg { get; set; }
        public string? estadoDerivacion { get; set; }
        public CircunscripcionDto? Circunscripcion { get; set; }
    }

    public class InformeRenacListResponse
    {
        public List<InformeRenacResponse>? InformeRenac { get; set; }
    }
    public class InformeRenacListPaginatedResponse
    {
        public List<InformeRenacResponse>? InformeRenac { get; set; }
        public PaginacionResponse? Paginacion { get; set; }
    }



    /*
     * Especialista SSIAT
     */

    public class EspecialistaSsiatPaginatedFilterRequest : PaginacionFiltroRequest
    {
        public bool? activo { get; set; }
        public string? filtro { get; set; }
    }
    public class EspecialistaSsiatResponse
    {
        public int? idInformeRenac { get; set; }
        public int? idCircunscripcion { get; set; }
        public int? idEstadoDerivacion { get; set; }
        public string? numero { get; set; }
        public DateTime? fecha { get; set; }
        public string? descripcion { get; set; }
        public string? urlinformesustento { get; set; }
        public string? nombreinformesustento { get; set; }
        public long rownum { get; set; }
        public bool? activo { get; set; }
        public DateTime? fechaReg { get; set; }
        public string? estadoDerivacion { get; set; }
        public bool? esDerivado { get; set; }
        public CircunscripcionDto? Circunscripcion { get; set; }
    }

    public class EspecialistaSsiatListPaginatedResponse
    {
        public List<EspecialistaSsiatResponse>? lista { get; set; }
        public PaginacionResponse? Paginacion { get; set; }
    }

    /*
     *  Subsecretario SSIAT
     */

    public class SubsecretarioSsiatPaginatedFilterRequest : PaginacionFiltroRequest
    {
        public bool? activo { get; set; }
        public string? filtro { get; set; }
    }

    public class SubsecretarioSsiatResponse
    {
        public int? idInformeRenac { get; set; }
        public int? idCircunscripcion { get; set; }
        public int? idEstadoDerivacion { get; set; }
        public string? numero { get; set; }
        public string? urlinformesustento { get; set; }
        public string? nombreinformesustento { get; set; }
        public long rownum { get; set; }
        public string? estadoSsiat { get; set; }
        public string? estadoAnotacion { get; set; }
        public string? estadoDerivacion { get; set; }
        public CircunscripcionDto? Circunscripcion { get; set; }
    }
    public class SubsecretarioSsiatListPaginatedResponse
    {
        public List<SubsecretarioSsiatResponse>? lista { get; set; }
        public PaginacionResponse? Paginacion { get; set; }
    }


    /*
     *  Subsecretario SSATDOT
     */

    public class SubsecretarioSsatdotPaginatedFilterRequest : PaginacionFiltroRequest
    {
        public bool? activo { get; set; }
        public string? filtro { get; set; }
    }

    public class SubsecretarioSsatdotResponse
    {
        public long rownum { get; set; }
        public int? idInformeRenac { get; set; }
        public int? idCircunscripcion { get; set; }
        public int? idEstadoDerivacion { get; set; }
        public string? numero { get; set; }
        public string? estadoDerivacion { get; set; }
        public CircunscripcionDto? Circunscripcion { get; set; }
    }

    public class SubsecretarioSsatdotListPaginatedResponse
    {
        public List<SubsecretarioSsatdotResponse>? lista { get; set; }
        public PaginacionResponse? Paginacion { get; set; }
    }

    public class SubsecretarioSsatdotDerivacionInformesPaginatedFilterRequest : PaginacionFiltroRequest
    {
        public string? filtro { get; set; }
    }

    public class SubsecretarioSsatdotDerivacionInformesResponse
    {
        public long rownum { get; set; }
        public int? idInformeRenac { get; set; }
        public int? idCircunscripcion { get; set; }
        public int? idEstadoDerivacion { get; set; }
        public string? numero { get; set; }
        public bool? evaluacionFavorable { get; set; }
        public string? estadoDerivacion { get; set; }
        public bool? esDerivado { get; set; }
        public CircunscripcionDto? Circunscripcion { get; set; }
    }

    public class SubsecretarioSsatdotDerivacionInformesListPaginatedResponse
    {
        public List<SubsecretarioSsatdotDerivacionInformesResponse>? lista { get; set; }
        public PaginacionResponse? Paginacion { get; set; }
    }

    // Informacion ssiat documentos

    public class InformacionSsiatDocumentosRequest
    {
        public int? idInformeRenac { get; set; }
    }

    public class InformacionSsiatDocumentosResponse
    {
        public string? informeAnotacion { get; set; }
        public string? proyectoMemoEspSsiat { get; set; }
        public string? proyectoMemoSubSsiat { get; set; }
        public string? numeroPartida { get; set; }
        public string? respuestaGore { get; set; }
    }

    /*
     *  Especialista SSATDOT
     */

    public class EspecialistaSsatdotPaginatedFilterRequest : PaginacionFiltroRequest
    {
        public bool? activo { get; set; }
        public string? filtro { get; set; }
    }

    public class EspecialistaSsatdotResponse
    {
        public long rownum { get; set; }
        public int? idInformeRenac { get; set; }
        public int? idCircunscripcion { get; set; }
        public int? idEstadoDerivacion { get; set; }
        public string? numero { get; set; }
        public string? estadoDerivacion { get; set; }
        public CircunscripcionDto? Circunscripcion { get; set; }
    }

    public class EspecialistaSsatdotListPaginatedResponse
    {
        public List<EspecialistaSsatdotResponse>? lista { get; set; }
        public PaginacionResponse? Paginacion { get; set; }
    }

    public class UpdateEvaluacionFavorableRequest
    {
        public int? idInformeRenac { get; set; }
        public bool? evaluacionFavorable { get; set; }
    }

    public class UpdateInformesOpinionFavorableRequest
    {
        public string? informeFavorableArchivo { get; set; }
        public string? informeFavorableNumero { get; set; }
        public DateTime? informeFavorableFecha { get; set; }
        public string? listaInformesRenac { get; set; }
        public string? informeFavorableArchivoBase64 { get; set; }
    }

    public class VerificarInformeEvaluacionFavorableRequest
    {
        public string? listaInformesRenac { get; set; }
    }

    /*
     *  Responsable de archivo
     */

    public class ResponsableArchivoSolicitudInformacionRequest : PaginacionFiltroRequest
    {
        public int? idInformeRenac { get; set; }
        public string? filtro { get; set; }
    }

    public class ResponsableArchivoSolicitudInformacionResponse
    {
        public long rownum { get; set; }
        public int? idInformeRenac { get; set; }
        public int? idCircunscripcion { get; set; }
        public int? idEstadoDerivacion { get; set; }
        public string? numero { get; set; }
        public bool? evaluacionFavorable { get; set; }
        public string? estadoDerivacion { get; set; }
        public bool? esDerivado { get; set; }
        public CircunscripcionDto? Circunscripcion { get; set; }
    }

    public class ResponsableArchivoSolicitudInformacionListPaginatedResponse
    {
        public List<ResponsableArchivoSolicitudInformacionResponse>? lista { get; set; }
        public PaginacionResponse? Paginacion { get; set; }
    }

    public class UpdateSolicitudInformacionRequest
    {
        public string? oficioSolicitudNumero { get; set; }
        public DateTime? oficioSolicitudFecha { get; set; }
        public DateTime? evidenciaSolicitudFecha { get; set; }
        public string? listaInformesRenac { get; set; }
        public string? oficioSolicitudArchivo { get; set; }
        public string? evidenciaSolicitudArchivo { get; set; }
        public string? oficioSolicitudArchivoBase64 { get; set; }
        public string? evidenciaSolicitudArchivoBase64 { get; set; }
    }

    /*
        Especialista SSIAT - registro de formatos / Respuesta GORE
     */

    public class EspecialistaSsiatRegistroFormatosRequest : PaginacionFiltroRequest
    {
        public string? filtro { get; set; }
    }

    public class EspecialistaSsiatRegistroFormatosResponse
    {
        public long rownum { get; set; }
        public int? idInformeRenac { get; set; }
        public int? idCircunscripcion { get; set; }
        public int? idEstadoDerivacion { get; set; }
        public string? numero { get; set; }
        public bool? evaluacionFavorable { get; set; }
        public string? constanciaAnotacionArchivo { get; set; }
        public string? respuestaGoreArchivo { get; set; }
        public bool? solicitudGore { get; set; }
        public string? estadoDerivacion { get; set; }
        public bool? esDerivado { get; set; }
        public string? solicitudDiasTranscurridos { get; set; }
        public CircunscripcionDto? Circunscripcion { get; set; }
    }

    public class EspecialistaSsiatRegistroFormatosListPaginatedResponse
    {
        public List<EspecialistaSsiatRegistroFormatosResponse>? lista { get; set; }
        public PaginacionResponse? Paginacion { get; set; }
    }

    /*
    
    Registrar Constancia de Anotacion

     */

    public class UpdateConstanciaAnotacionRequest
    {
        public int? idInformeRenac { get; set; }
        public string? constanciaAnotacionArchivo { get; set; }
        public string? constanciaAnotacionBase64 { get; set; }
    }

    /*
     
    Registrar Respuesta GORE

     */

    public class UpdateRespuestaGoreRequest
    {
        public int? idInformeRenac { get; set; }
        public string? respuestaGoreNumero { get; set; }
        public DateTime? respuestaGoreFecha { get; set; }
        public string? respuestaGoreArchivo { get; set; }
        public string? respuestaGoreBase64 { get; set; }
        public string? listaInformesRenac { get; set; }
    }


    /*
        Subsecretario SSIAT - Registro de anotación
    */

    public class SubsecretarioSsiatRegistroAnotacionRequest : PaginacionFiltroRequest
    {
        public string? filtro { get; set; }
    }

    public class SubsecretarioSsiatRegistroAnotacionResponse
    {
        public long rownum { get; set; }
        public int? idInformeRenac { get; set; }
        public int? idCircunscripcion { get; set; }
        public int? idEstadoDerivacion { get; set; }
        public string? numero { get; set; }
        public bool? evaluacionFavorable { get; set; }
        public bool? solicitudGore { get; set; }
        public string? constanciaAnotacionArchivo { get; set; }
        public string? constanciaAnotacionFirmadaArchivo { get; set; }
        public string? respuestaGoreArchivo { get; set; }
        public string? estadoDerivacion { get; set; }
        public bool? esDerivado { get; set; }
        public CircunscripcionDto? Circunscripcion { get; set; }
    }

    public class SubsecretarioSsiatRegistroAnotacionListPaginatedResponse
    {
        public List<SubsecretarioSsiatRegistroAnotacionResponse>? lista { get; set; }
        public PaginacionResponse? Paginacion { get; set; }
    }

    /*
    
    Registrar Constancia de Anotacion Firmada

     */

    public class UpdateConstanciaAnotacionFirmadaRequest
    {
        public int? idInformeRenac { get; set; }
        public DateTime? constanciaAnotacionFirmadaFecha { get; set; }
        public string? constanciaAnotacionFirmadaArchivo { get; set; }
        public string? constanciaAnotacionFirmadaArchivo64 { get; set; }
    }

    /*
        Responsable de archivo - Registro anotacion
     */

    public class ResponsableArchivoRegistroAnotacionRequest : PaginacionFiltroRequest
    {
        public string? filtro { get; set; }
    }

    public class ResponsableArchivoRegistroAnotacionResponse
    {
        public long rownum { get; set; }
        public int? idInformeRenac { get; set; }
        public int? idCircunscripcion { get; set; }
        public int? idEstadoDerivacion { get; set; }
        public string? numero { get; set; }
        public bool? solicitudGore { get; set; }
        public string? constanciaAnotacionArchivo { get; set; }
        public string? constanciaAnotacionFirmadaArchivo { get; set; }
        public string? informefavorablearchivo { get; set; }
        public string? respuestaGoreArchivo { get; set; }
        public bool? procesoAnotacionCerrado { get; set; }
        public bool? evaluacionFavorable { get; set; }
        public string? estadoDerivacion { get; set; }
        public bool? esDerivado { get; set; }
        public CircunscripcionDto? Circunscripcion { get; set; }
    }

    public class ResponsableArchivoRegistroAnotacionListPaginatedResponse
    {
        public List<ResponsableArchivoRegistroAnotacionResponse>? lista { get; set; }
        public PaginacionResponse? Paginacion { get; set; }
    }

    public class UpdateRegistroAnotacionRequest
    {
        public string? oficioAnotacionNumero { get; set; }
        public DateTime? oficioAnotacionFecha { get; set; }
        public string? oficioAnotacionArchivo { get; set; }
        public DateTime? evidenciaAnotacionFecha { get; set; }
        public string? evidenciaAnotacionArchivo { get; set; }
        public string? oficioAnotacionArchivoBase64 { get; set; }
        public string? evidenciaAnotacionArchivoBase64 { get; set; }
        public string? listaInformesRenac { get; set; }
    }

    public class CerrarProcesoAnotacionRequest
    {
        public string? listaInformesRenac { get; set; }
    }

}
