using FluentValidation;
using PCM.RENAC.Application.Dto;

namespace PCM.RENAC.Application.Validator
{
    public class DerivacionRenacIdRequestValidator : AbstractValidator<DerivacionRenacIdRequest>
    {
        public DerivacionRenacIdRequestValidator()
        {
            RuleFor(u => u.idDerivacionRenac)
                  .NotNull().Must(x => x.HasValue)
                  .WithMessage("Debe ingresar el Id");
        }
    }

    public class DerivacionRenacInsertRequestValidator : AbstractValidator<DerivacionRenacInsertRequest>
    {
        public DerivacionRenacInsertRequestValidator()
        {
            RuleFor(u => u.fechaDerivacion)
                .NotNull().WithMessage("Debe ingresar la fecha")
                .Must(fecha => fecha != DateTime.MinValue)
                .WithMessage("Debe ingresar una fecha válida");

            RuleFor(u => u.usuarioOrigen)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe ingresar el usuario que deriva");

            RuleFor(u => u.usuarioDestino)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe ingresar el usuario al que deriva");

            RuleFor(x => x.esRetorno)
               .NotNull()
               .WithMessage("El campo que indica el retorno es obligatorio.");

            RuleFor(x => x.usuarioOrigen)
                .MaximumLength(20)
                .WithMessage("El nombre de usuario que deriva debe tener máximo 20 caracteres");

            RuleFor(x => x.usuarioDestino)
                .MaximumLength(20)
                .WithMessage("El nombre de usuario al que deriva debe tener máximo 20 caracteres");

            RuleFor(x => x.observacion)
               .MaximumLength(250)
               .WithMessage("La observación debe tener máximo 250 caracteres");
        }
    }

    public class DerivacionRenacUpdateRequestValidator : AbstractValidator<DerivacionRenacUpdateRequest>
    {
        public DerivacionRenacUpdateRequestValidator()
        {
            RuleFor(u => u.idDerivacionRenac)
                .NotNull().Must(x => x.HasValue)
                .WithMessage("Debe ingresar el Id");

            RuleFor(u => u.fechaDerivacion)
                .NotNull().WithMessage("Debe ingresar la fecha")
                .Must(fecha => fecha != DateTime.MinValue)
                .WithMessage("Debe ingresar una fecha válida");

            RuleFor(u => u.usuarioOrigen)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe ingresar el usuario que deriva");

            RuleFor(u => u.usuarioDestino)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe ingresar el usuario al que deriva");

            RuleFor(x => x.esRetorno)
               .NotNull()
               .WithMessage("El campo que indica el retorno es obligatorio.");

            RuleFor(x => x.usuarioOrigen)
                .MaximumLength(20)
                .WithMessage("El nombre de usuario que deriva debe tener máximo 20 caracteres");

            RuleFor(x => x.usuarioDestino)
                .MaximumLength(20)
                .WithMessage("El nombre de usuario al que deriva debe tener máximo 20 caracteres");

            RuleFor(x => x.observacion)
               .MaximumLength(250)
               .WithMessage("La observación debe tener máximo 250 caracteres");
        }
    }

    public class DerivacionEspecialistaSSIATRequestValidator : AbstractValidator<DerivacionEspecialistaSSIATRequest>
    {
        public DerivacionEspecialistaSSIATRequestValidator()
        {           
            RuleFor(u => u.usuarioOrigen)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe ingresar el usuario que deriva");

            RuleFor(u => u.usuarioDestino)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe ingresar el usuario al que deriva");

            RuleFor(u => u.derivacioninformes)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe seleccionar por lo menos un informe");

            RuleFor(x => x.esRetorno)
               .NotNull()
               .WithMessage("El campo que indica el retorno es obligatorio.");

            RuleFor(u => u.documentoMemoBase64)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe adjuntar el Proyecto memo");

            RuleFor(x => x.usuarioOrigen)
                .MaximumLength(20)
                .WithMessage("El nombre de usuario que deriva debe tener máximo 20 caracteres");

            RuleFor(x => x.usuarioDestino)
                .MaximumLength(20)
                .WithMessage("El nombre de usuario al que deriva debe tener máximo 20 caracteres");
        }
    }

