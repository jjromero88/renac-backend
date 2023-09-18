using Microsoft.Extensions.DependencyInjection;
using PCM.RENAC.Application.Interface.Persistence;
using PCM.RENAC.Persistence.Context;
using PCM.RENAC.Persistence.Repository;
using PCM.RENAC.Persistence.Repository.Base;

namespace PCM.RENAC.Persistence
{
    public static class ConfigureServices
    {
        public static IServiceCollection AddPersistenceServices(this IServiceCollection services)
        {
            services.AddSingleton<DapperContext>();
            services.AddScoped<ITipoAsientoRepository, TipoAsientoRepository>();
            services.AddScoped<IInformeRenacRepository, InformeRenacRepository>();
            services.AddScoped<IAsientoCircunscripcionRepository, AsientoCircunscripcionRepository>();
            services.AddScoped<ITipoModificacionAsientoRepository, TipoModificacionAsientoRepository>();
            services.AddScoped<IAsientoModificacionRepository, AsientoModificacionRepository>();
            services.AddScoped<ICircunscripcionOrigenDestinoRepository, CircunscripcionOrigenDestinoRepository>();
            services.AddScoped<ICircunscripcionRepository, CircunscripcionRepository>();
            services.AddScoped<ITipoCircunscripcionRepository, TipoCircunscripcionRepository>();
            services.AddScoped<ITipoDispositivoRepository, TipoDispositivoRepository>();
            services.AddScoped<INormaRepository, NormaRepository>();
            services.AddScoped<IDerivacionRenacRepository, DerivacionRenacRepository>();
            services.AddScoped<IInformeDerivacionRepository, InformeDerivacionRepository>();
            services.AddScoped<IDocumentoDerivacionRepository, DocumentoDerivacionRepository>();
            services.AddScoped<ITipoDocumentoRenacRepository, TipoDocumentoRenacRepository>();
            services.AddScoped<IParametricasRenacRepository, ParametricasRenacRepository>();
            services.AddScoped<IConstanciaAnotacionRepository, ConstanciaAnotacionRepository>();
            services.AddScoped<IUnitOfWork, UnitOfWork>();

            return services;
        }
    }
}
