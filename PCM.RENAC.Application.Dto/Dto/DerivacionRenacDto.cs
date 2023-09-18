using System.ComponentModel.DataAnnotations;

namespace PCM.RENAC.Application.Dto
{
    public class DerivacionRenacDto : EntidadBase
    {
        [Display(Name = "Id")]
        public int? idDerivacionRenac { get; set; }
        public int? idDerivacionOrigen { get; set; }
        public int? idDerivacionDestino { get; set; }
        public string? idEspecialistaSsatdot { get; set; }
        [Display(Name = "Derivacion")]
        public DateTime? fechaDerivacion { get; set; }
        [Display(Name = "U.Origen")]
        public string? usuarioOrigen { get; set; }
        [Display(Name = "U.Destino")]
        public string? usuarioDestino { get; set; }
        [Display(Name = "Observacion")]
        public string? observacion { get; set; }
        [Display(Name = "Retorno")]
        public bool? esRetorno { get; set; }
        public string? derivacioninformes { get; set; }
        public int? idTipoDocumento { get; set; }
        public string? documentoMemoRuta { get; set; }
        public string? documentoMemoNombre { get; set; }
        public string? documentoMemoBase64 { get; set; }
        public string? numeroDocumento { get; set; }
        public DateTime? fechaDocumento { get; set; }
    }
    public class DerivacionRenacInsertRequest
    {
        public int? idDerivacionOrigen { get; set; }
        public int? idDerivacionDestino { get; set; }
        public DateTime? fechaDerivacion { get; set; }
        public string? usuarioOrigen { get; set; }
        public string? usuarioDestino { get; set; }
        public string? observacion { get; set; }
        public bool? esRetorno { get; set; }
        public string? derivacioninformes { get; set; }
    }
    public class DerivacionRenacUpdateRequest
    {
        public int? idDerivacionOrigen { get; set; }
        public int? idDerivacionDestino { get; set; }
        public int? idDerivacionRenac { get; set; }
        public DateTime? fechaDerivacion { get; set; }
        public string? usuarioOrigen { get; set; }
        public string? usuarioDestino { get; set; }
        public string? observacion { get; set; }
        public bool? esRetorno { get; set; }
        public string? derivacioninformes { get; set; }
    }
    public class DerivacionEspecialistaSSIATRequest
    {
        public string? usuarioOrigen { get; set; }
        public string? usuarioDestino { get; set; }
        public bool? esRetorno { get; set; }
        public string? derivacioninformes { get; set; }
        public string? documentoMemoRuta { get; set; }
        public string? documentoMemoNombre { get; set; }
        public string? documentoMemoBase64 { get; set; }
    }
    public class DerivacionSubsecretarioSSIATRequest
    {
        public string? usuarioOrigen { get; set; }
        public string? usuarioDestino { get; set; }
        public bool? esRetorno { get; set; }
        public string? derivacioninformes { get; set; }
        public int? idTipoDocumento { get; set; }
        public string? documentoMemoRuta { get; set; }
        public string? documentoMemoNombre { get; set; }
        public string? documentoMemoBase64 { get; set; }
        public string? numeroDocumento { get; set; }
        public DateTime? fechaDocumento { get; set; }
    }
    public class DerivacionSubsecretarioSSATDOTRequest
    {
        public string? idEspecialistaSsatdot { get; set; }
        public string? usuarioOrigen { get; set; }
        public string? usuarioDestino { get; set; }
        public bool? esRetorno { get; set; }
        public string? derivacioninformes { get; set; }
    }
    public class DerivacionEspecialistaSSATDOTRequest
    {
        public string? usuarioOrigen { get; set; }
        public string? usuarioDestino { get; set; }
        public bool? esRetorno { get; set; }
        public string? derivacioninformes { get; set; }
        public string? documentoMemoRuta { get; set; }
        public string? documentoMemoNombre { get; set; }
        public string? documentoMemoBase64 { get; set; }
    }

