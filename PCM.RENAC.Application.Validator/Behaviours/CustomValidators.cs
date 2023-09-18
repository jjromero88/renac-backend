using FluentValidation;

namespace PCM.RENAC.Application.Validator
{
    public static class CustomValidators
    {
        public static IRuleBuilderOptions<T, string?> IsNullOrWhiteSpace<T>(this IRuleBuilder<T, string?> ruleBuilder)
        {
            return ruleBuilder.Must(m => !String.IsNullOrWhiteSpace(m));
        }

        public static IRuleBuilderOptions<T, string?> BeNumeric<T>(this IRuleBuilder<T, string?> ruleBuilder)
        {
            return ruleBuilder.Must((rootObject, value, context) =>
            {
                if (string.IsNullOrEmpty(value))
                    return true;

                return long.TryParse(value, out _);
            });
        }

        public static bool BeValidInteger(int? value)
        {
            return value.HasValue;
        }

    }
}
