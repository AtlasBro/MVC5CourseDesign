using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace db.client.bll
{
    public class bks_ShoppingTrolley
    {
        public static void addCart1(string customerCode,string bookCode,db.dbEntities dc)
        {
            efHelper ef = new efHelper();

            db.bks_ShoppingTrolley entry = dc.bks_ShoppingTrolley.SingleOrDefault(a => a.customerCode==customerCode&&a.bookCode==bookCode);
            if (entry == null)
            {
                entry = new db.bks_ShoppingTrolley();
                entry.customerCode = customerCode;
                entry.bookCode = bookCode;
                entry.quantity = 1;
                entry.rowID = ef.newGuid();
                dc.bks_ShoppingTrolley.Add(entry);
            }
            else
            {
                entry.quantity++;
            }
            dc.SaveChanges();
        }
        public static void addNum1(string customerCode, string bookCode, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);
            db.bks_ShoppingTrolley entry = dc.bks_ShoppingTrolley
                .SingleOrDefault(a => a.customerCode == customerCode && a.bookCode == bookCode);
            entry.quantity++;
            dc.SaveChanges();
        }
        public static void subNum1(string customerCode, string bookCode, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);
            db.bks_ShoppingTrolley entry = dc.bks_ShoppingTrolley
                .SingleOrDefault(a => a.customerCode == customerCode && a.bookCode == bookCode);
            entry.quantity--;
            if (entry.quantity == 0)
            {
                dc.bks_ShoppingTrolley.Remove(entry);
            }
            dc.SaveChanges();
        }
        public static Dictionary<string,int> getShopping()
        {
            Dictionary<string, int> shopping = rui.sessionHelper.getValue<Dictionary<string, int>>("shopping");
            if (shopping == null)
            {

            }
            return shopping;
        }
    }
}