    public class DerivacionSubsecretarioSSIATRequestValidator : AbstractValidator<DerivacionSubsecretarioSSIATRequest>
    {
        public DerivacionSubsecretarioSSIATRequestValidator()
        {
            RuleFor(u => u.usuarioOrigen)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe ingresar el usuario que deriva");

            RuleFor(u => u.usuarioDestino)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe ingresar el usuario al que deriva");

            RuleFor(u => u.derivacioninformes)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe seleccionar por lo menos un informe");

            RuleFor(x => x.esRetorno)
               .NotNull()
               .WithMessage("El campo que indica el retorno es obligatorio.");

            RuleFor(u => u.idTipoDocumento)
                  .NotNull().Must(x => x.HasValue)
                  .WithMessage("Debe seleccionar el tipo de documento");

            RuleFor(u => u.documentoMemoBase64)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe adjuntar el Proyecto memo");

            RuleFor(u => u.numeroDocumento)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe ingresar el numero del documento");

            RuleFor(u => u.fechaDocumento)
                .NotNull().WithMessage("Debe ingresar la fecha del documento")
                .Must(fecha => fecha != DateTime.MinValue)
                .WithMessage("Debe ingresar un formato válido de fecha (dd/mm/aaaa)");

            RuleFor(x => x.numeroDocumento)
               .MaximumLength(20)
               .WithMessage("El número de documento debe tener máximo 20 caracteres");

            RuleFor(x => x.usuarioOrigen)
                .MaximumLength(20)
                .WithMessage("El nombre de usuario que deriva debe tener máximo 20 caracteres");

            RuleFor(x => x.usuarioDestino)
                .MaximumLength(20)
                .WithMessage("El nombre de usuario al que deriva debe tener máximo 20 caracteres");
        }
    }

    public class DerivacionAjustesSubsecretarioSsiatRequestValidator : AbstractValidator<DerivacionAjustesSubsecretarioSsiatRequest>
    {
        public DerivacionAjustesSubsecretarioSsiatRequestValidator()
        {
            RuleFor(u => u.usuarioOrigen)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe ingresar el usuario que deriva");

            RuleFor(u => u.usuarioDestino)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe ingresar el usuario al que deriva");

            RuleFor(u => u.derivacioninformes)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe seleccionar por lo menos un informe");

            RuleFor(u => u.observacion)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe ingresar las observaciones");

            RuleFor(x => x.esRetorno)
               .NotNull()
               .WithMessage("El campo que indica el retorno es obligatorio.");

            RuleFor(x => x.observacion)
                .MaximumLength(250)
                .WithMessage("Las observaciones de ajustes deben tener máximo 250 caracteres");

            RuleFor(x => x.usuarioOrigen)
                .MaximumLength(20)
                .WithMessage("El nombre de usuario que deriva debe tener máximo 20 caracteres");

            RuleFor(x => x.usuarioDestino)
                .MaximumLength(20)
                .WithMessage("El nombre de usuario al que deriva debe tener máximo 20 caracteres");
        }
    }

    public class DerivacionSubsecretarioSSATDOTRequestValidator : AbstractValidator<DerivacionSubsecretarioSSATDOTRequest>
    {
        public DerivacionSubsecretarioSSATDOTRequestValidator()
        {
            RuleFor(u => u.idEspecialistaSsatdot)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe seleccionar un especialista");

            RuleFor(u => u.usuarioOrigen)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe ingresar el usuario que deriva");

            RuleFor(u => u.usuarioDestino)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe ingresar el usuario al que deriva");

            RuleFor(u => u.derivacioninformes)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe seleccionar por lo menos un informe");

            RuleFor(x => x.esRetorno)
               .NotNull()
               .WithMessage("El campo que indica el retorno es obligatorio.");           

            RuleFor(x => x.usuarioOrigen)
                .MaximumLength(20)
                .WithMessage("El nombre de usuario que deriva debe tener máximo 20 caracteres");

            RuleFor(x => x.usuarioDestino)
                .MaximumLength(20)
                .WithMessage("El nombre de usuario al que deriva debe tener máximo 20 caracteres");
        }
    }

    public class DerivacionEspecialistaSSATDOTRequestValidator : AbstractValidator<DerivacionEspecialistaSSATDOTRequest>
    {
        public DerivacionEspecialistaSSATDOTRequestValidator()
        {
            RuleFor(u => u.usuarioOrigen)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe ingresar el usuario que deriva");

            RuleFor(u => u.usuarioDestino)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe ingresar el usuario al que deriva");

            RuleFor(u => u.derivacioninformes)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe seleccionar por lo menos un informe");

            RuleFor(x => x.esRetorno)
               .NotNull()
               .WithMessage("El campo que indica el retorno es obligatorio.");

            RuleFor(u => u.documentoMemoBase64)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe adjuntar el Proyecto memo");

            RuleFor(x => x.usuarioOrigen)
                .MaximumLength(20)
                .WithMessage("El nombre de usuario que deriva debe tener máximo 20 caracteres");

            RuleFor(x => x.usuarioDestino)
                .MaximumLength(20)
                .WithMessage("El nombre de usuario al que deriva debe tener máximo 20 caracteres");
        }
    }

