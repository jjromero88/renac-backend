using FluentValidation.Results;
using PCM.RENAC.Application.Dto;

namespace PCM.RENAC.Application.Validator
{
    public class ParametricasRenacValidationManager
    {
        private readonly ParametricasRenacIdRequestValidator _ParametricasRenacIdRequestValidator;
        private readonly ParametricasRenacInsertRequestValidator _ParametricasRenacInsertRequestValidator;
        private readonly ParametricasRenacUpdateRequestValidator _ParametricasRenacUpdateRequestValidator;

        public ParametricasRenacValidationManager()
        {
            _ParametricasRenacIdRequestValidator = new ParametricasRenacIdRequestValidator();
            _ParametricasRenacInsertRequestValidator = new ParametricasRenacInsertRequestValidator();
            _ParametricasRenacUpdateRequestValidator = new ParametricasRenacUpdateRequestValidator();
        }
        public ValidationResult Validate(ParametricasRenacInsertRequest entidad)
        {
            return _ParametricasRenacInsertRequestValidator.Validate(entidad);
        }
        public ValidationResult Validate(ParametricasRenacUpdateRequest entidad)
        {
            return _ParametricasRenacUpdateRequestValidator.Validate(entidad);
        }
        public ValidationResult Validate(ParametricasRenacIdRequest entidad)
        {
            return _ParametricasRenacIdRequestValidator.Validate(entidad);
        }

    }
}
