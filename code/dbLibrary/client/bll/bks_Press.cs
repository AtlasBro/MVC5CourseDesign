using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace db.client.bll
{
    public class bks_Press
    {
        //返回所有出版社信息
        public static DataTable getTable(db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);
            string sql = " SELECT rowID,pressCode,pressName FROM dbo.bks_Press ";
            DataTable table = ef.ExecuteDataTable(sql);
            return table;
        }
    }
}
