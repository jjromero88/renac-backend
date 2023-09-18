using System.ComponentModel.DataAnnotations;

namespace PCM.RENAC.Application.Dto
{
    public class InformeDerivacionDto : EntidadBase
    {
        [Display(Name = "Id")]
        public int? idInformeDerivacion { get; set; }
        [Display(Name = "Id Informe")]
        public int? idInformeRenac { get; set; }
        [Display(Name = "Id Derivacion")]
        public int? idDerivacionRenac { get; set; }
        public InformeRenacDto? InformeRenac { get; set; }
        public DerivacionRenacDto? DerivacionRenac { get; set; }
    }
    public class InformeDerivacionInsertRequest
    {
        public int? idInformeRenac { get; set; }
        public int? idDerivacionRenac { get; set; }
    }
    public class InformeDerivacionUpdateRequest
    {
        public int? idInformeDerivacion { get; set; }
        public int? idInformeRenac { get; set; }
        public int? idDerivacionRenac { get; set; }
    }
    public class InformeDerivacionIdRequest
    {
        public int? idInformeDerivacion { get; set; }
    }
    public class InformeDerivacionFiltrosRequest
    {
        public int? idInformeDerivacion { get; set; }
        public bool? activo { get; set; }
        public string? filtro { get; set; }
    }
    public class InformeDerivacionPaginacionFiltroRequest : PaginacionFiltroRequest
    {
        public bool? activo { get; set; }
        public string? filtro { get; set; }
    }
    public class InformeDerivacionResponse
    {
        public int? idInformeDerivacion { get; set; }
        public int? idInformeRenac { get; set; }
        public int? idDerivacionRenac { get; set; }        
        public long rownum { get; set; }
        public bool? activo { get; set; }
        public DateTime? fechaReg { get; set; }
        public InformeRenacDto? InformeRenac { get; set; }
        public DerivacionRenacDto? DerivacionRenac { get; set; }
    }
    public class InformeDerivacionListResponse
    {
        public List<InformeDerivacionResponse>? InformeDerivacion { get; set; }
    }
    public class InformeDerivacionListPaginatedResponse
    {
        public List<InformeDerivacionResponse>? InformeDerivacion { get; set; }
        public PaginacionResponse? Paginacion { get; set; }
    }
}
