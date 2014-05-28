namespace SGF.net.Helpers.Bootstrap3
{
    using System;

    /// <summary>
    /// A collection of button display types
    /// </summary>
    [Serializable]
    public enum Nav
    {        

        [StringValue("nav-pills")]
        Pills,

        [StringValue("nav-tabs")]
        Taps

    }

    public enum NavOption
    {
        [StringValue("nav-stacked")]
        Stacked,
    
        [StringValue("nav-justified")]
        Justified

    }

    public enum NavState
    {
        [StringValue("disabled")]
        Disabled,

        [StringValue("active")]
        Active

    }
}
