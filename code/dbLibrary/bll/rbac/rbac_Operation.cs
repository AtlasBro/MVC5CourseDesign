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
    /// rui
    /// 系统操作
    /// </summary>
    public class rbac_Operation
    {
        /// <summary>
        /// 通过单个编号获取单个名称
        /// </summary>
        /// <param name="code"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static string getNameByCode(string code, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc); 

            if (String.IsNullOrWhiteSpace(code))
                return "";

            string sql = " SELECT operationName FROM rbac_Operation WHERE operationCode=@operationCode ";
            return rui.typeHelper.toString(ef.ExecuteScalar(sql, new { operationCode = code }));
        }

        /// <summary>
        /// 通过多个编号获取名称，分割
        /// </summary>
        /// <param name="codes"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static string getNamesByCodes(string codes,db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc); 

            if (String.IsNullOrWhiteSpace(codes))
                return "";

            List<string> list = (from a in codes.Split(',')
                                 where a.Length > 0
                                 select a).ToList<string>();
            string inExpr = rui.dbTools.getInExpression(list);
            string sql = " SELECT operationName FROM rbac_Operation WHERE operationCode in @operationCode ";
            DataTable table = ef.ExecuteDataTable(sql, new { operationCode = rui.dbTools.getDpList(codes) });
            return rui.dbTools.getShowExpression(table, "operationName");
        }

        /// <summary>
        /// 绑定下拉框
        /// </summary>
        /// <param name="has请选择"></param>
        /// <returns></returns>
        public static List<SelectListItem> bindDdl(bool has请选择 = false)
        {
            efHelper ef = new efHelper();
            string sql = "SELECT operationCode as code,operationName as name FROM dbo.rbac_Operation order by showOrder asc";
            DataTable table = ef.ExecuteDataTable(sql);
            List<SelectListItem> list = rui.listHelper.dataTableToDdlList(table, has请选择, "");
            return list;
        }
    }
}
