using PCM.RENAC.Transversal.Common;
using PCM.RENAC.Application.Dto;

namespace PCM.RENAC.Application.Interface.Features
{
    public interface ICircunscripcionApplication : IBaseControl
    {
        Response<bool> Insert(Request<CircunscripcionDto> request);
        Response<bool> Update(Request<CircunscripcionDto> request);
        Response<bool> Delete(Request<CircunscripcionDto> request);
        Response<CircunscripcionDto> GetById(Request<CircunscripcionDto> request);
        Response<List<CircunscripcionDto>> GetList(Request<CircunscripcionDto> request);
        Response<List<CircunscripcionDto>> GetListPaginated(Request<CircunscripcionDto> request, out int PageSize, out int PageNumber, out int TotalReg);
    }
}
