﻿//Muestra unicamente la pagina home nada en especial
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;


namespace SGF.net.Controllers
{
    public class HomeController : Controller
    {       
        
        //
        // GET: /Home/

        public ActionResult Index()
        {
            return View();
        }



        

    }
}
