using System.ComponentModel.DataAnnotations;
using System.ComponentModel;
using System.Web.Mvc;


namespace SGF.net.Models
{
    [MetadataTypeAttribute(typeof(loanTypes.loanTypesMetadata))]

    //[Bind(Exclude = "officeId")] 
    public partial class loanTypes
    {
        internal sealed class loanTypesMetadata
        {

            private loanTypesMetadata()
            {
            }

            [Key]
            [DisplayName("Id Tipo Crédito:")]
            public int loanTypeId { get; set; }

            [Required(ErrorMessage = "Este Campo es Requerido")]
            [StringLength(40, MinimumLength = 1, ErrorMessage = "Nombre debe tener entre 1 y 40 caracteres!")]
            [DisplayName("Nombre:")]
            public string name { get; set; }

            [Required(ErrorMessage = "Este Campo es Requerido")]
            [StringLength(200, MinimumLength = 1, ErrorMessage = "Descripción debe tener entre 1 y 40 caracteres!")]
            [DisplayName("Descripción:")]
            public string description { get; set; }

            [Required]
            [DisplayName("Monto:")]
            [DataType(DataType.Currency), DisplayFormat(ApplyFormatInEditMode = true, DataFormatString = "{0:C}")]
            public decimal amount { get; set; }

            [Required]
            [DisplayName("Taza de Interés:")]
            [Range(0.01, 100.00, ErrorMessage = "La Taza de Interés debe ser entre 0.01 y 100")]
            [DisplayFormat(DataFormatString = "{0:#,###0.00}")]
            public decimal interestRate { get; set; }

            [Required]
            [DisplayName("Meses Plazo:")]
            [DisplayFormat(DataFormatString = "{0:#,###0.00}")]
            public int monthTerm { get; set; }

            [Required]
            [DisplayName("Cuotas por mes:")]
            [DisplayFormat(DataFormatString = "{0:#,###0.00}")]
            public int paymentMonth { get; set; }

            [DisplayName("Cuotas Totales:")]
            [DisplayFormat(DataFormatString = "{0:#,###0.00}")]
            public int? totalPayments { get; set; }

            [DisplayName("Total Préstamo:")]
            [DataType(DataType.Currency), DisplayFormat(ApplyFormatInEditMode = true, DataFormatString = "{0:C}")]
            public decimal? totalAmount { get; set; }

            [DisplayName("Monto Cuota:")]
            [DataType(DataType.Currency), DisplayFormat(ApplyFormatInEditMode = true, DataFormatString = "{0:C}")]
            public decimal? amountFee { get; set; }

            

           
        }
    }
}