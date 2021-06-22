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
    /// rui
    /// 系统资源表
    /// </summary>
    public class rbac_Resource
    {

        /// <summary>
        /// 新增
        /// </summary>
        /// <param name="entry"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static string insert(db.rbac_Resource entry, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            try
            {
                ef.beginTran();
                if (dc.rbac_Resource.Count(a => a.resourceCode == entry.resourceCode) > 0)
                    rui.excptHelper.throwEx("此编号已存在");

                entry.rowID = ef.newGuid();
                entry.opControl = "是";
                entry.dataControl = "否";
                dc.rbac_Resource.Add(entry);
                dc.SaveChanges();
                db.bll.rbac_ResourceOp.batchInsert(entry.resourceCode, entry.haveOperations, dc);
                ef.commit();
            }
            catch (Exception ex)
            {
                ef.rollBack();
                rui.logHelper.log(ex, true);
            }
            return entry.rowID;
        }

        /// <summary>
        /// 修改
        /// </summary>
        /// <param name="entry"></param>
        /// <param name="dc"></param>
        public static void update(db.rbac_Resource entry, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            if (dc.rbac_Resource.Count(a => a.resourceCode == entry.resourceCode && a.rowID != entry.rowID) > 0)
                rui.excptHelper.throwEx("此编号已存在");

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
                //删除相关表
                {
                    ef.beginTran();
                    var cmdPara = new { resourceCode = keyCode };
                    ef.Execute(" DELETE FROM rbac_RolePriv WHERE resourceCode=@resourceCode ", cmdPara);
                    ef.Execute(" DELETE FROM rbac_UserPriv WHERE resourceCode=@resourceCode ", cmdPara);
                    ef.Execute(" DELETE FROM rbac_Resource WHERE resourceCode=@resourceCode ", cmdPara);
                    ef.Execute(" DELETE FROM rbac_ResourceOp WHERE resourceCode=@resourceCode ", cmdPara);
                    ef.commit();
                }
            }
            catch (Exception ex)
            {
                ef.rollBack();
                rui.logHelper.log(ex, true);
            }
        }

        /// <summary>
        /// 更新排序
        /// </summary>
        /// <param name="entryList">实体对象集合</param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static string batchSave(List<db.rbac_Resource> entryList, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            Dictionary<string, string> errorDic = new Dictionary<string, string>();
            foreach (var entry in entryList)
            {
                try
                {
                    string sql = @" UPDATE rbac_Resource SET showOrder=@showOrder,pageWidth=@pageWidth,pagerCount=@pagerCount WHERE resourceCode=@resourceCode ";
                    var para = new { entry.resourceCode, entry.showOrder, entry.pageWidth, entry.pagerCount };
                    if (ef.Execute(sql, para) == 0)
                        rui.excptHelper.throwEx("数据未变更");
                }
                catch (Exception ex)
                {
                    errorDic.Add(entry.resourceCode, rui.excptHelper.getExMsg(ex));
                    rui.logHelper.log(ex);
                }
            }
            return rui.dbTools.getBatchMsg("批量保存", entryList.Count, errorDic);
        }

        /// <summary>
        /// 批量显示
        /// </summary>
        /// <param name="keyFieldValues"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static string batchShow(string keyFieldValues, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            List<string> KeyFieldList = rui.dbTools.getList(keyFieldValues);
            Dictionary<string, string> errorDic = new Dictionary<string, string>();

            //如果需要检查字段值，通过字段值和操作主键获取数据,对字段值进行检查
            //如果不需要检查字段值，直接对KeyFieldList进行遍历操作即可。
            string sqlCheck = " SELECT resourceCode,isShow FROM dbo.rbac_Resource WHERE resourceCode IN @resourceCode and isShow='是' ";
            DataTable table = ef.ExecuteDataTable(sqlCheck, new { resourceCode = KeyFieldList });

            foreach (string resourceCode in KeyFieldList)
            {
                try
                {
                    DataRow[] rows = table.Select("resourceCode='" + resourceCode + "'");
                    rui.dbTools.checkRowFieldValue(rows, "isShow", "是", "已显示");

                    string sql = " UPDATE rbac_Resource SET isShow='是' WHERE isShow='否' AND resourceCode=@resourceCode ";
                    if (ef.Execute(sql, new { resourceCode }) == 0)
                        rui.excptHelper.throwEx("数据未变更");
                }
                catch (Exception ex)
                {
                    errorDic.Add(resourceCode, rui.excptHelper.getExMsg(ex));
                    rui.logHelper.log(ex);
                }
            }
            return rui.dbTools.getBatchMsg("批量显示", KeyFieldList.Count, errorDic);
        }

        /// <summary>
        /// 批量隐藏
        /// </summary>
        /// <param name="keyFieldValues"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static string batchNoShow(string keyFieldValues, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            List<string> KeyFieldList = rui.dbTools.getList(keyFieldValues);
            Dictionary<string, string> errorDic = new Dictionary<string, string>();

            //如果需要检查字段值，通过字段值和操作主键获取数据,对字段值进行检查
            //如果不需要检查字段值，直接对KeyFieldList进行遍历操作即可。
            string sqlCheck = " SELECT resourceCode,isShow FROM dbo.rbac_Resource WHERE resourceCode IN @resourceCode and isShow='是' ";
            DataTable table = ef.ExecuteDataTable(sqlCheck, new { resourceCode = KeyFieldList });

            foreach (string resourceCode in KeyFieldList)
            {
                try
                {
                    DataRow[] rows = table.Select("resourceCode='" + resourceCode + "'");
                    rui.dbTools.checkRowFieldValue(rows, "isShow", "否", "已显示");

                    string sql = " UPDATE rbac_Resource SET isShow='否' WHERE isShow='是' AND resourceCode=@resourceCode ";
                    if (ef.Execute(sql, new { resourceCode }) == 0)
                        rui.excptHelper.throwEx("数据未变更");
                }
                catch (Exception ex)
                {
                    errorDic.Add(resourceCode, rui.excptHelper.getExMsg(ex));
                    rui.logHelper.log(ex);
                }
            }
            return rui.dbTools.getBatchMsg("批量隐藏", KeyFieldList.Count, errorDic);
        }

        /// <summary>
        /// 批量+1
        /// </summary>
        /// <param name="keyFieldValues"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static string batchAdd(string keyFieldValues, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            List<string> KeyFieldList = rui.dbTools.getList(keyFieldValues);
            Dictionary<string, string> errorDic = new Dictionary<string, string>();
            foreach (string resourceCode in KeyFieldList)
            {
                try
                {
                    string sql = " UPDATE rbac_Resource SET showOrder=isnull(showOrder,0)+1 WHERE resourceCode=@resourceCode ";
                    if (ef.Execute(sql, new { resourceCode = resourceCode }) == 0)
                        rui.excptHelper.throwEx("数据未变更");
                }
                catch (Exception ex)
                {
                    errorDic.Add(resourceCode, rui.excptHelper.getExMsg(ex));
                    rui.logHelper.log(ex);
                }
            }
            return rui.dbTools.getBatchMsg("批量+1", KeyFieldList.Count, errorDic);
        }

        /// <summary>
        /// 批量-1
        /// </summary>
        /// <param name="keyFieldValues"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static string batchSub(string keyFieldValues, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            List<string> KeyFieldList = rui.dbTools.getList(keyFieldValues);
            Dictionary<string, string> errorDic = new Dictionary<string, string>();

            foreach (string resourceCode in KeyFieldList)
            {
                try
                {
                    string sql = " UPDATE rbac_Resource SET showOrder=isnull(showOrder,0)-1 WHERE resourceCode=@resourceCode ";
                    if (ef.Execute(sql, new { resourceCode = resourceCode }) == 0)
                        rui.excptHelper.throwEx("数据未变更");
                }
                catch (Exception ex)
                {
                    errorDic.Add(resourceCode, rui.excptHelper.getExMsg(ex));
                    rui.logHelper.log(ex);
                }
            }
            return rui.dbTools.getBatchMsg("批量-1", KeyFieldList.Count, errorDic);
        }

        /// <summary>
        /// 批量变更模块
        /// </summary>
        /// <param name="keyFieldValues">resourceCode</param>
        /// <param name="moduleCode"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static string BatchChangeModule(string keyFieldValues, string moduleCode, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            List<string> KeyFieldList = rui.dbTools.getList(keyFieldValues);
            Dictionary<string, string> errorDic = new Dictionary<string, string>();

            foreach (string resourceCode in KeyFieldList)
            {
                try
                {
                    string sql = " UPDATE rbac_Resource SET moduleCode=@moduleCode WHERE resourceCode=@resourceCode ";
                    if (ef.Execute(sql, new { moduleCode, resourceCode = resourceCode }) == 0)
                        rui.excptHelper.throwEx("数据未变更");
                }
                catch (Exception ex)
                {
                    errorDic.Add(resourceCode, rui.excptHelper.getExMsg(ex));
                    rui.logHelper.log(ex);
                }
            }
            return rui.dbTools.getBatchMsg("批量变更模块", KeyFieldList.Count, errorDic);
        }

        /// <summary>
        /// 获取所有需要授权控制的资源及其拥有的操作
        /// </summary>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static DataTable getControlResource(db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            string sql = "  SELECT resourceCode,haveOperations FROM dbo.rbac_Resource WHERE opControl='是' ";
            DataTable table = ef.ExecuteDataTable(sql);
            return table;
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

            string sql = " SELECT resourceCode FROM rbac_Resource WHERE rowID=@rowID ";
            return rui.typeHelper.toString(ef.ExecuteScalar(sql, new { rowID }));
        }

        /// <summary>
        /// 通过code获取名称
        /// </summary>
        /// <param name="rowID"></param>
        /// <returns></returns>
        public static string getNameByCode(string code, db.dbEntities dc)
        {
            db.efHelper ef = new db.efHelper(ref dc);

            string sql = " SELECT resourceName FROM rbac_Resource WHERE resourceCode=@resourceCode ";
            return rui.typeHelper.toString(ef.ExecuteScalar(sql, new { resourceCode = code }));
        }

        /// <summary>
        /// 获取实体
        /// </summary>
        /// <param name="rowID"></param>
        /// <param name="dc"></param>
        /// <returns></returns>
        public static db.rbac_Resource getEntryByRowID(string rowID, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc);

            return dc.rbac_Resource.Single(a => a.rowID == rowID);
        }
    }
}
