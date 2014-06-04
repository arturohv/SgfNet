using System.ComponentModel.DataAnnotations;
using System.ComponentModel;
using System.Web.Mvc;

namespace SGF.net.Models
{
    [MetadataTypeAttribute(typeof(memberPaymentTypes.memberPaymentTypesMetadata))]
    public partial class memberPaymentTypes
    {
        internal sealed class memberPaymentTypesMetadata
        {

            private memberPaymentTypesMetadata()
            {
            }

            [Key]
            [DisplayName("Id Tipo Pago:")]   
            public int paymentTypeId { get; set; }

            [DisplayName("Tipo de Pago:")]
            [Required]
            public string name { get; set; }
        }

        
    }
}