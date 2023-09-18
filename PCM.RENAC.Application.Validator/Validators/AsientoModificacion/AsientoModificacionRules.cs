using FluentValidation;
using PCM.RENAC.Application.Dto;

namespace PCM.RENAC.Application.Validator
{
    public class AsientoModificacionIdRequestValidator : AbstractValidator<AsientoModificacionIdRequest>
    {
        public AsientoModificacionIdRequestValidator()
        {
            RuleFor(u => u.idAsientoModificacion)
            .NotNull().Must(x => x.HasValue)
            .WithMessage("Debe ingresar el Id");
        }
    }

    public class AsientoModificacionInsertRequestValidator : AbstractValidator<AsientoModificacionInsertRequest>
    {
        public AsientoModificacionInsertRequestValidator()
        {
            RuleFor(u => u.idAsientoCircunscripcion)
            .NotNull().Must(x => x.HasValue)
            .WithMessage("Debe seleccionar un asiento");

            RuleFor(u => u.idTipoModificacionAsiento)
            .NotNull().Must(x => x.HasValue)
            .WithMessage("Debe seleccionar un tipo de modificacion");
        }
    }

    public class AsientoModificacionUpdateRequestValidator : AbstractValidator<AsientoModificacionUpdateRequest>
    {
        public AsientoModificacionUpdateRequestValidator()
        {
            RuleFor(u => u.idAsientoModificacion)
            .NotNull().Must(x => x.HasValue)
            .WithMessage("Debe ingresar el Id");

            RuleFor(u => u.idAsientoCircunscripcion)
            .NotNull().Must(x => x.HasValue)
            .WithMessage("Debe seleccionar un asiento");

            RuleFor(u => u.idTipoModificacionAsiento)
            .NotNull().Must(x => x.HasValue)
            .WithMessage("Debe seleccionar un tipo de modificacion");
        }
    }
}
