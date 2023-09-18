using PCM.RENAC.Domain.Entities;
using PCM.RENAC.Transversal.Common;

namespace PCM.RENAC.Application.Interface.Persistence
{
    public interface IInformeRenacRepository : IGenericRepository<InformeRenac>
    {
        Response VerificarInformeEvaluacionFavorable(InformeRenac entidad);
        Response UpdateEvaluacionFavorable(InformeRenac entidad);
        Response UpdateInformesOpinionFavorable(InformeRenac entidad);
        Response UpdateSolicitudInformacion(InformeRenac entidad);
        Response UpdateRegistroAnotacion(InformeRenac entidad);
        Response UpdateConstanciaAnotacion(InformeRenac entidad);
        Response UpdateConstanciaAnotacionFirmada(InformeRenac entidad);
        Response UpdateRespuestaGore(InformeRenac entidad);
        Response UpdateCerrarProcesoAnotacion(InformeRenac entidad);
        Response<dynamic> GetListInformacionSsiatDocumentos(InformeRenac entidad);
        Response<List<dynamic>> GetListEspecialistaSsiatPaginated(InformeRenac entidad, out int PageSize, out int PageNumber, out int TotalReg);
        Response<List<dynamic>> GetListSubsecretarioSsiatPaginated(InformeRenac entidad, out int PageSize, out int PageNumber, out int TotalReg);
        Response<List<dynamic>> GetListSubsecretarioSsatdotPaginated(InformeRenac entidad, out int PageSize, out int PageNumber, out int TotalReg);
        Response<List<dynamic>> GetListEspecialistaSsatdotPaginated(InformeRenac entidad, out int PageSize, out int PageNumber, out int TotalReg);
        Response<List<dynamic>> GetListSubsecretarioSsatdotDerivacionInformesPaginated(InformeRenac entidad, out int PageSize, out int PageNumber, out int TotalReg);
        Response<List<dynamic>> GetListResponsableArchivoSolicitudInformacionPaginated(InformeRenac entidad, out int PageSize, out int PageNumber, out int TotalReg);
        Response<List<dynamic>> GetListEspecialistaSsiatRegistroFormatosPaginated(InformeRenac entidad, out int PageSize, out int PageNumber, out int TotalReg);
        Response<List<dynamic>> GetListSubsecretarioSsiatRegistroAnotacionPaginated(InformeRenac entidad, out int PageSize, out int PageNumber, out int TotalReg);
        Response<List<dynamic>> GetListResponsableArchivoRegistroAnotacionPaginated(InformeRenac entidad, out int PageSize, out int PageNumber, out int TotalReg);
    }
}
