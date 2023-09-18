using System.IO;
using System.Reflection;
using Microsoft.Extensions.Configuration;

namespace PCM.RENAC.Transversal.Common.Util
{
    public static class FileApplicationKeys
    {
        private static readonly IConfigurationRoot Configuration;

        static FileApplicationKeys()
        {
            var builder = new ConfigurationBuilder()
                .SetBasePath(Directory.GetCurrentDirectory())
                .AddJsonFile("appsettings.json", optional: true, reloadOnChange: true);

            Configuration = builder.Build();
        }

        private static string ObtenerRutaRaiz()
        {
            // Obtenemos el ensamblado que contiene la clase actual
            Assembly assembly = Assembly.GetExecutingAssembly();

            // Obtenemos la ruta del directorio del ensamblado (proyecto actual)
            string ensambladoDirectorio = new FileInfo(assembly.Location).DirectoryName;

            // Navegamos hacia arriba en la estructura de carpetas hasta llegar a la carpeta "wwwroot"
            DirectoryInfo apiDirectory = Directory.GetParent(ensambladoDirectorio).Parent.Parent;

            // Obtenemos la ruta de la carpeta raiz de documentos
            string rutaRaiz = Path.Combine(apiDirectory.FullName, "wwwroot");

            // Resolvemos la ruta completa (para solucionar posibles rutas relativas)
            rutaRaiz = Path.GetFullPath(rutaRaiz);

            return rutaRaiz;
        }

        // RENAC PATH

        public static string RootPathRenac => Configuration.GetSection("Renac:RootFiles").Value ?? string.Empty;
        public static string PathInformeRenac => Configuration.GetSection("Renac:PathInformeRenac").Value ?? string.Empty;
        public static string PathDocumentoMemoEspecialistaSsiat => Configuration.GetSection("Renac:PathProyectoMemoEspecialistaSsiat").Value ?? string.Empty;
        public static string PathDocumentoMemoSubsecretarioSsiat => Configuration.GetSection("Renac:PathProyectoMemoSubsecretarioSsiat").Value ?? string.Empty;
        public static string PathInformeOpinionFavorable => Configuration.GetSection("Renac:PathInformeOpinionFavorable").Value ?? string.Empty;
        public static string PathProyectoMemoEspecialistaSsatdot => Configuration.GetSection("Renac:PathProyectoMemoEspecialistaSsatdot").Value ?? string.Empty;
        public static string PathDocumentosSubsecretarioSsatdot => Configuration.GetSection("Renac:PathDocumentosSubsecretarioSsatdot").Value ?? string.Empty;
        public static string PathEvidenciaAnotacion => Configuration.GetSection("Renac:PathEvidenciaAnotacion").Value ?? string.Empty;
        public static string PathOficioAnotacion => Configuration.GetSection("Renac:PathOficioAnotacion").Value ?? string.Empty;
        public static string PathEvidenciaSolicitudInformacion => Configuration.GetSection("Renac:PathEvidenciaSolicitudInformacion").Value ?? string.Empty;
        public static string PathOficioSolicitudInformacion => Configuration.GetSection("Renac:PathOficioSolicitudInformacion").Value ?? string.Empty;
        public static string PathConstanciaAnotacion => Configuration.GetSection("Renac:PathConstanciaAnotacionRenac").Value ?? string.Empty;
        public static string PathRespuestaGore => Configuration.GetSection("Renac:PathRespuestaGore").Value ?? string.Empty;
        public static string PathDocumentoDerivacionAnotacionEspecialistaSsiat => Configuration.GetSection("Renac:PathDocumentoDerivacionAnotacionEspecialistaSsiat").Value ?? string.Empty;
        public static string PathDocumentoDerivacionAnotacionSubsecretarioSsiat => Configuration.GetSection("Renac:PathDocumentoDerivacionAnotacionSubsecretarioSsiat").Value ?? string.Empty;
        public static string PathConstanciaAnotacionFirmada => Configuration.GetSection("Renac:PathConstanciaAnotacionFirmada").Value ?? string.Empty;
        public static string PathConstanciaAnotacionPlantilla => Configuration.GetSection("Renac:PathConstanciaAnotacionRenacPlantilla").Value ?? string.Empty;


        // RENLIM PATH

        public static string RootPathRenlim => Configuration.GetSection("Renlim:RootFiles").Value ?? string.Empty;
    

    }
}
