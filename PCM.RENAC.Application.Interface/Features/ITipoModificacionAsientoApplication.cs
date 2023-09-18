using PCM.RENAC.Application.Dto;
using PCM.RENAC.Transversal.Common;

namespace PCM.RENAC.Application.Interface.Features
{
    public interface ITipoModificacionAsientoApplication : IBaseControl
    {
        Response<bool> Insert(Request<TipoModificacionAsientoDto> request);
        Response<bool> Update(Request<TipoModificacionAsientoDto> request);
        Response<bool> Delete(Request<TipoModificacionAsientoDto> request);
        Response<TipoModificacionAsientoDto> GetById(Request<TipoModificacionAsientoDto> request);
        Response<List<TipoModificacionAsientoDto>> GetList(Request<TipoModificacionAsientoDto> request);
        Response<List<TipoModificacionAsientoDto>> GetListPaginated(Request<TipoModificacionAsientoDto> request, out int PageSize, out int PageNumber, out int TotalReg);
    }
}
