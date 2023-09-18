using FluentValidation.Results;
using PCM.RENAC.Application.Dto;

namespace PCM.RENAC.Application.Validator
{
    public class InformeDerivacionValidationManager
    {
        private readonly InformeDerivacionIdRequestValidator _InformeDerivacionIdRequestValidator;
        private readonly InformeDerivacionInsertRequestValidator _InformeDerivacionInsertRequestValidator;
        private readonly InformeDerivacionUpdateRequestValidator _InformeDerivacionUpdateRequestValidator;

        public InformeDerivacionValidationManager()
        {
            _InformeDerivacionIdRequestValidator = new InformeDerivacionIdRequestValidator();
            _InformeDerivacionInsertRequestValidator = new InformeDerivacionInsertRequestValidator();
            _InformeDerivacionUpdateRequestValidator = new InformeDerivacionUpdateRequestValidator();
        }

        public ValidationResult Validate(InformeDerivacionInsertRequest entidad)
        {
            return _InformeDerivacionInsertRequestValidator.Validate(entidad);
        }
        public ValidationResult Validate(InformeDerivacionUpdateRequest entidad)
        {
            return _InformeDerivacionUpdateRequestValidator.Validate(entidad);
        }
        public ValidationResult Validate(InformeDerivacionIdRequest entidad)
        {
            return _InformeDerivacionIdRequestValidator.Validate(entidad);
        }
    }
}
