//------------------------------------------------------------------------------
// <auto-generated>
//    Este código se generó a partir de una plantilla.
//
//    Los cambios manuales en este archivo pueden causar un comportamiento inesperado de la aplicación.
//    Los cambios manuales en este archivo se sobrescribirán si se regenera el código.
// </auto-generated>
//------------------------------------------------------------------------------

namespace SGF.net.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class offices
    {
        public offices()
        {
            this.members = new HashSet<members>();
        }
    
        public int officeId { get; set; }
        public string officeName { get; set; }
        public string description { get; set; }
    
        public virtual ICollection<members> members { get; set; }
    }
}
