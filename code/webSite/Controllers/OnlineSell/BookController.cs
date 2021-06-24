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
        //客户查看所有书籍
        public ActionResult Index()
        {
            List<db.bks_Book> list = db.bll.client.books.getBooks();
            return View(list);
        }

        [HttpGet]
        public ActionResult TrolleyAdd(string bookcode)
        {
            sv_shopTrolley entry= db.bll.client.books.getEntry(bookcode);
            return View(entry);
        }

        [HttpPost]
        //客户加入购物车
        public ActionResult TrolleyAdd(string customerCode,string bookcode,int quantity)
        {
            db.bll.client.user.AddToCart(customerCode, bookcode, quantity);
            return View();
        }

    }
}