    public class DerivacionRenacIdRequest
    {
        public int? idDerivacionRenac { get; set; }
    }
    public class DerivacionRenacFiltrosRequest
    {
        public int? idDerivacionRenac { get; set; }
        public bool? activo { get; set; }
        public string? filtro { get; set; }
    }
    public class DerivacionAjustesSubsecretarioSsiatRequest
    {
        public string? usuarioOrigen { get; set; }
        public string? usuarioDestino { get; set; }
        public bool? esRetorno { get; set; }
        public string? observacion { get; set; }
        public string? derivacioninformes { get; set; }
    }
    public class DerivacionAjustesEspecialistaSsatdotRequest
    {
        public string? usuarioOrigen { get; set; }
        public string? usuarioDestino { get; set; }
        public bool? esRetorno { get; set; }
        public string? observacion { get; set; }
        public string? derivacioninformes { get; set; }
    }
    public class DerivacionAjustesSubsecretarioSsatdotRequest
    {
        public string? usuarioOrigen { get; set; }
        public string? usuarioDestino { get; set; }
        public bool? esRetorno { get; set; }
        public string? observacion { get; set; }
        public string? derivacioninformes { get; set; }
    }
    public class DerivacionInformesSubsecretarioSsatdotRequest
    {
        public string? usuarioOrigen { get; set; }
        public string? usuarioDestino { get; set; }
        public bool? esRetorno { get; set; }
        public string? derivacioninformes { get; set; }
        public int? idTipoDocumento { get; set; }
        public string? documentoMemoRuta { get; set; }
        public string? documentoMemoNombre { get; set; }
        public DateTime? fechaDocumento { get; set; }
        public string? numeroDocumento { get; set; }
        public string? documentoMemoBase64 { get; set; }
    }
    public class DerivacionInformesResponsableArchivoRequest
    {
        public string? usuarioOrigen { get; set; }
        public string? usuarioDestino { get; set; }
        public bool? esRetorno { get; set; }
        public string? derivacioninformes { get; set; }        
    }
    public class DerivacionRenacPaginacionFiltroRequest : PaginacionFiltroRequest
    {
        public bool? activo { get; set; }
        public string? filtro { get; set; }
    }
    public class DerivacionRenacResponse
    {
        public int? idDerivacionRenac { get; set; }
        public int? idDerivacionOrigen { get; set; }
        public int? idDerivacionDestino { get; set; }
        public string? idEspecialistaSsatdot { get; set; }
        public DateTime? fechaDerivacion { get; set; }
        public string? usuarioOrigen { get; set; }
        public string? usuarioDestino { get; set; }
        public string? observacion { get; set; }
        public bool? esRetorno { get; set; }
        public long rownum { get; set; }
        public bool? activo { get; set; }
        public DateTime? fechaReg { get; set; }
    }

    public class DerivacionRenacListResponse
    {
        public List<DerivacionRenacResponse>? DerivacionRenac { get; set; }
    }
    public class DerivacionRenacListPaginatedResponse
    {
        public List<DerivacionRenacResponse>? DerivacionRenac { get; set; }
        public PaginacionResponse? Paginacion { get; set; }
    }

    public class DerivacionModificacionEspecialistaSsiatRequest
    {
        public string? usuarioOrigen { get; set; }
        public string? usuarioDestino { get; set; }
        public string? observacion { get; set; }
        public bool? esRetorno { get; set; }
        public string? derivacioninformes { get; set; }
    }

    public class DerivacionParaAnotacionEspecialistaSsiatRequest
    {
        public string? usuarioOrigen { get; set; }
        public string? usuarioDestino { get; set; }
        public bool? esRetorno { get; set; }
        public string? derivacioninformes { get; set; }
        public string? documentoMemoRuta { get; set; }
        public string? documentoMemoNombre { get; set; }
        public string? documentoMemoBase64 { get; set; }
    }
    public class DerivacionParaAnotacionSubsecretarioSsiatRequest
    {
        public string? usuarioOrigen { get; set; }
        public string? usuarioDestino { get; set; }
        public bool? esRetorno { get; set; }
        public string? derivacioninformes { get; set; }
        public string? documentoMemoRuta { get; set; }
        public string? documentoMemoNombre { get; set; }
        public DateTime? fechaDocumento { get; set; }
        public string? numeroDocumento { get; set; }
        public string? documentoMemoBase64 { get; set; }
    }

}
