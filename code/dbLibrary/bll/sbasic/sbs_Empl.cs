using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;

namespace db.bll
{
    public class sbs_Empl
    {
        /// <summary>
        /// 新增
        /// </summary>
        /// <param name="entry"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static string insert(db.sbs_Empl entry, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            try
            {
                _checkInput(entry);
                ef.beginTran();
                if (dc.sbs_Empl.Count(a => a.emplCode == entry.emplCode) > 0)
                    rui.excptHelper.throwEx("职工编号已存在");

                entry.rowID = ef.newGuid();
                entry.importDate = DateTime.Now;
                entry.sourceFrom = "系统";
                dc.sbs_Empl.Add(entry);
                dc.SaveChanges();

                ef.commit();
            }
            catch (Exception ex)
            {
                ef.rollBack();
                rui.logHelper.log(ex, true);
            }
            return entry.rowID;
        }

        private static void _checkInput(db.sbs_Empl entry)
        {
            rui.dataCheck.checkNotNull(entry.emplCode, "职工编号");
            rui.dataCheck.checkNotNull(entry.orgCode, "组织");
            rui.dataCheck.checkNotNull(entry.deptCode, "部门");
        }

        /// <summary>
        /// 修改
        /// </summary>
        /// <param name="entry"></param>
        /// <param name="dc"></param>
        public static void update(db.sbs_Empl entry, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);
            _checkInput(entry);
            efHelper.entryUpdate(entry, dc);
            //同步用户的姓名
            {
                db.rbac_User entryTemp = dc.rbac_User.SingleOrDefault(a => a.userCode == entry.emplCode);
                if (entryTemp != null)
                    entryTemp.userName = entry.emplName;
            }
            //同步用户组织内所属部门
            {
                db.rbac_UserOrg entryOrg = dc.rbac_UserOrg.SingleOrDefault(a => a.userCode == entry.emplCode && a.orgCode == entry.orgCode);
                if (entryOrg != null)
                    entryOrg.deptCode = entryOrg.deptCode;
            }
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
                ef.checkCanDelete("rbac_User", "relatedCode", keyCode, "该职工已创建登录账号，需要先删除登录账号");

                //删除
                ef.Execute(" delete from sbs_Empl where emplCode=@emplCode ", new { emplCode = keyCode });
            }
            catch (Exception ex)
            {
                rui.logHelper.log(ex, true);
            }
        }

        /// <summary>
        /// 通过rowID获取主键
        /// </summary>
        /// <param name="rowID"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static string getCodeByRowID(string rowID, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            string sql = " SELECT emplCode FROM sbs_Empl WHERE rowID=@rowID ";
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
            string sql = " SELECT emplName FROM sbs_Empl WHERE emplCode=@emplCode ";
            return rui.typeHelper.toString(ef.ExecuteScalar(sql, new { emplCode = code }));
        }

        /// <summary>
        /// 主键查询(详情用)
        /// </summary>
        /// <param name="rowID"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static db.sbs_Empl getEntryByRowID(string rowID, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            return dc.sbs_Empl.Single(a => a.rowID == rowID);
        }

        /// <summary>
        /// 设定选中职工能在本组织内登陆
        /// </summary>
        /// <param name="selected"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static string setLogin(string selected, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            List<string> list = rui.dbTools.getDpList(selected);
            string sql = @" SELECT emplCode,emplName,orgCode,deptCode FROM sbs_Empl WHERE emplCode IN @emplCode  ";
            DataTable emplTable = ef.ExecuteDataTable(sql, new { emplCode = list });

            List<string> keyCodeList = new List<string>();
            Dictionary<string, string> dicError = new Dictionary<string, string>();

            string orgCode = db.bll.loginAdminHelper.getOrgCode();
            foreach (DataRow row in emplTable.Rows)
            {
                string emplCode = row["emplCode"].ToString();
                keyCodeList.Add(emplCode);
                try
                {
                    //如果允许登录的是本组织，则归属部门就是原部门,否则归属部门为空，并默认不可以登录，需要通过用户那里批量修改归属部门
                    if (row["orgCode"].ToString() == orgCode)
                        db.bll.rbac_User.createRelatedUser(emplCode, row["emplName"].ToString(), orgCode, row["deptCode"].ToString(), dc);
                    else
                        db.bll.rbac_User.createRelatedUser(emplCode, row["emplName"].ToString(), orgCode, null, dc);
                }
                catch (Exception ex)
                {
                    dicError.Add(emplCode, rui.excptHelper.getExMsg(ex));
                    rui.logHelper.log(ex);
                }
            }
            return rui.dbTools.getBatchMsg("批量创建登录账号", keyCodeList.Count, dicError);
        }

        /// <summary>
        /// 绑定当前登录组织内的所有职工(排除离职的)
        /// </summary>
        /// <param name="has请选择"></param>
        /// <param name="isLoginOrg"></param>
        /// <returns></returns>
        public static List<SelectListItem> bindDdl(bool has请选择 = false, bool isLoginOrg = true)
        {
            efHelper ef = new efHelper();
            string sql = @" SELECT emplCode as code,emplName as name FROM dbo.sbs_Empl
                    INNER JOIN dbo.sbs_Dept ON dbo.sbs_Empl.deptCode = dbo.sbs_Dept.deptCode
                    where status ='在职'  ";
            if (isLoginOrg)
            {
                string orgCode = db.bll.loginAdminHelper.getOrgCode();
                sql += " and orgCode='" + orgCode + "' ";
            }
            DataTable table = ef.ExecuteDataTable(sql);
            List<SelectListItem> list = rui.listHelper.dataTableToDdlList(table, has请选择, "");
            return list;
        }

        /// <summary>
        /// 绑定某个部门内所有的职工(排除离职的)
        /// </summary>
        /// <param name="deptCode"></param>
        /// <param name="has请选择"></param>
        /// <returns></returns>
        public static List<SelectListItem> bindDdlForDept(string deptCode, bool has请选择 = false)
        {
            efHelper ef = new efHelper();
            string sql = " SELECT emplCode AS code,emplName AS name FROM sbs_Empl WHERE status ='在职' and deptCode=@deptCode ";
            DataTable table = ef.ExecuteDataTable(sql, new { deptCode });
            List<SelectListItem> list = rui.listHelper.dataTableToDdlList(table, has请选择, "");
            return list;
        }

        /// <summary>
        /// 导入数据，如果关联的表没有过来，一起导入
        /// 上级关联的表有：bs_Dept,rbac_Org
        /// </summary>
        /// <param name="sysTableName"></param>
        /// <param name="selectedList"></param>
        /// <param name="message"></param>
        /// <returns></returns>
        public static bool syncData(string selectedinExpression, ref string message, db.dbEntities dc)
        {
            efHelper ef = new efHelper();
            if (selectedinExpression == "")
                return true;

            bool result = rui.syncHelper.syncData("bs_Empl", selectedinExpression, ref message);

            //导入缺少的部门
            #region
            {
                string sql = @"SELECT DISTINCT deptCode FROM dbo.sbs_Empl
                            except
                            SELECT deptCode FROM dbo.sbs_Dept ";
                DataTable table = ef.ExecuteDataTable(sql);
                string selectInExpr = rui.dbTools.getInExpression(table, "deptCode");
                if (selectInExpr.Length > 0)
                    result = result && db.bll.sbs_Dept.syncData(selectInExpr, ref message, dc);
            }
            #endregion

            return result;
        }
    }
}
