using PCM.RENAC.Application.Interface.Persistence;

namespace PCM.RENAC.Persistence.Repository.Base
{
    public class UnitOfWork : IUnitOfWork
    {
        public ITipoAsientoRepository TipoAsiento { get; }
        public IInformeRenacRepository InformeRenac { get; }
        public IAsientoCircunscripcionRepository AsientoCircunscripcion { get; }
        public ITipoModificacionAsientoRepository TipoModificacionAsiento { get; }
        public IAsientoModificacionRepository AsientoModificacion { get; }
        public ICircunscripcionOrigenDestinoRepository CircunscripcionOrigenDestino { get; }
        public ICircunscripcionRepository Circunscripcion { get; }
        public ITipoCircunscripcionRepository TipoCircunscripcion { get; }
        public ITipoDispositivoRepository TipoDispositivo { get; }
        public INormaRepository Norma { get; }
        public IDerivacionRenacRepository DerivacionRenac { get; }
        public IInformeDerivacionRepository InformeDerivacion { get; }
        public IDocumentoDerivacionRepository DocumentoDerivacion { get; }
        public ITipoDocumentoRenacRepository TipoDocumentoRenac { get; }
        public IParametricasRenacRepository ParametricasRenac { get; }
        public IConstanciaAnotacionRepository ConstanciaAnotacion { get; }

        public UnitOfWork(ITipoAsientoRepository tipoasiento,
                          IInformeRenacRepository informeRenac,
                          IAsientoCircunscripcionRepository asientoCircunscripcion,
                          ITipoModificacionAsientoRepository tipoModificacionAsiento,
                          IAsientoModificacionRepository asientoModificacion,
                          ICircunscripcionOrigenDestinoRepository circunscripcionOrigenDestino,
                          ICircunscripcionRepository circunscripcion,
                          ITipoCircunscripcionRepository tipoCircunscripcion,
                          ITipoDispositivoRepository tipoDispositivo,
                          INormaRepository norma,
                          IDerivacionRenacRepository derivacionRenac,
                          IInformeDerivacionRepository informeDerivacion,
                          IDocumentoDerivacionRepository documentoDerivacion,
                          ITipoDocumentoRenacRepository tipoDocumentoRenac,
                          IParametricasRenacRepository parametricasRenac,
                          IConstanciaAnotacionRepository constanciaAnotacion
                          )
        {
            TipoAsiento = tipoasiento;
            InformeRenac = informeRenac;
            AsientoCircunscripcion = asientoCircunscripcion;
            TipoModificacionAsiento = tipoModificacionAsiento;
            AsientoModificacion = asientoModificacion;
            CircunscripcionOrigenDestino = circunscripcionOrigenDestino;
            Circunscripcion = circunscripcion;
            TipoCircunscripcion = tipoCircunscripcion;
            TipoDispositivo = tipoDispositivo;
            Norma = norma;
            DerivacionRenac = derivacionRenac;
            InformeDerivacion = informeDerivacion;
            DocumentoDerivacion = documentoDerivacion;
            TipoDocumentoRenac = tipoDocumentoRenac;
            ParametricasRenac = parametricasRenac;
            ConstanciaAnotacion = constanciaAnotacion;
        }

        public void Dispose()
        {
            GC.SuppressFinalize(this);
        }
    }
}
