using PCM.RENAC.Application.Dto;
using PCM.RENAC.Transversal.Common;

namespace PCM.RENAC.Application.Interface.Features
{
    public interface IDocumentoDerivacionApplication : IBaseControl
    {
        Response<bool> Insert(Request<DocumentoDerivacionDto> request);
        Response<bool> Update(Request<DocumentoDerivacionDto> request);
        Response<bool> Delete(Request<DocumentoDerivacionDto> request);
        Response<DocumentoDerivacionDto> GetById(Request<DocumentoDerivacionDto> request);
        Response<List<DocumentoDerivacionDto>> GetList(Request<DocumentoDerivacionDto> request);
        Response<List<DocumentoDerivacionDto>> GetListPaginated(Request<DocumentoDerivacionDto> request, out int PageSize, out int PageNumber, out int TotalReg);
    }
}
