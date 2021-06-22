using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


namespace db.bll
{
    /// <summary>
    /// 审批节点关系
    /// </summary>
    public class af_NodeRelation
    {
        /// <summary>
        /// 通过nodeGuid获取对象
        /// </summary>
        /// <param name="nodeGuid"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static db.af_NodeRelation getEntryByCode(string nodeGuid, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc); 

            db.af_NodeRelation node = dc.af_NodeRelation.SingleOrDefault(a => a.nodeGuid == nodeGuid);
            return node;
        }

        /// <summary>
        /// 修改
        /// </summary>
        /// <param name="entry"></param>
        /// <param name="dc"></param>
        public static void update(db.af_NodeRelation entry, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc); 

            efHelper.entryUpdate(entry, dc);
            dc.SaveChanges();
        }
    }
}
