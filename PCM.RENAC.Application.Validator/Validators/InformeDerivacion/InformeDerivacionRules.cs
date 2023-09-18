using FluentValidation;
using PCM.RENAC.Application.Dto;

namespace PCM.RENAC.Application.Validator
{
    public class InformeDerivacionIdRequestValidator : AbstractValidator<InformeDerivacionIdRequest>
    {
        public InformeDerivacionIdRequestValidator()
        {
            RuleFor(u => u.idInformeDerivacion)
                  .NotNull().Must(x => x.HasValue)
                  .WithMessage("Debe ingresar el Id");
        }
    }

    public class InformeDerivacionInsertRequestValidator : AbstractValidator<InformeDerivacionInsertRequest>
    {
        public InformeDerivacionInsertRequestValidator()
        {
            RuleFor(u => u.idInformeRenac)
               .NotNull().Must(x => x.HasValue)
               .WithMessage("Debe seleccionar un Informe Renac");

            RuleFor(u => u.idDerivacionRenac)
                .NotNull().Must(x => x.HasValue)
                .WithMessage("Debe seleccionar la Derivacion");
        }
    }
    public class InformeDerivacionUpdateRequestValidator : AbstractValidator<InformeDerivacionUpdateRequest>
    {
        public InformeDerivacionUpdateRequestValidator()
        {
            RuleFor(u => u.idInformeDerivacion)
                .NotNull().Must(x => x.HasValue)
                .WithMessage("Debe ingresar el Id");

            RuleFor(u => u.idInformeRenac)
               .NotNull().Must(x => x.HasValue)
               .WithMessage("Debe seleccionar un Informe Renac");

            RuleFor(u => u.idDerivacionRenac)
                .NotNull().Must(x => x.HasValue)
                .WithMessage("Debe seleccionar la Derivacion");
        }
    }

}
