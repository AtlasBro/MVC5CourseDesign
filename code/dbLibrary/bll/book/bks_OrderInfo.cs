using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Web.Mvc;
using System.Text;
using System.Threading.Tasks;

namespace db.bll 
{
    public class bks_OrderInfo
    {
        private static string _createCode(db.dbEntities dc)
        {
            string Code = "PK" + DateTime.Now.ToString("yyyyMMdd");
            string result = (from a in dc.bks_OrderInfo
                             where a.orderCode.StartsWith(Code)
                             select a.orderCode).Max();
            if (result != null)
            {
                Code = rui.stringHelper.codeNext(result, 4);
            }
            else
            {
                Code = Code + "0001";
            }
            return Code;
        }
        private static void _checkInput(db.bks_OrderInfo entry)
        {
            rui.dataCheck.checkNotNull(entry.orderCode, "订单编号");
            rui.dataCheck.checkNotNull(entry.customerCode, "图书编号");
            rui.dataCheck.checkNotNull(entry.addressCode, "价格");
           
        }
        public static string insert(db.bks_Book entry, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            if (rui.typeHelper.isNullOrEmpty(entry.bookCode))
                entry.bookCode = _createCode(dc);
            else if (dc.bks_Book.Count(a => a.bookCode == entry.bookCode) > 0)
            {
                rui.excptHelper.throwEx("编号已存在");
            }

            //检查数据合法性
            //_checkInput(entry);

            //设置字段默认值
            entry.isSell = "否";
            entry.stockSum = 0;
            entry.sellSum = 0;
            entry.rowID = ef.newGuid();
            dc.bks_Book.Add(entry);
            dc.SaveChanges();
            return entry.rowID;
        }

        //修改
        public static void update(db.bks_Book entry, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            //检查数据合法性
            //_checkInput(entry);

            efHelper.entryUpdate(entry, dc);
            dc.SaveChanges();
        }

        //删除
        public static void delete(string rowID, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);
            try
            {
                string keyCode = getCodeByRowID(rowID, dc);
                //删除前检查
                ef.checkCanDelete("bks_BookStockDetail", "bookCode", keyCode, "已进货，不允许删除");
                ef.checkCanDelete("bks_ShoppingTrolley", "bookCode", keyCode, "已被用户加入购物车，不允许删除");
                ef.checkCanDelete("bks_OrderDetail", "bookCode", keyCode, "已被客户采购，不允许删除");

                //删除
                ef.Execute("DELETE from dbo.bks_Book where rowID=@rowID ", new { rowID });
            }
            catch (Exception ex)
            {
                rui.logHelper.log(ex);
                throw ex;
            }
        }

        //通过rowID获取主键
        public static string getCodeByRowID(string rowID, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            string sql = "select orderCode from dbo.bks_OrderInfo where rowID=@rowID ";
            object value = ef.ExecuteScalar(sql, new { rowID });
            return rui.typeHelper.toString(value);
        }

        //通过rowID获取名称
        //public static string getNameByRowID(string rowID, db.dbEntities dc)
        //{
        //    efHelper ef = new efHelper(ref dc);

        //    string sql = "select bookName from dbo.bks_Book where rowID=@rowID ";
        //    object value = ef.ExecuteScalar(sql, new { rowID });
        //    return rui.typeHelper.toString(value);
        //}

        //通过编号获取名称
        //public static string getNameByCode(string keyCode, db.dbEntities dc)
        //{
        //    efHelper ef = new efHelper(ref dc);

        //    string sql = "select bookName from dbo.bks_OrderInfo where orderCode=@orderCode ";
        //    object value = ef.ExecuteScalar(sql, new { bookCode = keyCode });
        //    return rui.typeHelper.toString(value);
        //}

        //获取实体
        public static db.bks_OrderInfo getEntryByRowID(string rowID, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc); dc = ef.dc;

            db.bks_OrderInfo entry = dc.bks_OrderInfo.Single(a => a.rowID == rowID);
            return entry;
        }

        //获取实体
        public static db.bks_OrderInfo getEntryByCode(string keyCode, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            db.bks_OrderInfo entry = dc.bks_OrderInfo.SingleOrDefault(a => a.orderCode == keyCode);
            return entry;
        }
        public static string batchpush(string keyFieldValues, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);
            
            List<string> KeyFieldList = rui.dbTools.getList(keyFieldValues);
            Dictionary<string, string> errorDic = new Dictionary<string, string>();

            //查询批量操作中已显示的记录，用于提示
            string sqlCheck = " SELECT orderCode,status FROM dbo.bks_OrderInfo WHERE orderCode IN @orderCode AND status='NA' ";
            DataTable table = ef.ExecuteDataTable(sqlCheck, new { orderCode = KeyFieldList });
            foreach (string orderCode in KeyFieldList)
            {
                try
                {
                    //检查遍历的数据是否已上架
                    DataRow[] rows = table.Select("orderCode='" + orderCode + "'");
                    rui.dbTools.checkRowFieldValue(rows, "status", "SP", "已发货");

                    string sql = " UPDATE bks_OrderInfo SET status='SP' WHERE orderCode=@orderCode ";
                    if (ef.Execute(sql, new { orderCode }) == 0)
                        rui.excptHelper.throwEx("数据未变更");
                }
                catch (Exception ex)
                {
                    errorDic.Add(orderCode, rui.excptHelper.getExMsg(ex));
                    rui.logHelper.log(ex);
                }
            }
            return rui.dbTools.getBatchMsg("发货", KeyFieldList.Count, errorDic);
        }
    }
}
