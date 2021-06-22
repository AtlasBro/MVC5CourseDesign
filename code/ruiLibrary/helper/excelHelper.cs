using Aspose.Cells;
using System;
using System.Data;
using System.IO;

namespace rui
{
    /// <summary>
    /// Excel导出和导入
    /// </summary>
    public class excelHelper
    {
        /// <summary>
        /// Excel To DataTable
        /// </summary>
        /// <param name="strFilePath">文件的绝对路径</param>
        /// <returns></returns>
        public static DataTable excelToDataTable(string strFilePath)
        {
            Workbook workbook = new Workbook(File.Open(strFilePath, FileMode.Open));
            DataTable dtExcel = null;
            try
            {
                Cells cells = workbook.Worksheets[0].Cells;
                dtExcel = cells.ExportDataTableAsString(0, 0, cells.MaxDataRow + 1, cells.MaxDataColumn + 1, true);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
            return dtExcel;
        }


        /// <summary>
        /// DataTable To Excel
        /// </summary>
        /// <param name="table"></param>
        /// <param name="SheetName">Sheetname</param>
        /// <returns>返回文件的流</returns>
        public static MemoryStream dataTableToExcel(DataTable table, string SheetName)
        {
            Workbook wb = new Workbook(FileFormatType.Xlsx);
            Worksheet sheet = wb.Worksheets[0];
            sheet.Name = SheetName;

            //添加标题行
            int rowIndex = 0;
            for (int j = 0; j < table.Columns.Count; j++)
            {
                sheet.Cells[rowIndex, j].PutValue(table.Columns[j].ColumnName);
            }
            //添加数据行
            rowIndex = 1;
            for (int i = 0; i < table.Rows.Count; i++)
            {
                for (int j = 0; j < table.Columns.Count; j++)
                {
                    sheet.Cells[rowIndex + i, j].PutValue(table.Rows[i][j].ToString());
                }
            }
            //返回文件流
            MemoryStream ms = new MemoryStream();
            wb.Save(ms, SaveFormat.Xlsx);
            wb = null;
            ms.Position = 0;
            return ms;
        }
    }
}
