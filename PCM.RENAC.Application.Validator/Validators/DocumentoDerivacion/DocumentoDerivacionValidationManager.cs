using FluentValidation.Results;
using PCM.RENAC.Application.Dto;

namespace PCM.RENAC.Application.Validator
{
    public class DocumentoDerivacionValidationManager
    {
        private readonly DocumentoDerivacionIdRequestValidator _DocumentoDerivacionIdRequestValidator;
        private readonly DocumentoDerivacionInsertRequestValidator _DocumentoDerivacionInsertRequestValidator;
        private readonly DocumentoDerivacionUpdateRequestValidator _DocumentoDerivacionUpdateRequestValidator;

        public DocumentoDerivacionValidationManager()
        {
            _DocumentoDerivacionIdRequestValidator = new DocumentoDerivacionIdRequestValidator();
            _DocumentoDerivacionInsertRequestValidator = new DocumentoDerivacionInsertRequestValidator();
            _DocumentoDerivacionUpdateRequestValidator = new DocumentoDerivacionUpdateRequestValidator();
        }

        public ValidationResult Validate(DocumentoDerivacionInsertRequest entidad)
        {
            return _DocumentoDerivacionInsertRequestValidator.Validate(entidad);
        }
        public ValidationResult Validate(DocumentoDerivacionUpdateRequest entidad)
        {
            return _DocumentoDerivacionUpdateRequestValidator.Validate(entidad);
        }
        public ValidationResult Validate(DocumentoDerivacionIdRequest entidad)
        {
            return _DocumentoDerivacionIdRequestValidator.Validate(entidad);
        }
    }
}
