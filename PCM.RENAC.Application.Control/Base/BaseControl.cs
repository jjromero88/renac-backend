using PCM.RENAC.Application.Control.Claims;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PCM.RENAC.Application.Control.Base
{
    public static class BaseControl
    {
        public static string IdUsuarioAuditoria(string TokenSesion)
        {
            string? usuarioId = string.Empty;
            var jwtTokenHandler = new JwtTokenHandler();
            string usuariokey = jwtTokenHandler.GetClaimValue(TokenSesion, TiposClaims.IdUsuario);

            usuarioId = string.IsNullOrEmpty(usuariokey) ? "0" : usuariokey;

            return usuarioId;
        }
    }
}
