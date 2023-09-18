using Microsoft.AspNetCore.Mvc.Filters;

namespace PCM.RENAC.Application.Control.Filters
{
    public class PermissionFilterAttribute : ActionFilterAttribute
    {
        public string? userkey { get; set; }
        public string? token { get; set; }

        public PermissionFilterAttribute()
        {
        }

        public override void OnActionExecuting(ActionExecutingContext context)
        {
            var controllerName = context.RouteData.Values["controller"].ToString();
            var actionName = context.RouteData.Values["action"].ToString();


            //if (!_dataAccessService.HasPermission(userId, controllerName, actionName))
            //{
            //    context.Result = new UnauthorizedResult();
            //    return;
            //}

            base.OnActionExecuting(context);
        }
    }

}
