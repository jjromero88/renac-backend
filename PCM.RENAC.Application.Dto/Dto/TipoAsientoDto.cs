using System.ComponentModel.DataAnnotations;

namespace PCM.RENAC.Application.Dto
{
    public class TipoAsientoDto: EntidadBase
    {
        [Display(Name = "Id")]
        public int? idTipoAsiento { get; set; }
        [Display(Name = "Codigo")]
        public int? codigo { get; set; }
        [Display(Name = "Descripcion")]
        public string? descripcion { get; set; }
    }

    public class TipoAsientoInsertRequest
    {
        public int? codigo { get; set; }
        public string? descripcion { get; set; }
    }

    public class TipoAsientoUpdateRequest
    {
        public int? idTipoAsiento { get; set; }
        public int? codigo { get; set; }
        public string? descripcion { get; set; }
    }

    public class TipoAsientoFiltrosRequest
    {
        public int? idTipoAsiento { get; set; }
        public string? descripcion { get; set; }
        public bool? activo { get; set; }
        public string? filtro { get; set; }
    }
    public class TipoAsientoPaginacionFiltroRequest : PaginacionFiltroRequest
    {
        public string? descripcion { get; set; }
        public bool? activo { get; set; }
        public string? filtro { get; set; }
    }

    public class TipoAsientoIdRequest
    {
        public int? idTipoAsiento { get; set; }
    }
    public class TipoAsientoResponse
    {
        public int? idTipoAsiento { get; set; }
        public int? codigo { get; set; }
        public string? descripcion { get; set; }
        public bool? activo { get; set; }
        public DateTime? fechareg { get; set; }
        public long rownum { get; set; }
    }

    public class TipoAsientoListResponse
    {
        public List<TipoAsientoResponse>? TipoAsiento { get; set; }
    }
    public class TipoAsientoListPaginatedResponse
    {
        public List<TipoAsientoResponse>? TipoAsiento { get; set; }
        public PaginacionResponse? Paginacion { get; set; }
    }

}
