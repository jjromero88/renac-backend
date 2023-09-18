using PCM.RENAC.Application.Dto;
using PCM.RENAC.Transversal.Common;

namespace PCM.RENAC.Application.Interface.Features
{
    public interface IInformeDerivacionApplication : IBaseControl
    {
        Response<bool> Insert(Request<InformeDerivacionDto> request);
        Response<bool> Update(Request<InformeDerivacionDto> request);
        Response<bool> Delete(Request<InformeDerivacionDto> request);
        Response<InformeDerivacionDto> GetById(Request<InformeDerivacionDto> request);
        Response<List<InformeDerivacionDto>> GetList(Request<InformeDerivacionDto> request);
        Response<List<InformeDerivacionDto>> GetListPaginated(Request<InformeDerivacionDto> request, out int PageSize, out int PageNumber, out int TotalReg);
    }
}
