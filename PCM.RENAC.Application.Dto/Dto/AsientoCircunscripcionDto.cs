using System.ComponentModel.DataAnnotations;

namespace PCM.RENAC.Application.Dto
{
    public class AsientoCircunscripcionDto : EntidadBase
    {
        [Display(Name = "Id")]
        public int? idAsientoCircunscripcion { get; set; }
        [Display(Name = "Informe")]
        public int? idInformeRenac { get; set; }
        [Display(Name = "Asiento")]
        public int? idTipoAsiento { get; set; }
        [Display(Name = "Norma")]
        public int? idDispositivo { get; set; }
        [Display(Name = "Numero")]
        public string? numeroAsiento { get; set; }
        [Display(Name = "Descripcion")]
        public string? descripcion { get; set; }
        [Display(Name = "Circunscripcion")]
        public string? nombreCircunscripcion { get; set; }
        [Display(Name = "Capita")]
        public string? nombreCapital { get; set; }
        [Display(Name = "Provincia")]
        public string? nombreProvincia { get; set; }
        [Display(Name = "Departamento")]
        public string? nombreDepartamento { get; set; }
        [Display(Name = "Observaciones")]
        public string? informacionComplementaria { get; set; }
        [Display(Name = "Fecha anotacion")]
        public DateTime? fechaAnotacion { get; set; }
        [Display(Name = "Modificaciones")]
        public string? detalle_modificacion { get; set; }
        public string? detallesModificacion { get; set; }
        public string? circunscripcionOrigenes { get; set; }
        public string? circunscripcionDestinos { get; set; }
        public int codTipoAsiento { get; set; }
        public string? tipoCircunscripcion { get; set; }
        public InformeRenacDto? InformeRenac { get; set; }
        public TipoAsientoDto? TipoAsiento { get; set; }
        public NormaDto? Norma { get; set; }
    }
    public class AsientoCircunscripcionInsertRequest
    {
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
        public string? detallesModificacion { get; set; }
        public string? circunscripcionOrigenes { get; set; }
        public string? circunscripcionDestinos { get; set; }
        public int codTipoAsiento { get; set; }
        public string? tipoCircunscripcion { get; set; }
    }
    public class AsientoCircunscripcionUpdateRequest
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
        public string? detallesModificacion { get; set; }
        public string? circunscripcionOrigenes { get; set; }
        public string? circunscripcionDestinos { get; set; }
        public int codTipoAsiento { get; set; }
        public string? tipoCircunscripcion { get; set; }
    }
    public class AsientoCircunscripcionFiltrosRequest
    {
        public int? idAsientoCircunscripcion { get; set; }
        public int? idInformeRenac { get; set; }
        public int? idTipoAsiento { get; set; }
        public int? idDispositivo { get; set; }
        public bool? activo { get; set; }
        public string? filtro { get; set; }
    }
    public class AsientoCircunscripcionPaginacionFiltroRequest : PaginacionFiltroRequest
    {
        public int? idInformeRenac { get; set; }
        public bool? activo { get; set; }
        public string? filtro { get; set; }
    }
    public class AsientoCircunscripcionIdRequest
    {
        public int? idAsientoCircunscripcion { get; set; }
    }
    public class AsientoCircunscripcionResponse
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
        public bool? activo { get; set; }
        public long rownum { get; set; }
        public InformeRenacResponse? InformeRenac { get; set; }
        public TipoAsientoResponse? TipoAsiento { get; set; }
        public NormaDto? Norma { get; set; }
    }
    public class AsientoCircunscripcionListResponse
    {
        public List<AsientoCircunscripcionResponse>? AsientoCircunscripcion { get; set; }
    }
    public class AsientoCircunscripcionListPaginatedResponse
    {
        public List<AsientoCircunscripcionResponse>? AsientoCircunscripcion { get; set; }
        public PaginacionResponse? Paginacion { get; set; }
    }

    //INFORMACION SSIAT

    public class InformacionSsiatAsientosRequest
    {
        public int? idInformeRenac { get; set; }
    }
    public class InformacionSsiatAsientosResponse
    {
        public long rownum { get; set; }
        public int? idAsientoCircunscripcion { get; set; }
        public int? idInformeRenac { get; set; }
        public int? idDispositivo { get; set; }
        public string? nombreCircunscripcion { get; set; }
        public DateTime? fechaAnotacion { get; set; }
        public InformeRenacResponse? InformeRenac { get; set; }
        public NormaDto? Norma { get; set; }
    }
    public class InformacionSsiatAsientosListResponse
    {
        public List<InformacionSsiatAsientosResponse>? lista { get; set; }
    }

}
