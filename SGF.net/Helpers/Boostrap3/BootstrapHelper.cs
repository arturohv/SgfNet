//Clase de helpers que me permite usar actionLink y submitButton 
//Con algunas caracteristicas especiales para evitar digitar mucho codigo adicional
//Permite usar iconos, color y tipo de botones

namespace SGF.net.Helpers.Bootstrap3
{

    using System.Collections.Generic;
    using System.Web.Mvc;
    using System.Reflection;
    using System.Web.Mvc.Html;
    using System.Web;

    public static class BootstrapHelper
    {

        const string S_NUM = "#";
        const string SPACE = " ";

        #region HtmlContantes
        const string A = "a";
        const string B = "b";
        const string UL = "ul";
        const string LI = "li";
        const string SPAN = "span";
        const string BUTTON = "button";
        #endregion HtmlContantes

        #region CssContantes
        const string TOP = "top";
        const string DROPDOWN = "dropdown";
        const string DROPDOWN_TOGGLE = "dropdown-toggle";
        const string DROPDOWN_MENU = "dropdown-menu";
        const string DROPDOWN_SUBMENU = "dropdown-submenu";
        const string CARET = "caret";
        #endregion CssContantes

        #region AttributesContantes
        const string HREF = "href";
        const string REF = "ref";
        const string CLASS = "class";
        const string TOOLTIP = "tooltip";
        const string TITLE = "title";
        const string DATA_PLACEMENT = "data-placement";
        const string DATA_TOGGLE = "data-toggle";
        const string TYPE = "type";
        const string SUBMIT = "submit";

        #endregion AttributesContantes

        #region LocalContantes
        const string PRE_CLASS_ICONS = "glyphicon glyphicon-";
        const string ESPACE = " ";
        const char BS = '_';
        const char MN = '-';
        #endregion LocalContantes


        /// <summary>
        /// 
        /// </summary>
        /// <param name="html"></param>
        /// <param name="actionName">Nombre de la accion</param>
        /// <param name="linkText">Texto de la accion</param>
        /// <param name="tooltip">Texto para el tooltip</param>
        /// <param name="routeValues">Valores de route</param>
        /// <param name="htmlAttributes">Atributos del elemento</param>
        /// <param name="typeButton"></param>
        /// <param name="icon"></param>
        /// <returns></returns>
        public static MvcHtmlString ActionLinkBootstrap(
            this HtmlHelper html,
            string linkText,
            string actionName,
            object routeValues = null,
            object htmlAttributes = null,
            Buttons typeButton = Buttons.Default,
            Icons icon = Icons.None,
            string tooltip = "")
        {
            var url = new UrlHelper(html.ViewContext.RequestContext);
            var builder = new TagBuilder(A);
            builder.MergeAttribute(HREF, url.Action(actionName, routeValues));

            if (!string.IsNullOrEmpty(tooltip))
                builder.MergeAttributes(
                    new Dictionary<string, object>()
                        {
                            { REF, TOOLTIP }, 
                            { DATA_PLACEMENT, TOP }, 
                            { TITLE, tooltip }
                        }
                    );

            IDictionary<string, object> attributes = HtmlHelper.AnonymousObjectToHtmlAttributes(htmlAttributes);
            if (attributes != null)
                builder.MergeAttributes(attributes, true);

            builder.AddCssClass(EnumUtils.stringValueOf(typeButton));//types.Select(t => t.GetStringValue()));    

            if (icon != Icons.None)
            {
                var glyph = new TagBuilder(SPAN);
                glyph.MergeAttribute(CLASS, PRE_CLASS_ICONS + icon.ToString().Replace(BS, MN).ToLowerInvariant());
                builder.InnerHtml = glyph + ESPACE + linkText.Trim();
            }
            else
            {
                builder.InnerHtml = linkText;
            }
            return MvcHtmlString.Create(builder.ToString());
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="html"></param>
        /// <param name="linkText"></param>
        /// <param name="actionName"></param>
        /// <param name="typeButton"></param>
        /// <param name="icon"></param>
        /// <param name="tooltip"></param>
        /// <returns></returns>
        public static MvcHtmlString ActionLinkBootstrap(
            this HtmlHelper html,
            string linkText,
            string actionName,
            Buttons typeButton = Buttons.Default,
            Icons icon = Icons.None,
            string tooltip = "")
        {
            return ActionLinkBootstrap(html, linkText, actionName, null, null, typeButton, icon, tooltip);
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="textButton"></param>
        /// <param name="htmlAttributes"></param>
        /// <param name="typeButton"></param>
        /// <returns></returns>
        public static MvcHtmlString SubmitButtonBootstrap(this HtmlHelper html, string textButton, Buttons typeButton = Buttons.Default, object htmlAttributes = null)
        {
            var builder = new TagBuilder(BUTTON);
            builder.MergeAttribute(TYPE, SUBMIT);
            builder.SetInnerText(textButton);
            if (htmlAttributes != null)
            {
                builder.MergeAttributes(HtmlHelper.AnonymousObjectToHtmlAttributes(htmlAttributes));
            }
            builder.AddCssClass(EnumUtils.stringValueOf(typeButton));
            return MvcHtmlString.Create(builder.ToString());
        }

       

        
    }
}
