using FluentValidation;
using PCM.RENAC.Application.Control.Util;
using PCM.RENAC.Application.Dto;

namespace PCM.RENAC.Application.Validator
{
    public class InformeRenacIdRequestValidator : AbstractValidator<InformeRenacIdRequest>
    {
        public InformeRenacIdRequestValidator()
        {
            RuleFor(u => u.idInformeRenac)
                  .NotNull().Must(x => x.HasValue)
                  .WithMessage("Debe ingresar el Id");
        }
    }

    public class InformeRenacInsertRequestValidator : AbstractValidator<InformeRenacInsertRequest>
    {
        public InformeRenacInsertRequestValidator()
        {
            RuleFor(u => u.idCircunscripcion)
                .NotNull().Must(x => x.HasValue)
                .WithMessage("Debe seleccionar la circunscripcion");

            RuleFor(u => u.numero)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe ingresar el numero de informe");

            RuleFor(u => u.InformeAnotacionBase64)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe subir un informe");

            RuleFor(u => u.fecha)
                .NotNull().WithMessage("Debe ingresar la fecha")
                .Must(fecha => fecha != DateTime.MinValue)
                .WithMessage("Debe ingresar una fecha válida");

            RuleFor(x => x.numero)
                .MaximumLength(20)
                .WithMessage("La descripcion debe tener máximo 20 caracteres");

            RuleFor(x => x.descripcion)
                .MaximumLength(250)
                .WithMessage("La descripcion debe tener máximo 250 caracteres");
        }
    }

    public class InformeRenacUpdateRequestValidator : AbstractValidator<InformeRenacUpdateRequest>
    {
        public InformeRenacUpdateRequestValidator()
        {
            RuleFor(u => u.idInformeRenac)
                .NotNull().Must(x => x.HasValue)
                .WithMessage("Debe ingresar el Id");

            RuleFor(u => u.idCircunscripcion)
                .NotNull().Must(x => x.HasValue)
                .WithMessage("Debe seleccionar la circunscripcion");

            RuleFor(u => u.numero)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe ingresar el numero de informe");

            RuleFor(u => u.fecha)
                .NotNull().WithMessage("Debe ingresar la fecha")
                .Must(fecha => fecha != DateTime.MinValue)
                .WithMessage("Debe ingresar una fecha válida");

            RuleFor(x => x.numero)
                .MaximumLength(20)
                .WithMessage("La descripcion debe tener máximo 20 caracteres");

            RuleFor(x => x.descripcion)
                .MaximumLength(250)
                .WithMessage("La descripcion debe tener máximo 250 caracteres");
        }
    }

    public class UpdateEvaluacionFavorableRequestValidator : AbstractValidator<UpdateEvaluacionFavorableRequest>
    {
        public UpdateEvaluacionFavorableRequestValidator()
        {
            RuleFor(u => u.idInformeRenac)
                .NotNull().Must(x => x.HasValue)
                .WithMessage("Debe seleccionar un informe");

            RuleFor(u => u.evaluacionFavorable)
                .NotNull().Must(x => x.HasValue)
                .WithMessage("Debe colocar la evaluacion favorable");
        }
    }

    public class UpdateInformesOpinionFavorableRequestValidator : AbstractValidator<UpdateInformesOpinionFavorableRequest>
    {
        public UpdateInformesOpinionFavorableRequestValidator()
        {
            RuleFor(u => u.informeFavorableArchivo)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe ingresar el numero de informe");

            RuleFor(u => u.informeFavorableNumero)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe ingresar el numero de informe");

            RuleFor(u => u.informeFavorableArchivo)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe ingresar el numero de informe");

            RuleFor(u => u.informeFavorableFecha)
                .NotNull().WithMessage("Debe ingresar la fecha")
                .Must(fecha => fecha != DateTime.MinValue)
                .WithMessage("Debe ingresar una fecha válida");

            RuleFor(u => u.listaInformesRenac)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe seleccionar al menos un informe");

            RuleFor(u => u.informeFavorableArchivoBase64)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe seleccionar el informe de opinion favorable");
        }
    }

    public class VerificarInformeEvaluacionFavorableRequestValidator : AbstractValidator<VerificarInformeEvaluacionFavorableRequest>
    {
        public VerificarInformeEvaluacionFavorableRequestValidator()
        {
            RuleFor(u => u.listaInformesRenac)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe seleccionar al menos un informe");
        }
    }

