using PCM.RENAC.Application.Dto;
using PCM.RENAC.Transversal.Common;

namespace PCM.RENAC.Application.Interface.Features
{
    public interface IDerivacionRenacApplication : IBaseControl
    {
        Response<bool> Insert(Request<DerivacionRenacDto> request);
        Response<bool> Update(Request<DerivacionRenacDto> request);
        Response<bool> Delete(Request<DerivacionRenacDto> request);
        Response<bool> DerivacionEspecialistaSSIAT(Request<DerivacionRenacDto> request);
        Response<bool> DerivacionSubsecretarioSSIAT(Request<DerivacionRenacDto> request);
        Response<bool> DerivacionAjustesSubsecretarioSSIAT(Request<DerivacionRenacDto> request);
        Response<bool> DerivacionSubsecretarioSSATDOT(Request<DerivacionRenacDto> request);
        Response<bool> DerivacionEspecialistaSSATDOT(Request<DerivacionRenacDto> request);
        Response<DerivacionRenacDto> GetById(Request<DerivacionRenacDto> request);
        Response<List<DerivacionRenacDto>> GetList(Request<DerivacionRenacDto> request);
        Response<List<DerivacionRenacDto>> GetListPaginated(Request<DerivacionRenacDto> request, out int PageSize, out int PageNumber, out int TotalReg);
        Response<bool> DerivacionAjustesEspecialistaSSATDOT(Request<DerivacionRenacDto> request);
        Response<bool> DerivacionAjustesSubsecretarioSSATDOT(Request<DerivacionRenacDto> request);
        Response<bool> DerivacionInformesSubsecretarioSSATDOT(Request<DerivacionRenacDto> request);
        Response<bool> DerivacionInformesResponsableArchivo(Request<DerivacionRenacDto> request);
        Response<bool> DerivacionModificacionEspecialistaSSIAT(Request<DerivacionRenacDto> request);
        Response<bool> DerivacionParaAnotacionEspecialistaSSIAT(Request<DerivacionRenacDto> request);
        Response<bool> DerivacionParaAnotacionSubsecretarioSSIAT(Request<DerivacionRenacDto> request);

    }
}
