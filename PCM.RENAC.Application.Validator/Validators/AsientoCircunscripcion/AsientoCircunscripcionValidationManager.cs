using FluentValidation.Results;
using PCM.RENAC.Application.Dto;

namespace PCM.RENAC.Application.Validator
{
    public class AsientoCircunscripcionValidationManager
    {
        private readonly AsientoCircunscripcionIdRequestValidator _asientoCircunscripcionIdRequestValidator;
        private readonly AsientoCircunscripcionInsertRequestValidator _asientoCircunscripcionInsertRequestValidator;
        private readonly AsientoCircunscripcionUpdateRequestValidator _asientoCircunscripcionUpdateRequestValidator;

        public AsientoCircunscripcionValidationManager()
        {
            _asientoCircunscripcionIdRequestValidator = new AsientoCircunscripcionIdRequestValidator();
            _asientoCircunscripcionInsertRequestValidator = new AsientoCircunscripcionInsertRequestValidator();
            _asientoCircunscripcionUpdateRequestValidator = new AsientoCircunscripcionUpdateRequestValidator();
        }

        public ValidationResult Validate(AsientoCircunscripcionIdRequest entidad)
        {
            return _asientoCircunscripcionIdRequestValidator.Validate(entidad);
        }
        public ValidationResult Validate(AsientoCircunscripcionInsertRequest entidad)
        {
            return _asientoCircunscripcionInsertRequestValidator.Validate(entidad);
        }
        public ValidationResult Validate(AsientoCircunscripcionUpdateRequest entidad)
        {
            return _asientoCircunscripcionUpdateRequestValidator.Validate(entidad);
        }
    }
}
