using System.ComponentModel.DataAnnotations;

namespace PCM.RENAC.Application.Dto
{
    public class CircunscripcionOrigenDestinoDto : EntidadBase
    {
        [Display(Name = "Id")]
        public int? idCircunscripcionOrigenDestino { get; set; }
        [Display(Name = "Asiento")]
        public int? idAsientoCircunscripcion { get; set; }
        [Display(Name = "Nombre circunscripcion")]
        public string? nombreCircunscripcion { get; set; }
        [Display(Name = "Origen-destino")]
        public string? origenDestino { get; set; }
        public AsientoCircunscripcionDto? AsientoCircunscripcion { get; set; }
    }

    public class CircunscripcionOrigenDestinoInsertRequest
    {
        public int? idAsientoCircunscripcion { get; set; }
        public string? nombreCircunscripcion { get; set; }
        public string? origenDestino { get; set; }
    }

    public class CircunscripcionOrigenDestinoUpdateRequest
    {
        public int? idCircunscripcionOrigenDestino { get; set; }
        public int? idAsientoCircunscripcion { get; set; }
        public string? nombreCircunscripcion { get; set; }
        public string? origenDestino { get; set; }
    }

    public class CircunscripcionOrigenDestinoFiltrosRequest
    {
        public int? idCircunscripcionOrigenDestino { get; set; }
        public int? idAsientoCircunscripcion { get; set; }
        public bool? activo { get; set; }
        public string? filtro { get; set; }
    }
    public class CircunscripcionOrigenDestinoPaginacionFiltroRequest : PaginacionFiltroRequest
    {
        public int? idCircunscripcionOrigenDestino { get; set; }
        public int? idAsientoCircunscripcion { get; set; }
        public bool? activo { get; set; }
        public string? filtro { get; set; }
    }
    public class CircunscripcionOrigenDestinoIdRequest
    {
        public int? idCircunscripcionOrigenDestino { get; set; }
    }
    public class CircunscripcionOrigenDestinoResponse
    {
        public int? idCircunscripcionOrigenDestino { get; set; }
        public int? idAsientoCircunscripcion { get; set; }
        public string? nombreCircunscripcion { get; set; }
        public string? origenDestino { get; set; }
        public long rownum { get; set; }
        public bool? activo { get; set; }
        public AsientoCircunscripcionDto? AsientoCircunscripcion { get; set; }
    }
    public class CircunscripcionOrigenDestinoListResponse
    {
        public List<CircunscripcionOrigenDestinoResponse>? CircunscripcionOrigenDestino { get; set; }
    }
    public class CircunscripcionOrigenDestinoListPaginatedResponse
    {
        public List<CircunscripcionOrigenDestinoResponse>? CircunscripcionOrigenDestino { get; set; }
        public PaginacionResponse? Paginacion { get; set; }
    }
}
