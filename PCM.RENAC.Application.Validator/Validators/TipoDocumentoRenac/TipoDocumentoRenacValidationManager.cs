using FluentValidation.Results;
using PCM.RENAC.Application.Dto;

namespace PCM.RENAC.Application.Validator
{
    public class TipoDocumentoRenacValidationManager
    {
        private readonly TipoDocumentoRenacIdRequestValidator _TipoDocumentoRenacIdRequestValidator;
        private readonly TipoDocumentoRenacInsertRequestValidator _TipoDocumentoRenacInsertRequestValidator;
        private readonly TipoDocumentoRenacUpdateRequestValidator _TipoDocumentoRenacUpdateRequestValidator;

        public TipoDocumentoRenacValidationManager()
        {
            _TipoDocumentoRenacIdRequestValidator = new TipoDocumentoRenacIdRequestValidator();
            _TipoDocumentoRenacInsertRequestValidator = new TipoDocumentoRenacInsertRequestValidator();
            _TipoDocumentoRenacUpdateRequestValidator = new TipoDocumentoRenacUpdateRequestValidator();
        }

        public ValidationResult Validate(TipoDocumentoRenacInsertRequest entidad)
        {
            return _TipoDocumentoRenacInsertRequestValidator.Validate(entidad);
        }
        public ValidationResult Validate(TipoDocumentoRenacUpdateRequest entidad)
        {
            return _TipoDocumentoRenacUpdateRequestValidator.Validate(entidad);
        }
        public ValidationResult Validate(TipoDocumentoRenacIdRequest entidad)
        {
            return _TipoDocumentoRenacIdRequestValidator.Validate(entidad);
        }
    }
}
