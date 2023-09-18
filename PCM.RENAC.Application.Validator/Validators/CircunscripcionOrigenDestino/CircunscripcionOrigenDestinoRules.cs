using FluentValidation;
using PCM.RENAC.Application.Dto;

namespace PCM.RENAC.Application.Validator
{
    public class CircunscripcionOrigenDestinoIdRequestValidator : AbstractValidator<CircunscripcionOrigenDestinoIdRequest>
    {
        public CircunscripcionOrigenDestinoIdRequestValidator()
        {
            RuleFor(u => u.idCircunscripcionOrigenDestino)
                  .NotNull().Must(x => x.HasValue)
                  .WithMessage("Debe ingresar el Id");
        }
    }

    public class CircunscripcionOrigenDestinoInsertRequestValidator : AbstractValidator<CircunscripcionOrigenDestinoInsertRequest>
    {
        public CircunscripcionOrigenDestinoInsertRequestValidator()
        {
            RuleFor(u => u.idAsientoCircunscripcion)
                .NotNull().Must(x => x.HasValue)
                .WithMessage("Debe seleccionar el asiento de circunscripcion");

            RuleFor(u => u.nombreCircunscripcion)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe ingresar el nombre de la circunscripcion");

            RuleFor(u => u.origenDestino)
               .IsNullOrWhiteSpace()
               .WithMessage("Debe ingresar el origen-destino");

            RuleFor(x => x.nombreCircunscripcion)
                .MaximumLength(150)
                .WithMessage("El nombre de la crcunscripcion debe tener máximo 150 caracteres");

            RuleFor(x => x.origenDestino)
              .MaximumLength(150)
              .WithMessage("El origen-destino debe tener máximo 150 caracteres");
        }
    }

    public class CircunscripcionOrigenDestinoUpdateRequestValidator : AbstractValidator<CircunscripcionOrigenDestinoUpdateRequest>
    {
        public CircunscripcionOrigenDestinoUpdateRequestValidator()
        {
            RuleFor(u => u.idCircunscripcionOrigenDestino)
                .NotNull().Must(x => x.HasValue)
                .WithMessage("Debe ingresar el Id");

            RuleFor(u => u.idAsientoCircunscripcion)
               .NotNull().Must(x => x.HasValue)
               .WithMessage("Debe seleccionar el asiento de circunscripcion");

            RuleFor(u => u.nombreCircunscripcion)
                .IsNullOrWhiteSpace()
                .WithMessage("Debe ingresar el nombre de la circunscripcion");

            RuleFor(u => u.origenDestino)
               .IsNullOrWhiteSpace()
               .WithMessage("Debe ingresar el origen-destino");

            RuleFor(x => x.nombreCircunscripcion)
                .MaximumLength(150)
                .WithMessage("El nombre de la crcunscripcion debe tener máximo 150 caracteres");

            RuleFor(x => x.origenDestino)
              .MaximumLength(150)
              .WithMessage("El origen-destino debe tener máximo 150 caracteres");

        }
    }
}
