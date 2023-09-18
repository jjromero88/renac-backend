using PCM.RENAC.Application.Dto;
using PCM.RENAC.Transversal.Common;

namespace PCM.RENAC.Application.Interface.Features
{
    public interface IConstanciaAnotacionApplication : IBaseControl
    {
        Response<GenerarConstanciaAnotacionResponse> GenerarConstanciaAnotacion(Request<ConstanciaAnotacionDto> request);
    }
}
