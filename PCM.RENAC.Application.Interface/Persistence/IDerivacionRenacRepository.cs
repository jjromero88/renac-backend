using PCM.RENAC.Domain.Entities;
using PCM.RENAC.Transversal.Common;

namespace PCM.RENAC.Application.Interface.Persistence
{
    public interface IDerivacionRenacRepository : IGenericRepository<DerivacionRenac>
    {
        Response DerivacionEspecialistaSSIAT(DerivacionRenac entidad);
        Response DerivacionSubsecretarioSSIAT(DerivacionRenac entidad);
        Response DerivacionAjustesSubsecretarioSSIAT(DerivacionRenac entidad);
        Response DerivacionSubsecretarioSSATDOT(DerivacionRenac entidad);
        Response DerivacionEspecialistaSSATDOT(DerivacionRenac entidad);
        Response DerivacionAjustesEspecialistaSSATDOT(DerivacionRenac entidad);
        Response DerivacionAjustesSubsecretarioSSATDOT(DerivacionRenac entidad);
        Response DerivacionInformesSubsecretarioSSATDOT(DerivacionRenac entidad);
        Response DerivacionInformesResponsableArchivo(DerivacionRenac entidad);
        Response DerivacionModificacionEspecialistaSSIAT(DerivacionRenac entidad);
        Response DerivacionParaAnotacionEspecialistaSSIAT(DerivacionRenac entidad);
        Response DerivacionParaAnotacionSubsecretarioSSIAT(DerivacionRenac entidad);
    }
}
