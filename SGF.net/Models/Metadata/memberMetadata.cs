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
            [Required(ErrorMessage = "Este Campo es Requerido")]
            [StringLength(20, MinimumLength = 9, ErrorMessage = "Cédula debe tener entre 9 y 20 caracteres!")]
            public string documentId { get; set; }

            [DisplayName("Nombre:")]
            [Required(ErrorMessage = "Este Campo es Requerido")]
            [StringLength(20, MinimumLength = 1, ErrorMessage = "Nombre debe tener entre 1 y 20 caracteres!")]
            public string firstName { get; set; }

            [DisplayName("Apellidos:")]
            [Required(ErrorMessage = "Este Campo es Requerido")]
            [StringLength(40, MinimumLength = 1, ErrorMessage = "Cédula debe tener entre 1 y 40 caracteres!")]
            public string lastName { get; set; }

            [DisplayName("Estado Civil:")]
            [Required(ErrorMessage = "Este Campo es Requerido")]
            public int maritalStatusId { get; set; }

            [DisplayName("Fecha Nacimiento:")]
            [Required(ErrorMessage = "Este Campo es Requerido")]
            [DataType(DataType.Date), DisplayFormat(DataFormatString = "{0:dd/MM/yyyy}", ApplyFormatInEditMode = true)]
            public System.DateTime birthdate { get; set; }

            [DisplayName("Teléfono:")]            
            public string phoneNumber { get; set; }

            [DisplayName("Móvil:")]
            public string cellNumber { get; set; }

            [DisplayName("Dirección:")]
            [StringLength(300, ErrorMessage = "Dirección no debe tener más de 300 caracteres!")]
            public string address { get; set; }

            [DisplayName("Departamento:")]
            [Required(ErrorMessage = "Este Campo es Requerido")]
            public int officeId { get; set; }

            [DisplayName("Fecha Ingreso:")]
            [Required(ErrorMessage = "Este Campo es Requerido")]
            [DataType(DataType.Date), DisplayFormat(DataFormatString = "{0:dd/MM/yyyy}", ApplyFormatInEditMode = true)]
            public System.DateTime dischargedDate { get; set; }

            [DisplayName("Tipo de Pago:")]
            [Required(ErrorMessage = "Este Campo es Requerido")]
            public int paymentTypeId { get; set; }

            [DisplayName("Activo:")]            
            public bool active { get; set; }

            [DisplayName("Nombre Completo:")]  
            public string fullname { get { return firstName + " " + lastName; } }

            
            //public virtual memberMaritalStatus memberMaritalStatus { get; set; }
            //public virtual memberPaymentTypes memberPaymentTypes { get; set; }
            //public virtual offices offices { get; set; }
        }
    }
}