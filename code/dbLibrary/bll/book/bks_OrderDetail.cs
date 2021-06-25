using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace db.bll 
{
    public class bks_OrderDetail
    {
        /// <summary>
        /// 生成编号
        /// </summary>
        /// <param name="dc"></param>
        /// <returns></returns>
        private static int _createDetailNo(string orderCode, db.dbEntities dc)
        {
            int value = 0;
            var result = from a in dc.bks_OrderDetail
                         where a.orderCode == orderCode
                         orderby a.bookCode descending
                         select a.bookCode;
            if (result.Count() == 0)
                value = 1;
            else
                value = rui.typeHelper.toInt(result.First()) + 1;
            return value;
        }
        public static db.bks_OrderDetail getEntryByRowID(string rowID, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc); 
            //dc = ef.dc;

            db.bks_OrderDetail entry = dc.bks_OrderDetail.SingleOrDefault(a => a.rowID == rowID);
            return entry;
        }
        public static db.bks_OrderDetail getEntryByCode(string keyCode, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            db.bks_OrderDetail entry = dc.bks_OrderDetail.SingleOrDefault(a => a.orderCode == keyCode);
            return entry;
        }
    }
}
