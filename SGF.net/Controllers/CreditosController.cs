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
    public class CreditosController : Controller
    {
        private XenosENEntities db = new XenosENEntities();

        //
        // GET: /Creditos/

        //public ActionResult Index()
        //{
        //    var memberloans = db.memberLoans.Include(m => m.loanTypes).Include(m => m.memberLoansStatus).Include(m => m.members);
        //    return View(memberloans.ToList());
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



            var tbl = from s in db.memberLoans.Include(m => m.loanTypes).Include(m => m.memberLoansStatus).Include(m => m.members)

                      select s;
            tbl = tbl.Where(s => s.members.documentId != string.Empty);
            if (!String.IsNullOrEmpty(searchString))
            {
                tbl = tbl.Where(s => s.members.documentId.ToUpper().Contains(searchString.ToUpper()));
            }
            switch (sortOrder)
            {
                case "name_desc":
                    tbl = tbl.OrderByDescending(s => s.memberLoansStatus.name);
                    break;

                default:
                    tbl = tbl.OrderBy(s => s.memberLoansStatus.name);
                    break;
            }
            int pageSize = 10;
            int pageNumber = (page ?? 1);
            return View(tbl.ToPagedList(pageNumber, pageSize));
        }

        //
        // GET: /Creditos/Details/5

        public ActionResult Details(int id = 0, int id2 = 0)
        {
            memberLoans memberloans = db.memberLoans.Find(id,id2);
            if (memberloans == null)
            {
                return HttpNotFound();
            }
            return View(memberloans);
        }

        //
        // GET: /Creditos/Create

        public ActionResult Create()
        {
            ViewBag.loanTypeId = new SelectList(db.loanTypes, "loanTypeId", "name");
            ViewBag.memberLoanStatusId = new SelectList(db.memberLoansStatus, "memberLoanStatusId", "name");
            ViewBag.memberId = new SelectList(db.members, "memberId", "fullname");

           

            return View();
        }

        //
        // POST: /Creditos/Create

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(memberLoans memberloans)
        {
            if (ModelState.IsValid)
            {
                db.memberLoans.Add(memberloans);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.loanTypeId = new SelectList(db.loanTypes, "loanTypeId", "name", memberloans.loanTypeId);
            ViewBag.memberLoanStatusId = new SelectList(db.memberLoansStatus, "memberLoanStatusId", "name", memberloans.memberLoanStatusId);
            ViewBag.memberId = new SelectList(db.members, "memberId", "fullname", memberloans.memberId);
            return View(memberloans);
        }

        //
        // GET: /Creditos/Edit/5

        public ActionResult Edit(int id = 0, int id2 = 0)
        {
            memberLoans memberloans = db.memberLoans.Find(id, id2);
            if (memberloans == null)
            {
                return HttpNotFound();
            }
            ViewBag.loanTypeId = new SelectList(db.loanTypes, "loanTypeId", "name", memberloans.loanTypeId);
            ViewBag.memberLoanStatusId = new SelectList(db.memberLoansStatus, "memberLoanStatusId", "name", memberloans.memberLoanStatusId);
            ViewBag.memberId = new SelectList(db.members, "memberId", "fullname", memberloans.memberId);
            return View(memberloans);
        }

        //
        // POST: /Creditos/Edit/5

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(memberLoans memberloans)
        {
            if (ModelState.IsValid)
            {
                db.Entry(memberloans).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.loanTypeId = new SelectList(db.loanTypes, "loanTypeId", "name", memberloans.loanTypeId);
            ViewBag.memberLoanStatusId = new SelectList(db.memberLoansStatus, "memberLoanStatusId", "name", memberloans.memberLoanStatusId);
            ViewBag.memberId = new SelectList(db.members, "memberId", "fullname", memberloans.memberId);
            return View(memberloans);
        }

        //
        // GET: /Creditos/Delete/5

        public ActionResult Delete(int id = 0, int id2 = 0)
        {
            memberLoans memberloans = db.memberLoans.Find(id,id2);
            if (memberloans == null)
            {
                return HttpNotFound();
            }
            return View(memberloans);
        }

        //
        // POST: /Creditos/Delete/5

        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id, int id2)
        {
            memberLoans memberloans = db.memberLoans.Find(id,id2);
            db.memberLoans.Remove(memberloans);
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