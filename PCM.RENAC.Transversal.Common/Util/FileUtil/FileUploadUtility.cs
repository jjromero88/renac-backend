using Microsoft.AspNetCore.Http;
using MimeKit;

namespace PCM.RENAC.Transversal.Common.Util
{
    public static class FileUploadUtility
    {
        public static ResponseFile SaveBase64File(string? fileBase64, string? fileName, string targetFolderPath, string nombreCorrelativo)
        {
            ResponseFile retorno = new ResponseFile();

            try
            {
                // Obtenemos el path raiz
                string rootPath = FileApplicationKeys.RootPathRenac.ToString();

                // Guardamos el path principal
                string folderPath = targetFolderPath;

                // Armamos la ruta completa
                targetFolderPath = Path.Combine(rootPath, targetFolderPath);

                // Verificar que el archivo no sea nulo o vacío
                if (string.IsNullOrEmpty(fileBase64))
                {
                    retorno.Message = "El archivo no es válido.";
                    retorno.MessageException = "El archivo no es válido.";
                    retorno.Error = true;
                    return retorno;
                }

                // Verificar permisos de escritura en la carpeta de destino
                try
                {
                    using (FileStream fs = File.Create(Path.Combine(targetFolderPath, Path.GetRandomFileName()), 1, FileOptions.DeleteOnClose))
                    {
                    }
                }
                catch (UnauthorizedAccessException ex)
                {
                    retorno.Message = "No tienes permisos de escritura en la carpeta de destino.";
                    retorno.MessageException = ex.Message;
                    retorno.Error = true;
                    return retorno;
                }

                // Crear la carpeta de destino si no existe
                if (!Directory.Exists(targetFolderPath))
                {
                    Directory.CreateDirectory(targetFolderPath);
                }

                // Remove file type from base64 encoding, if any
                if (fileBase64.Contains(","))
                {
                    fileBase64 = fileBase64.Substring(fileBase64.IndexOf(",") + 1);
                }

                // Convert base64 encoded string to binary
                byte[] fileBytes;
                fileBytes = Convert.FromBase64String(fileBase64);

                // Generar un nombre de archivo nuevo
                string timestamp = DateTime.Now.ToString("yyyyMMddHHmmss");
                string fileExtension = Path.GetExtension(fileName) ?? "";
                string newFileName = $"{nombreCorrelativo}_{timestamp}{fileExtension}";
                string filePath = Path.Combine(targetFolderPath, newFileName);

                // Guardar el archivo en la carpeta de destino
                using (var stream = new FileStream(filePath, FileMode.Create))
                {
                    stream.Write(fileBytes, 0, fileBytes.Length);
                }

                retorno.Message = "El archivo ha sido guardado exitosamente.";
                retorno.FileName = newFileName;
                retorno.PathFile = Path.Combine(folderPath, newFileName);
                retorno.Error = false;
                return retorno;
            }
            catch (Exception ex)
            {
                retorno.Message = "Error al guardar el archivo.";
                retorno.MessageException = ex.Message.ToString();
                retorno.Error = true;
                return retorno;
            }
        }

        public static ResponseFile DownloadAndConvertToBase64(string rootPath, string filePath)
        {
            ResponseFile retorno = new ResponseFile();

            try
            {
                //obtenemos el nombre del archivo
                string fileName = string.IsNullOrEmpty(filePath) ? string.Empty : Path.GetFileName(filePath);

                // Verificar si el directorio existe
                if (!Directory.Exists(rootPath))
                {
                    retorno.Error = true;
                    retorno.Message = "El directorio no existe.";
                    return retorno;
                }

                // obtiene el Path
                filePath = Path.Combine(rootPath, filePath);

                // Resolvemos la ruta completa (para solucionar posibles rutas relativas)
                filePath = Path.GetFullPath(filePath);

                // Verificar si el archivo existe
                if (!File.Exists(filePath))
                {
                    retorno.Error = true;
                    retorno.Message = "El archivo no fue encontrado.";
                    return retorno;
                }

                // Verificar si tienes permisos de lectura sobre el directorio
                try
                {
                    Directory.GetFiles(rootPath);
                }
                catch (UnauthorizedAccessException ex)
                {
                    retorno.Error = true;
                    retorno.Message = "No tienes permisos de lectura sobre el directorio.";
                    retorno.MessageException = ex.Message.ToString();
                    return retorno;
                }

                //convierte en array de bytes
                byte[] fileBytes = File.ReadAllBytes(filePath);
                string base64String = Convert.ToBase64String(fileBytes);

                // Obtener el content type del archivo
                string contentType = MimeTypes.GetMimeType(Path.GetExtension(filePath));

                retorno.Error = false;
                retorno.Message = "Descarga realizada con exito.";
                retorno.FileName = fileName;
                retorno.base64String = base64String;
                retorno.contentType = contentType;
            }
            catch (Exception ex)
            {
                retorno.Error = true;
                retorno.Message = "Ocurrio un error al intentar descargar el archivo.";
                retorno.MessageException = ex.Message.ToString();
            }

            return retorno;
        }

    }
}
