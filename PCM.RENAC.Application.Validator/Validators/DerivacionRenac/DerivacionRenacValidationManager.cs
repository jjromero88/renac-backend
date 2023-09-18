using FluentValidation.Results;
using PCM.RENAC.Application.Dto;

namespace PCM.RENAC.Application.Validator
{
    public class DerivacionRenacValidationManager
    {
        private readonly DerivacionRenacIdRequestValidator _DerivacionRenacIdRequestValidator;
        private readonly DerivacionRenacInsertRequestValidator _DerivacionRenacInsertRequestValidator;
        private readonly DerivacionRenacUpdateRequestValidator _DerivacionRenacUpdateRequestValidator;
        private readonly DerivacionEspecialistaSSIATRequestValidator _derivacionEspecialistaSSIATRequestValidator;
        private readonly DerivacionSubsecretarioSSIATRequestValidator _derivacionSubsecretarioSSIATRequestValidator;
        private readonly DerivacionAjustesSubsecretarioSsiatRequestValidator _derivacionAjustesSubsecretarioSsiatRequestValidator;
        private readonly DerivacionSubsecretarioSSATDOTRequestValidator _derivacionSubsecretarioSSATDOTRequestValidator;
        private readonly DerivacionEspecialistaSSATDOTRequestValidator _derivacionEspecialistaSSATDOTRequestValidator;
        private readonly DerivacionAjustesEspecialistaSsatdotRequestValidator _derivacionAjustesEspecialistaSsatdotRequestValidator;
        private readonly DerivacionAjustesSubsecretarioSsatdotRequestValidator _derivacionAjustesSubsecretarioSsatdotRequestValidator;
        private readonly DerivacionInformesSubsecretarioSsatdotRequestValidator _derivacionInformesSubsecretarioSsatdotRequestValidator;
        private readonly DerivacionInformesResponsableArchivoRequestValidator _derivacionInformesResponsableArchivoRequestValidator;
        private readonly DerivacionModificacionEspecialistaSsiatRequestValidator _derivacionModificacionEspecialistaSsiatRequestValidator;
        private readonly DerivacionParaAnotacionEspecialistaSsiatRequestValidator _derivacionParaAnotacionEspecialistaSsiatRequestValidator;
        private readonly DerivacionParaAnotacionSubsecretarioSsiatRequestValidator _derivacionParaAnotacionSubsecretarioSsiatRequestValidator;

        public DerivacionRenacValidationManager()
        {
            _DerivacionRenacIdRequestValidator = new DerivacionRenacIdRequestValidator();
            _DerivacionRenacInsertRequestValidator = new DerivacionRenacInsertRequestValidator();
            _DerivacionRenacUpdateRequestValidator = new DerivacionRenacUpdateRequestValidator();
            _derivacionEspecialistaSSIATRequestValidator = new DerivacionEspecialistaSSIATRequestValidator();
            _derivacionSubsecretarioSSIATRequestValidator = new DerivacionSubsecretarioSSIATRequestValidator();
            _derivacionAjustesSubsecretarioSsiatRequestValidator = new DerivacionAjustesSubsecretarioSsiatRequestValidator();
            _derivacionSubsecretarioSSATDOTRequestValidator = new DerivacionSubsecretarioSSATDOTRequestValidator();
            _derivacionEspecialistaSSATDOTRequestValidator = new DerivacionEspecialistaSSATDOTRequestValidator();
            _derivacionAjustesEspecialistaSsatdotRequestValidator = new DerivacionAjustesEspecialistaSsatdotRequestValidator();
            _derivacionAjustesSubsecretarioSsatdotRequestValidator = new DerivacionAjustesSubsecretarioSsatdotRequestValidator();
            _derivacionInformesSubsecretarioSsatdotRequestValidator = new DerivacionInformesSubsecretarioSsatdotRequestValidator();
            _derivacionInformesResponsableArchivoRequestValidator = new DerivacionInformesResponsableArchivoRequestValidator();
            _derivacionModificacionEspecialistaSsiatRequestValidator = new DerivacionModificacionEspecialistaSsiatRequestValidator();
            _derivacionParaAnotacionEspecialistaSsiatRequestValidator = new DerivacionParaAnotacionEspecialistaSsiatRequestValidator();
            _derivacionParaAnotacionSubsecretarioSsiatRequestValidator = new DerivacionParaAnotacionSubsecretarioSsiatRequestValidator();
        }

        public ValidationResult Validate(DerivacionRenacInsertRequest entidad)
        {
            return _DerivacionRenacInsertRequestValidator.Validate(entidad);
        }
        public ValidationResult Validate(DerivacionRenacUpdateRequest entidad)
        {
            return _DerivacionRenacUpdateRequestValidator.Validate(entidad);
        }
        public ValidationResult Validate(DerivacionRenacIdRequest entidad)
        {
            return _DerivacionRenacIdRequestValidator.Validate(entidad);
        }
        public ValidationResult Validate(DerivacionEspecialistaSSIATRequest entidad)
        {
            return _derivacionEspecialistaSSIATRequestValidator.Validate(entidad);
        }
        public ValidationResult Validate(DerivacionSubsecretarioSSIATRequest entidad)
        {
            return _derivacionSubsecretarioSSIATRequestValidator.Validate(entidad);
        }
        public ValidationResult Validate(DerivacionAjustesSubsecretarioSsiatRequest entidad)
        {
            return _derivacionAjustesSubsecretarioSsiatRequestValidator.Validate(entidad);
        }
        public ValidationResult Validate(DerivacionSubsecretarioSSATDOTRequest entidad)
        {
            return _derivacionSubsecretarioSSATDOTRequestValidator.Validate(entidad);
        }
        public ValidationResult Validate(DerivacionEspecialistaSSATDOTRequest entidad)
        {
            return _derivacionEspecialistaSSATDOTRequestValidator.Validate(entidad);
        }
        public ValidationResult Validate(DerivacionAjustesEspecialistaSsatdotRequest entidad)
        {
            return _derivacionAjustesEspecialistaSsatdotRequestValidator.Validate(entidad);
        }
        public ValidationResult Validate(DerivacionAjustesSubsecretarioSsatdotRequest entidad)
        {
            return _derivacionAjustesSubsecretarioSsatdotRequestValidator.Validate(entidad);
        }
        public ValidationResult Validate(DerivacionInformesSubsecretarioSsatdotRequest entidad)
        {
            return _derivacionInformesSubsecretarioSsatdotRequestValidator.Validate(entidad);
        }
        public ValidationResult Validate(DerivacionInformesResponsableArchivoRequest entidad)
        {
            return _derivacionInformesResponsableArchivoRequestValidator.Validate(entidad);
        }
        public ValidationResult Validate(DerivacionModificacionEspecialistaSsiatRequest entidad)
        {
            return _derivacionModificacionEspecialistaSsiatRequestValidator.Validate(entidad);
        }
        public ValidationResult Validate(DerivacionParaAnotacionEspecialistaSsiatRequest entidad)
        {
            return _derivacionParaAnotacionEspecialistaSsiatRequestValidator.Validate(entidad);
        }
        public ValidationResult Validate(DerivacionParaAnotacionSubsecretarioSsiatRequest entidad)
        {
            return _derivacionParaAnotacionSubsecretarioSsiatRequestValidator.Validate(entidad);
        }
    }
}
