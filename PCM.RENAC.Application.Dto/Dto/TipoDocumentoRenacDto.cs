using System.ComponentModel.DataAnnotations;

namespace PCM.RENAC.Application.Dto
{
    public class TipoDocumentoRenacDto: EntidadBase
    {
        [Display(Name = "Id")]
        public int? idTipoDocumentoRenac { get; set; }
        [Display(Name = "Codigo")]
        public int? codigo { get; set; }
        [Display(Name = "Descripcion")]
        public string? descripcion { get; set; }
    }
    public class TipoDocumentoRenacInsertRequest
    {
        public int? codigo { get; set; }
        public string? descripcion { get; set; }
    }
    public class TipoDocumentoRenacUpdateRequest
    {
        public int? idTipoDocumentoRenac { get; set; }
        public int? codigo { get; set; }
        public string? descripcion { get; set; }
    }
    public class TipoDocumentoRenacIdRequest
    {
        public int? idTipoDocumentoRenac { get; set; }
    }
    public class TipoDocumentoRenacFiltrosRequest
    {
        public int? idTipoDocumentoRenac { get; set; }
        public string? descripcion { get; set; }
        public bool? activo { get; set; }
        public string? filtro { get; set; }
    }
    public class TipoDocumentoRenacPaginacionFiltroRequest : PaginacionFiltroRequest
    {
        public bool? activo { get; set; }
        public string? descripcion { get; set; }
        public string? filtro { get; set; }
    }
    public class TipoDocumentoRenacResponse
    {
        public int? idTipoDocumentoRenac { get; set; }
        public int? codigo { get; set; }
        public string? descripcion { get; set; }
        public long rownum { get; set; }
        public bool? activo { get; set; }
        public DateTime? fechaReg { get; set; }
    }
    public class TipoDocumentoRenacListResponse
    {
        public List<TipoDocumentoRenacResponse>? TipoDocumentoRenac { get; set; }
    }
    public class TipoDocumentoRenacListPaginatedResponse
    {
        public List<TipoDocumentoRenacResponse>? TipoDocumentoRenac { get; set; }
        public PaginacionResponse? Paginacion { get; set; }
    }
}
