using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace db.client.bll
{
    public class bks_BookType
    {
        //返回所有的图书类型信息
        public static DataTable getTable(db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);
            string sql = " SELECT rowID,bookTypeCode,bookTypeName FROM dbo.bks_BookType ";
            DataTable table = ef.ExecuteDataTable(sql);
            return table;
        }
    }
}
