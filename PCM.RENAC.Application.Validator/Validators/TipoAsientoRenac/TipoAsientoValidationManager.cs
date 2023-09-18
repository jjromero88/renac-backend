using FluentValidation.Results;
using PCM.RENAC.Application.Dto;

namespace PCM.RENAC.Application.Validator
{
    public class TipoAsientoValidationManager
    {
        private readonly TipoAsientoIdRequestValidator _tipoAsientoIdRequestValidator;
        private readonly TipoAsientoInsertRequestValidator _tipoAsientoInsertRequestValidator;
        private readonly TipoAsientoUpdateRequestValidator _tipoAsientoUpdateRequestValidator;

        public TipoAsientoValidationManager()
        {
            _tipoAsientoIdRequestValidator = new TipoAsientoIdRequestValidator();
            _tipoAsientoInsertRequestValidator = new TipoAsientoInsertRequestValidator();
            _tipoAsientoUpdateRequestValidator = new TipoAsientoUpdateRequestValidator();
        }

        public ValidationResult Validate(TipoAsientoInsertRequest entidad)
        {
            return _tipoAsientoInsertRequestValidator.Validate(entidad);
        }
        public ValidationResult Validate(TipoAsientoUpdateRequest entidad)
        {
            return _tipoAsientoUpdateRequestValidator.Validate(entidad);
        }
        public ValidationResult Validate(TipoAsientoIdRequest entidad)
        {
            return _tipoAsientoIdRequestValidator.Validate(entidad);
        }
    }
}
