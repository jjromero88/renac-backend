using FluentValidation;
using PCM.RENAC.Application.Control.Util;
using PCM.RENAC.Application.Dto;

namespace PCM.RENAC.Application.Validator
{
    public class AsientoCircunscripcionIdRequestValidator : AbstractValidator<AsientoCircunscripcionIdRequest>
    {
        public AsientoCircunscripcionIdRequestValidator()
        {
            RuleFor(u => u.idAsientoCircunscripcion)
                  .NotNull().Must(x => x.HasValue)
                  .WithMessage("Debe ingresar el Id");
        }
    }

    public class AsientoCircunscripcionInsertRequestValidator : AbstractValidator<AsientoCircunscripcionInsertRequest>
    {
        public AsientoCircunscripcionInsertRequestValidator()
        {
            RuleFor(u => u.detallesModificacion)
            .Must((request, detallesmodificacion) =>
            {
                if (request.codTipoAsiento == TipoAsientoCodigo.Modificacion || request.codTipoAsiento == TipoAsientoCodigo.Cancelacion)
                    return !string.IsNullOrWhiteSpace(detallesmodificacion);

                return true;
            }).WithMessage("Debe seleccionar por lo menos un tipo de modificacion");

            RuleFor(u => u.circunscripcionOrigenes)
            .Must((request, circunscripcionOrigenes) =>
            {
                if (request.codTipoAsiento == TipoAsientoCodigo.Modificacion || request.codTipoAsiento == TipoAsientoCodigo.Creacion)
                    return !string.IsNullOrWhiteSpace(circunscripcionOrigenes);

                return true;
            }).WithMessage("Debe ingresar al menos una Circunscripción origen");

            RuleFor(u => u.circunscripcionDestinos)
            .Must((request, circunscripcionDestinos) =>
            {
                if (request.codTipoAsiento == TipoAsientoCodigo.Modificacion || request.codTipoAsiento == TipoAsientoCodigo.Cancelacion)
                    return !string.IsNullOrWhiteSpace(circunscripcionDestinos);

                return true;
            }).WithMessage("Debe ingresar al menos una Circunscripción destino");      

            RuleFor(u => u.nombreCapital)
            .Must((request, nombreCapital) =>
            {
                if (request.tipoCircunscripcion?.Trim().ToLower() == TipoCircunscripcionDescripcion.Departamento || request.tipoCircunscripcion?.Trim().ToLower() == TipoCircunscripcionDescripcion.Provincia || request.tipoCircunscripcion?.Trim().ToLower() == TipoCircunscripcionDescripcion.Distrito)
                    return !string.IsNullOrWhiteSpace(nombreCapital);

                return true;
            }).WithMessage("Debe ingresar el nombre de la capital");

            RuleFor(u => u.nombreDepartamento)
            .Must((request, nombreDepartamento) =>
            {
                if (request.tipoCircunscripcion?.Trim().ToLower() == TipoCircunscripcionDescripcion.Provincia || request.tipoCircunscripcion?.Trim().ToLower() == TipoCircunscripcionDescripcion.Distrito)
                    return !string.IsNullOrWhiteSpace(nombreDepartamento);

                return true;
            }).WithMessage("Debe ingresar el nombre del departamento");

            RuleFor(u => u.nombreProvincia)
            .Must((request, nombreProvincia) =>
            {
                if (request.tipoCircunscripcion?.Trim().ToLower() == TipoCircunscripcionDescripcion.Distrito)
                    return !string.IsNullOrWhiteSpace(nombreProvincia);

                return true;
            }).WithMessage("Debe ingresar el nombre de la provincia");

            RuleFor(u => u.idInformeRenac)
                   .NotNull().Must(x => x.HasValue)
                   .WithMessage("Debe seleccionar el informe");

            RuleFor(u => u.idTipoAsiento)
                   .NotNull().Must(x => x.HasValue)
                   .WithMessage("Debe seleccionar el tipo de asiento");

            RuleFor(u => u.idDispositivo)
                   .NotNull().Must(x => x.HasValue)
                   .WithMessage("Debe adjuntar una norma");

            RuleFor(u => u.numeroAsiento)
               .IsNullOrWhiteSpace()
               .WithMessage("Debe ingresar el número de la circunscripción");

            RuleFor(u => u.nombreCircunscripcion)
               .IsNullOrWhiteSpace()
               .WithMessage("Debe ingresar el nombre de la circunscripcion");

            RuleFor(x => x.descripcion)
                .MaximumLength(100)
                .WithMessage("La descripcion debe tener máximo 100 caracteres");

            RuleFor(x => x.nombreCircunscripcion)
                .MaximumLength(150)
                .WithMessage("El nombre de circunscripcion debe tener máximo 150 caracteres");

            RuleFor(x => x.nombreCapital)
                .MaximumLength(150)
                .WithMessage("El nombre de la capital debe tener máximo 150 caracteres");

            RuleFor(x => x.nombreProvincia)
                .MaximumLength(150)
                .WithMessage("El nombre de la provincia debe tener máximo 150 caracteres");

            RuleFor(x => x.nombreDepartamento)
                .MaximumLength(150)
                .WithMessage("El nombre del departamento debe tener máximo 150 caracteres");

            RuleFor(x => x.informacionComplementaria)
                .MaximumLength(250)
                .WithMessage("El información complementario debe tener máximo 250 caracteres");
        }
    }

