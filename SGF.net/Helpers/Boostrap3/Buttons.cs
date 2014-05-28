namespace SGF.net.Helpers.Bootstrap3
{
    using System;

    /// <summary>
    /// A collection of button display types
    /// </summary>
    [Serializable]
    public enum Buttons
    {
        [StringValue("btn btn-default")]
        Default,

        [StringValue("btn btn-primary")]
        Primary,

        [StringValue("btn btn-success")]
        Success,

        [StringValue("btn btn-info")]
        Info,

        [StringValue("btn btn-warning")]
        Warning,
        
        [StringValue("btn btn-link")]
        Link,

        [StringValue("btn-xs")]
        ExtraSmall,
        
        [StringValue("btn-sm")]
        Small,
                
        [StringValue("btn-lg")]
        Large, 
                
        [StringValue("btn-block")]
        Block

    }
}
