using System.ComponentModel.DataAnnotations;

namespace PCM.RENAC.Application.Dto
{
    public class CircunscripcionDto : EntidadBase
    {
        [Display(Name = "Id")]
        public int? CodCircunscripcion { get; set; }
        [Display(Name = "Circunscripcion")]
        public string? NombreCircunscripcion { get; set; }
        [Display(Name = "Numbre")]
        public string? NomCircunscripcion { get; set; }
        [Display(Name = "Tipo")]
        public int? TipCircunscripcion { get; set; }
        [Display(Name = "Codigo Departamento")]
        public int? CodDepCircunscripcion { get; set; }
        [Display(Name = "Codigo Provincia")]
        public int? CodProvCircunscripcion { get; set; }
        public TipoCircunscripcionDto? TipoCircunscripcion { get; set; }
    }

    public class CircunscripcionFiltrosRequest
    {
        public int? CodCircunscripcion { get; set; }
        public int? TipCircunscripcion { get; set; }
        public string? NomCircunscripcion { get; set; }
    }

    public class CircunscripcionResponse
    {
        public int? CodCircunscripcion { get; set; }
        public string? NombreCircunscripcion { get; set; }
        public string? NomCircunscripcion { get; set; }
        public int? TipCircunscripcion { get; set; }
        public int? CodDepCircunscripcion { get; set; }
        public int? CodProvCircunscripcion { get; set; }
        public bool? activo { get; set; }
        public TipoCircunscripcionDto? TipoCircunscripcion { get; set; }
    }

    public class CircunscripcionListResponse
    {
        public List<CircunscripcionResponse>? Circunscripcion { get; set; }
    }

    public class CircunscripcionListPaginatedResponse
    {
        public List<CircunscripcionResponse>? Circunscripcion { get; set; }
        public PaginacionResponse? Paginacion { get; set; }
    }

}
