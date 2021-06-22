using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace db.bll.client
{
    public class books
    {
        public static List<db.bks_Book> getBooks()
        {
            dbEntities dc = new dbEntities();
            List<db.bks_Book> list = dc.bks_Book.ToList<db.bks_Book>();
            return list;
        }
        public static db.bks_Book getEntry(string bookcode)
        {
            dbEntities dc = new dbEntities();
            db.bks_Book entry = dc.bks_Book.SingleOrDefault(a => a.bookCode == bookcode);
            return entry;
        }
    }
}
