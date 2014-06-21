//Contiene la logica y la capa negocios para los gestion de pagos 
//Tiene todas las funciones CRUD necesarias para que me funcione en la vista
//Utiliza metodos de ordenamiento y paginacion en el ViewResult

using System.Linq;
using System.Web.Mvc;
using SGF.net.Models;


namespace SGF.net.Controllers
{
    public class PaymentController : Controller
    {
        private XenosENEntities db = new XenosENEntities();
        //
        // GET: /Payment/

        public ActionResult Index()
        {
            var ViewPayments = db.View_PendingsPayments;
            return View(ViewPayments.ToList());

            
        }

    }
}
