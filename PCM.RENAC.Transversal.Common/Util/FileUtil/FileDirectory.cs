using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PCM.RENAC.Transversal.Common.Util
{
    public static class FileDirectory
    {
        private static string rootPathRenac = FileApplicationKeys.RootPathRenac.ToString();
        private static string rootPathRenlim = FileApplicationKeys.RootPathRenlim.ToString();

        public static string GetDirectory(int id)
        {
            switch (id)
            {
                case 1://retorna el root path de Renac
                    return rootPathRenac;
                case 2://retorna el root path de Renlim
                    return rootPathRenlim;

                default:
                    return string.Empty;
            }
        }
    }
}
