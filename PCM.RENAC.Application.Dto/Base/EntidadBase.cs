using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PCM.RENAC.Application.Dto
{
    public class Paginacion
    {
        public int PageSize { get; set; }
        public int PageNumber { get; set; }
    }
    public class PaginacionFiltroRequest
    {
        /// <summary>
        /// Número de página, valor por defecto 0
        /// </summary>
        public int PageSize { get; set; } = 0;

        /// <summary>
        /// Cantidad de registros por página, valor por defecto 10
        /// </summary>
        public int PageNumber { get; set; } = 10;
    }

    public class PaginacionResponse
    {
        /// <summary>
        /// Total de registros encontrados
        /// </summary>
        public int totalReg { get; set; }

        /// <summary>
        /// Total de registro por pagina
        /// </summary>
        public int rowsPerPage { get; set; }

        /// <summary>
        /// Pagina actual
        /// </summary>
        public int currentPage { get; set; }
    }
}
