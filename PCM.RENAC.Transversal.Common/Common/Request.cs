using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PCM.RENAC.Transversal.Common
{
    public class Request<T>
    {
        public T entidad { get; set; }
        public string? authkey { get; set; }
    }
}