    public class AsientoCircunscripcionUpdateRequestValidator : AbstractValidator<AsientoCircunscripcionUpdateRequest>
    {
        public AsientoCircunscripcionUpdateRequestValidator()
        {
            RuleFor(u => u.detallesModificacion)
            .Must((request, detallesmodificacion) =>
            {
                if (request.codTipoAsiento == TipoAsientoCodigo.Modificacion || request.codTipoAsiento == TipoAsientoCodigo.Cancelacion)
                    return !string.IsNullOrWhiteSpace(detallesmodificacion);

                return true;
            }).WithMessage("Debe seleccionar por lo menos un tipo de modificacion");

            RuleFor(u => u.circunscripcionOrigenes)
            .Must((request, circunscripcionOrigenes) =>
            {
                if (request.codTipoAsiento == TipoAsientoCodigo.Modificacion || request.codTipoAsiento == TipoAsientoCodigo.Creacion)
                    return !string.IsNullOrWhiteSpace(circunscripcionOrigenes);

                return true;
            }).WithMessage("Debe ingresar al menos una Circunscripción origen");

            RuleFor(u => u.circunscripcionDestinos)
            .Must((request, circunscripcionDestinos) =>
            {
                if (request.codTipoAsiento == TipoAsientoCodigo.Modificacion || request.codTipoAsiento == TipoAsientoCodigo.Cancelacion)
                    return !string.IsNullOrWhiteSpace(circunscripcionDestinos);

                return true;
            }).WithMessage("Debe ingresar al menos una Circunscripción destino");

            RuleFor(u => u.nombreCapital)
            .Must((request, nombreCapital) =>
            {
                if (request.tipoCircunscripcion?.Trim().ToLower() == TipoCircunscripcionDescripcion.Departamento || request.tipoCircunscripcion?.Trim().ToLower() == TipoCircunscripcionDescripcion.Provincia || request.tipoCircunscripcion?.Trim().ToLower() == TipoCircunscripcionDescripcion.Distrito)
                    return !string.IsNullOrWhiteSpace(nombreCapital);

                return true;
            }).WithMessage("Debe ingresar el nombre de la capital");

            RuleFor(u => u.nombreDepartamento)
            .Must((request, nombreDepartamento) =>
            {
                if (request.tipoCircunscripcion?.Trim().ToLower() == TipoCircunscripcionDescripcion.Provincia || request.tipoCircunscripcion?.Trim().ToLower() == TipoCircunscripcionDescripcion.Distrito)
                    return !string.IsNullOrWhiteSpace(nombreDepartamento);

                return true;
            }).WithMessage("Debe ingresar el nombre del departamento");

            RuleFor(u => u.nombreProvincia)
            .Must((request, nombreProvincia) =>
            {
                if (request.tipoCircunscripcion?.Trim().ToLower() == TipoCircunscripcionDescripcion.Distrito)
                    return !string.IsNullOrWhiteSpace(nombreProvincia);

                return true;
            }).WithMessage("Debe ingresar el nombre de la provincia");

            RuleFor(u => u.idAsientoCircunscripcion)
                  .NotNull().Must(x => x.HasValue)
                  .WithMessage("Debe ingresar el Id");

            RuleFor(u => u.idInformeRenac)
                   .NotNull().Must(x => x.HasValue)
                   .WithMessage("Debe seleccionar el informe");

            RuleFor(u => u.idTipoAsiento)
                   .NotNull().Must(x => x.HasValue)
                   .WithMessage("Debe seleccionar el tipo de asiento");

            RuleFor(u => u.idDispositivo)
                  .NotNull().Must(x => x.HasValue)
                  .WithMessage("Debe adjuntar una norma");

            RuleFor(u => u.numeroAsiento)
               .IsNullOrWhiteSpace()
               .WithMessage("Debe ingresar el número de la circunscripción");

            RuleFor(u => u.nombreCircunscripcion)
               .IsNullOrWhiteSpace()
               .WithMessage("Debe ingresar el nombre de la circunscripcion");

            RuleFor(x => x.descripcion)
                .MaximumLength(100)
                .WithMessage("La descripcion debe tener máximo 100 caracteres");

            RuleFor(x => x.nombreCircunscripcion)
                .MaximumLength(150)
                .WithMessage("El nombre de circunscripcion debe tener máximo 150 caracteres");

            RuleFor(x => x.nombreCapital)
                .MaximumLength(150)
                .WithMessage("El nombre de la capital debe tener máximo 150 caracteres");

            RuleFor(x => x.nombreProvincia)
                .MaximumLength(150)
                .WithMessage("El nombre de la provincia debe tener máximo 150 caracteres");

            RuleFor(x => x.nombreDepartamento)
                .MaximumLength(150)
                .WithMessage("El nombre del departamento debe tener máximo 150 caracteres");

            RuleFor(x => x.informacionComplementaria)
                .MaximumLength(200)
                .WithMessage("El información complementario debe tener máximo 200 caracteres");
        }
    }

}
