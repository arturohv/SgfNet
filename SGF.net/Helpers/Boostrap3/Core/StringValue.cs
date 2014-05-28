/*
* This file is part of - WebExtras
* Copyright (C) 2014 Mihir Mone
*
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU Lesser General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
* GNU Lesser General Public License for more details.
*
* You should have received a copy of the GNU Lesser General Public License
* along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

namespace SGF.net.Helpers.Bootstrap3
{
    using System;
    using System.Reflection;
    /// <summary>
    /// String value attribute which can be applied to Enumerations
    /// to resolve to STRING rather than the default INT
    /// </summary>
    [Serializable]
    public class StringValue : Attribute
    {
        /// <summary>
        /// String value
        /// </summary>
        private readonly string m_value;

        /// <summary>
        /// Custom string value decider
        /// </summary>
        public Type ValueType { get; private set; }

        /// <summary>
        /// Flag indicating whether this attribute has a custom string value
        /// decider associated with it
        /// </summary>
        public bool HasCustom { get; private set; }

        /// <summary>
        /// String value
        /// </summary>
        public string Value { get { return m_value; } }

        /// <summary>
        /// Constructor
        /// </summary>
        /// <param name="value">Value to be associated with the enum attribute</param>
        public StringValue(string value)
        {
            m_value = value;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="t"></param>
        public StringValue(Type t)
        {
            if (!typeof(StringValue).IsAssignableFrom(t))
                throw new InvalidOperationException("El tipo " + t.FullName + " no esta implementado.");

            ValueType = t;
            HasCustom = true;
        }
    }
}