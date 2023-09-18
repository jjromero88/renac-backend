using Microsoft.AspNetCore.Mvc;
using System.ComponentModel.DataAnnotations;

namespace PCM.RENAC.Api.Controllers.Base
{
    public class BaseMantenimiento : Controller
    {
        /// <summary>
        /// Autenticación del API por Token - Formato utilizado 'Bearer {token}'
        /// </summary>
        [Required]
        [FromHeader(Name = "Authorization")]
        public string Token { get; set; }

    }
}
