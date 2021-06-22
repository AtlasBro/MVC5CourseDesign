using LitJson;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace db.bll
{
    /// <summary>
    /// 审批流
    /// </summary>
    public class af_AuditFlow
    {
        /// <summary>
        /// 生成编号
        /// </summary>
        /// <param name="dc"></param>
        /// <returns></returns>
        private static string _createKeyCode(db.dbEntities dc)
        {
            string Code = "AF";
            string result = (from a in dc.af_AuditFlow
                             where a.flowCode.StartsWith(Code)
                             select a.flowCode).Max();
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

        /// <summary>
        /// 新增
        /// </summary>
        /// <param name="entry"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static string insert(db.af_AuditFlow entry, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            if (rui.typeHelper.isNullOrEmpty(entry.flowCode))
                entry.flowCode = _createKeyCode(dc);

            entry.rowID = ef.newGuid();
            dc.af_AuditFlow.Add(entry);
            dc.SaveChanges();
            return entry.rowID;
        }

        /// <summary>
        /// 修改
        /// </summary>
        /// <param name="entry"></param>
        /// <param name="dc"></param>
        public static void update(db.af_AuditFlow entry, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            efHelper.entryUpdate(entry, dc);
            dc.SaveChanges();
        }

        /// <summary>
        /// 删除
        /// </summary>
        /// <param name="keyCode"></param>
        /// <param name="dc"></param>
        public static void delete(string keyCode, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            try
            {
                //删除检测
                ef.checkCanDelete("af_AuditLog", "flowCode", keyCode, "已生成审批记录，不允许删除");

                //删除相关表 af_AuditNode和af_NodeRelation
                ef.beginTran();
                var cmdPara = new { flowCode = keyCode };
                ef.Execute(" DELETE FROM af_NodeRelation WHERE flowCode=@flowCode ", cmdPara);
                ef.Execute(" DELETE FROM af_AuditNode WHERE flowCode=@flowCode ", cmdPara);
                ef.Execute(" DELETE FROM af_AuditFlow WHERE flowCode=@flowCode ", cmdPara);
                ef.commit();
            }
            catch (Exception ex)
            {
                ef.rollBack();
                rui.logHelper.log(ex, true);
            }
        }

        /// <summary>
        /// 通过rowID获取主键
        /// </summary>
        /// <param name="rowID"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static string getKeyByRowID(string rowID, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            string sql = " SELECT flowCode FROM af_AuditFlow WHERE rowID=@rowID ";
            return rui.typeHelper.toString(ef.ExecuteScalar(sql, new { rowID }));
        }

        /// <summary>
        /// 通过编号获取名称
        /// </summary>
        /// <param name="code"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static string getNameByCode(string code, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            if (String.IsNullOrWhiteSpace(code))
                return "";
            string sql = " SELECT flowName FROM af_AuditFlow WHERE flowCode=@flowCode ";
            return rui.typeHelper.toString(ef.ExecuteScalar(sql, new { flowCode = code }));
        }

        /// <summary>
        /// 获取实体
        /// </summary>
        /// <param name="rowID"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static db.af_AuditFlow getEntryByRowID(string rowID, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            return dc.af_AuditFlow.Single(a => a.rowID == rowID);
        }
        public static db.af_AuditFlow getEntryByCode(string keyCode, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            return dc.af_AuditFlow.Single(a => a.auditTypeCode == keyCode);
        }

        /// <summary>
        /// 启用
        /// </summary>
        /// <param name="keyFieldValues"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static string toUse(string keyFieldValues, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            List<string> KeyFieldList = rui.dbTools.getList(keyFieldValues);
            Dictionary<string, string> errorDic = new Dictionary<string, string>();

            string sqlCheck = " SELECT flowCode,isUse FROM af_AuditFlow WHERE flowCode in @flowCode and isUse='是' ";
            DataTable table = ef.ExecuteDataTable(sqlCheck, new { flowCode = KeyFieldList });

            foreach (string flowCode in KeyFieldList)
            {
                try
                {
                    DataRow[] rows = table.Select("flowCode='" + flowCode + "'");
                    rui.dbTools.checkRowFieldValue(rows, "isUse", "是", "已启用");

                    string sql = " UPDATE af_AuditFlow SET isUse='是' WHERE isUse='否' and flowCode=@flowCode ";
                    ef.Execute(sql, new { flowCode });
                }
                catch (Exception ex)
                {
                    errorDic.Add(flowCode, rui.excptHelper.getExMsg(ex));
                    rui.logHelper.log(ex);
                }
            }
            return rui.dbTools.getBatchMsg("批量启用", KeyFieldList.Count, errorDic);
        }

        /// <summary>
        /// 禁用
        /// </summary>
        /// <param name="keyFieldValues"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static string toNoUse(string keyFieldValues, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            List<string> KeyFieldList = rui.dbTools.getList(keyFieldValues);
            Dictionary<string, string> errorDic = new Dictionary<string, string>();

            string sqlCheck = " SELECT flowCode,isUse FROM af_AuditFlow WHERE flowCode in @flowCode and isUse='否' ";
            DataTable table = ef.ExecuteDataTable(sqlCheck, new { flowCode = KeyFieldList });

            foreach (string flowCode in KeyFieldList)
            {
                try
                {
                    DataRow[] rows = table.Select("flowCode='" + flowCode + "'");
                    rui.dbTools.checkRowFieldValue(rows, "isUse", "否", "已禁用");

                    string sql = " UPDATE af_AuditFlow SET isUse='否' WHERE isUse='是' and flowCode=@flowCode ";
                    ef.Execute(sql, new { flowCode });
                }
                catch (Exception ex)
                {
                    errorDic.Add(flowCode, rui.excptHelper.getExMsg(ex));
                    rui.logHelper.log(ex);
                }
            }
            return rui.dbTools.getBatchMsg("批量禁用", KeyFieldList.Count, errorDic);
        }

        /// <summary>
        /// 判断是否有节点(首先删除未保存的记录,无物流记录的也删除)
        /// </summary>
        /// <param name="rowID"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static bool hasNode(string rowID, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            string flowCode = db.bll.af_AuditFlow.getKeyByRowID(rowID, dc);
            ef.Execute(" DELETE FROM af_AuditNode WHERE flowCode=@flowCode AND nodeJson IS NULL ", new { flowCode });
            ef.Execute(" DELETE FROM af_NodeRelation WHERE flowCode=@flowCode AND nodeJson IS NULL ", new { flowCode });
            ef.Execute(" DELETE FROM af_AuditNode WHERE flowCode NOT IN (SELECT flowCode FROM af_NodeRelation) ");
            string sql = " SELECT rowID FROM af_AuditNode WHERE flowCode IN (SELECT flowCode FROM af_AuditFlow WHERE rowID=@rowID) ";
            return ef.ExecuteExist(sql, new { rowID });
        }

        /// <summary>
        /// 获取节点信息
        /// 返回键值对集合
        /// </summary>
        /// <param name="rowID"></param>
        /// <returns></returns>
        public static Dictionary<string, string> getWFJson(string rowID, dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            Dictionary<string, string> dic = new Dictionary<string, string>();
            string flowCode = dc.af_AuditFlow.SingleOrDefault(a => a.rowID == rowID).flowCode;
            //获取开始节点
            {
                db.af_AuditNode node = dc.af_AuditNode.SingleOrDefault(a => a.flowCode == flowCode && a.nodeType == "start");
                dic.Add("begin", node.nodeJson);
            }
            //获取活动节点,将节点的name属性设置到元素上
            {
                var result = from a in dc.af_AuditNode
                             where a.flowCode == flowCode && a.nodeType == "active"
                             select a;
                string actives = "";
                foreach (var item in result)
                    actives += _setNodeName(item.nodeJson, item.nodeDesc) + "*";
                actives = rui.stringHelper.removeLastChar(actives);
                dic.Add("actives", actives);
            }
            //获取路由节点
            {
                var result = from a in dc.af_NodeRelation
                             where a.flowCode == flowCode
                             select a;
                string routes = "";
                foreach (var item in result)
                    routes += item.nodeJson + "*";
                routes = rui.stringHelper.removeLastChar(routes);
                dic.Add("routes", routes);
            }
            //获取结束节点
            {
                db.af_AuditNode node = dc.af_AuditNode.SingleOrDefault(a => a.flowCode == flowCode && a.nodeType == "end");
                dic.Add("end", node.nodeJson);
            }
            return dic;
        }

        /// <summary>
        /// 设置节点名称
        /// </summary>
        /// <param name="nodeJson"></param>
        /// <param name="name"></param>
        /// <returns></returns>
        private static string _setNodeName(string nodeJson, string name)
        {
            if (name != "")
            {
                JsonData json = JsonMapper.ToObject(nodeJson);
                json["name"] = name;
                string value = JsonMapper.ToJson(json);
                return value;
            }
            return nodeJson;
        }

        /// <summary>
        /// 添加部门审批流管理
        /// </summary>
        /// <param name="rowID"></param>
        /// <param name="selectedItems"></param>
        /// <param name="dc"></param>
        public static void addDept(string rowID, string selectedItems, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            string flowCode = db.bll.af_AuditFlow.getKeyByRowID(rowID, dc);
            List<string> itemList = rui.dbTools.getList(selectedItems);
            foreach (string deptCode in itemList)
            {
                ef.Execute(" INSERT INTO af_AuditFlowDept(rowID,flowCode, deptCode) VALUES (@rowID,@flowCode,@deptCode) ",
                    new { rowID = ef.newGuid(), flowCode, deptCode });
            }
        }

        /// <summary>
        /// 删除部门审批流关联
        /// </summary>
        /// <param name="rowID"></param>
        /// <param name="selectedItems"></param>
        /// <param name="dc"></param>
        public static void deleteDept(string rowID, string selectedItems, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            string flowCode = db.bll.af_AuditFlow.getKeyByRowID(rowID, dc);
            List<string> itemList = rui.dbTools.getList(selectedItems);
            List<string> sqlList = new List<string>();
            foreach (string deptCode in itemList)
            {
                ef.Execute(" DELETE FROM af_AuditFlowDept WHERE flowCode=@flowCode and deptCode=@deptCode ", new { flowCode, deptCode });
            }
        }
    }
}
