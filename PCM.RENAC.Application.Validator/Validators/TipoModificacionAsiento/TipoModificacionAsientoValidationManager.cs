using FluentValidation.Results;
using PCM.RENAC.Application.Dto;

namespace PCM.RENAC.Application.Validator
{
    public class TipoModificacionAsientoValidationManager
    {
        private readonly TipoModificacionAsientoIdRequestValidator _tipoModificacionAsientoIdRequestValidator;
        private readonly TipoModificacionAsientoInsertRequestValidator _tipoModificacionAsientoInsertRequestValidator;
        private readonly TipoModificacionAsientoUpdateRequestValidator _tipoModificacionAsientoUpdateRequestValidator;

        public TipoModificacionAsientoValidationManager()
        {
            _tipoModificacionAsientoIdRequestValidator = new TipoModificacionAsientoIdRequestValidator();
            _tipoModificacionAsientoInsertRequestValidator = new TipoModificacionAsientoInsertRequestValidator();
            _tipoModificacionAsientoUpdateRequestValidator = new TipoModificacionAsientoUpdateRequestValidator();
        }

        public ValidationResult Validate(TipoModificacionAsientoInsertRequest entidad)
        {
            return _tipoModificacionAsientoInsertRequestValidator.Validate(entidad);
        }
        public ValidationResult Validate(TipoModificacionAsientoUpdateRequest entidad)
        {
            return _tipoModificacionAsientoUpdateRequestValidator.Validate(entidad);
        }
        public ValidationResult Validate(TipoModificacionAsientoIdRequest entidad)
        {
            return _tipoModificacionAsientoIdRequestValidator.Validate(entidad);
        }
    }
}
