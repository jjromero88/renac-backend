using Microsoft.AspNetCore.Mvc.Filters;
using PCM.RENAC.Application.Control.Util;

namespace PCM.RENAC.Application.Control.Filters
{
    public class ValidateAuthorizationRequestAttribute : ActionFilterAttribute
    {
        public ValidateAuthorizationRequestAttribute() { }

        public override void OnActionExecuting(ActionExecutingContext context)
        {
            try
            {
                string authorization = context.HttpContext.Request.Headers["Authorization"];

                // If no authorization header found, nothing to process further
                if (string.IsNullOrEmpty(authorization))
                {
                    var mensaje = string.Format("{0}|{1}", ConstantesError.ERROR_CABECERA_AUTHORIZATION_NULO_CODIGO, "No se ha encontrado parámetro  Authorization en la cabecera de la solicitud.");

                    throw new Exception(mensaje);
                }

                string token;
                if (!authorization.StartsWith("Bearer ", StringComparison.OrdinalIgnoreCase))
                {
                    var mensaje = string.Format("{0}|{1}", ConstantesError.ERROR_TOKEN_FORMATO_INCORRECTO_CODIGO, "Formato incorrecto de parámetro Authorization en la cabecera de la solicitud, 'Bearer ' es requerido.");

                    throw new Exception(mensaje);
                }
                else
                    token = authorization.Substring("Bearer ".Length).Trim();

                // If no token found, no further work possible
                if (string.IsNullOrEmpty(token))
                {
                    var mensaje = string.Format("{0}|{1}", ConstantesError.ERROR_TOKEN_NULO_CODIGO, "No se ha encontrado Token en la cabecera del Request.");

                    throw new Exception(mensaje);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }

        }
    }

}
