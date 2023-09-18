using FluentValidation;
using PCM.RENAC.Application.Dto;

namespace PCM.RENAC.Application.Validator
{
    public class TipoDocumentoRenacIdRequestValidator : AbstractValidator<TipoDocumentoRenacIdRequest>
    {
        public TipoDocumentoRenacIdRequestValidator()
        {
            RuleFor(u => u.idTipoDocumentoRenac)
                  .NotNull().Must(x => x.HasValue)
                  .WithMessage("Debe ingresar el Id");
        }
    }

    public class TipoDocumentoRenacInsertRequestValidator : AbstractValidator<TipoDocumentoRenacInsertRequest>
    {
        public TipoDocumentoRenacInsertRequestValidator()
        {
            RuleFor(u => u.codigo)
                .NotNull().Must(x => x.HasValue)
                .WithMessage("Debe ingresar un codigo");

            RuleFor(u => u.descripcion)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe ingresar una descripcion");

            RuleFor(x => x.descripcion)
                .MaximumLength(150)
                .WithMessage("La descripcion debe tener máximo 150 caracteres");

            RuleFor(x => x.codigo)
                .Must(CustomValidators.BeValidInteger)
                .WithMessage("El campo codigo debe ser un número entero.");

        }
    }

    public class TipoDocumentoRenacUpdateRequestValidator : AbstractValidator<TipoDocumentoRenacUpdateRequest>
    {
        public TipoDocumentoRenacUpdateRequestValidator()
        {
            RuleFor(u => u.idTipoDocumentoRenac)
                  .NotNull().Must(x => x.HasValue)
                  .WithMessage("Debe ingresar el Id");

            RuleFor(u => u.codigo)
                 .NotNull().Must(x => x.HasValue)
                 .WithMessage("Debe ingresar un codigo");

            RuleFor(u => u.descripcion)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe ingresar una descripcion");

            RuleFor(x => x.descripcion)
                .MaximumLength(150)
                .WithMessage("La descripcion debe tener máximo 150 caracteres");

            RuleFor(x => x.codigo)
                .Must(CustomValidators.BeValidInteger)
                .WithMessage("El campo codigo debe ser un número entero.");
        }
    }


}
