using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace db.bll
{
    public class sys_ExlImport
    {
        public static void importData(string tableName)
        {
            //根据表名调用对应业务类内的业务方法
            if (tableName == "bks_Press")
                db.bll.bks_Press.SaveData(null);
            if (tableName == "bks_BookStock")
            {
                db.bll.bks_BookStock.SaveData(null);
            }
                

        }
       
    }
}
