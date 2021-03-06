﻿using System.ComponentModel.DataAnnotations;
using System.ComponentModel;
using System.Web.Mvc;

namespace SGF.net.Models
{
    [MetadataTypeAttribute(typeof(memberMaritalStatus.MemberMaritalStatusMetadata))]
    public partial class memberMaritalStatus
    {
        internal sealed class MemberMaritalStatusMetadata
        {
            private MemberMaritalStatusMetadata()
            {
            }

            [Key]
            [Required]
            [DisplayName("Estado Civil Id:")]
            public int maritalStatusId { get; set; }
            
            [DisplayName("Estado Civil:")]
            public string name { get; set; }
        }
    }
}