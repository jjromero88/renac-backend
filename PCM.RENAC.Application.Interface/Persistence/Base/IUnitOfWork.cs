using PCM.RENAC.Domain.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PCM.RENAC.Application.Interface.Persistence
{
    public interface IUnitOfWork : IDisposable
    {
        //RENAC
        ITipoAsientoRepository TipoAsiento { get; }
        IInformeRenacRepository InformeRenac { get; }
        IAsientoCircunscripcionRepository AsientoCircunscripcion { get; }
        ITipoModificacionAsientoRepository TipoModificacionAsiento { get; }
        IAsientoModificacionRepository AsientoModificacion { get; }
        ICircunscripcionOrigenDestinoRepository CircunscripcionOrigenDestino { get; }
        IDerivacionRenacRepository DerivacionRenac { get; }
        IInformeDerivacionRepository InformeDerivacion { get; }
        IDocumentoDerivacionRepository DocumentoDerivacion { get; }
        ITipoDocumentoRenacRepository TipoDocumentoRenac { get; }
        IParametricasRenacRepository ParametricasRenac { get; }
        IConstanciaAnotacionRepository ConstanciaAnotacion { get; }

        //RENLIM
        ICircunscripcionRepository Circunscripcion { get;}
        ITipoCircunscripcionRepository TipoCircunscripcion { get; }
        ITipoDispositivoRepository TipoDispositivo { get; }
        INormaRepository Norma { get; }
    }
}
