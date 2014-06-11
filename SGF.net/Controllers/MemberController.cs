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
    public class MemberController : Controller
    {
        private XenosENEntities db = new XenosENEntities();
        //
        // GET: /Member/

        //public ActionResult Index()
        //{
        //    var members = db.members.Include(m => m.memberMaritalStatus).Include(m => m.memberPaymentTypes).Include(m => m.offices);
        //    return View(members.ToList());
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

            

            var tbl = from s in db.members.Include(m => m.memberMaritalStatus).Include(m => m.memberPaymentTypes).Include(m => m.offices)

                      select s;
            tbl = tbl.Where(s => s.documentId != string.Empty);
            if (!String.IsNullOrEmpty(searchString))
            {
                tbl = tbl.Where(s => s.documentId.ToUpper().Contains(searchString.ToUpper()));
            }
            switch (sortOrder)
            {
                case "name_desc":
                    tbl = tbl.OrderByDescending(s => s.firstName);
                    break;

                default:
                    tbl = tbl.OrderBy(s => s.firstName);
                    break;
            }
            int pageSize = 10;
            int pageNumber = (page ?? 1);
            return View(tbl.ToPagedList(pageNumber, pageSize));
        }
               

        //
        // GET: /Member/Details/5

        public ActionResult Details(int id = 0)
        {
            members members = db.members.Find(id);
            if (members == null)
            {
                return HttpNotFound();
            }
            return View(members);
        }

        //
        // GET: /Member/Create

        public ActionResult Create()
        {
            ViewBag.maritalStatusId = new SelectList(db.memberMaritalStatus, "maritalStatusId", "name");
            ViewBag.paymentTypeId = new SelectList(db.memberPaymentTypes, "paymentTypeId", "name");
            ViewBag.officeId = new SelectList(db.offices, "officeId", "officeName");
            return View();
        }

        //
        // POST: /Member/Create

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(members members)
        {
            if (ModelState.IsValid)
            {
                db.members.Add(members);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.maritalStatusId = new SelectList(db.memberMaritalStatus, "maritalStatusId", "name", members.maritalStatusId);
            ViewBag.paymentTypeId = new SelectList(db.memberPaymentTypes, "paymentTypeId", "name", members.paymentTypeId);
            ViewBag.officeId = new SelectList(db.offices, "officeId", "officeName", members.officeId);
            return View(members);
        }

        //
        // GET: /Member/Edit/5

        public ActionResult Edit(int id = 0)
        {
            members members = db.members.Find(id);
            if (members == null)
            {
                return HttpNotFound();
            }
            ViewBag.maritalStatusId = new SelectList(db.memberMaritalStatus, "maritalStatusId", "name", members.maritalStatusId);
            ViewBag.paymentTypeId = new SelectList(db.memberPaymentTypes, "paymentTypeId", "name", members.paymentTypeId);
            ViewBag.officeId = new SelectList(db.offices, "officeId", "officeName", members.officeId);
            return View(members);
        }

        //
        // POST: /Member/Edit/5

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(members members)
        {
            if (ModelState.IsValid)
            {
                db.Entry(members).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.maritalStatusId = new SelectList(db.memberMaritalStatus, "maritalStatusId", "name", members.maritalStatusId);
            ViewBag.paymentTypeId = new SelectList(db.memberPaymentTypes, "paymentTypeId", "name", members.paymentTypeId);
            ViewBag.officeId = new SelectList(db.offices, "officeId", "officeName", members.officeId);
            return View(members);
        }

        //
        // GET: /Member/Delete/5

        public ActionResult Delete(int id = 0)
        {
            members members = db.members.Find(id);
            if (members == null)
            {
                return HttpNotFound();
            }
            return View(members);
        }

        //
        // POST: /Member/Delete/5

        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            members members = db.members.Find(id);
            db.members.Remove(members);
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