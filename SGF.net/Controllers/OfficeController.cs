using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using SGF.net.Models;

namespace SGF.net.Controllers
{
    public class OfficeController : Controller
    {
        private XenosENEntities db = new XenosENEntities();

        //
        // GET: /Office/

        public ActionResult Index()
        {
            return View(db.offices.ToList());
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