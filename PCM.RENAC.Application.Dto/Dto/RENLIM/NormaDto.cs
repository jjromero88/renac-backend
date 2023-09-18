using System.ComponentModel.DataAnnotations;

namespace PCM.RENAC.Application.Dto
{
    public class NormaDto : EntidadBase
    {
        [Display(Name = "Id")]
        public int? CodNorma { get; set; }
        [Display(Name = "IdTipo")]
        public int? Tipo { get; set; }
        [Display(Name = "Numero")]
        public string? Numero { get; set; }
        [Display(Name = "Fecha")]
        public DateTime? Fecha { get; set; }
        [Display(Name = "Ruta archivo")]
        public string? Archivo { get; set; }
        public TipoDispositivoDto? TipoDispositivo { get; set; }
    }

    public class NormaFiltrosRequest
    {
        public int? CodNorma { get; set; }
        public int? Tipo { get; set; }
        public string? Numero { get; set; }
        public DateTime? Fecha { get; set; }
    }

    public class NormaResponse
    {
        public int? CodNorma { get; set; }
        public int? Tipo { get; set; }
        public string? Numero { get; set; }
        public DateTime? Fecha { get; set; }
        public string? Archivo { get; set; }
        public bool? activo { get; set; }
        public TipoDispositivoDto? TipoDispositivo { get; set; }
    }

    public class NormaListResponse
    {
        public List<NormaResponse>? Norma { get; set; }
    }

    public class NormaListPaginatedResponse
    {
        public List<NormaResponse>? Norma { get; set; }
        public PaginacionResponse? Paginacion { get; set; }
    }

}
