using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PCM.RENAC.Transversal.Common
{
    public static class UtilDates
    {
        private static string[] nombresMeses = {
        "enero", "febrero", "marzo", "abril", "mayo", "junio",
        "julio", "agosto", "septiembre", "octubre", "noviembre", "diciembre"
    };

        public static string DateToDescription(DateTime? fecha)
        {
            if (fecha != null)
                return fecha.Value.Day + " de " + nombresMeses[fecha.Value.Month - 1] + " de " + fecha.Value.Year;

            return string.Empty;
        }

        public static string DateStringFormat(DateTime? fecha)
        {
            if (fecha != null)
                return fecha.Value.ToString("dd/MM/yyyy");

            return string.Empty;
        }

    }
}
