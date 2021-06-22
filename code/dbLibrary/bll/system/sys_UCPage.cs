using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace db.bll
{
    /// <summary>
    /// 页面用户配置
    /// </summary>
    public class sys_UcPage
    {
        //变更页面参数
        public static void update(string resourceCode, int cPageSize, int cPageWidth, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc); 

            //保存列配置数据
            string userCode = db.bll.loginAdminHelper.getUserCode();
            List<string> fieldCodeList = rui.requestHelper.getList("fieldCodeList");
            List<string> CFieldNameList = rui.requestHelper.getList("CFieldNameList");
            List<string> showOrderList = rui.requestHelper.getList("showOrderList");
            List<string> colWidthList = rui.requestHelper.getList("colWidthList");
            List<string> fixedValueList = rui.requestHelper.getList("fixedValueList");
            List<string> alignTypeList = rui.requestHelper.getList("alignTypeList");

            Dictionary<string, bool> isShowList = new Dictionary<string, bool>();
            Dictionary<string, bool> isOrderList = new Dictionary<string, bool>();
            for (int i = 0; i < fieldCodeList.Count; i++)
            {
                string fieldCode = fieldCodeList[i];
                if (CFieldNameList[i] == "")
                    rui.excptHelper.throwEx("必须录入列名");

                db.sys_UCColumn entry = dc.sys_UCColumn.SingleOrDefault(a => a.resourceCode == resourceCode
                    && a.userCode == userCode && a.fieldCode == fieldCode);
                //如果未配置过，则新增
                if (entry == null)
                {
                    entry = new db.sys_UCColumn();
                    entry.rowID = ef.newGuid();
                    entry.resourceCode = resourceCode;
                    entry.userCode = userCode;
                    entry.fieldCode = fieldCode;
                    dc.sys_UCColumn.Add(entry);
                }

                entry.fieldName = CFieldNameList[i];
                entry.isShow = rui.requestHelper.getValue(fieldCode + "_isShow", false) == "" ? false : true;
                entry.showOrder = rui.typeHelper.toInt(showOrderList[i]);
                entry.isOrder  = rui.requestHelper.getValue(fieldCode + "_isOrder", false) == "" ? false : true;
                entry.colWidth = rui.typeHelper.toIntAllowNull(colWidthList[i]);
                entry.isResize = rui.requestHelper.getValue(fieldCode + "_isResize", false) == "" ? false : true;
                entry.fixedValue = fixedValueList[i];
                entry.alignType = alignTypeList[i];
            }

            //保存分页配置数据
            db.sys_UCPager pEntry = dc.sys_UCPager.SingleOrDefault(a => a.resourceCode == resourceCode && a.userCode == userCode);
            if (pEntry == null)
            {
                pEntry = new db.sys_UCPager();
                pEntry.rowID = ef.newGuid();
                dc.sys_UCPager.Add(pEntry);
                pEntry.resourceCode = resourceCode;
                pEntry.userCode = userCode;
            }
            pEntry.pageSize = cPageSize;
            pEntry.pageWidth = cPageWidth;
            dc.SaveChanges();
        }

        //重置分页配置
        public static void reSet(string resourceCode, db.dbEntities dc)
        {
            efHelper ef = new efHelper(ref dc); 

            string userCode = db.bll.loginAdminHelper.getUserCode();
            //删除列配置数据
            var resultColumn = from a in dc.sys_UCColumn
                               where a.userCode == userCode && a.resourceCode == resourceCode
                               select a;
            foreach (var item in resultColumn)
                dc.sys_UCColumn.Remove(item);

            //删除分页配置数据
            var resultPage = from a in dc.sys_UCPager
                             where a.userCode == userCode && a.resourceCode == resourceCode
                             select a;
            foreach (var item in resultPage)
                dc.sys_UCPager.Remove(item);
            dc.SaveChanges();
        }
    }
}
