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

        //public ActionResult Index()
        //{
        //    var ViewPayments = db.View_PendingsPayments;           

        //    return View(ViewPayments.ToList());
        //}

        public ViewResult Index(string sortOrder, string currentFilter, string searchString, int? page)
        {
            ViewBag.CurrentSort = sortOrder;
            ViewBag.NameSortParm = String.IsNullOrEmpty(sortOrder) ? "name_desc" : "";

            if (searchString != null)
            {
                page = 1;
            }
            else
            {
                searchString = currentFilter;
            }

            ViewBag.CurrentFilter = searchString;          


            var tbl = db.View_PendingsPayments.OrderBy(s => s.NombreFull);

                     
            int pageSize = 10;
            int pageNumber = (page ?? 1);
            return View(tbl.ToPagedList(pageNumber, pageSize));
        }

    }
}
