using Microsoft.AspNetCore.Mvc.Filters;
using PCM.RENAC.Application.Control.Util;
using System.Text;

namespace PCM.RENAC.Application.Control.Filters
{
    public class ValidateModelAttribute : ActionFilterAttribute
    {
        public override void OnActionExecuting(ActionExecutingContext context)
        {
            if (!context.ModelState.IsValid)
            {
                var camposrequeridos = new StringBuilder();
                context.ModelState.Values.ToList().ForEach(m =>
                {
                    m.Errors.ToList().ForEach(e =>
                    {
                        camposrequeridos.Append(string.Format("{0},", e.ErrorMessage));
                    });
                });

                var mensaje = string.Format("{0}|{1}", ConstantesError.ERROR_ENTIDAD_CAMPO_REQUERIDO_CODIGO, camposrequeridos.ToString());
                throw new Exception(mensaje);
            }
        }
    }

}
