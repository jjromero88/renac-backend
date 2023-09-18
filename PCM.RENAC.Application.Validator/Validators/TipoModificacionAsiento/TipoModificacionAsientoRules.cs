using FluentValidation;
using PCM.RENAC.Application.Dto;

namespace PCM.RENAC.Application.Validator
{
    public class TipoModificacionAsientoIdRequestValidator : AbstractValidator<TipoModificacionAsientoIdRequest>
    {
        public TipoModificacionAsientoIdRequestValidator()
        {
            RuleFor(u => u.idTipoModificacionAsiento)
                  .NotNull().Must(x => x.HasValue)
                  .WithMessage("Debe ingresar el Id");
        }
    }

    public class TipoModificacionAsientoInsertRequestValidator : AbstractValidator<TipoModificacionAsientoInsertRequest>
    {
        public TipoModificacionAsientoInsertRequestValidator()
        {
            RuleFor(u => u.descripcion)
            .IsNullOrWhiteSpace()
            .WithMessage("Debe ingresar una descripcion");

            RuleFor(x => x.descripcion)
            .MaximumLength(100)
            .WithMessage("La descripcion debe tener máximo 100 caracteres");
        }
    }

    public class TipoModificacionAsientoUpdateRequestValidator : AbstractValidator<TipoModificacionAsientoUpdateRequest>
    {
        public TipoModificacionAsientoUpdateRequestValidator()
        {
            RuleFor(u => u.idTipoModificacionAsiento)
            .NotNull().Must(x => x.HasValue)
            .WithMessage("Debe ingresar el Id");

            RuleFor(u => u.descripcion)
            .IsNullOrWhiteSpace()
            .WithMessage("Debe ingresar una descripcion");

            RuleFor(x => x.descripcion)
            .MaximumLength(100)
            .WithMessage("La descripcion debe tener máximo 100 caracteres");
        }
    }
}