    public class DerivacionAjustesEspecialistaSsatdotRequestValidator : AbstractValidator<DerivacionAjustesEspecialistaSsatdotRequest>
    {
        public DerivacionAjustesEspecialistaSsatdotRequestValidator()
        {
            RuleFor(u => u.usuarioOrigen)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe ingresar el usuario que deriva");

            RuleFor(u => u.usuarioDestino)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe ingresar el usuario al que deriva");

            RuleFor(u => u.derivacioninformes)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe seleccionar por lo menos un informe");

            RuleFor(u => u.observacion)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe ingresar las observaciones");

            RuleFor(x => x.esRetorno)
               .NotNull()
               .WithMessage("El campo que indica el retorno es obligatorio.");

            RuleFor(x => x.observacion)
                .MaximumLength(250)
                .WithMessage("Las observaciones de ajustes deben tener máximo 250 caracteres");

            RuleFor(x => x.usuarioOrigen)
                .MaximumLength(20)
                .WithMessage("El nombre de usuario que deriva debe tener máximo 20 caracteres");

            RuleFor(x => x.usuarioDestino)
                .MaximumLength(20)
                .WithMessage("El nombre de usuario al que deriva debe tener máximo 20 caracteres");
        }
    }

    public class DerivacionAjustesSubsecretarioSsatdotRequestValidator : AbstractValidator<DerivacionAjustesSubsecretarioSsatdotRequest>
    {
        public DerivacionAjustesSubsecretarioSsatdotRequestValidator()
        {
            RuleFor(u => u.usuarioOrigen)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe ingresar el usuario que deriva");

            RuleFor(u => u.usuarioDestino)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe ingresar el usuario al que deriva");

            RuleFor(u => u.derivacioninformes)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe seleccionar por lo menos un informe");

            RuleFor(u => u.observacion)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe ingresar las observaciones");

            RuleFor(x => x.esRetorno)
               .NotNull()
               .WithMessage("El campo que indica el retorno es obligatorio.");

            RuleFor(x => x.observacion)
                .MaximumLength(250)
                .WithMessage("Las observaciones de ajustes deben tener máximo 250 caracteres");

            RuleFor(x => x.usuarioOrigen)
                .MaximumLength(20)
                .WithMessage("El nombre de usuario que deriva debe tener máximo 20 caracteres");

            RuleFor(x => x.usuarioDestino)
                .MaximumLength(20)
                .WithMessage("El nombre de usuario al que deriva debe tener máximo 20 caracteres");
        }
    }

    public class DerivacionInformesSubsecretarioSsatdotRequestValidator : AbstractValidator<DerivacionInformesSubsecretarioSsatdotRequest>
    {
        public DerivacionInformesSubsecretarioSsatdotRequestValidator()
        {
            RuleFor(u => u.usuarioOrigen)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe ingresar el usuario que deriva");

            RuleFor(u => u.usuarioDestino)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe ingresar el usuario al que deriva");

            RuleFor(u => u.derivacioninformes)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe seleccionar por lo menos un informe");

            RuleFor(x => x.esRetorno)
               .NotNull()
               .WithMessage("El campo que indica el retorno es obligatorio.");

            RuleFor(u => u.fechaDocumento)
                .NotNull().WithMessage("Debe ingresar la fecha del documento")
                .Must(fecha => fecha != DateTime.MinValue)
                .WithMessage("Debe ingresar un formato válido de fecha (dd/mm/aaaa)");

            RuleFor(u => u.numeroDocumento)
              .IsNullOrWhiteSpace()
              .WithMessage("Debe ingresar el numero del documento");

            RuleFor(u => u.documentoMemoBase64)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe adjuntar el Proyecto memo");

            RuleFor(x => x.numeroDocumento)
               .MaximumLength(20)
               .WithMessage("El número de documento debe tener máximo 20 caracteres");

            RuleFor(x => x.usuarioOrigen)
                .MaximumLength(20)
                .WithMessage("El nombre de usuario que deriva debe tener máximo 20 caracteres");

            RuleFor(x => x.usuarioDestino)
                .MaximumLength(20)
                .WithMessage("El nombre de usuario al que deriva debe tener máximo 20 caracteres");
        }
    }

