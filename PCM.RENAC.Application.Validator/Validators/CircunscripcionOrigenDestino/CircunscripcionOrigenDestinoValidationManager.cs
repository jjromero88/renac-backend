using FluentValidation.Results;
using PCM.RENAC.Application.Dto;

namespace PCM.RENAC.Application.Validator
{
    public  class CircunscripcionOrigenDestinoValidationManager
    {
        private readonly CircunscripcionOrigenDestinoIdRequestValidator _circunscripcionOrigenDestinoIdRequestValidator;
        private readonly CircunscripcionOrigenDestinoInsertRequestValidator _circunscripcionOrigenDestinoInsertRequestValidator;
        private readonly CircunscripcionOrigenDestinoUpdateRequestValidator _circunscripcionOrigenDestinoUpdateRequestValidator;

        public CircunscripcionOrigenDestinoValidationManager()
        {
            _circunscripcionOrigenDestinoIdRequestValidator = new CircunscripcionOrigenDestinoIdRequestValidator();
            _circunscripcionOrigenDestinoInsertRequestValidator = new CircunscripcionOrigenDestinoInsertRequestValidator();
            _circunscripcionOrigenDestinoUpdateRequestValidator = new CircunscripcionOrigenDestinoUpdateRequestValidator();
        }

        public ValidationResult Validate(CircunscripcionOrigenDestinoInsertRequest entidad)
        {
            return _circunscripcionOrigenDestinoInsertRequestValidator.Validate(entidad);
        }
        public ValidationResult Validate(CircunscripcionOrigenDestinoUpdateRequest entidad)
        {
            return _circunscripcionOrigenDestinoUpdateRequestValidator.Validate(entidad);
        }
        public ValidationResult Validate(CircunscripcionOrigenDestinoIdRequest entidad)
        {
            return _circunscripcionOrigenDestinoIdRequestValidator.Validate(entidad);
        }
    }
}
