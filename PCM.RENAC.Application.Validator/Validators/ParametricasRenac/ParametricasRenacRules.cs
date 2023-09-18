using FluentValidation;
using PCM.RENAC.Application.Dto;

namespace PCM.RENAC.Application.Validator
{
    public class ParametricasRenacIdRequestValidator : AbstractValidator<ParametricasRenacIdRequest>
    {
        public ParametricasRenacIdRequestValidator()
        {
            RuleFor(u => u.idParametricasRenac)
            .NotNull().Must(x => x.HasValue)
            .WithMessage("Debe ingresar el Id");
        }
    }
    public class ParametricasRenacInsertRequestValidator : AbstractValidator<ParametricasRenacInsertRequest>
    {
        public ParametricasRenacInsertRequestValidator()
        {
            RuleFor(u => u.descripcion)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe ingresar una descripcion");

            RuleFor(u => u.codigo)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe ingresar el codigo");

            RuleFor(x => x.descripcion)
                .MaximumLength(80)
                .WithMessage("La descripcion debe tener máximo 80 caracteres");

            RuleFor(x => x.codigo)
                .MaximumLength(4)
                .WithMessage("El codigo debe tener máximo 4 caracteres");
        }
    }
    public class ParametricasRenacUpdateRequestValidator : AbstractValidator<ParametricasRenacUpdateRequest>
    {
        public ParametricasRenacUpdateRequestValidator()
        {
            RuleFor(u => u.idParametricasRenac)
                .NotNull().Must(x => x.HasValue)
                .WithMessage("Debe ingresar el Id");

            RuleFor(u => u.descripcion)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe ingresar una descripcion");

            RuleFor(u => u.codigo)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe ingresar el codigo");

            RuleFor(x => x.descripcion)
                .MaximumLength(80)
                .WithMessage("La descripcion debe tener máximo 80 caracteres");

            RuleFor(x => x.codigo)
                .MaximumLength(4)
                .WithMessage("El codigo debe tener máximo 4 caracteres");
        }
    }
}
