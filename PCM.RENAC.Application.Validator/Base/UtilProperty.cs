using System.ComponentModel.DataAnnotations;
using System.Reflection;

namespace PCM.RENAC.Application.Validator
{
    public static class UtilProperty
    {
        public static string GetDisplayName(Type type, string propertyName)
        {
            PropertyInfo propertyInfo = type.GetProperty(propertyName);
            if (propertyInfo != null)
            {
                DisplayAttribute displayAttribute = propertyInfo.GetCustomAttribute<DisplayAttribute>();
                if (displayAttribute != null)
                {
                    return displayAttribute.GetName();
                }
            }
            return propertyName;
        }


    }
}
