using PCM.RENAC.Application.Dto;
using PCM.RENAC.Transversal.Common;

namespace PCM.RENAC.Application.Interface.Features
{
    public interface IAsientoModificacionApplication : IBaseControl
    {
        Response<bool> Insert(Request<AsientoModificacionDto> request);
        Response<bool> Update(Request<AsientoModificacionDto> request);
        Response<bool> Delete(Request<AsientoModificacionDto> request);
        Response<AsientoModificacionDto> GetById(Request<AsientoModificacionDto> request);
        Response<List<AsientoModificacionDto>> GetList(Request<AsientoModificacionDto> request);
        Response<List<AsientoModificacionDto>> GetListPaginated(Request<AsientoModificacionDto> request, out int PageSize, out int PageNumber, out int TotalReg);
    }
}
