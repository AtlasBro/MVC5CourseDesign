using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Mvc;

namespace db.bll
{
    /// <summary>
    /// 资源权限明细
    /// </summary>
    public class rbac_ResourceOp
    {
        //新增权限(单据新增)
        public static void insert(string resourceCode,db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            db.rbac_ResourceOp entry = new db.rbac_ResourceOp();

            entry.rowID = ef.newGuid();
            entry.resourceCode = resourceCode;
            dc.rbac_ResourceOp.Add(entry);
            dc.SaveChanges();
            setSortOrder(dc);
        }

        //批量新增
        public static void batchInsert(string resourceCode,string haveOperations,db.dbEntities dc)
        {
            List<string> list = rui.dbTools.getList(haveOperations);
            foreach(var item in list)
            {
                db.bll.rbac_ResourceOp.insert(resourceCode, item, dc);
            }
        }

        //从选择项目中新增
        public static void insert(string resourceCode,string keyCode,db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            db.rbac_ResourceOp entry = dc.rbac_ResourceOp.SingleOrDefault(a => a.resourceCode == resourceCode
                && a.operationCode == keyCode);
            if (entry == null)
            {
                entry = new db.rbac_ResourceOp();

                entry.rowID = ef.newGuid();
                entry.resourceCode = resourceCode;
                entry.operationCode = keyCode;
                entry.operationName = db.bll.rbac_Operation.getNameByCode(keyCode, dc);
                dc.rbac_ResourceOp.Add(entry);
            }
            dc.SaveChanges();
            setSortOrder(dc);
        }

        //设置排序号为空的等于行号
        public static void setSortOrder(db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);
            string sql = " UPDATE dbo.rbac_ResourceOp SET showOrder=rowNum WHERE ISNULL(showOrder,0)=0 ";
            ef.Execute(sql);
        }

        //删除权限
        public static void delete(string rowID,db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            string sql = " delete from rbac_ResourceOp where rowID=@rowID ";
            ef.Execute(sql, new { rowID });
        }

        //删除权限
        public static void delete(string resourceCode,string opCode,db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            string sql = " delete from rbac_ResourceOp where resourceCode=@resourceCode and operationCode=@operationCode ";
            ef.Execute(sql, new { resourceCode, operationCode = opCode });
        }

        //保存数据
        public static string batchSave(db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);
            Dictionary<string, List<string>> dic = new Dictionary<string, List<string>>();
            dic.Add("rowID", rui.requestHelper.getList("rowIDList"));
            dic.Add("operationCode", rui.requestHelper.getList("operationCodeList"));
            dic.Add("operationName", rui.requestHelper.getList("operationNameList"));
            dic.Add("showOrder", rui.requestHelper.getList("showOrderList"));
            List<db.rbac_ResourceOp> list = efHelper.getEntryList<db.rbac_ResourceOp>(dc, dic);
            foreach (db.rbac_ResourceOp item in list)
            {
                db.rbac_ResourceOp entry = dc.rbac_ResourceOp.SingleOrDefault(a => a.rowID == item.rowID);
                entry.operationCode = item.operationCode;
                entry.operationName = item.operationName;
                entry.showOrder = item.showOrder;
                if (rui.typeHelper.isNullOrEmpty(entry.showOrder))
                    entry.showOrder = entry.rowNum;
            }
            dc.SaveChanges();

            string value = rui.dbTools.getShowExpression(dic["operationCode"]);
            if (value.Length > 0)
                value = value + ",";
            return value;
        }

        /// <summary>
        /// 绑定下拉框
        /// </summary>
        /// <param name="has请选择"></param>
        /// <returns></returns>
        public static List<SelectListItem> bindDdl(string resourceCode, bool has请选择 = false)
        {
            efHelper ef = new efHelper();
            string sql = "   SELECT operationCode AS code,operationName AS name FROM dbo.rbac_ResourceOp WHERE resourceCode=@resourceCode ORDER BY showOrder ASC ";
            DataTable table = ef.ExecuteDataTable(sql,new { resourceCode });
            List<SelectListItem> list = rui.listHelper.dataTableToDdlList(table, has请选择, "");
            return list;
        }
    }
}
