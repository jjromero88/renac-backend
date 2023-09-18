using PCM.RENAC.Domain;

namespace PCM.RENAC.Transversal.Common
{
    public class UtilApplication
    {
        public static int GetTotalReg<T>(List<T> lista)
        {
            var responseList = lista.OfType<EntidadBase>().ToList();
            if (responseList != null && responseList.Count > 0)
            {
                return responseList[0].TotalReg;
            }
            return 0;
        }
    }
}
