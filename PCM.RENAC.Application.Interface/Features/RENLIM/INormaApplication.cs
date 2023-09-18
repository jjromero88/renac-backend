using PCM.RENAC.Transversal.Common;
using PCM.RENAC.Application.Dto;

namespace PCM.RENAC.Application.Interface.Features
{
    public interface INormaApplication : IBaseControl
    {
        Response<bool> Insert(Request<NormaDto> request);
        Response<bool> Update(Request<NormaDto> request);
        Response<bool> Delete(Request<NormaDto> request);
        Response<NormaDto> GetById(Request<NormaDto> request);
        Response<List<NormaDto>> GetList(Request<NormaDto> request);
        Response<List<NormaDto>> GetListPaginated(Request<NormaDto> request, out int PageSize, out int PageNumber, out int TotalReg);
    }
}
