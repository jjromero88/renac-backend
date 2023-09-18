using PCM.RENAC.Transversal.Common;
using PCM.RENAC.Application.Dto;

namespace PCM.RENAC.Application.Interface.Features
{
    public interface ITipoAsientoApplication : IBaseControl
    {
        Response<bool> Insert(Request<TipoAsientoDto> request);
        Response<bool> Update(Request<TipoAsientoDto> request);
        Response<bool> Delete(Request<TipoAsientoDto> request);
        Response<TipoAsientoDto> GetById(Request<TipoAsientoDto> request);
        Response<List<TipoAsientoDto>> GetList(Request<TipoAsientoDto> request);
        Response<List<TipoAsientoDto>> GetListPaginated(Request<TipoAsientoDto> request, out int PageSize, out int PageNumber, out int TotalReg);
    }
}
