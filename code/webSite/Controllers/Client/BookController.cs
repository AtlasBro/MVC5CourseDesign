using db;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace web.Controllers.Client
{
    public class BookController : Controller
    {
        // GET: Book
        public ActionResult Index()
        {
            List<db.bks_Book> list = db.bll.client.books.getBooks();
            return View(list);
        }

    }
}