using System.ComponentModel.DataAnnotations;
using System.ComponentModel;
using System.Web.Mvc;

namespace SGF.net.Models
{
    [MetadataTypeAttribute(typeof(offices.OfficesMetadata))]

    [Bind(Exclude = "officeId")] 
	public partial class offices
	{
		internal sealed class OfficesMetadata{

            private OfficesMetadata()
            {
            }

            [Key]            
            [DisplayName("Id Oficina:")]            
            public int officeId { get; set; }

            [DisplayName("Oficina:")]
            [Required]
            [StringLength(60, MinimumLength = 3, ErrorMessage = "Oficina debe tener entre 3 y 60 caracteres!")]
            public string officeName { get; set; }

            [DisplayName("Descripción:")]
            [StringLength(255, ErrorMessage = "Descripción debe tener máximo 255 caracteres!")]
            public string description { get; set; }
		}
	}
}