using System.ComponentModel.DataAnnotations;
using System.ComponentModel;
using System.Web.Mvc;

namespace SGF.net.Models
{
    [MetadataTypeAttribute(typeof(members.MemberMetadata))]
    public partial class members
    {
        internal sealed class MemberMetadata
        {

            private MemberMetadata()
            {
            }

            [Key]
            [DisplayName("Id:")]   
            public int memberId { get; set; }

            [DisplayName("Cédula:")]
            [Required]
            public string documentId { get; set; }


            public string firstName { get; set; }
            public string lastName { get; set; }
            public int maritalStatusId { get; set; }
            public System.DateTime birthdate { get; set; }
            public string phoneNumber { get; set; }
            public string cellNumber { get; set; }
            public string address { get; set; }
            public int officeId { get; set; }
            public System.DateTime dischargedDate { get; set; }
            public int paymentTypeId { get; set; }
            public bool active { get; set; }

            
            //public virtual memberMaritalStatus memberMaritalStatus { get; set; }
            //public virtual memberPaymentTypes memberPaymentTypes { get; set; }
            //public virtual offices offices { get; set; }
        }
    }
}