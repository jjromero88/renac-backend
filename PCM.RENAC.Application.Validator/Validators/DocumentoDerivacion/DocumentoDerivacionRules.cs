using FluentValidation;
using PCM.RENAC.Application.Dto;

namespace PCM.RENAC.Application.Validator
{
    public class DocumentoDerivacionIdRequestValidator : AbstractValidator<DocumentoDerivacionIdRequest>
    {
        public DocumentoDerivacionIdRequestValidator()
        {
            RuleFor(u => u.idDocumentoDerivacion)
                  .NotNull().Must(x => x.HasValue)
                  .WithMessage("Debe ingresar el Id");
        }
    }

    public class DocumentoDerivacionInsertRequestValidator : AbstractValidator<DocumentoDerivacionInsertRequest>
    {
        public DocumentoDerivacionInsertRequestValidator()
        {
            RuleFor(u => u.idDerivacionRenac)
                   .NotNull().Must(x => x.HasValue)
                   .WithMessage("Debe asignar el documento a una derivacion");

            RuleFor(u => u.idTipoDocumentoRenac)
                   .NotNull().Must(x => x.HasValue)
                   .WithMessage("Debe seleccionar un tipo de documento");

            RuleFor(u => u.rutaDocumento)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe ingresar la ruta del documento");

            RuleFor(u => u.nombreDocumento)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe ingresar el nombre del documento");
             
            RuleFor(x => x.rutaDocumento)
                .MaximumLength(250)
                .WithMessage("La ruta de documento debe tener máximo 250 caracteres");

            RuleFor(x => x.nombreDocumento)
                .MaximumLength(100)
                .WithMessage("El nombre del documento debe tener máximo 100 caracteres");
        }
    }

    public class DocumentoDerivacionUpdateRequestValidator : AbstractValidator<DocumentoDerivacionUpdateRequest>
    {
        public DocumentoDerivacionUpdateRequestValidator()
        {
            RuleFor(u => u.idDocumentoDerivacion)
                .NotNull().Must(x => x.HasValue)
                .WithMessage("Debe ingresar el Id");

            RuleFor(u => u.idDerivacionRenac)
                   .NotNull().Must(x => x.HasValue)
                   .WithMessage("Debe asignar el documento a una derivacion");

            RuleFor(u => u.idTipoDocumentoRenac)
                   .NotNull().Must(x => x.HasValue)
                   .WithMessage("Debe seleccionar un tipo de documento");

            RuleFor(u => u.rutaDocumento)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe ingresar la ruta del documento");

            RuleFor(u => u.nombreDocumento)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe ingresar el nombre del documento");

            RuleFor(x => x.rutaDocumento)
                .MaximumLength(250)
                .WithMessage("La ruta de documento debe tener máximo 250 caracteres");

            RuleFor(x => x.nombreDocumento)
                .MaximumLength(100)
                .WithMessage("El nombre del documento debe tener máximo 100 caracteres");
        }
    }

}
