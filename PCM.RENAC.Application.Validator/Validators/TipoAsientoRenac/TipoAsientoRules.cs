using FluentValidation;
using PCM.RENAC.Application.Dto;

namespace PCM.RENAC.Application.Validator
{
    public class TipoAsientoIdRequestValidator : AbstractValidator<TipoAsientoIdRequest>
    {
        public TipoAsientoIdRequestValidator()
        {
            RuleFor(u => u.idTipoAsiento)
            .NotNull().Must(x => x.HasValue)
            .WithMessage("Debe ingresar el Id");
        }
    }

    public class TipoAsientoInsertRequestValidator : AbstractValidator<TipoAsientoInsertRequest>
    {
        public TipoAsientoInsertRequestValidator()
        {
            RuleFor(u => u.descripcion)
            .IsNullOrWhiteSpace()
            .WithMessage("Debe ingresar una descripcion");

            RuleFor(u => u.codigo)
            .NotNull().Must(x => x.HasValue)
            .WithMessage("Debe ingresar el codigo");

            RuleFor(x => x.codigo)
               .Must(CustomValidators.BeValidInteger)
               .WithMessage("El campo codigo debe ser un número entero.");

            RuleFor(x => x.descripcion)
            .MaximumLength(100)
            .WithMessage("La descripcion debe tener máximo 100 caracteres");
        }
    }

    public class TipoAsientoUpdateRequestValidator : AbstractValidator<TipoAsientoUpdateRequest>
    {
        public TipoAsientoUpdateRequestValidator()
        {
            RuleFor(u => u.idTipoAsiento)
            .NotNull().Must(x => x.HasValue)
            .WithMessage("Debe ingresar el Id");

            RuleFor(u => u.codigo)
            .NotNull().Must(x => x.HasValue)
            .WithMessage("Debe ingresar el codigo");

            RuleFor(x => x.codigo)
               .Must(CustomValidators.BeValidInteger)
               .WithMessage("El campo codigo debe ser un número entero.");

            RuleFor(u => u.descripcion)
            .IsNullOrWhiteSpace()
            .WithMessage("Debe ingresar una descripcion");

            RuleFor(x => x.descripcion)
            .MaximumLength(100)
            .WithMessage("La descripcion debe tener máximo 100 caracteres");
        }
    }

}
