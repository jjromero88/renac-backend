using PCM.RENAC.Application.Dto;
using PCM.RENAC.Transversal.Common;

namespace PCM.RENAC.Application.Interface.Features
{
    public interface ICircunscripcionOrigenDestinoApplication : IBaseControl
    {
        Response<bool> Insert(Request<CircunscripcionOrigenDestinoDto> request);
        Response<bool> Update(Request<CircunscripcionOrigenDestinoDto> request);
        Response<bool> Delete(Request<CircunscripcionOrigenDestinoDto> request);
        Response<CircunscripcionOrigenDestinoDto> GetById(Request<CircunscripcionOrigenDestinoDto> request);
        Response<List<CircunscripcionOrigenDestinoDto>> GetList(Request<CircunscripcionOrigenDestinoDto> request);
        Response<List<CircunscripcionOrigenDestinoDto>> GetListPaginated(Request<CircunscripcionOrigenDestinoDto> request, out int PageSize, out int PageNumber, out int TotalReg);
    }
}
