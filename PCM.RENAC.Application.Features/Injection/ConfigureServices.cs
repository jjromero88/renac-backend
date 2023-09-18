using Microsoft.Extensions.DependencyInjection;
using PCM.RENAC.Application.Interface.Features;
using PCM.RENAC.Domain.Entities;

namespace PCM.RENAC.Application.Features
{
    public static class ConfigureServices
    {
        public static IServiceCollection AddApplicationServices(this IServiceCollection services)
        {
            services.AddScoped<ITipoAsientoApplication, TipoAsientoApplication>();
            services.AddScoped<IInformeRenacApplication, InformeRenacApplication>();
            services.AddScoped<IAsientoCircunscripcionApplication, AsientoCircunscripcionApplication>();
            services.AddScoped<ITipoModificacionAsientoApplication, TipoModificacionAsientoApplication>();
            services.AddScoped<IAsientoModificacionApplication, AsientoModificacionApplication>();
            services.AddScoped<ICircunscripcionOrigenDestinoApplication, CircunscripcionOrigenDestinoApplication>();
            services.AddScoped<ICircunscripcionApplication, CircunscripcionApplication>();
            services.AddScoped<ITipoCircunscripcionApplication, TipoCircunscripcionApplication>();
            services.AddScoped<ITipoDispositivoApplication, TipoDispositivoApplication>();
            services.AddScoped<IDerivacionRenacApplication, DerivacionRenacApplication>();
            services.AddScoped<IDocumentoDerivacionApplication, DocumentoDerivacionApplication>();
            services.AddScoped<IInformeDerivacionApplication, InformeDerivacionApplication>();
            services.AddScoped<ITipoDocumentoRenacApplication, TipoDocumentoRenacApplication>();
            services.AddScoped<IParametricasRenacApplication, ParametricasRenacApplication>();
            services.AddScoped<IConstanciaAnotacionApplication, ConstanciaAnotacionApplication>();
            services.AddScoped<INormaApplication, NormaApplication>();

            return services;
        }
    }
}
