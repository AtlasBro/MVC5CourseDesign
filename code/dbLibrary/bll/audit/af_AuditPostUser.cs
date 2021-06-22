using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace db.bll
{
    /// <summary>
    /// 审批职务用户
    /// </summary>
    public class af_AuditPostUser
    {

        /// <summary>
        /// 用户任职批量设定
        /// </summary>
        /// <param name="userCodes">用户编号，多个</param>
        /// <param name="postCode">任职职务</param>
        public static string batchSetPost(string userCodes, string postCode, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);
            List<string> userCodeList = rui.dbTools.getList(userCodes);
            Dictionary<string, string> errorDic = new Dictionary<string, string>();
            string isDeptPost = db.bll.af_AuditPost.isDeptPost(postCode, dc);
            string orgCode = db.bll.loginAdminHelper.getOrgCode();
            if (isDeptPost == "是")
            {
                //如果是部门职务，则查询每个用户在当前组织下归属的部门
                string sql = " SELECT userCode, deptCode FROM rbac_UserOrg WHERE orgCode=@orgCode AND userCode IN @userCode ";
                DataTable table = ef.ExecuteDataTable(sql, new { orgCode, userCode = userCodeList });
                foreach (DataRow row in table.Rows)
                {
                    //添加用户部门任职
                    string userCode = row["userCode"].ToString();
                    string deptCode = row["deptCode"].ToString();
                    db.af_AuditPostUser entry = dc.af_AuditPostUser.SingleOrDefault(a => a.userCode == userCode && a.postCode == postCode && a.deptCode == deptCode);
                    if (entry == null)
                    {
                        entry = new db.af_AuditPostUser();
                        dc.af_AuditPostUser.Add(entry);

                        entry.rowID = ef.newGuid();
                        entry.userCode = userCode;
                        entry.postCode = postCode;
                        entry.orgCode = orgCode;
                        entry.deptCode = deptCode;
                        entry.sourceFrom = "新增";
                        entry.importDate = DateTime.Now;
                    }
                    else
                    {
                        errorDic.Add(userCode, "已任职过该职务");
                    }
                }
            }
            else
            {
                //如果不是部门职务，则不需要查询归属部门，直接用户任职即可
                foreach (var userCode in userCodeList)
                {
                    db.af_AuditPostUser entry = dc.af_AuditPostUser.SingleOrDefault(a => a.userCode == userCode && a.postCode == postCode);
                    if (entry == null)
                    {
                        entry = new db.af_AuditPostUser();
                        dc.af_AuditPostUser.Add(entry);

                        entry.rowID = ef.newGuid();
                        entry.userCode = userCode;
                        entry.postCode = postCode;
                        entry.orgCode = orgCode;
                        entry.sourceFrom = "新增";
                        entry.importDate = DateTime.Now;
                    }
                    else
                    {
                        errorDic.Add(userCode, "已任职过该职务");
                    }
                }
            }
            dc.SaveChanges();
            return rui.dbTools.getBatchMsg("用户任职", userCodeList.Count, errorDic);
        }

        /// <summary>
        /// 批量保存  变更任职部门
        /// </summary>
        /// <param name="rowIDList"></param>
        /// <param name="deptCodeList"></param>
        public static string batchSave(List<string> rowIDList, List<string> showValueList, List<string> isDeptPostList, List<string> deptCodeList, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            Dictionary<string, string> errorDic = new Dictionary<string, string>();
            for (int i = 0; i < rowIDList.Count; i++)
            {
                try
                {
                    if (isDeptPostList[i] == "是")
                    {
                        string sql = " UPDATE af_AuditPostUser SET deptCode=@deptCode WHERE rowID=@rowID ";
                        if (ef.Execute(sql, new { deptCode = deptCodeList[i], rowID = rowIDList[i] }) == 0)
                            rui.excptHelper.throwEx("数据未变更");
                    }
                    //else
                    //{
                    //    rui.excptHelper.throwEx("非部分职务无需变更任职部门");
                    //}
                }
                catch (Exception ex)
                {
                    errorDic.Add(showValueList[i], rui.excptHelper.getExMsg(ex));
                    rui.logHelper.log(ex);
                }
            }
            return rui.dbTools.getBatchMsg("批量保存", rowIDList.Count, errorDic);
        }

        /// <summary>
        /// 删除
        /// </summary>
        /// <param name="rowID"></param>
        /// <param name="dc"></param>
        public static void delete(string rowID, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);
            try
            {
                ef.beginTran();
                //删除
                ef.Execute(" DELETE from af_AuditPostUser where rowID=@rowID ", new { rowID = rowID });
                ef.commit();
            }
            catch (Exception ex)
            {
                ef.rollBack();
                rui.logHelper.log(ex, true);
            }
        }

        /// <summary>
        /// 获取部门职务
        /// </summary>
        /// <param name="deptCode"></param>
        /// <param name="postCode"></param>
        /// <returns></returns>
        public static DataTable getPostUsers(string deptCode, string postCode, db.dbEntities dc)
        {
            DataTable table = new DataTable();
            return table;
        }

    }
}
