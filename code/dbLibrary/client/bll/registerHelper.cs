using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace db.client.bll
{
    public class registerHelper
    {
        public static void SaveAccount(view.Register model,dbEntities dc)
        {
                db.bks_Customer p = new bks_Customer
                {
                    customerCode = model.customerCode,
                    cusomterName = model.cusomterName,
                    password = model.password,
                    email = model.email,
                    telphone = model.telphone
                };
                dc.bks_Customer.Add(p);
                dc.SaveChanges();
        }
        public static bool IsRepeat(view.Register model, dbEntities dc)
        {
            db.bks_Customer entry = dc.bks_Customer.FirstOrDefault(a => a.customerCode == model.customerCode);
            if (entry != null)
            {
                return false;
            }
            return true;
        }
    }
}
