﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace db.bll.client
{
    public class bks_BookType
    {
        public static DataTable getTable(db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);
            string sql = " SELECT rowID,bookTypeCode,bookTypeName FROM dbo.bks_BookType ";
            DataTable table = ef.ExecuteDataTable(sql);
            return table;
        }
    }
}
