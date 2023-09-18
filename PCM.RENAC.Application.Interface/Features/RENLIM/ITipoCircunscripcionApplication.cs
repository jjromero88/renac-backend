using PCM.RENAC.Application.Dto;
using PCM.RENAC.Transversal.Common;

namespace PCM.RENAC.Application.Interface.Features
{
    public interface ITipoCircunscripcionApplication : IBaseControl
    {
        Response<bool> Insert(Request<TipoCircunscripcionDto> request);
        Response<bool> Update(Request<TipoCircunscripcionDto> request);
        Response<bool> Delete(Request<TipoCircunscripcionDto> request);
        Response<TipoCircunscripcionDto> GetById(Request<TipoCircunscripcionDto> request);
        Response<List<TipoCircunscripcionDto>> GetList(Request<TipoCircunscripcionDto> request);
        Response<List<TipoCircunscripcionDto>> GetListPaginated(Request<TipoCircunscripcionDto> request, out int PageSize, out int PageNumber, out int TotalReg);
    }
}
