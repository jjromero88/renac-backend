using PCM.RENAC.Application.Dto;
using PCM.RENAC.Transversal.Common;

namespace PCM.RENAC.Application.Interface.Features
{
    public interface IInformeRenacApplication : IBaseControl
    {
        Response<bool> Insert(Request<InformeRenacDto> request);
        Response<bool> Update(Request<InformeRenacDto> request);
        Response<bool> Delete(Request<InformeRenacDto> request);
        Response<InformeRenacDto> GetById(Request<InformeRenacDto> request);
        Response<List<InformeRenacDto>> GetList(Request<InformeRenacDto> request);
        Response<List<InformeRenacDto>> GetListPaginated(Request<InformeRenacDto> request, out int PageSize, out int PageNumber, out int TotalReg);
        Response<InformeRenacDto> GetListInformacionSsiatDocumentos(Request<InformeRenacDto> request);
        Response<List<InformeRenacDto>> GetListEspecialistaSsiatPaginated(Request<InformeRenacDto> request, out int PageSize, out int PageNumber, out int TotalReg);
        Response<List<InformeRenacDto>> GetListSubsecretarioSsiatPaginated(Request<InformeRenacDto> request, out int PageSize, out int PageNumber, out int TotalReg);
        Response<List<InformeRenacDto>> GetListSubsecretarioSsatdotPaginated(Request<InformeRenacDto> request, out int PageSize, out int PageNumber, out int TotalReg);
        Response<List<InformeRenacDto>> GetListEspecialistaSsatdotPaginated(Request<InformeRenacDto> request, out int PageSize, out int PageNumber, out int TotalReg);
        Response<List<InformeRenacDto>> GetListSubsecretarioSsatdotDerivacionInformesPaginated(Request<InformeRenacDto> request, out int PageSize, out int PageNumber, out int TotalReg);
        Response<List<InformeRenacDto>> GetListResponsableArchivoSolicitudInformacionPaginated(Request<InformeRenacDto> request, out int PageSize, out int PageNumber, out int TotalReg);
        Response<List<InformeRenacDto>> GetListSubsecretarioSsiatRegistroAnotacionPaginated(Request<InformeRenacDto> request, out int PageSize, out int PageNumber, out int TotalReg);
        Response<bool> UpdateEvaluacionFavorable(Request<InformeRenacDto> request);
        Response<bool> UpdateInformesOpinionFavorable(Request<InformeRenacDto> request);
        Response<bool> VerificarInformeEvaluacionFavorable(Request<InformeRenacDto> request);
        Response<bool> UpdateSolicitudInformacion(Request<InformeRenacDto> request);
        Response<bool> UpdateRegistroAnotacion(Request<InformeRenacDto> request);
        Response<bool> UpdateConstanciaAnotacion(Request<InformeRenacDto> request);
        Response<bool> UpdateConstanciaAnotacionFirmada(Request<InformeRenacDto> request);
        Response<List<InformeRenacDto>> GetListEspecialistaSsiatRegistroFormatosPaginated(Request<InformeRenacDto> request, out int PageSize, out int PageNumber, out int TotalReg);
        Response<bool> UpdateRespuestaGore(Request<InformeRenacDto> request);
        Response<List<InformeRenacDto>> GetListResponsableArchivoRegistroAnotacionPaginated(Request<InformeRenacDto> request, out int PageSize, out int PageNumber, out int TotalReg);
        Response<bool> UpdateCerrarProcesoAnotacion(Request<InformeRenacDto> request);
    }
}
