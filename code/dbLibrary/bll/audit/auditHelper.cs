using db.bll;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace db.lib
{
    /// <summary>
    /// 审批的辅助类
    /// </summary>
    public class auditHelper
    {
        #region 与送审单据有关的方法

        /// <summary>
        /// 通过单据类型获取单据
        /// 每新增一个审批单据
        /// 1）就给auditType枚举增加了一个枚举项
        /// 2）通过IBill派生出一个单据类，完成接口内方法的实现
        /// 3）增加if判断，当type等于此类型是，返回此单据类的引用
        /// </summary>
        /// <param name="type"></param>
        /// <returns></returns>
        public static auditBill.IBill getBillByType(afType type)
        {
            auditBill.IBill bill = null;

            //通过传入的枚举返回对应的接口实现


            if (bill == null)
                rui.excptHelper.throwEx("未获取对应的单据类型");
            return bill;
        }

        /// <summary>
        /// 获取某个单据的所属部门
        /// </summary>
        /// <param name="type"></param>
        /// <param name="relatedRowID"></param>
        /// <returns></returns>
        private static string getDeptCode(afType type, long relatedRowID)
        {
            auditBill.IBill bill = getBillByType(type);
            return bill.getDeptCode(relatedRowID);
        }

        /// <summary>
        /// 更改单据的审批状态
        /// </summary>
        /// <param name="type"></param>
        /// <param name="relatedRowID"></param>
        /// <param name="newState"></param>
        /// <param name="dc"></param>
        private static void changeAuditStatus(afType type, long relatedRowID, string newState, db.dbEntities dc)
        {
            auditBill.IBill bill = getBillByType(type);
            bill.changeAuditStatus(relatedRowID, newState, dc);
        }

        /// <summary>
        /// 单据驳回到送审节点
        /// </summary>
        /// <param name="type"></param>
        /// <param name="relatedRowID"></param>
        /// <param name="dc"></param>
        private static void rejectToSend(afType type, long relatedRowID, db.dbEntities dc)
        {
            auditBill.IBill bill = getBillByType(type);
            bill.rejectToSend(relatedRowID, dc);
        }

        /// <summary>
        /// 设置单据审批通过
        /// </summary>
        /// <param name="type"></param>
        /// <param name="relatedRowID"></param>
        /// <param name="passDate"></param>
        /// <param name="dc"></param>
        private static void auditPass(afType type, long relatedRowID, DateTime passDate, db.dbEntities dc)
        {
            auditBill.IBill bill = getBillByType(type);
            bill.auditPass(relatedRowID, passDate, dc);
        }

        #endregion

        #region 与审批人员有关的方法
        /// <summary>
        /// 获取某个单据的送审人
        /// </summary>
        /// <param name="type"></param>
        /// <param name="relatedRowID"></param>
        /// <returns></returns>
        private static string getSendUserCode(afType type, long relatedRowID,db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc); 
            string sql = " SELECT userCode FROM  af_AuditLog WHERE auditTypeCode=@auditTypeCode AND relatedRowID=@relatedRowID AND recordType='送审' ORDER BY createDate DESC ";
            return rui.typeHelper.toString(ef.ExecuteScalar(sql, new { auditTypeCode = type.ToString(), relatedRowID }));
        }

        /// <summary>
        /// 获取某个节点可选审批人员列表
        /// </summary>
        /// <param name="nodeCode">节点编号</param>
        /// <param name="type">单据类型</param>
        /// <param name="relatedRowID">关联单据的行号</param>
        /// <returns></returns>
        private static DataTable getSelectUserList(string nodeCode, afType type, long relatedRowID,db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc); 
            DataRow row = ef.ExecuteDataRow(" SELECT selectUserCodes,selectRoleCodes,selectPostCodes FROM af_AuditNode WHERE nodeCode=@nodeCode ", new { nodeCode });
            DataTable table = new DataTable();
            //创建表结构
            {
                table.Columns.Add("userCode", typeof(string));
                table.Columns.Add("userName", typeof(string));
            }
            try
            {
                //获取各种审批人员
                table = rui.dbTools.margeDataTable(table, getUserListByUserCodes(row["selectUserCodes"].ToString(),dc), "userCode");
                table = rui.dbTools.margeDataTable(table, getUserListByRoleCodes(row["selectRoleCodes"].ToString(),dc), "userCode");
                table = rui.dbTools.margeDataTable(table, getUserListByPostCodes(row["selectPostCodes"].ToString(), type, relatedRowID,dc), "userCode");
            }
            catch (Exception ex)
            {
                rui.logHelper.log(ex,true);
            }
            return table;
        }

        /// <summary>
        /// 获取某个节点必审人员列表
        /// </summary>
        /// <param name="nodeCode">节点编号</param>
        /// <param name="type">单据类型</param>
        /// <param name="relatedRowID">关联单据的行号</param>
        /// <returns></returns>
        private static DataTable getMustUserList(string nodeCode, afType type, long relatedRowID,db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc); 
            string sql = " SELECT auditUserCodes,auditRoleCodes,auditPostCodes FROM af_AuditNode WHERE nodeCode=@nodeCode ";
            DataRow row = ef.ExecuteDataRow(sql, new { nodeCode });
            DataTable table = new DataTable();
            //创建表结构
            {
                table.Columns.Add("userCode", typeof(string));
                table.Columns.Add("userName", typeof(string));
            }
            try
            {
                //获取各种审批人员
                table = rui.dbTools.margeDataTable(table, getUserListByUserCodes(row["auditUserCodes"].ToString(),dc), "userCode");
                table = rui.dbTools.margeDataTable(table, getUserListByRoleCodes(row["auditRoleCodes"].ToString(),dc), "userCode");
                table = rui.dbTools.margeDataTable(table, getUserListByPostCodes(row["auditPostCodes"].ToString(), type, relatedRowID,dc), "userCode");
            }
            catch (Exception ex)
            {
                rui.logHelper.log(ex,true);
            }
            return table;
        }

        /// <summary>
        /// 通过用户编号列表,分割，获取用户信息
        /// </summary>
        /// <param name="userCodes"></param>
        /// <returns></returns>
        private static DataTable getUserListByUserCodes(string userCodes,db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc); 
            DataTable table = new DataTable();
            //创建表结构
            {
                table.Columns.Add("userCode", typeof(string));
                table.Columns.Add("userName", typeof(string));
            }
            if (String.IsNullOrWhiteSpace(userCodes) == false)
            {
                string sql = " SELECT userCode,userName FROM rbac_User WHERE CHARINDEX(userCode,@userCodes)>0 ";
                DataTable result = ef.ExecuteDataTable(sql, new { userCodes });
                table = rui.dbTools.margeDataTable(table, result, "userCode");
            }
            return table;
        }

        /// <summary>
        /// 通过角色编号,分割，获取人员列表
        /// </summary>
        /// <param name="roleCodes"></param>
        /// <returns></returns>
        private static DataTable getUserListByRoleCodes(string roleCodes,db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc); 
            DataTable table = new DataTable();
            //创建表结构
            {
                table.Columns.Add("userCode", typeof(string));
                table.Columns.Add("userName", typeof(string));
            }
            if (String.IsNullOrWhiteSpace(roleCodes) == false)
            {
                string sql = @" SELECT rbac_User.userCode,rbac_User.userName 
                    FROM rbac_User
                    LEFT JOIN rbac_RoleUser ON rbac_User.userCode = rbac_RoleUser.userCode
                    WHERE  CHARINDEX(roleCode,@roleCodes)>0 ";
                DataTable result = ef.ExecuteDataTable(sql, new { roleCodes });
                table = rui.dbTools.margeDataTable(table, result, "userCode");
            }
            return table;
        }

        /// <summary>
        /// 通过审核职务获取人员列表（需要部门信息）
        /// </summary>
        /// <param name="postCode"></param>
        /// <param name="type"></param>
        /// <param name="relatedRowID"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        private static DataTable getUserListByPostCodes(string postCode, afType type, long relatedRowID,db.dbEntities dc) {
            DataTable table = new DataTable();
            //创建表结构
            {
                table.Columns.Add("userCode", typeof(string));
                table.Columns.Add("userName", typeof(string));
            }
            //获取职务关联的所有人
            string deptCode = db.lib.auditHelper.getDeptCode(type, relatedRowID);
            DataTable result = db.bll.af_AuditPostUser.getPostUsers(deptCode, postCode,dc);
            if (result.Rows.Count == 0)
                rui.excptHelper.throwEx("该单据所属部门未设置" + db.bll.af_AuditPost.getNameByCode(postCode,dc) + "关联人员");
            table = rui.dbTools.margeDataTable(table, result, "userCode");

            return table;
        }

        #endregion

        /// <summary>
        /// 判断某种单据类型是否启用审批
        /// 如果不启用，则送审时，自动审批通过
        /// 如果启用，则需要根据审批流列表的个数来决定下一步操作
        /// </summary>
        /// <param name="type">单据类型</param>
        /// <returns></returns>
        public static bool auditTypeIsAudit(afType type,db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc); 
            string sql = " SELECT isAudit FROM af_AuditType WHERE auditTypeCode=@auditTypeCode  ";
            string value = rui.typeHelper.toString(ef.ExecuteScalar(sql, new { auditTypeCode = type.ToString() }));
            if (value == null)
                rui.excptHelper.throwEx("未创建该审批单据类型");

            if (value == "是")
                return true;
            else
                return false;
        }

        /// <summary>
        /// 获取某个审批流的起始节点
        /// 送审的时候用
        /// </summary>
        /// <param name="flowCode">审批流编号</param>
        /// <returns></returns>
        public static string getFirstNodeCode(string flowCode,db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc); 
            string sql = " SELECT nodeCode FROM af_NodeRelation WHERE flowCode=@flowCode AND nodeType='start' ";
            string value = rui.typeHelper.toString(ef.ExecuteScalar(sql, new { flowCode }));
            if (value == null)
                rui.excptHelper.throwEx("缺少起始节点");
            return value.ToString();
        }

        /// <summary>
        /// 获取某个审批流的当前节点的下一个审批流节点（多个分支，需要通过判断条件）,并成成审批日志===
        /// 审批过程中用
        /// 如果有多个下级，则根据条件来判断走哪一分支（如果那个分支都不满足，则生成异常，如果有多个分支，则取第一个匹配的）
        /// </summary>
        /// <param name="flowCode">审批流编号</param>
        /// <param name="startNodeCode">开始节点编号</param>
        /// <param name="type">单据类型</param>
        /// <param name="relatedRowID">关联单据的行号</param>
        /// <returns></returns>
        public static string getNextNodeCode(string flowCode, string startNodeCode,db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc); 
            string sql = " SELECT endNodeCode FROM af_NodeRelation WHERE flowCode=@flowCode AND startNodeCode=@startNodeCode ";
            string value = rui.typeHelper.toString(ef.ExecuteScalar(sql, new { flowCode, startNodeCode }));
            if (value == null)
                rui.excptHelper.throwEx("不存在下级节点");
            return rui.typeHelper.toString(value);
        }

        /// <summary>
        /// 判断某个节点是否开始节点（送审节点）
        /// </summary>
        /// <param name="nodeCode"></param>
        /// <returns></returns>
        private static bool isFirstNodeCode(string nodeCode,db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc); 
            string sql = " SELECT rowID FROM af_AuditNode WHERE nodeType='start' and nodeCode=@nodeCode ";
            return ef.ExecuteExist(sql, new { nodeCode });
        }

        /// <summary>
        /// 判断某个节点是否结束节点(倒数第二个节点)
        /// 当某个节点审批通过后，获取其下一级节点
        /// 判断节点是否结束节点，如果是，则审批结束，如果不是，则获取其必选人员名单和可选人员名单，生成审批日志。
        /// 如果是结束节点，则审批结束
        /// </summary>
        /// <param name="nodeCode"></param>
        /// <returns></returns>
        private static bool isEndNodeCode(string flowCode, string nodeCode,db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc); 
            string nextNodeCode = getNextNodeCode(flowCode, nodeCode, dc);
            string sql = " SELECT rowID FROM af_AuditNode WHERE nodeCode=@nodeCode AND nodeType='end' ";
            return ef.ExecuteExist(sql, new { nodeCode = nextNodeCode });
        }

        /// <summary>
        /// 生成某节点的审批日志
        /// </summary>
        /// <param name="startNodeCode"></param>
        /// <param name="nextNodeCode"></param>
        /// <param name="seletedUserCodes"></param>
        /// <param name="flowCode"></param>
        /// <param name="type"></param>
        /// <param name="relatedRowID"></param>
        /// <param name="dc"></param>
        public static void createAuditLog(string startNodeCode,string nextNodeCode, string seletedUserCodes, string flowCode, afType type, long relatedRowID, db.dbEntities dc)
        {
            auditBill.IBill bill = getBillByType(type);
            //1、获取节点必须审批人员列表
            DataTable mustAuditDt = getMustUserList(nextNodeCode, type, relatedRowID, dc);
            //2、获取选择的可选审批人员列表
            DataTable selectAuditDt = getUserListByUserCodes(seletedUserCodes, dc);
            mustAuditDt = rui.dbTools.margeDataTable(mustAuditDt, selectAuditDt, "userCode");
            if (mustAuditDt.Rows.Count == 0)
                rui.excptHelper.throwEx("未获取到下一级参审人员");
            //生成审批日志
            foreach (DataRow row in mustAuditDt.Rows)
            {
                db.af_AuditLog entry = new af_AuditLog();
                dc.af_AuditLog.Add(entry);
                bill.setRelatedInfo(relatedRowID, entry, dc);
                entry.auditTypeCode = type.ToString();
                entry.flowCode = flowCode;
                entry.startNodeCode = startNodeCode;
                entry.nodeCode = nextNodeCode;
                entry.userCode = row["userCode"].ToString();
                entry.createDate = DateTime.Now;
                entry.passType = db.bll.af_AuditNode.getPassType(flowCode, nextNodeCode, dc);
                entry.printTag = db.bll.af_AuditNode.getPrintTag(flowCode, nextNodeCode, dc);
                entry.recordType = "审批";
            }
        }

        /// <summary>
        /// 当节点审批结束后，调用节点处理方法
        /// 判断当前节点是否是结束节点
        ///    是：设置单据审批通过
        ///    否：获取单据的下一级节点，并生成下一级的审批日志
        /// </summary>
        /// <param name="nodeCode"></param>
        private static void dealNodeAuditCompleted(string flowCode, string nodeCode, afType type, long relatedRowID, string seletedUserCodes,DateTime passDate, db.dbEntities dc)
        {
            //判断是否结束节点，是则设置单据审批通过CL
            //不是结束节点，则设置审批中OP，并获取下一级节点编号，和审批人员，生成审批日志
            if (isEndNodeCode(flowCode,nodeCode,dc) == true)
            {
                auditPass(type, relatedRowID, passDate, dc);
            }
            else
            {
                //获取下一级节点，获取审批人员，生成下一级的审批日志
                {
                    string nextNodeCode = getNextNodeCode(flowCode, nodeCode,dc);
                    //生成下一级的审批日志
                    createAuditLog(nodeCode, nextNodeCode, seletedUserCodes, flowCode, type, relatedRowID, dc);
                }
            }
        }

        /// <summary>
        /// 获取某种单据类型在当前组织内启用的审批流列表 -- 外部调用方法
        /// 只获取启用的(如果存在多个启用的审批流，则提供用户选择的功能)
        /// 
        /// 1) 查询不与部门关联的本类型启用的单据
        /// 2) 查询与部门关联的本类型启用的单据
        /// </summary>
        /// <param name="type">单据类型</param>
        /// <param name="orgCode">所属组织</param>
        /// <returns></returns>
        public static DataTable getAuditFlowList(afType type, string orgCode,string deptCode,db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc); 
            //查询出没有被任何部门关联的审批流
            string sql = @" SELECT flowCode,flowName FROM dbo.af_AuditFlow 
                WHERE isUse='是' AND auditTypeCode=@auditTypeCode AND orgCode=@orgCode
                AND flowCode not in (SELECT distinct flowCode FROM dbo.af_AuditFlowDept) ";
            DataTable table = ef.ExecuteDataTable(sql, new { auditTypeCode = type.ToString(), orgCode });

            //查询出被本部门关联的审批流
            string sqlDept = @" SELECT flowCode,flowName FROM dbo.af_AuditFlow 
                WHERE isUse='是' AND auditTypeCode=@auditTypeCode AND orgCode=@orgCode 
                and flowCode in (SELECT flowCode FROM dbo.af_AuditFlowDept where deptCode=@deptCode) ";
            DataTable tableDept = ef.ExecuteDataTable(sqlDept,new { auditTypeCode=type.ToString(), orgCode, deptCode });

            rui.dbTools.margeDataTable(table, tableDept, "flowCode");
            
            return table;
        }

        /// <summary>
        /// 单据送审 -- 外部调用方法
        /// 0、判断该类型的单据是否启用审批流，如果没启用，则设置单据审批通过。
        /// 1、设置单据送审状态
        /// 2、生成送审记录
        /// 3、生成第一级节点的审批日志
        ///     获取节点的必须审批人员列表
        ///     获取节点的选择审批人员列表
        ///     合并两部分，生成审批日志表的数据
        /// </summary>
        /// <param name="flowCode">用户审批流</param>
        /// <param name="type">单据类型</param>
        /// <param name="relatedRowID">关联的单据行号</param>
        /// <param name="seletedUserCodes">选择的可选人员名单</param>
        public static string sendAudit(string flowCode, afType type, long relatedRowID, string seletedUserCodes, db.dbEntities dc)
        {
            string message = "";
            auditBill.IBill bill = getBillByType(type);
            //检查是否启用审批流,如果没启用，则单据送审后直接审批通过,生成一条审批日志
            if (auditTypeIsAudit(type,dc) == false)
            {
                //调用单据送审逻辑
                message = bill.sendAudit(flowCode, type, relatedRowID, seletedUserCodes, "未启用审批", dc);
                //审批通过逻辑
                db.lib.auditHelper.auditPass(type, relatedRowID,DateTime.Now, dc);
                dc.SaveChanges();
            }
            else
            {
                //调用单据送审逻辑
                message = bill.sendAudit(flowCode, type, relatedRowID, seletedUserCodes, "送审", dc);
                dc.SaveChanges();
            }
            return message;
        }

        /// <summary>
        /// 送审子方法，每个单据实现接口内调用
        /// </summary>
        /// <param name="flowCode"></param>
        /// <param name="type"></param>
        /// <param name="relatedRowID"></param>
        /// <param name="seletedUserCodes"></param>
        /// <param name="sendRemark"></param>
        /// <param name="dc"></param>
        public static void sendAuditSub(string flowCode, afType type, long relatedRowID, string seletedUserCodes, string sendRemark, dbEntities dc)
        {
            auditBill.IBill bill = getBillByType(type);
            //获取起始节点编号
            string firstNodeCode = db.lib.auditHelper.getFirstNodeCode(flowCode,dc);
            //生成送审日志
            {
                db.af_AuditLog entry = new af_AuditLog();
                dc.af_AuditLog.Add(entry);
                bill.setRelatedInfo(relatedRowID, entry, dc);
                //审批类型
                entry.auditTypeCode = type.ToString();
                entry.flowCode = flowCode;
                entry.nodeCode = firstNodeCode;
                entry.userCode = db.bll.loginAdminHelper.getUserCode();
                entry.createDate = DateTime.Now;
                entry.passType = "单人";
                entry.printTag = db.bll.af_AuditNode.getPrintTag(flowCode, firstNodeCode, dc);
                entry.recordType = "送审";
                entry.auditDate = DateTime.Now;
                entry.auditResult = "通过";
                entry.auditRemark = sendRemark;
            }
            //生成第一级审批日志
            if (sendRemark == "送审")
            {
                string nextNodeCode = db.lib.auditHelper.getNextNodeCode(flowCode, firstNodeCode,dc);
                db.lib.auditHelper.createAuditLog(firstNodeCode, nextNodeCode, seletedUserCodes, flowCode, type, relatedRowID, dc);
            }
        }

        /// <summary>
        /// 某个节点审批通过 -- 外部调用方法
        /// 首先通过行号获取日志信息
        /// 通过审批节点编号获取节点信息
        /// 判断节点的通过类型
        /// 如果是单人，则设置同一个单据所有未审的人免审，调用处理节点方法
        /// 如果是多人，则判断是否还有未审批的日志
        ///     有：则不做任何处理
        ///     无：调用处理节点方法
        /// </summary>
        /// <param name="logRowID">审批日志行号</param>
        public static void auditPass(string logRowID, string auditRemark, string seletedUserCodes,DateTime passDate, db.dbEntities dc)
        {
            db.af_AuditLog logEntry = dc.af_AuditLog.SingleOrDefault(a => a.rowID == logRowID);
            //当节点没有审批时，处理下边的逻辑
            if (logEntry.auditDate == null)
            {
                afType type = (db.lib.afType)Enum.Parse(typeof(db.lib.afType), logEntry.auditTypeCode);
                //设置单据审批中
                {
                    changeAuditStatus(type, logEntry.relatedRowID, rui.eAuditStatus.审批中.ToString(), dc);
                }
                //设置本节点审批通过
                {
                    logEntry.auditDate = passDate;
                    logEntry.auditResult = "通过";
                    logEntry.auditRemark = auditRemark;
                }
                //根据通过类型设置其它节点的审批状态
                if (logEntry.passType == "单人")
                {
                    //查询同一个单据同一个审批节点其它未审批的节点，设置免审
                    var result = from a in dc.af_AuditLog
                                 where a.auditTypeCode == logEntry.auditTypeCode
                                 && a.relatedRowID == logEntry.relatedRowID
                                 && a.relatedKeyCode == logEntry.relatedKeyCode
                                 && a.nodeCode == logEntry.nodeCode
                                 && a.rowID != logEntry.rowID 
                                 && a.auditDate == null
                                 select a;
                    foreach (var item in result)
                    {
                        item.auditDate = passDate;
                        item.auditResult = "通过";
                        item.auditRemark = "免审";
                    }
                    //调用节点审批结束处理方法
                    dealNodeAuditCompleted(logEntry.flowCode, logEntry.nodeCode, type, logEntry.relatedRowID, seletedUserCodes, passDate, dc);
                }
                if (logEntry.passType == "多人")
                {
                    //获取同一个单据同一个审批节点其它未审批的节点的个数
                    int count = (from a in dc.af_AuditLog
                                 where a.auditTypeCode == logEntry.auditTypeCode
                                 && a.relatedRowID == logEntry.relatedRowID
                                 && a.relatedKeyCode == logEntry.relatedKeyCode
                                 && a.nodeCode == logEntry.nodeCode
                                 && a.rowID != logEntry.rowID
                                 && a.auditDate == null
                                 select a).Count();
                    //同节点都审批完毕
                    if (count == 0)
                    {
                        //调用节点审批结束处理方法
                        dealNodeAuditCompleted(logEntry.flowCode, logEntry.nodeCode, type, logEntry.relatedRowID, seletedUserCodes, passDate, dc);
                    }
                }
                dc.SaveChanges();
            }
            else
            {
                rui.excptHelper.throwEx("已审批过");
            }
        }

        /// <summary>
        /// 审批驳回 -- 外部调用方法
        /// 0）修改该节点的审批状态
        /// 1）如果驳回到原点，则设置单据驳回(调用单据驳回逻辑，重新送审)
        /// 2）如果驳回的不是原点，则重新生成该节点的审批日志
        /// </summary>
        /// <param name="relatedRowID"></param>
        /// <param name="nodeCode">驳回的节点编号</param>
        public static void auditReject(string logRowID, long relatedRowID, string nodeCode, string auditRemark, db.dbEntities dc)
        {
            db.af_AuditLog logEntry = dc.af_AuditLog.SingleOrDefault(a => a.rowID == logRowID);
            //当节点没有审批时，处理下边的逻辑
            if (logEntry.auditDate == null)
            {
                afType type = (db.lib.afType)Enum.Parse(typeof(db.lib.afType), logEntry.auditTypeCode);
                auditBill.IBill bill = getBillByType(type);
                string flowCode = db.bll.af_AuditNode.getFlowCodeByNodeCode(nodeCode, dc);
                //设置本节点审批驳回
                {
                    logEntry.auditDate = DateTime.Now;
                    logEntry.auditResult = "驳回";
                    logEntry.auditRemark = auditRemark;

                    //获取同一个单据同一个审批节点其它未审批的节点，设置免审
                    var result = from a in dc.af_AuditLog
                                 where a.auditTypeCode == logEntry.auditTypeCode
                                 && a.relatedRowID == logEntry.relatedRowID
                                 && a.relatedKeyCode == logEntry.relatedKeyCode
                                 && a.nodeCode == logEntry.nodeCode
                                 && a.rowID != logEntry.rowID
                                 && a.auditDate == null
                                 select a;
                    foreach (var item in result)
                    {
                        item.auditDate = DateTime.Now;
                        item.auditResult = "驳回";
                        item.auditRemark = "免审";
                    }
                }
                //判断是否驳回原点
                if (isFirstNodeCode(nodeCode,dc))
                {
                    //驳回原点
                    bill.rejectToSend(relatedRowID, dc);
                }
                else
                {
                    //驳回到中间节点,获取该单据该节点已参审的人员,重新生成审批日志
                    List<string> list = db.bll.af_AuditLog.getAuditUserCodeList(nodeCode, logEntry.auditTypeCode, logEntry.relatedRowID.ToString(), logEntry.relatedKeyCode, dc);
                    foreach (string userCode in list)
                    {
                        db.af_AuditLog entry = new af_AuditLog();
                        dc.af_AuditLog.Add(entry);
                        bill.setRelatedInfo(relatedRowID, entry, dc);
                        entry.auditTypeCode = type.ToString();
                        entry.flowCode = flowCode;
                        entry.nodeCode = nodeCode;
                        entry.userCode = userCode;
                        entry.createDate = DateTime.Now;
                        entry.passType = db.bll.af_AuditNode.getPassType(flowCode, nodeCode, dc);
                        entry.printTag = db.bll.af_AuditNode.getPrintTag(flowCode, nodeCode, dc);
                        entry.recordType = "审批";
                    }
                }
                dc.SaveChanges();
            }
            else
            {
                rui.excptHelper.throwEx("已驳回过");
            }
        }

        /// <summary>
        /// 获取单据审批日志 按照审批时间降序
        /// </summary>
        /// <param name="relatedRowID"></param>
        /// <param name="auditTypeCode"></param>
        /// <returns></returns>
        public static DataTable getAuditLog(string relatedRowID, string auditTypeCode,db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc); 
            string sql = @"  SELECT af_AuditLog.rowID, createDate,af_AuditLog.passType,recordType,
                        nodeDesc,af_AuditLog.userCode,userName,auditDate,auditResult,auditRemark 
                        FROM af_AuditLog
                        LEFT JOIN af_NodeRelation ON 
	                        af_AuditLog.flowCode = af_NodeRelation.flowCode
	                        AND af_AuditLog.nodeCode = af_NodeRelation.nodeCode
                        LEFT JOIN rbac_User ON af_AuditLog.userCode = rbac_User.userCode 
                        WHERE relatedRowID=@relatedRowID and auditTypeCode=@auditTypeCode ORDER BY createDate ASC ";
            DataTable table = ef.ExecuteDataTable(sql, new { relatedRowID, auditTypeCode });
            return table;
        }

        /// <summary>
        /// 获取某个单据允许驳回的列表
        /// </summary>
        /// <param name="logRowID"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static DataTable getRejectList(string logRowID,db.dbEntities dc)
        {
            DataTable table = db.bll.af_AuditLog.getRejectList(logRowID, dc);
            return table;
        }



        /// <summary>
        /// 获取单据审批所在的控制器名称
        /// </summary>
        /// <param name="auditTypeCode"></param>
        /// <returns></returns>
        public static string getAuditController(string auditTypeCode)
        {
            string controllerName = auditTypeCode;


            if (controllerName == "")
                rui.excptHelper.throwEx("getAuditController未获取到对应的控制器");
            return controllerName;
        }

        /// <summary>
        /// 获取单据审批所在Action名称
        /// </summary>
        /// <param name="auditTypeCode"></param>
        /// <returns></returns>
        public static string getAuditAction(string auditTypeCode)
        {
            string actionName = "billAudit";


            if (actionName == "")
                rui.excptHelper.throwEx("getAuditController未获取到对应的Action");
            return actionName;
        }
    }

    // 新增一个新的审批单据需要做的事情
    // 1）给afType增加枚举项
    // 2）给auditHelper的getAuditController方法增加代码
    // 3）编写一个继承IBill的审批单据处理类
    // 4）给auditHelper的getBillByType方法增加代码


    // 审批类型 -- 名称和控制器保持一致
    public enum afType
    {

    }

    // 单据类型 -- 和表名保持一致
    public enum billType
    {

    }
}
