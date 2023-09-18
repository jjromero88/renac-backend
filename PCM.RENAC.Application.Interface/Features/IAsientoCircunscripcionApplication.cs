using PCM.RENAC.Application.Dto;
using PCM.RENAC.Transversal.Common;

namespace PCM.RENAC.Application.Interface.Features
{
    public interface IAsientoCircunscripcionApplication : IBaseControl
    {
        Response<bool> Insert(Request<AsientoCircunscripcionDto> request);
        Response<bool> Update(Request<AsientoCircunscripcionDto> request);
        Response<bool> Delete(Request<AsientoCircunscripcionDto> request);
        Response<AsientoCircunscripcionDto> GetById(Request<AsientoCircunscripcionDto> request);
        Response<List<AsientoCircunscripcionDto>> GetList(Request<AsientoCircunscripcionDto> request);
        Response<List<AsientoCircunscripcionDto>> GetListPaginated(Request<AsientoCircunscripcionDto> request, out int PageSize, out int PageNumber, out int TotalReg);
        Response<List<AsientoCircunscripcionDto>> InformacionSsiatAsientosList(Request<AsientoCircunscripcionDto> request);
    }
}
