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

            [DisplayName("Nombre:")]
            [Required]
            public string firstName { get; set; }

            [DisplayName("Apellidos:")]
            [Required]
            public string lastName { get; set; }

            [DisplayName("Estado Civil:")]
            [Required]
            public int maritalStatusId { get; set; }

            [DisplayName("Fecha Nacimiento:")]
            [Required]
            [DataType(DataType.Date), DisplayFormat(DataFormatString = "{0:dd/MM/yyyy}", ApplyFormatInEditMode = true)]
            public System.DateTime birthdate { get; set; }

            [DisplayName("Teléfono:")]            
            public string phoneNumber { get; set; }

            [DisplayName("Móvil:")]
            public string cellNumber { get; set; }

            [DisplayName("Dirección:")]
            public string address { get; set; }

            [DisplayName("Departamento:")]
            [Required]
            public int officeId { get; set; }

            [DisplayName("Fecha Ingreso:")]
            [Required]
            public System.DateTime dischargedDate { get; set; }

            [DisplayName("Tipo de Pago:")]
            [Required]
            public int paymentTypeId { get; set; }

            [DisplayName("Activo:")]            
            public bool active { get; set; }

            
            //public virtual memberMaritalStatus memberMaritalStatus { get; set; }
            //public virtual memberPaymentTypes memberPaymentTypes { get; set; }
            //public virtual offices offices { get; set; }
        }
    }
}