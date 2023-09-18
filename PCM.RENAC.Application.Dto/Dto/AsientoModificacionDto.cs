using System.ComponentModel.DataAnnotations;

namespace PCM.RENAC.Application.Dto
{
    public class AsientoModificacionDto : EntidadBase
    {
        [Display(Name = "Id")]
        public int? idAsientoModificacion { get; set; }
        [Display(Name = "Asiento")]
        public int? idAsientoCircunscripcion { get; set; }
        [Display(Name = "Modificacion")]
        public int? idTipoModificacionAsiento { get; set; }
    }

    public class AsientoModificacionInsertRequest
    {
        public int? idAsientoCircunscripcion { get; set; }
        public int? idTipoModificacionAsiento { get; set; }
    }

    public class AsientoModificacionUpdateRequest
    {
        public int? idAsientoModificacion { get; set; }
        public int? idAsientoCircunscripcion { get; set; }
        public int? idTipoModificacionAsiento { get; set; }
    }

    public class AsientoModificacionFiltrosRequest
    {
        public int? idAsientoModificacion { get; set; }
        public int? idAsientoCircunscripcion { get; set; }
        public int? idTipoModificacionAsiento { get; set; }
        public bool? activo { get; set; }
        public string? filtro { get; set; }
    }
    public class AsientoModificacionPaginacionFiltroRequest : PaginacionFiltroRequest
    {
        public int? idAsientoModificacion { get; set; }
        public int? idAsientoCircunscripcion { get; set; }
        public int? idTipoModificacionAsiento { get; set; }
        public bool? activo { get; set; }
        public string? filtro { get; set; }
    }

    public class AsientoModificacionIdRequest
    {
        public int? idAsientoModificacion { get; set; }
    }
    public class AsientoModificacionResponse
    {
        public int? idAsientoModificacion { get; set; }
        public int? idAsientoCircunscripcion { get; set; }
        public int? idTipoModificacionAsiento { get; set; }
        public long rownum { get; set; }
        public bool? activo { get; set; }
    }

    public class AsientoModificacionListResponse
    {
        public List<AsientoModificacionResponse>? AsientoModificacion { get; set; }
    }
    public class AsientoModificacionListPaginatedResponse
    {
        public List<AsientoModificacionResponse>? AsientoModificacion { get; set; }
        public PaginacionResponse? Paginacion { get; set; }
    }
}
