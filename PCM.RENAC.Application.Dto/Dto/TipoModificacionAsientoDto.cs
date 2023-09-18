using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Xml.Linq;

namespace PCM.RENAC.Application.Dto
{
    public class TipoModificacionAsientoDto : EntidadBase
    {
        [Display(Name = "Id")]
        public int? idTipoModificacionAsiento { get; set; }
        [Display(Name = "Descripcion")]
        public string? descripcion { get; set; }
    }

    public class TipoModificacionAsientoInsertRequest
    {
        public string? descripcion { get; set; }
    }

    public class TipoModificacionAsientoUpdateRequest
    {
        public int? idTipoModificacionAsiento { get; set; }
        public string? descripcion { get; set; }
    }

    public class TipoModificacionAsientoFiltrosRequest
    {
        public int? idTipoModificacionAsiento { get; set; }
        public string? descripcion { get; set; }
        public bool? activo { get; set; }
        public string? filtro { get; set; }
    }
    public class TipoModificacionAsientoPaginacionFiltroRequest : PaginacionFiltroRequest
    {
        public string? descripcion { get; set; }
        public bool? activo { get; set; }
        public string? filtro { get; set; }
    }

    public class TipoModificacionAsientoIdRequest
    {
        public int? idTipoModificacionAsiento { get; set; }
    }
    public class TipoModificacionAsientoResponse
    {
        public int? idTipoModificacionAsiento { get; set; }
        public string? descripcion { get; set; }
        public DateTime? fechaReg { get; set; }
        public long rownum { get; set; }
        public bool? activo { get; set; }
    }

    public class TipoModificacionAsientoListResponse
    {
        public List<TipoModificacionAsientoResponse>? TipoModificacionAsiento { get; set; }
    }
    public class TipoModificacionAsientoListPaginatedResponse
    {
        public List<TipoModificacionAsientoResponse>? TipoModificacionAsiento { get; set; }
        public PaginacionResponse? Paginacion { get; set; }
    }
}
