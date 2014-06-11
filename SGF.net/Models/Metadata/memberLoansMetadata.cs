using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel;
using System.Web.Mvc;

namespace SGF.net.Models
{
    [MetadataTypeAttribute(typeof(memberLoans.MemberLoansMetadata))]
    public partial class memberLoans
    {
        internal sealed class MemberLoansMetadata
        {
            private MemberLoansMetadata()
            {
            }
            [Key]
            public int memberLoanId { get; set; }
            [DisplayName("Asociado:")]
            public int memberId { get; set; }
            [DisplayName("Tipo Crédito:")]
            public int loanTypeId { get; set; }
            [DisplayName("Estado:")]
            public int memberLoanStatusId { get; set; }
            [DisplayName("Fecha Solicitud:")]
            public Nullable<System.DateTime> appDate { get; set; }
            [DisplayName("Fecha Aprobación:")]
            public Nullable<System.DateTime> aprDate { get; set; }
            [DisplayName("Notas:")]
            public string Notes { get; set; }

        }
    }
}