    public class UpdateSolicitudInformacionRequestValidator : AbstractValidator<UpdateSolicitudInformacionRequest>
    {
        public UpdateSolicitudInformacionRequestValidator()
        {
            RuleFor(u => u.oficioSolicitudNumero)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe ingresar el numero de la solicitud");

            RuleFor(u => u.oficioSolicitudFecha)
                .NotNull().WithMessage("Debe ingresar la fecha")
                .Must(fecha => fecha != DateTime.MinValue)
                .WithMessage("Debe ingresar una fecha válida");

            RuleFor(u => u.evidenciaSolicitudFecha)
                .NotNull().WithMessage("Debe ingresar la fecha")
                .Must(fecha => fecha != DateTime.MinValue)
                .WithMessage("Debe ingresar una fecha válida");

            RuleFor(u => u.listaInformesRenac)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe seleccionar al menos un informe");

            RuleFor(x => x.oficioSolicitudNumero)
                .MaximumLength(20)
                .WithMessage("El numero de la solicitud debe tener máximo 20 caracteres");

            //RuleFor(u => u.oficioSolicitudArchivoBase64)
            //    .IsNullOrWhiteSpace()
            //    .WithMessage("Debe seleccionar el oficio de solicitud");

            //RuleFor(u => u.evidenciaSolicitudArchivoBase64)
            //    .IsNullOrWhiteSpace()
            //    .WithMessage("Debe seleccionar la evidencia de solicitud");
        }
    }

    public class UpdateConstanciaAnotacionRequestValidator : AbstractValidator<UpdateConstanciaAnotacionRequest>
    {
        public UpdateConstanciaAnotacionRequestValidator()
        {
            RuleFor(u => u.idInformeRenac)
                  .NotNull().Must(x => x.HasValue)
                  .WithMessage("Debe ingresar el Id");

            RuleFor(u => u.constanciaAnotacionBase64)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe seleccionar la Constancia de anotación");
        }
    }

    public class UpdateRespuestaGoreRequestValidator : AbstractValidator<UpdateRespuestaGoreRequest>
    {
        public UpdateRespuestaGoreRequestValidator()
        {
           
            RuleFor(u => u.respuestaGoreNumero)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe ingresar el numero de la respuesta GORE");

            RuleFor(u => u.respuestaGoreFecha)
               .NotNull().WithMessage("Debe ingresar una fecha")
               .Must(fecha => fecha != DateTime.MinValue)
               .WithMessage("Debe ingresar una fecha válida");

            //RuleFor(u => u.respuestaGoreBase64)
            //    .IsNullOrWhiteSpace()
            //    .WithMessage("Debe subir el documento de respuesta de GORE");

            RuleFor(u => u.respuestaGoreBase64)
            .Must((request, respuestaGoreBase64) =>
            {
                if (request.idInformeRenac == null)
                    return !string.IsNullOrWhiteSpace(respuestaGoreBase64);

                return true;
            }).WithMessage("Debe subir el documento de respuesta GORE");

            RuleFor(x => x.respuestaGoreNumero)
                .MaximumLength(20)
                .WithMessage("El número debe tener máximo 20 caracteres");

            RuleFor(u => u.listaInformesRenac)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe seleccionar al menos un informe");

        }
    }

    public class UpdateRegistroAnotacionRequestValidator : AbstractValidator<UpdateRegistroAnotacionRequest>
    {
        public UpdateRegistroAnotacionRequestValidator()
        {
            RuleFor(u => u.oficioAnotacionNumero)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe ingresar el numero de la solicitud");

            RuleFor(u => u.oficioAnotacionFecha)
                .NotNull().WithMessage("Debe ingresar la fecha")
                .Must(fecha => fecha != DateTime.MinValue)
                .WithMessage("Debe ingresar una fecha válida");

            RuleFor(u => u.evidenciaAnotacionFecha)
                .NotNull().WithMessage("Debe ingresar la fecha")
                .Must(fecha => fecha != DateTime.MinValue)
                .WithMessage("Debe ingresar una fecha válida");

            RuleFor(u => u.listaInformesRenac)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe seleccionar al menos un informe");

            RuleFor(x => x.oficioAnotacionNumero)
                .MaximumLength(20)
                .WithMessage("El numero de la solicitud debe tener máximo 20 caracteres");

            RuleFor(u => u.oficioAnotacionArchivoBase64)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe seleccionar el oficio para la anotación");

            RuleFor(u => u.evidenciaAnotacionArchivoBase64)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe seleccionar la evidencia para la anotación");
        }
    }

    public class UpdateConstanciaAnotacionFirmadaRequestValidator : AbstractValidator<UpdateConstanciaAnotacionFirmadaRequest>
    {
        public UpdateConstanciaAnotacionFirmadaRequestValidator()
        {
            RuleFor(u => u.idInformeRenac)
                  .NotNull().Must(x => x.HasValue)
                  .WithMessage("Debe ingresar el Id");

            RuleFor(u => u.constanciaAnotacionFirmadaFecha)
                .NotNull().WithMessage("Debe ingresar la fecha")
                .Must(fecha => fecha != DateTime.MinValue)
                .WithMessage("Debe ingresar una fecha válida");

            //RuleFor(u => u.constanciaAnotacionFirmadaArchivo64)
            //    .IsNullOrWhiteSpace()
            //    .WithMessage("Debe seleccionar la Constancia de anotación firmada digitalmente");
        }
    }

    public class CerrarProcesoAnotacionRequestValidator : AbstractValidator<CerrarProcesoAnotacionRequest>
    {
        public CerrarProcesoAnotacionRequestValidator()
        {
            RuleFor(u => u.listaInformesRenac)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe seleccionar al menos un informe");
        }
    }

}
