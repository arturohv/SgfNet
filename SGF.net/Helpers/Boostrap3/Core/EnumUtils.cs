

namespace SGF.net.Helpers.Bootstrap3
{
    using System;
    using System.Reflection;
    public class EnumUtils
    {
        public static string stringValueOf(Enum value)
        {
            FieldInfo fi = value.GetType().GetField(value.ToString());
            StringValue[] attributes = (StringValue[])fi.GetCustomAttributes(typeof(StringValue), false);
            if (attributes.Length > 0)
            {
                return attributes[0].Value;
            }
            else
            {
                return value.ToString();
            }
        }

        public static object enumValueOf(string value, Type enumType)
        {
            string[] names = Enum.GetNames(enumType);
            foreach (string name in names)
            {
                if (stringValueOf((Enum)Enum.Parse(enumType, name)).Equals(value))
                {
                    return Enum.Parse(enumType, name);
                }
            }

            throw new ArgumentException("La cadena no es una descripción o el valor de la enumeración especificada.");
        }
    }
}
