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
    
    public partial class loanTypes
    {
        public loanTypes()
        {
            this.memberLoans = new HashSet<memberLoans>();
        }
    
        public int loanTypeId { get; set; }
        public string name { get; set; }
        public string description { get; set; }
        public decimal amount { get; set; }
        public decimal interestRate { get; set; }
        public int monthTerm { get; set; }
        public int paymentMonth { get; set; }
        public Nullable<int> totalPayments { get; set; }
        public Nullable<decimal> totalAmount { get; set; }
        public Nullable<decimal> amountFee { get; set; }
    
        public virtual ICollection<memberLoans> memberLoans { get; set; }
    }
}
