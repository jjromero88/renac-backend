using FluentValidation.Results;
using PCM.RENAC.Application.Dto;

namespace PCM.RENAC.Application.Validator
{
    public class InformeRenacValidationManager
    {
        private readonly InformeRenacIdRequestValidator _informeRenacIdRequestValidator;
        private readonly InformeRenacInsertRequestValidator _informeRenacInsertRequestValidator;
        private readonly InformeRenacUpdateRequestValidator _informeRenacUpdateRequestValidator;
        private readonly UpdateEvaluacionFavorableRequestValidator _updateEvaluacionFavorableRequestValidator;
        public readonly UpdateInformesOpinionFavorableRequestValidator _updateInformesOpinionFavorableRequestValidator;
        public readonly VerificarInformeEvaluacionFavorableRequestValidator _verificarInformeEvaluacionFavorableRequestValidator;
        public readonly UpdateSolicitudInformacionRequestValidator _updateSolicitudInformacionRequestValidator;
        public readonly UpdateConstanciaAnotacionRequestValidator _updateConstanciaAnotacionRequestValidator;
        public readonly UpdateRespuestaGoreRequestValidator _updateRespuestaGoreRequestValidator;
        public readonly UpdateRegistroAnotacionRequestValidator _updateRegistroAnotacionRequestValidator;
        public readonly UpdateConstanciaAnotacionFirmadaRequestValidator _updateConstanciaAnotacionFirmadaRequestValidator;
        public readonly CerrarProcesoAnotacionRequestValidator _cerrarProcesoAnotacionRequestValidator;

        public InformeRenacValidationManager()
        {
            _informeRenacIdRequestValidator = new InformeRenacIdRequestValidator();
            _informeRenacInsertRequestValidator = new InformeRenacInsertRequestValidator();
            _informeRenacUpdateRequestValidator = new InformeRenacUpdateRequestValidator();
            _updateEvaluacionFavorableRequestValidator = new UpdateEvaluacionFavorableRequestValidator();
            _updateInformesOpinionFavorableRequestValidator = new UpdateInformesOpinionFavorableRequestValidator();
            _verificarInformeEvaluacionFavorableRequestValidator = new VerificarInformeEvaluacionFavorableRequestValidator();
            _updateSolicitudInformacionRequestValidator = new UpdateSolicitudInformacionRequestValidator();
            _updateConstanciaAnotacionRequestValidator = new UpdateConstanciaAnotacionRequestValidator();
            _updateRespuestaGoreRequestValidator = new UpdateRespuestaGoreRequestValidator();
            _updateRegistroAnotacionRequestValidator = new UpdateRegistroAnotacionRequestValidator();
            _updateConstanciaAnotacionFirmadaRequestValidator = new UpdateConstanciaAnotacionFirmadaRequestValidator();
            _cerrarProcesoAnotacionRequestValidator = new CerrarProcesoAnotacionRequestValidator();
        }

        public ValidationResult Validate(InformeRenacInsertRequest entidad)
        {
            return _informeRenacInsertRequestValidator.Validate(entidad);
        }
        public ValidationResult Validate(InformeRenacUpdateRequest entidad)
        {
            return _informeRenacUpdateRequestValidator.Validate(entidad);
        }
        public ValidationResult Validate(InformeRenacIdRequest entidad)
        {
            return _informeRenacIdRequestValidator.Validate(entidad);
        }
        public ValidationResult Validate(UpdateEvaluacionFavorableRequest entidad)
        {
            return _updateEvaluacionFavorableRequestValidator.Validate(entidad);
        }
        public ValidationResult Validate(UpdateInformesOpinionFavorableRequest entidad)
        {
            return _updateInformesOpinionFavorableRequestValidator.Validate(entidad);
        }
        public ValidationResult Validate(VerificarInformeEvaluacionFavorableRequest entidad)
        {
            return _verificarInformeEvaluacionFavorableRequestValidator.Validate(entidad);
        }
        public ValidationResult Validate(UpdateSolicitudInformacionRequest entidad)
        {
            return _updateSolicitudInformacionRequestValidator.Validate(entidad);
        }
        public ValidationResult Validate(UpdateConstanciaAnotacionRequest entidad)
        {
            return _updateConstanciaAnotacionRequestValidator.Validate(entidad);
        }
        public ValidationResult Validate(UpdateRespuestaGoreRequest entidad)
        {
            return _updateRespuestaGoreRequestValidator.Validate(entidad);
        }
        public ValidationResult Validate(UpdateRegistroAnotacionRequest entidad)
        {
            return _updateRegistroAnotacionRequestValidator.Validate(entidad);
        }
        public ValidationResult Validate(UpdateConstanciaAnotacionFirmadaRequest entidad)
        {
            return _updateConstanciaAnotacionFirmadaRequestValidator.Validate(entidad);
        }
        public ValidationResult Validate(CerrarProcesoAnotacionRequest entidad)
        {
            return _cerrarProcesoAnotacionRequestValidator.Validate(entidad);
        }
    }
}
