using FluentValidation;
using PCM.RENAC.Application.Dto;
using PCM.RENAC.Application.Validator;

namespace PCM.RENAC.Api.Modules.Validator
{
    public static class ValidatorExtensions
    {
        public static IServiceCollection AddValidator(this IServiceCollection services)
        {
            services.AddTransient<IValidator<TipoAsientoInsertRequest>, TipoAsientoInsertRequestValidator>();
            services.AddTransient<IValidator<TipoAsientoUpdateRequest>, TipoAsientoUpdateRequestValidator>();
            services.AddTransient<IValidator<TipoAsientoIdRequest>, TipoAsientoIdRequestValidator>();
            services.AddTransient<TipoAsientoValidationManager>();

            services.AddTransient<IValidator<InformeRenacInsertRequest>, InformeRenacInsertRequestValidator>();
            services.AddTransient<IValidator<InformeRenacUpdateRequest>, InformeRenacUpdateRequestValidator>();
            services.AddTransient<IValidator<InformeRenacIdRequest>, InformeRenacIdRequestValidator>();
            services.AddTransient<InformeRenacValidationManager>();

            services.AddTransient<IValidator<AsientoCircunscripcionInsertRequest>, AsientoCircunscripcionInsertRequestValidator>();
            services.AddTransient<IValidator<AsientoCircunscripcionUpdateRequest>, AsientoCircunscripcionUpdateRequestValidator>();
            services.AddTransient<IValidator<AsientoCircunscripcionIdRequest>, AsientoCircunscripcionIdRequestValidator>();
            services.AddTransient<AsientoCircunscripcionValidationManager>();

            services.AddTransient<IValidator<TipoModificacionAsientoInsertRequest>, TipoModificacionAsientoInsertRequestValidator>();
            services.AddTransient<IValidator<TipoModificacionAsientoUpdateRequest>, TipoModificacionAsientoUpdateRequestValidator>();
            services.AddTransient<IValidator<TipoModificacionAsientoIdRequest>, TipoModificacionAsientoIdRequestValidator>();
            services.AddTransient<TipoModificacionAsientoValidationManager>();

            services.AddTransient<IValidator<AsientoModificacionInsertRequest>, AsientoModificacionInsertRequestValidator>();
            services.AddTransient<IValidator<AsientoModificacionUpdateRequest>, AsientoModificacionUpdateRequestValidator>();
            services.AddTransient<IValidator<AsientoModificacionIdRequest>, AsientoModificacionIdRequestValidator>();
            services.AddTransient<AsientoModificacionValidationManager>();

            services.AddTransient<IValidator<CircunscripcionOrigenDestinoInsertRequest>, CircunscripcionOrigenDestinoInsertRequestValidator>();
            services.AddTransient<IValidator<CircunscripcionOrigenDestinoUpdateRequest>, CircunscripcionOrigenDestinoUpdateRequestValidator>();
            services.AddTransient<IValidator<CircunscripcionOrigenDestinoIdRequest>, CircunscripcionOrigenDestinoIdRequestValidator>();
            services.AddTransient<CircunscripcionOrigenDestinoValidationManager>();

            services.AddTransient<IValidator<DerivacionRenacInsertRequest>, DerivacionRenacInsertRequestValidator>();
            services.AddTransient<IValidator<DerivacionRenacUpdateRequest>, DerivacionRenacUpdateRequestValidator>();
            services.AddTransient<IValidator<DerivacionRenacIdRequest>, DerivacionRenacIdRequestValidator>();
            services.AddTransient<DerivacionRenacValidationManager>();

            services.AddTransient<IValidator<DocumentoDerivacionInsertRequest>, DocumentoDerivacionInsertRequestValidator>();
            services.AddTransient<IValidator<DocumentoDerivacionUpdateRequest>, DocumentoDerivacionUpdateRequestValidator>();
            services.AddTransient<IValidator<DocumentoDerivacionIdRequest>, DocumentoDerivacionIdRequestValidator>();
            services.AddTransient<DocumentoDerivacionValidationManager>();

            services.AddTransient<IValidator<InformeDerivacionInsertRequest>, InformeDerivacionInsertRequestValidator>();
            services.AddTransient<IValidator<InformeDerivacionUpdateRequest>, InformeDerivacionUpdateRequestValidator>();
            services.AddTransient<IValidator<InformeDerivacionIdRequest>, InformeDerivacionIdRequestValidator>();
            services.AddTransient<InformeDerivacionValidationManager>();

            services.AddTransient<IValidator<TipoDocumentoRenacInsertRequest>, TipoDocumentoRenacInsertRequestValidator>();
            services.AddTransient<IValidator<TipoDocumentoRenacUpdateRequest>, TipoDocumentoRenacUpdateRequestValidator>();
            services.AddTransient<IValidator<TipoDocumentoRenacIdRequest>, TipoDocumentoRenacIdRequestValidator>();
            services.AddTransient<TipoDocumentoRenacValidationManager>();

            services.AddTransient<IValidator<ParametricasRenacInsertRequest>, ParametricasRenacInsertRequestValidator>();
            services.AddTransient<IValidator<ParametricasRenacUpdateRequest>, ParametricasRenacUpdateRequestValidator>();
            services.AddTransient<IValidator<ParametricasRenacIdRequest>, ParametricasRenacIdRequestValidator>();
            services.AddTransient<ParametricasRenacValidationManager>();

            return services;
        }
    }
}
