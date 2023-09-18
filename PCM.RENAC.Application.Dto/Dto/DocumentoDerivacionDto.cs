using System.ComponentModel.DataAnnotations;

namespace PCM.RENAC.Application.Dto
{
    public class DocumentoDerivacionDto : EntidadBase
    {
        [Display(Name = "Id")]
        public int? idDocumentoDerivacion { get; set; }
        [Display(Name = "Derivacion")]
        public int? idDerivacionRenac { get; set; }
        [Display(Name = "Tipo documento")]
        public int? idTipoDocumentoRenac { get; set; }
        [Display(Name = "Ruta Documento")]
        public string? rutaDocumento { get; set; }
        [Display(Name = "Nombre documento")]
        public string? nombreDocumento { get; set; }
        public DateTime? fechaDocumento { get; set; }
        public string? numeroDocumento { get; set; }
        public DerivacionRenacDto? DerivacionRenac { get; set; }
        public TipoDocumentoRenacDto? TipoDocumentoRenac { get; set; }
    }
    public class DocumentoDerivacionInsertRequest
    {
        public int? idDerivacionRenac { get; set; }
        public int? idTipoDocumentoRenac { get; set; }
        public string? rutaDocumento { get; set; }
        public string? nombreDocumento { get; set; }
    }
    public class DocumentoDerivacionUpdateRequest
    {
        public int? idDocumentoDerivacion { get; set; }
        public int? idDerivacionRenac { get; set; }
        public int? idTipoDocumentoRenac { get; set; }
        public string? rutaDocumento { get; set; }
        public string? nombreDocumento { get; set; }
    }
    public class DocumentoDerivacionIdRequest
    {
        public int? idDocumentoDerivacion { get; set; }
    }
    public class DocumentoDerivacionFiltrosRequest
    {
        public int? idDocumentoDerivacion { get; set; }
        public int? idDerivacionRenac { get; set; }
        public bool? activo { get; set; }
        public string? filtro { get; set; }
    }
    public class DocumentoDerivacionPaginacionFiltroRequest : PaginacionFiltroRequest
    {
        public int? idDerivacionRenac { get; set; }
        public bool? activo { get; set; }
        public string? filtro { get; set; }
    }
    public class DocumentoDerivacionResponse
    {
        public int? idDocumentoDerivacion { get; set; }
        public int? idDerivacionRenac { get; set; }
        public int? idTipoDocumentoRenac { get; set; }
        public string? rutaDocumento { get; set; }
        public string? nombreDocumento { get; set; }
        public DateTime? fechaDocumento { get; set; }
        public string? numeroDocumento { get; set; }
        public bool? activo { get; set; }
        public DerivacionRenacDto? DerivacionRenac { get; set; }
        public TipoDocumentoRenacDto? TipoDocumentoRenac { get; set; }
    }
    public class DocumentoDerivacionListResponse
    {
        public List<DocumentoDerivacionResponse>? DocumentoDerivacion { get; set; }
    }
    public class DocumentoDerivacionListPaginatedResponse
    {
        public List<DocumentoDerivacionResponse>? DocumentoDerivacion { get; set; }
        public PaginacionResponse? Paginacion { get; set; }
    }
}
