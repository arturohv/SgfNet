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
    public class OfficeController : Controller
    {
        private XenosENEntities db = new XenosENEntities();

        //
        // GET: /Office/

        //public ActionResult Index()
        //{
        //    return View(db.offices.ToList());
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

            var tbl = from s in db.offices

                      select s;
            tbl = tbl.Where(s => s.officeName != string.Empty);
            if (!String.IsNullOrEmpty(searchString))
            {
                tbl = tbl.Where(s => s.officeName.ToUpper().Contains(searchString.ToUpper()));
            }
            switch (sortOrder)
            {
                case "name_desc":
                    tbl = tbl.OrderByDescending(s => s.officeName);
                    break;

                default:
                    tbl = tbl.OrderBy(s => s.officeName);
                    break;
            }
            int pageSize = 3;
            int pageNumber = (page ?? 1);
            return View(tbl.ToPagedList(pageNumber, pageSize));
        }

        //
        // GET: /Office/Details/5

        public ActionResult Details(int id = 0)
        {
            offices offices = db.offices.Find(id);
            if (offices == null)
            {
                return HttpNotFound();
            }
            return View(offices);
        }

        //
        // GET: /Office/Create

        public ActionResult Create()
        {
            return View();
        }

        //
        // POST: /Office/Create

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(offices offices)
        {
            if (ModelState.IsValid)
            {
                db.offices.Add(offices);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(offices);
        }

        //
        // GET: /Office/Edit/5

        public ActionResult Edit(int id = 0)
        {
            offices offices = db.offices.Find(id);
            if (offices == null)
            {
                return HttpNotFound();
            }
            return View(offices);
        }

        //
        // POST: /Office/Edit/5

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(offices offices)
        {
            if (ModelState.IsValid)
            {
                db.Entry(offices).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(offices);
        }

        //
        // GET: /Office/Delete/5

        public ActionResult Delete(int id = 0)
        {
            offices offices = db.offices.Find(id);
            if (offices == null)
            {
                return HttpNotFound();
            }
            return View(offices);
        }

        //
        // POST: /Office/Delete/5

        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            offices offices = db.offices.Find(id);
            db.offices.Remove(offices);
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