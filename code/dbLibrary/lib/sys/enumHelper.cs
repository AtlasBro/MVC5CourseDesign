using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

//存放字段的状态值（防止拼错）
namespace rui
{
    /// <summary>
    /// 数据权限枚举项目
    /// </summary>
    public enum eAuditStatus
    {
        未送审, 已送审, 审批中, 驳回, 审批通过
    }

    /// <summary>
    /// 单据类型
    /// </summary>
    public enum eStatus
    {
        初始, 确认
    }

    /// <summary>
    /// 审批职位
    /// </summary>
    public enum ePostName
    {
        经办人, 证明人, 部门领导, 现场运维部部长, 部门分管领导, 财务
    }
}
