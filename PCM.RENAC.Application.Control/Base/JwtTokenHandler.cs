using System.IdentityModel.Tokens.Jwt;

namespace PCM.RENAC.Application.Control.Base
{
    public class JwtTokenHandler
    {
        private readonly JwtSecurityTokenHandler _tokenHandler;

        public JwtTokenHandler()
        {
            _tokenHandler = new JwtSecurityTokenHandler();
        }

        public string GetClaimValue(string token, string claimType)
        {
            token = token.Contains("Bearer ") ? token.Replace("Bearer ", "") : token;

            if (_tokenHandler.CanReadToken(token))
            {
                var securityToken = _tokenHandler.ReadJwtToken(token);
                var claim = securityToken.Claims.FirstOrDefault(c => c.Type == claimType);
                if (claim != null)
                {
                    return claim.Value;
                }
            }
            return null;
        }
    }
}
