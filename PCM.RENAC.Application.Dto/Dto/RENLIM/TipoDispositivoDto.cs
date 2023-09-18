using System.ComponentModel.DataAnnotations;

namespace PCM.RENAC.Application.Dto
{
    public class TipoDispositivoDto : EntidadBase
    {
        [Display(Name = "Id")]
        public int? Id { get; set; }
        [Display(Name = "Descripcion")]
        public string? Descripcion { get; set; }
        [Display(Name = "Abreviatura")]
        public string? Abreviado { get; set; }
        [Display(Name = "Grupo")]
        public int? Grupo { get; set; }
        [Display(Name = "Orden")]
        public int? Orden { get; set; }
    }
    public class TipoDispositivoFiltrosRequest
    {
        public int? Id { get; set; }
        public int? Grupo { get; set; }
    }
    public class TipoDispositivoResponse
    {
        public int? Id { get; set; }
        public string? Descripcion { get; set; }
        public string? Abreviado { get; set; }
        public int? Grupo { get; set; }
        public int? Orden { get; set; }
        public bool? activo { get; set; }
    }
    public class TipoDispositivoListResponse
    {
        public List<TipoDispositivoResponse>? TipoDispositivo { get; set; }
    }


}
