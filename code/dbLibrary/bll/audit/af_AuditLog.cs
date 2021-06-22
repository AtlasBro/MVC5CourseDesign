using db.lib;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace db.bll
{
    /// <summary>
    /// 审批日志
    /// </summary>
    public class af_AuditLog
    {
        /// <summary>
        /// 获取某条审批日期的打印标记
        /// </summary>
        /// <param name="rowID"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static string getPrintTag(string rowID, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc); 

            string sql = " SELECT printTag FROM af_AuditLog WHERE rowID=@rowID ";
            return rui.typeHelper.toString(ef.ExecuteScalar(sql, new { rowID }));
        }

        /// <summary>
        /// 通过行号获取节点信息
        /// </summary>
        /// <param name="rowID"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static DataRow getByRowID(string rowID, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc); 

            string sql = " SELECT relatedRowID,relatedKeyCode,auditTypeCode,nodeCode FROM af_AuditLog WHERE rowID=@rowID ";
            return ef.ExecuteDataRow(sql, new { rowID });
        }

        /// <summary>
        /// 获取当前单据当前节点中参审的所有人员列表（包括免审的）,单据驳回用
        /// </summary>
        /// <param name="nodeCode"></param>
        /// <param name="auditTypeCode"></param>
        /// <param name="relatedRowID"></param>
        /// <param name="relatedKeyCode"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static List<string> getAuditUserCodeList(string nodeCode, string auditTypeCode, string relatedRowID, string relatedKeyCode, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc); 

            string sql = @" SELECT DISTINCT userCode FROM af_AuditLog
                WHERE nodeCode=@nodeCode AND auditTypeCode=@auditTypeCode AND relatedRowID=@relatedRowID AND relatedKeyCode=@relatedKeyCode ";
            DataTable table = ef.ExecuteDataTable(sql, new { nodeCode, auditTypeCode, relatedRowID, relatedKeyCode });
            return rui.dbTools.getList(table, "userCode");
        }

        /// <summary>
        /// 获取某个单据某个节点的已审批通过的人员列表
        /// </summary>
        /// <param name="nodeCode"></param>
        /// <param name="auditTypeCode"></param>
        /// <param name="relatedRowID"></param>
        /// <param name="relatedKeyCode"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        private static string _getAuditUserName(string nodeCode, string auditTypeCode, string relatedRowID, string relatedKeyCode, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc); 

            string sql = @" SELECT DISTINCT userName FROM af_AuditLog
                LEFT JOIN rbac_User ON af_AuditLog.userCode = rbac_User.userCode
                WHERE nodeCode=@nodeCode AND auditTypeCode=@auditTypeCode AND relatedRowID=@relatedRowID AND relatedKeyCode=@relatedKeyCode ";
            DataTable table = ef.ExecuteDataTable(sql, new { nodeCode, auditTypeCode, relatedRowID, relatedKeyCode });
            return rui.dbTools.getShowExpression(table, "userName");
        }

        /// <summary>
        /// 获取日志中某个节点关联的驳回列表
        /// </summary>
        /// <param name="logRowID"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static DataTable getRejectList(string logRowID, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc); 

            DataRow row = db.bll.af_AuditLog.getByRowID(logRowID, dc);
            string nodeCode = row["nodeCode"].ToString();
            string relatedRowID = row["relatedRowID"].ToString();
            string relatedKeyCode = row["relatedKeyCode"].ToString();
            string auditTypeCode = row["auditTypeCode"].ToString();

            string sql = @" SELECT recordType,userCode,passType,startNodeCode,nodeCode FROM af_AuditLog 
                    WHERE nodeCode!=@nodeCode AND auditTypeCode=@auditTypeCode AND relatedRowID=@relatedRowID AND relatedKeyCode=@relatedKeyCode ";
            DataTable logDt = ef.ExecuteDataTable(sql, new { nodeCode, auditTypeCode, relatedRowID, relatedKeyCode });

            //构建表结构
            DataTable returnDt = new DataTable();
            returnDt.Columns.Add("节点编号");
            returnDt.Columns.Add("记录类型");
            returnDt.Columns.Add("通过类型");
            returnDt.Columns.Add("参与人员");

            //首先获取送审节点，通过送审获取下一级节点（直到结束）
            DataRow[] logRows = logDt.Select("recordType='送审'");
            if (logRows.Length > 0)
            {
                DataRow returnRow = returnDt.NewRow();
                returnRow["节点编号"] = logRows[0]["nodeCode"];
                returnRow["记录类型"] = logRows[0]["recordType"];
                returnRow["通过类型"] = logRows[0]["passType"];
                returnDt.Rows.Add(returnRow);
                _getRejectListSub(logDt, returnDt, logRows[0]["nodeCode"].ToString());
            }
            //设置节点审批人员信息
            foreach (DataRow item in returnDt.Rows)
            {
                item["参与人员"] = _getAuditUserName(item["节点编号"].ToString(), auditTypeCode, relatedRowID, relatedKeyCode, dc);
            }
            return returnDt;
        }

        /// <summary>
        /// 递归调用的子方法 -- 驳回列表调用
        /// </summary>
        /// <param name="logDt"></param>
        /// <param name="returnDt"></param>
        /// <param name="nodeCode"></param>
        private static void _getRejectListSub(DataTable logDt, DataTable returnDt, string nodeCode)
        {
            //首先获取送审节点，通过送审获取下一级节点（直到结束）
            DataRow[] logRows = logDt.Select("startNodeCode='" + nodeCode + "'");
            if (logRows.Length > 0)
            {
                DataRow returnRow = returnDt.NewRow();
                returnRow["节点编号"] = logRows[0]["nodeCode"];
                returnRow["记录类型"] = logRows[0]["recordType"];
                returnRow["通过类型"] = logRows[0]["passType"];
                returnDt.Rows.Add(returnRow);
                _getRejectListSub(logDt, returnDt, logRows[0]["nodeCode"].ToString());
            }
        }


        /// <summary>
        /// 通过【职务名称，单据编号】获取审批人和审批时间，单据打印用
        /// 存在漏洞风险，如果不同单据编号有重复的会出现问题（出现问题后，给方法增加审批类型参数）
        /// </summary>
        /// <param name="post"></param>
        /// <param name="relatedKeyCode"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static string getAuditUserName(rui.ePostName post, string relatedKeyCode, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc); 

            string sql = @"  SELECT af_AuditLog.userCode,userName,auditDate FROM af_AuditLog 
              INNER JOIN rbac_User ON af_AuditLog.userCode = rbac_User.userCode
              WHERE auditResult='通过' and auditRemark !='免审' and relatedKeyCode=@relatedKeyCode AND printTag=@printTag  ";
            DataTable table = ef.ExecuteDataTable(sql, new { relatedKeyCode, printTag = post.ToString() });
            string value = "";
            string time = "";
            string str = "";
            foreach (DataRow row in table.Rows)
            {
                value += row["userName"].ToString() + ",";
                time += row["auditDate"].ToString() + ",";
            }
            if (value.Length > 0)
            {
                value = value.Substring(0, value.Length - 1);
            }
            if (time.Length > 0)
            {
                //进行类型的转换 改变日期的展示形式 然后进行字符串的拼接
                time = time.Substring(0, time.Length - 1);
                DateTime tim = Convert.ToDateTime(time);
                str = tim.ToLongDateString().ToString();
            }
            string result = value + "<br/>" + str;
            if (result == "<br/>")
                return "";
            return result;
        }
    }
}
