using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace db.view
{
    public class af_AuditFlowDesign
    {
        //审批流行号
        public string rowID { get; set; }
        //操作方式
        public string opMode { get; set; }
        //开始节点的json
        public string begin { get; set; }
        //结束节点的json
        public string end { get; set; }
        //活动节点的json组合
        public string actives { get; set; }
        //路由节点的json组合
        public string routes { get; set; }

    }
}
