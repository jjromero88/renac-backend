using PCM.RENAC.Domain.Entities;
using PCM.RENAC.Transversal.Common;

namespace PCM.RENAC.Application.Interface.Persistence
{
    public interface IAsientoCircunscripcionRepository : IGenericRepository<AsientoCircunscripcion>
    {
        Response<List<dynamic>> InformacionSsiatAsientosList(AsientoCircunscripcion entidad);
    }
}
