using FluentValidation.Results;
using PCM.RENAC.Application.Dto;

namespace PCM.RENAC.Application.Validator
{
    public class AsientoModificacionValidationManager
    {
        private readonly AsientoModificacionIdRequestValidator _asientoModificacionIdRequestValidator;
        private readonly AsientoModificacionInsertRequestValidator _asientoModificacionInsertRequestValidator;
        private readonly AsientoModificacionUpdateRequestValidator _asientoModificacionUpdateRequestValidator;

        public AsientoModificacionValidationManager()
        {
            _asientoModificacionIdRequestValidator = new AsientoModificacionIdRequestValidator();
            _asientoModificacionInsertRequestValidator = new AsientoModificacionInsertRequestValidator();
            _asientoModificacionUpdateRequestValidator = new AsientoModificacionUpdateRequestValidator();
        }

        public ValidationResult Validate(AsientoModificacionInsertRequest entidad)
        {
            return _asientoModificacionInsertRequestValidator.Validate(entidad);
        }
        public ValidationResult Validate(AsientoModificacionUpdateRequest entidad)
        {
            return _asientoModificacionUpdateRequestValidator.Validate(entidad);
        }
        public ValidationResult Validate(AsientoModificacionIdRequest entidad)
        {
            return _asientoModificacionIdRequestValidator.Validate(entidad);
        }
    }
}
