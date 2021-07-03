using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace db.bll
{
    public class bks_customerAddress
    {
        public static string getCodeByRowID(string rowID, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            string sql = "select rowNum from dbo.bks_CustomerAddress where rowID=@rowID ";
            object value = ef.ExecuteScalar(sql, new { rowID });
            return rui.typeHelper.toString(value);
        }
        public static db.bks_CustomerAddress getEntryByRowID(string rowID, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc); dc = ef.dc;

            db.bks_CustomerAddress entry = dc.bks_CustomerAddress.Single(a => a.rowID == rowID);
            return entry;
        }
        private static void _checkInput(db.bks_CustomerAddress entry)
        {
            rui.dataCheck.checkNotNull(entry.addressName, "地址");
            rui.dataCheck.checkNotNull(entry.isDefault, "是否默认");
        }
        //新增
        public static string insert(db.bks_CustomerAddress entry, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            //if (rui.typeHelper.isNullOrEmpty(entry.bookCode))
            //    entry.bookCode = _createCode(dc);
            //else if (dc.bks_Book.Count(a => a.bookCode == entry.bookCode) > 0)
            //{
            //    rui.excptHelper.throwEx("编号已存在");
            //}

            //检查数据合法性
            _checkInput(entry);
            //设置字段默认值
            entry.rowID = ef.newGuid();
            dc.bks_CustomerAddress.Add(entry);
            dc.SaveChanges();
            return entry.rowID;
        }
        //修改
        public static void update(db.bks_CustomerAddress entry, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            //检查数据合法性
            _checkInput(entry);

            efHelper.entryUpdate(entry, dc);
            ////保存封面图
            //List<string> surfacePicList = rui.webDiskHelper.saveUploadFiles("/upload/bks_book", "surfacePic");
            //if (surfacePicList.Count > 0)
            //    entry.surfacePic = surfacePicList[0];

            dc.SaveChanges();
        }
        public static void delete(string rowID, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);
            try
            {
                ef.beginTran();
                //删除
                ef.Execute("DELETE from dbo.bks_customerAddress where rowID=@rowID ", new { rowID });
                ef.commit();
            }
            catch (Exception ex)
            {
                ef.rollBack();
                rui.logHelper.log(ex, true);
            }
        }
    }
}
