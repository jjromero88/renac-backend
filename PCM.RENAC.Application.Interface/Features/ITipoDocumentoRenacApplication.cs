using PCM.RENAC.Application.Dto;
using PCM.RENAC.Transversal.Common;

namespace PCM.RENAC.Application.Interface.Features
{
    public interface ITipoDocumentoRenacApplication : IBaseControl
    {
        Response<bool> Insert(Request<TipoDocumentoRenacDto> request);
        Response<bool> Update(Request<TipoDocumentoRenacDto> request);
        Response<bool> Delete(Request<TipoDocumentoRenacDto> request);
        Response<TipoDocumentoRenacDto> GetById(Request<TipoDocumentoRenacDto> request);
        Response<List<TipoDocumentoRenacDto>> GetList(Request<TipoDocumentoRenacDto> request);
        Response<List<TipoDocumentoRenacDto>> GetListPaginated(Request<TipoDocumentoRenacDto> request, out int PageSize, out int PageNumber, out int TotalReg);
    }
}
