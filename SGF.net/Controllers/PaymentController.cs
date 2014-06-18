using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using SGF.net.Models;
using PagedList;

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
