using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Parcial_Uno_GPI.Models
{
    public class MenuSingleton
    {
        public static bool nuevasCategorias = false;
        private static MenuSingleton instance = null;
        public string texto1 = "";
        public string texto2 = "";
        public MenuSingleton()
        {
            ParcialUnoEntities contexto = new ParcialUnoEntities();
            var data = contexto.Accion.ToList();
            texto1 = data.Where(x => x.idAccion == 1).First().accion1;
            texto2 = data.Where(x => x.idAccion == 2).First().accion1;

        }

        public static MenuSingleton Instance
        {
            get
            {
                if (instance == null || nuevasCategorias)
                    instance = new MenuSingleton();
                return instance;
            }
        }
    }
}