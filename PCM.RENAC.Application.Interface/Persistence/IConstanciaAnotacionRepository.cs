using PCM.RENAC.Domain.Entities;
using PCM.RENAC.Transversal.Common;

namespace PCM.RENAC.Application.Interface.Persistence
{
    public interface IConstanciaAnotacionRepository : IGenericRepository<ConstanciaAnotacion>
    {
        Response<dynamic> GetConstanciaAnotacion(ConstanciaAnotacion entidad);
        Response<List<dynamic>> GetConstanciaAnotacionAsientos(ConstanciaAnotacion entidad);
    }
}
