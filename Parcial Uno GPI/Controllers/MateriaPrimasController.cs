using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using Parcial_Uno_GPI.Models;

namespace Parcial_Uno_GPI.Controllers
{
    public class MateriaPrimasController : Controller
    {
        private ParcialUnoEntities db = new ParcialUnoEntities();

        // GET: MateriaPrimas
        public ActionResult Index()
        {
            return View(db.MateriaPrima.ToList());
        }

        // GET: MateriaPrimas/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            MateriaPrima materiaPrima = db.MateriaPrima.Find(id);
            if (materiaPrima == null)
            {
                return HttpNotFound();
            }
            return View(materiaPrima);
        }

        // GET: MateriaPrimas/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: MateriaPrimas/Create
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "idMaterial,nombreMat,descripcionMat,stock,medida,stockMinimo,estado")] MateriaPrima materiaPrima)
        {
            if (ModelState.IsValid)
            {
                db.MateriaPrima.Add(materiaPrima);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(materiaPrima);
        }

        // GET: MateriaPrimas/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            MateriaPrima materiaPrima = db.MateriaPrima.Find(id);
            if (materiaPrima == null)
            {
                return HttpNotFound();
            }
            return View(materiaPrima);
        }

        // POST: MateriaPrimas/Edit/5
        // Para protegerse de ataques de publicación excesiva, habilite las propiedades específicas a las que quiere enlazarse. Para obtener 
        // más detalles, vea https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "idMaterial,nombreMat,descripcionMat,stock,medida,stockMinimo,estado")] MateriaPrima materiaPrima)
        {
            if (ModelState.IsValid)
            {
                db.Entry(materiaPrima).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(materiaPrima);
        }

        // GET: MateriaPrimas/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            MateriaPrima materiaPrima = db.MateriaPrima.Find(id);
            if (materiaPrima == null)
            {
                return HttpNotFound();
            }
            return View(materiaPrima);
        }

        // POST: MateriaPrimas/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed([Bind(Include = "idMaterial,nombreMat,descripcionMat,stock,medida,stockMinimo,estado")] MateriaPrima materiaPrima)
        {
            if (ModelState.IsValid)
            {
                db.Entry(materiaPrima).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