    public class DerivacionInformesResponsableArchivoRequestValidator : AbstractValidator<DerivacionInformesResponsableArchivoRequest>
    {
        public DerivacionInformesResponsableArchivoRequestValidator()
        {
            RuleFor(u => u.usuarioOrigen)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe ingresar el usuario que deriva");

            RuleFor(u => u.usuarioDestino)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe ingresar el usuario al que deriva");

            RuleFor(u => u.derivacioninformes)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe seleccionar por lo menos un informe");

            RuleFor(x => x.esRetorno)
               .NotNull()
               .WithMessage("El campo que indica el retorno es obligatorio.");           

            RuleFor(x => x.usuarioOrigen)
                .MaximumLength(20)
                .WithMessage("El nombre de usuario que deriva debe tener máximo 20 caracteres");

            RuleFor(x => x.usuarioDestino)
                .MaximumLength(20)
                .WithMessage("El nombre de usuario al que deriva debe tener máximo 20 caracteres");
        }
    }

    public class DerivacionModificacionEspecialistaSsiatRequestValidator : AbstractValidator<DerivacionModificacionEspecialistaSsiatRequest>
    {
        public DerivacionModificacionEspecialistaSsiatRequestValidator()
        {
            RuleFor(u => u.usuarioOrigen)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe ingresar el usuario que deriva");

            RuleFor(u => u.usuarioDestino)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe ingresar el usuario al que deriva");

            RuleFor(u => u.derivacioninformes)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe seleccionar por lo menos un informe");

            RuleFor(u => u.observacion)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe ingresar las observaciones");

            RuleFor(x => x.esRetorno)
               .NotNull()
               .WithMessage("El campo que indica el retorno es obligatorio.");

            RuleFor(x => x.observacion)
                .MaximumLength(250)
                .WithMessage("Las observaciones de ajustes deben tener máximo 250 caracteres");

            RuleFor(x => x.usuarioOrigen)
                .MaximumLength(20)
                .WithMessage("El nombre de usuario que deriva debe tener máximo 20 caracteres");

            RuleFor(x => x.usuarioDestino)
                .MaximumLength(20)
                .WithMessage("El nombre de usuario al que deriva debe tener máximo 20 caracteres");
        }
    }

    public class DerivacionParaAnotacionEspecialistaSsiatRequestValidator : AbstractValidator<DerivacionParaAnotacionEspecialistaSsiatRequest>
    {
        public DerivacionParaAnotacionEspecialistaSsiatRequestValidator()
        {
            RuleFor(u => u.usuarioOrigen)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe ingresar el usuario que deriva");

            RuleFor(u => u.usuarioDestino)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe ingresar el usuario al que deriva");

            RuleFor(u => u.derivacioninformes)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe seleccionar por lo menos un informe");

            RuleFor(x => x.esRetorno)
               .NotNull()
               .WithMessage("El campo que indica el retorno es obligatorio.");

            RuleFor(u => u.documentoMemoBase64)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe adjuntar el Proyecto memo");

            RuleFor(x => x.usuarioOrigen)
                .MaximumLength(20)
                .WithMessage("El nombre de usuario que deriva debe tener máximo 20 caracteres");

            RuleFor(x => x.usuarioDestino)
                .MaximumLength(20)
                .WithMessage("El nombre de usuario al que deriva debe tener máximo 20 caracteres");
        }
    }

    public class DerivacionParaAnotacionSubsecretarioSsiatRequestValidator : AbstractValidator<DerivacionParaAnotacionSubsecretarioSsiatRequest>
    {
        public DerivacionParaAnotacionSubsecretarioSsiatRequestValidator()
        {
            RuleFor(u => u.usuarioOrigen)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe ingresar el usuario que deriva");

            RuleFor(u => u.usuarioDestino)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe ingresar el usuario al que deriva");

            RuleFor(u => u.derivacioninformes)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe seleccionar por lo menos un informe");

            RuleFor(x => x.esRetorno)
               .NotNull()
               .WithMessage("El campo que indica el retorno es obligatorio.");

            RuleFor(u => u.numeroDocumento)
              .IsNullOrWhiteSpace()
              .WithMessage("Debe ingresar el numero del documento");

            RuleFor(u => u.fechaDocumento)
                .NotNull().WithMessage("Debe ingresar la fecha del documento")
                .Must(fecha => fecha != DateTime.MinValue)
                .WithMessage("Debe ingresar un formato válido de fecha (dd/mm/aaaa)");

            RuleFor(x => x.numeroDocumento)
               .MaximumLength(20)
               .WithMessage("El número de documento debe tener máximo 20 caracteres");

            RuleFor(u => u.documentoMemoBase64)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe adjuntar el Proyecto memo");

            RuleFor(x => x.usuarioOrigen)
                .MaximumLength(20)
                .WithMessage("El nombre de usuario que deriva debe tener máximo 20 caracteres");

            RuleFor(x => x.usuarioDestino)
                .MaximumLength(20)
                .WithMessage("El nombre de usuario al que deriva debe tener máximo 20 caracteres");
        }
    }

}