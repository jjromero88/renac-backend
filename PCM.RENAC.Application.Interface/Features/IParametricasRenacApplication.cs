using PCM.RENAC.Transversal.Common;
using PCM.RENAC.Application.Dto;

namespace PCM.RENAC.Application.Interface.Features
{
    public interface IParametricasRenacApplication : IBaseControl
    {
        Response<bool> Insert(Request<ParametricasRenacDto> request);
        Response<bool> Update(Request<ParametricasRenacDto> request);
        Response<bool> Delete(Request<ParametricasRenacDto> request);
        Response<ParametricasRenacDto> GetById(Request<ParametricasRenacDto> request);
        Response<List<ParametricasRenacDto>> GetList(Request<ParametricasRenacDto> request);
        Response<List<ParametricasRenacDto>> GetListPaginated(Request<ParametricasRenacDto> request, out int PageSize, out int PageNumber, out int TotalReg);
    }
}
