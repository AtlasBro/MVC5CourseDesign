using LitJson;
using System.Data;
using System.Linq;


namespace db.bll
{
    /// <summary>
    /// 审批节点
    /// </summary>
    public class af_AuditNode
    {
        /// <summary>
        /// 通过NodeCode获取对象
        /// </summary>
        /// <param name="nodeCode"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static db.af_AuditNode getEntryByCode(string nodeCode, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc); 

            db.af_AuditNode node = dc.af_AuditNode.SingleOrDefault(a => a.nodeCode == nodeCode);
            return node;
        }

        /// <summary>
        /// 修改
        /// </summary>
        /// <param name="entry"></param>
        /// <param name="dc"></param>
        public static void update(db.af_AuditNode entry, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc); 

            //修正打印标记
            var result = from a in dc.af_AuditLog
                         where a.nodeCode == entry.nodeCode && a.printTag != entry.printTag
                         select a;
            foreach (var item in result)
            {
                item.printTag = entry.printTag;
            }
            efHelper.entryUpdate(entry, dc);
            dc.SaveChanges();
        }

        /// <summary>
        /// 创建开始和结束节点
        /// </summary>
        /// <param name="rowID"></param>
        /// <param name="startID"></param>
        /// <param name="endID"></param>
        /// <param name="dc"></param>
        public static void createStartAndEnd(string rowID, string startID, string endID, dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc); 

            string flowCode = dc.af_AuditFlow.SingleOrDefault(a => a.rowID == rowID).flowCode;
            if (dc.af_AuditNode.Count(a => a.flowCode == flowCode) == 0)
            {
                //创建开始
                db.af_AuditNode start = new db.af_AuditNode();
                start.rowID = ef.newGuid();
                start.flowCode = flowCode;
                start.nodeCode = startID;
                start.nodeType = "start";
                start.printTag = "经办人";
                start.passType = "单人";
                start.isEmailInform = "是";
                start.isNoteInform = "是";
                dc.af_AuditNode.Add(start);

                //创建结束
                db.af_AuditNode end = new db.af_AuditNode();
                end.rowID = ef.newGuid();
                end.flowCode = flowCode;
                end.nodeCode = endID;
                end.nodeType = "end";
                start.printTag = "经办人";
                end.passType = "单人";
                end.isEmailInform = "是";
                end.isNoteInform = "是";
                dc.af_AuditNode.Add(end);

                dc.SaveChanges();
            }
        }


        /// <summary>
        /// 创建活动节点
        /// 当类型等于start和end时，需要判断是否已经有对应类型的节点，如果已经有对应类型的节点了，无需新增
        /// </summary>
        /// <param name="rowID">审批流行号</param>
        /// <param name="guidID">节点guidID</param>
        /// <param name="type">start,end,active</param>
        /// <returns></returns>
        public static void createNode(string rowID, string guidID, dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc); 

            string flowCode = dc.af_AuditFlow.SingleOrDefault(a => a.rowID == rowID).flowCode;
            db.af_AuditNode node = new db.af_AuditNode();
            node = new db.af_AuditNode();
            node.rowID = ef.newGuid();
            node.flowCode = flowCode;
            node.nodeCode = guidID;
            node.nodeType = "active";
            node.printTag = "部门经理";
            node.passType = "单人";
            node.isEmailInform = "是";
            node.isNoteInform = "是";
            dc.af_AuditNode.Add(node);
            dc.SaveChanges();
        }

        /// <summary>
        /// 创建路由节点
        /// </summary>
        /// <param name="rowID">审批流行号</param>
        /// <param name="guidID">路由节点guidID</param>
        /// <param name="startID"></param>
        /// <param name="endID"></param>
        /// <param name="dc"></param>
        public static void createRoute(string rowID, string guidID, string startID, string endID, dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc); 

            string flowCode = dc.af_AuditFlow.SingleOrDefault(a => a.rowID == rowID).flowCode;
            db.af_NodeRelation route = new db.af_NodeRelation();
            route.rowID = ef.newGuid();
            route.flowCode = flowCode;
            route.startNodeCode = startID;
            route.endNodeCode = endID;
            route.nodeGuid = guidID;
            dc.af_NodeRelation.Add(route);
            dc.SaveChanges();
        }

        /// <summary>
        /// 移除节点（如果节点类型是start和end，不允许删除）
        /// 当type="active"时,需要将其对应的路由节点一起删除
        /// </summary>
        /// <param name="rowID">审批流行号</param>
        /// <param name="guidID"></param>
        /// <param name="type">active,route</param>
        public static void dropElement(string rowID, string guidID, string type, dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc); 

            //只需要删除路由节点
            if (type == "route")
            {
                db.af_NodeRelation entry = dc.af_NodeRelation.SingleOrDefault(a => a.nodeGuid == guidID);
                dc.af_NodeRelation.Remove(entry);
                dc.SaveChanges();
            }
            //删除节点，并删除其关联的路由节点(开始和结束节点不允许删除)
            if (type == "active")
            {
                db.af_AuditNode node = dc.af_AuditNode.SingleOrDefault(a => a.nodeCode == guidID);
                if (node.nodeType != "start" && node.nodeType != "end")
                {
                    dc.af_AuditNode.Remove(node);
                    var result = from a in dc.af_NodeRelation
                                 where a.startNodeCode == guidID || a.endNodeCode == guidID
                                 select a;
                    foreach (db.af_NodeRelation route in result)
                        dc.af_NodeRelation.Remove(route);
                    dc.SaveChanges();
                }
            }
        }

        /// <summary>
        /// 保存节点
        /// 保存节点的json信息
        /// </summary>
        /// <param name="rowID">审批流行号</param>
        /// <param name="startJson">开始节点的guidID</param>
        /// <param name="activeJson">活动节点集合</param>
        /// <param name="routeJsons">路由节点集合</param>
        /// <param name="endJson">结束节点的guidID</param>
        /// <param name="dc"></param>
        public static void saveJson(string rowID, string startJson, string activeJsons, string routeJsons, string endJson, dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc); 

            string flowCode = dc.af_AuditFlow.SingleOrDefault(a => a.rowID == rowID).flowCode;
            //处理开始节点
            {
                JsonData data = JsonMapper.ToObject(startJson);
                string nodeID = data["id"].ToString();
                db.af_AuditNode node = dc.af_AuditNode.SingleOrDefault(a => a.flowCode == flowCode && a.nodeCode == nodeID);
                node.nodeJson = startJson;
            }
            //处理活动节点
            {
                var result = from a in activeJsons.Split('*')
                             where a.Length > 0
                             select a;
                foreach (string item in result)
                {
                    JsonData data = JsonMapper.ToObject(item);
                    string nodeID = data["id"].ToString();
                    db.af_AuditNode node = dc.af_AuditNode.SingleOrDefault(a => a.flowCode == flowCode && a.nodeCode == nodeID);
                    node.nodeJson = item;
                }
            }
            //处理路由节点
            {
                var result = from a in routeJsons.Split('*')
                             where a.Length > 0
                             select a;
                foreach (string item in result)
                {
                    JsonData data = JsonMapper.ToObject(item);
                    string nodeID = data["id"].ToString();
                    db.af_NodeRelation node = dc.af_NodeRelation.SingleOrDefault(a => a.flowCode == flowCode && a.nodeGuid == nodeID);
                    node.nodeJson = item;
                }
            }
            //处理结束节点
            {
                JsonData data = JsonMapper.ToObject(endJson);
                string nodeID = data["id"].ToString();
                db.af_AuditNode node = dc.af_AuditNode.SingleOrDefault(a => a.flowCode == flowCode && a.nodeCode == nodeID);
                node.nodeJson = endJson;
            }
            dc.SaveChanges();
        }

        /// <summary>
        /// 获取某个节点的审批类型
        /// </summary>
        /// <param name="flowCode"></param>
        /// <param name="nodeCode"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static string getPassType(string flowCode, string nodeCode, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc); 

            string sql = " SELECT passType FROM af_AuditNode WHERE flowCode=@flowCode AND nodeCode=@nodeCode ";
            return rui.typeHelper.toString(ef.ExecuteScalar(sql, new { flowCode, nodeCode }));
        }

        /// <summary>
        /// 获取某个节点的打印标记
        /// </summary>
        /// <param name="flowCode"></param>
        /// <param name="nodeCode"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static string getPrintTag(string flowCode, string nodeCode, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc); 

            string sql = " SELECT printTag FROM af_AuditNode WHERE flowCode=@flowCode AND nodeCode=@nodeCode ";
            return rui.typeHelper.toString(ef.ExecuteScalar(sql, new { flowCode, nodeCode }));
        }

        /// <summary>
        /// 获取某个节点所属审批流
        /// </summary>
        /// <param name="nodeCode"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static string getFlowCodeByNodeCode(string nodeCode, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc); 

            string sql = " SELECT flowCode FROM af_AuditNode WHERE nodeCode=@nodeCode ";
            return rui.typeHelper.toString(ef.ExecuteScalar(sql, new { nodeCode }));
        }

        /// <summary>
        /// 符号转换
        /// </summary>
        /// <param name="fieldName"></param>
        /// <param name="value"></param>
        /// <returns></returns>
        public static string tranfer(string fieldName, string value)
        {
            switch (fieldName)
            {
                case "nodeType":
                    switch (value)
                    {
                        case "start":
                            return "开始";
                        case "active":
                            return "中间";
                        case "end":
                            return "结束";
                    }
                    break;
            }
            return "";
        }
    }
}
