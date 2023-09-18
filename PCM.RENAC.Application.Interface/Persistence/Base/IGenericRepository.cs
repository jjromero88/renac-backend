using PCM.RENAC.Transversal.Common;

namespace PCM.RENAC.Application.Interface.Persistence
{
    public interface IGenericRepository<T> where T : class
    {
        Response Insert(T entidad);
        Response Update(T entidad);
        Response Delete(T entidad);
        Response<dynamic> GetById(T entidad);
        Response<List<dynamic>> GetList(T entidad);
        Response<List<dynamic>> GetListPaginated(T entidad, out int PageSize, out int PageNumber, out int TotalReg);
    }
}
