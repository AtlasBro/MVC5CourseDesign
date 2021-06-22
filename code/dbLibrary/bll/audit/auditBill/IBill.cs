using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace db.lib.auditBill
{
    /// <summary>
    /// 定义每个送审的业务单据需要提供的方法，每个单据都需要编写一份
    /// </summary>
    public interface IBill
    {
        //利用部门编号获取职务关联人
        string getDeptCode(long relatedRowID);

        //设置日志的关联信息（单据主键，单据创建人，单据创建部门）
        void setRelatedInfo(long relatedRowID, db.af_AuditLog entry, dbEntities dc);
        
        //单据送审
        /// <summary>
        /// 未送审和驳回状态允许送审
        /// 记录单据的送审信息，保存送审人和送审时间
        /// 生成送审日志和第一级审批日志
        /// 用到预算项目的业务单据需要向bg_BudUseDetail表内插入预算使用记录,状态是送审
        /// </summary>
        /// <param name="flowCode">所用审批流</param>
        /// <param name="type">审批类型</param>
        /// <param name="relatedRowID">关联行号</param>
        /// <param name="seletedUserCodes">选择的参审人员</param>
        /// <param name="sendRemark">送审备注 - 未启用审批，送审</param>
        /// <param name="dc"></param>
        string sendAudit(string flowCode, afType type, long relatedRowID, string seletedUserCodes, string sendRemark, dbEntities dc);

        //驳回到送审节点（重新送审）
        /// <summary>
        /// 设置单据的驳回状态
        /// 用到预算项目的业务单据需要从预算使用明细表bg_BudUseDetail内删除记录
        /// </summary>
        /// <param name="relatedRowID"></param>
        /// <param name="dc"></param>
        void rejectToSend(long relatedRowID, dbEntities dc);

        //变更审批状态（变更单据auditStatus字段值）
        void changeAuditStatus(long relatedRowID, string newState, dbEntities dc);
        
        //单据审批通过
        /// <summary>
        ///报销的业务单据 - 需要变更bg_BudUseDetail表报销记录的status字段的值="CL"
        ///报销的业务单据 - 记录财务审批人和财务审批时间字段的值
        /// </summary>
        /// <param name="relatedRowID"></param>
        /// <param name="financeDataTime">审批通过时间，通过人取Session的值</param>
        /// <param name="dc"></param>
        void auditPass(long relatedRowID, DateTime passDate, dbEntities dc);
    }
}
