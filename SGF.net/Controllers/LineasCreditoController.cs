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
    public class LineasCreditoController : Controller
    {
        private XenosENEntities db = new XenosENEntities();

        //
        // GET: /LineasCredito/

        //public ActionResult Index()
        //{
        //    return View(db.loanTypes.ToList());
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

            var tbl = from s in db.loanTypes

                      select s;
            tbl = tbl.Where(s => s.name != string.Empty);
            if (!String.IsNullOrEmpty(searchString))
            {
                tbl = tbl.Where(s => s.name.ToUpper().Contains(searchString.ToUpper()));
            }
            switch (sortOrder)
            {
                case "name_desc":
                    tbl = tbl.OrderByDescending(s => s.name);
                    break;

                default:
                    tbl = tbl.OrderBy(s => s.name);
                    break;
            }
            int pageSize = 10;
            int pageNumber = (page ?? 1);
            return View(tbl.ToPagedList(pageNumber, pageSize));
        }

        //
        // GET: /LineasCredito/Details/5

        public ActionResult Details(int id = 0)
        {
            loanTypes loantypes = db.loanTypes.Find(id);
            if (loantypes == null)
            {
                return HttpNotFound();
            }
            return View(loantypes);
        }

        //
        // GET: /LineasCredito/Create

        public ActionResult Create()
        {
            return View();
        }

        //
        // POST: /LineasCredito/Create

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(loanTypes loantypes)
        {
            if (ModelState.IsValid)
            {
                db.loanTypes.Add(loantypes);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(loantypes);
        }

        //
        // GET: /LineasCredito/Edit/5

        public ActionResult Edit(int id = 0)
        {
            loanTypes loantypes = db.loanTypes.Find(id);
            if (loantypes == null)
            {
                return HttpNotFound();
            }
            return View(loantypes);
        }

        //
        // POST: /LineasCredito/Edit/5

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(loanTypes loantypes)
        {
            if (ModelState.IsValid)
            {
                db.Entry(loantypes).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(loantypes);
        }

        //
        // GET: /LineasCredito/Delete/5

        public ActionResult Delete(int id = 0)
        {
            loanTypes loantypes = db.loanTypes.Find(id);
            if (loantypes == null)
            {
                return HttpNotFound();
            }
            return View(loantypes);
        }

        //
        // POST: /LineasCredito/Delete/5

        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            loanTypes loantypes = db.loanTypes.Find(id);
            db.loanTypes.Remove(loantypes);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }
    }
}