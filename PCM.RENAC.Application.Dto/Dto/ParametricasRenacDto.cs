using System.ComponentModel.DataAnnotations;

namespace PCM.RENAC.Application.Dto
{
    public class ParametricasRenacDto : EntidadBase
    {
        [Display(Name = "Id")]
        public int? idParametricasRenac { get; set; }
        [Display(Name = "Id Padre")]
        public int? idPadre { get; set; }
        [Display(Name = "Grupo")]
        public int? idGrupo { get; set; }
        [Display(Name = "Codigo")]
        public string? codigo { get; set; }
        [Display(Name = "Descripcion")]
        public string? descripcion { get; set; }
    }
    public class ParametricasRenacInsertRequest
    {
        public int? idPadre { get; set; }
        public int? idGrupo { get; set; }
        public string? codigo { get; set; }
        public string? descripcion { get; set; }
    }
    public class ParametricasRenacUpdateRequest
    {
        public int? idParametricasRenac { get; set; }
        public int? idPadre { get; set; }
        public int? idGrupo { get; set; }
        public string? codigo { get; set; }
        public string? descripcion { get; set; }
    }
    public class ParametricasRenacIdRequest
    {
        public int? idParametricasRenac { get; set; }
    }
    public class ParametricasRenacFiltrosRequest
    {
        public int? idParametricasRenac { get; set; }
        public string? descripcion { get; set; }
        public bool? activo { get; set; }
        public string? filtro { get; set; }
    }
    public class ParametricasRenacPaginacionFiltroRequest : PaginacionFiltroRequest
    {
        public string? descripcion { get; set; }
        public bool? activo { get; set; }
        public string? filtro { get; set; }
    }
    public class ParametricasRenacResponse
    {
        public int? idParametricasRenac { get; set; }
        public int? idPadre { get; set; }
        public int? idGrupo { get; set; }
        public string? codigo { get; set; }
        public string? descripcion { get; set; }
        public bool? activo { get; set; }
        public DateTime? fechareg { get; set; }
        public long rownum { get; set; }
    }
    public class ParametricasRenacListResponse
    {
        public List<ParametricasRenacResponse>? ParametricasRenac { get; set; }
    }
    public class ParametricasRenacListPaginatedResponse
    {
        public List<ParametricasRenacResponse>? ParametricasRenac { get; set; }
        public PaginacionResponse? Paginacion { get; set; }
    }

}
