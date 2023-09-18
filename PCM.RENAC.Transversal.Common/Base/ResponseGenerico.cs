using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PCM.RENAC.Transversal.Common
{
    public class ResponseDatos
    {
        public int id { get; set; }
        public string? descripcion { get; set; }
    }

    public class ListaResponseDatos
    {
        public List<ResponseDatos>? items { get; set; }
    }

    public class ResponseSuccess
    {
        public ResponseSuccessDetalle success { get; set; }
    }

    public class ResponseSuccessDetalle
    {
        public string titulo { get; set; }
        public string codigo { get; set; }
        public string mensaje { get; set; }
    }

    public class ResponseError
    {
        public ResponseErrorDetalle error { get; set; }
    }

    public class ResponseErrorDetalle
    {
        public string titulo { get; set; }
        public string codigo { get; set; }
        public string mensaje { get; set; }
    }
}
