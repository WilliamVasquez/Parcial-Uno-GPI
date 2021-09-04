using Parcial_Uno_GPI.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity.SqlServer;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Parcial_Uno_GPI.Controllers
{
    public class HomeController : Controller
    {
        ParcialUnoEntities contexto = new ParcialUnoEntities();
        public ActionResult Index()
        {
            if (Session["permiso"] != null)
                return RedirectToAction(Session["permiso"].ToString());
            else
                return View();
        }
        public ActionResult Admin()
        {
            if (Session["permiso"] != null)
                return View();
            else
                return RedirectToAction("Index");
        }
        public ActionResult LogOut()
        {
            Session.Clear();
            Session.Abandon();
            return RedirectToAction("Index");
        }
        [HttpPost]
        public JsonResult ValidUser(Usuarios us)
        {
            try
            {
                var data = (from cu in contexto.Usuarios
                            join cp in contexto.Vista on cu.rol equals cp.idVista
                            where (cu.nameUser == us.nameUser)
                            select new
                            {
                                vista = cp.vista1,
                                nombre = cu.nameUser,
                                pass = cu.passUser
                            }).SingleOrDefault();
                if (data != null && Utilidades.Estado(us.passUser, data.pass))
                {
                    Session["permiso"] = data.vista;
                    Session["nombre"] = data.nombre;
                    return Json("Bienvenido " + Session["nombre"]);
                }
                else
                {
                    return Json("No");
                }
            }
            catch (Exception e)
            {
                return Json(e.Message);
            }
        }

        public ActionResult Alertas()
        {
            string h = "0";
            List<MateriaPrima> data = contexto.MateriaPrima.ToList();
            ViewBag.alertas = data.Where(x => x.estado.ToString().Equals(h)).ToList();
            return View();
        }
    }
}
