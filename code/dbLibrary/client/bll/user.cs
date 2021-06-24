using db;
using db.view.client;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace db.bll.client
{
    public class user
    {
        //保存用户数据
        public static void save(userinfo model)
        {
            dbEntities dc = new dbEntities();
            bks_Customer entry = new bks_Customer
            {
                cusomterName = model.CustomerName,
                customerCode = model.CustomerCode,
                password = model.password,
                email = model.email,
                telphone = model.telephone
            };
            dc.bks_Customer.Add(entry);
            dc.SaveChanges();
        }

        //比较登录信息
        public static string getUserName(string cusomterName)
        {
            dbEntities dc = new dbEntities();
            efHelper ef = new efHelper(ref dc);
            string sql = "select cusomterName FROM bks_Customer WHERE cusomterName=@cusomterName";
            return rui.typeHelper.toString(ef.ExecuteScalar(sql, new { cusomterName })).Trim();
        }
        public static string getUserPass(string cusomterName)
        {
            dbEntities dc = new dbEntities();
            efHelper ef = new efHelper(ref dc);
            string sql = "select password FROM bks_Customer WHERE cusomterName=@cusomterName";
            return rui.typeHelper.toString(ef.ExecuteScalar(sql,new { cusomterName })).Trim();
        }

        //增加到购物车
        public static void AddToCart(string customerCode,string bookCode,int quantity)
        {
            dbEntities dc = new dbEntities();
            bks_ShoppingTrolley entry = new bks_ShoppingTrolley();
            entry.customerCode = customerCode;
            entry.bookCode = bookCode;
            entry.quantity = quantity;
            dc.bks_ShoppingTrolley.Add(entry);
            dc.SaveChanges();
        }
    }
}
