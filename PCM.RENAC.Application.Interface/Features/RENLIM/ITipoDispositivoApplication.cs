using PCM.RENAC.Application.Dto;
using PCM.RENAC.Transversal.Common;

namespace PCM.RENAC.Application.Interface.Features
{
    public interface ITipoDispositivoApplication : IBaseControl
    {
        Response<bool> Insert(Request<TipoDispositivoDto> request);
        Response<bool> Update(Request<TipoDispositivoDto> request);
        Response<bool> Delete(Request<TipoDispositivoDto> request);
        Response<TipoDispositivoDto> GetById(Request<TipoDispositivoDto> request);
        Response<List<TipoDispositivoDto>> GetList(Request<TipoDispositivoDto> request);
        Response<List<TipoDispositivoDto>> GetListPaginated(Request<TipoDispositivoDto> request, out int PageSize, out int PageNumber, out int TotalReg);
    }
}
