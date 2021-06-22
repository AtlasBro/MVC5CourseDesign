using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace db.view
{
    //显示审批日志
    public class af_AuditLog : rui.pagerBase
    {
        public string rowID { get; set; }
        public string type { get; set; }

        public override void Search()
        {
            this.ResourceCode = "af_AuditLog";

            this.getPageConfig();
            this.dataTable = db.lib.auditHelper.getAuditLog(rowID, type, null);
            rui.dbTools.insert序号(this.dataTable);

            //显示的列和列顺序
            this.showColumn = this.getShowColumn();
        }
    }
}
