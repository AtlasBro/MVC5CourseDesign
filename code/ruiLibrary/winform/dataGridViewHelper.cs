using rui.winform;
using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace rui.winform
{
    /// <summary>
    /// Winform中设置DataGridView控件的相关属性
    /// </summary>
    public class dataGridViewHelper
    {
        /// <summary>
        /// 获取选中行的主键集合
        /// </summary>
        /// <param name="view"></param>
        /// <param name="columnName"></param>
        /// <returns></returns>
        public static List<string> getSelectedList(DataGridView view, string columnName)
        {
            List<string> list = new List<string>();
            foreach (DataGridViewRow row in view.Rows)
            {
                if (rui.typeHelper.toBoolean(row.Cells["选择"].Value) == true)
                    list.Add(row.Cells[columnName].Value.ToString());
            }
            return list;
        }

        /// <summary>
        /// 设置行不允许排序
        /// </summary>
        /// <param name="view"></param>
        public static void SetColumnsNoSortable(DataGridView view)
        {
            foreach (DataGridViewColumn col in view.Columns)
            {
                col.SortMode = DataGridViewColumnSortMode.NotSortable;
            }
        }

        /// <summary>
        /// 设置列编辑模式
        /// </summary>
        /// <param name="view"></param>
        /// <param name="ColumnName"></param>
        /// <param name="width"></param>
        public static void setColumnEdit(DataGridView view, string ColumnName, int width)
        {
            view.Columns[ColumnName].AutoSizeMode = DataGridViewAutoSizeColumnMode.None;
            view.Columns[ColumnName].Width = width;
            view.Columns[ColumnName].ReadOnly = false;
            view.EditMode = DataGridViewEditMode.EditOnEnter;
        }

        /// <summary>
        /// 去除表中重复字段的值
        /// </summary>
        /// <param name="table"></param>
        /// <param name="priKeyName"></param>
        /// <param name="columns"></param>
        public static void removeDuplicate(DataTable table, string priKeyName, int[] columns)
        {
            for (int i = table.Rows.Count - 1; i > 0; i--)
            {
                if (table.Rows[i][priKeyName].ToString() != "配件:" && table.Rows[i][priKeyName].ToString() == table.Rows[i - 1][priKeyName].ToString())
                {
                    foreach (int loc in columns)
                    {
                        table.Rows[i][loc] = DBNull.Value;
                    }
                }
            }
        }
        /// <summary>
        /// 设置列通用属性,保留原长度值
        /// </summary>
        /// <param name="view"></param>
        public static void setColumns(DataGridView view)
        {
            //设定奇数行颜色不同
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle1 = new System.Windows.Forms.DataGridViewCellStyle();
            dataGridViewCellStyle1.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(224)))), ((int)(((byte)(224)))));
            view.AlternatingRowsDefaultCellStyle = dataGridViewCellStyle1;
            view.RowHeadersWidthSizeMode = DataGridViewRowHeadersWidthSizeMode.DisableResizing;
            view.AllowUserToResizeRows = false;

            //设置选择模式
            view.SelectionMode = DataGridViewSelectionMode.CellSelect;
            view.BorderStyle = BorderStyle.FixedSingle;

            //完成序号列的生成
            view.RowPostPaint += delegate(object sender, DataGridViewRowPostPaintEventArgs e)
            {
                DataGridView dataGridView1 = sender as DataGridView;
                SolidBrush b = new SolidBrush(dataGridView1.RowHeadersDefaultCellStyle.ForeColor);
                e.Graphics.DrawString((e.RowIndex + 1).ToString(System.Globalization.CultureInfo.CurrentUICulture), dataGridView1.DefaultCellStyle.Font, b, e.RowBounds.Location.X + 10, e.RowBounds.Location.Y + 6);
            };
        }
        /// <summary>
        /// 设置列通用属性
        /// </summary>
        /// <param name="view"></param>
        /// <param name="columnFill"></param>
        public static void setColumns(DataGridView view, bool columnFill)
        {
            //设定奇数行颜色不同
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle1 = new System.Windows.Forms.DataGridViewCellStyle();
            dataGridViewCellStyle1.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(224)))), ((int)(((byte)(224)))));
            view.AlternatingRowsDefaultCellStyle = dataGridViewCellStyle1;
            view.RowHeadersWidthSizeMode = DataGridViewRowHeadersWidthSizeMode.DisableResizing;
            view.AllowUserToResizeRows = false;

            //设置选择模式
            view.SelectionMode = DataGridViewSelectionMode.CellSelect;
            view.BorderStyle = BorderStyle.FixedSingle;

            //设定列的大小模式
            foreach (DataGridViewColumn c in view.Columns)
            {
                if (c.CellType.Name != "DataGridViewCheckBoxCell")
                    c.ReadOnly = true;

                if (columnFill)
                {
                    if (c.Resizable == DataGridViewTriState.True)
                        c.AutoSizeMode = DataGridViewAutoSizeColumnMode.Fill;
                }
                else
                {
                    if (c.Resizable == DataGridViewTriState.True)
                    {
                        c.MinimumWidth = 40;
                        c.AutoSizeMode = DataGridViewAutoSizeColumnMode.AllCells;
                    }
                }
            }

            //完成序号列的生成
            view.RowPostPaint += delegate(object sender, DataGridViewRowPostPaintEventArgs e)
            {
                DataGridView dataGridView1 = sender as DataGridView;
                SolidBrush b = new SolidBrush(dataGridView1.RowHeadersDefaultCellStyle.ForeColor);
                e.Graphics.DrawString((e.RowIndex + 1).ToString(System.Globalization.CultureInfo.CurrentUICulture), dataGridView1.DefaultCellStyle.Font, b, e.RowBounds.Location.X + 10, e.RowBounds.Location.Y + 6);
            };
        }
        /// <summary>
        /// 设置列通用属性，为最后一列添加“合计样式”,适用于有合计需求的DataGridView
        /// </summary>
        /// <param name="view"></param>
        /// <param name="columnFill"></param>
        /// <param name="checkBoxColumnName"></param>
        /// <param name="hasTotal"></param>
        /// <param name="is用料单"></param>
        public static void setColumns(DataGridView view, bool columnFill, string checkBoxColumnName, bool hasTotal, bool is用料单 = false)
        {
            //设定奇数行颜色不同
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle1 = new System.Windows.Forms.DataGridViewCellStyle();
            dataGridViewCellStyle1.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(224)))), ((int)(((byte)(224)))));
            view.AlternatingRowsDefaultCellStyle = dataGridViewCellStyle1;
            view.RowHeadersWidthSizeMode = DataGridViewRowHeadersWidthSizeMode.DisableResizing;
            view.AllowUserToResizeRows = false;

            //设置选择模式
            view.SelectionMode = DataGridViewSelectionMode.CellSelect;
            view.BorderStyle = BorderStyle.FixedSingle;

            //设定列的大小模式
            foreach (DataGridViewColumn c in view.Columns)
            {
                if (c.CellType.Name != "DataGridViewCheckBoxCell")
                    c.ReadOnly = true;
                if (columnFill)
                {
                    if (c.Resizable == DataGridViewTriState.True)
                        c.AutoSizeMode = DataGridViewAutoSizeColumnMode.Fill;
                }
                else
                {
                    if (c.Resizable == DataGridViewTriState.True)
                    {
                        c.MinimumWidth = 10;
                        c.AutoSizeMode = DataGridViewAutoSizeColumnMode.AllCells;
                    }
                }
                //取消合计方式下的列排序
                c.SortMode = DataGridViewColumnSortMode.Programmatic;
            }

            //完成序号列的生成
            view.RowPostPaint += delegate(object sender, DataGridViewRowPostPaintEventArgs e)
            {
                DataGridView dataGridView1 = sender as DataGridView;
                SolidBrush b = new SolidBrush(dataGridView1.RowHeadersDefaultCellStyle.ForeColor);
                if (e.RowIndex == view.Rows.Count - 1)
                {
                    if (hasTotal)
                        e.Graphics.DrawString("合计", dataGridView1.DefaultCellStyle.Font, b, e.RowBounds.Location.X + 10, e.RowBounds.Location.Y + 4);
                    else
                        e.Graphics.DrawString((e.RowIndex + 1).ToString(System.Globalization.CultureInfo.CurrentUICulture), dataGridView1.DefaultCellStyle.Font, b, e.RowBounds.Location.X + 10, e.RowBounds.Location.Y + 6);
                }
                else
                    e.Graphics.DrawString((e.RowIndex + 1).ToString(System.Globalization.CultureInfo.CurrentUICulture), dataGridView1.DefaultCellStyle.Font, b, e.RowBounds.Location.X + 10, e.RowBounds.Location.Y + 6);
            };
            //去除相应行的CheckBox
            {
                if (checkBoxColumnName != "")
                {
                    foreach (DataGridViewRow row in view.Rows)
                    {
                        if (row.Cells[1].Value.ToString() == "")
                        {
                            DataGridViewCell cell = new DataGridViewTextBoxCell();
                            cell.Value = "";
                            row.Cells[checkBoxColumnName] = cell;
                        }
                        //员工用料单
                        if (is用料单 && row.Cells["加工单号"].Value.ToString() != "")
                        {
                            DataGridViewCell cell = new DataGridViewTextBoxCell();
                            cell.Value = "";
                            row.Cells[checkBoxColumnName] = cell;
                        }
                    }
                }
            }
            //有合计的下生成合计列样式
            if (hasTotal)
            {
                //修改最后一行的颜色样式
                {
                    if (view.Rows.Count > 0)
                    {
                        DataGridViewCellStyle style = new DataGridViewCellStyle();
                        style.BackColor = Color.Gold;
                        style.Font = new System.Drawing.Font("宋体", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(134)));
                        view.Rows[view.Rows.Count - 1].DefaultCellStyle = style;
                    }
                }
            }
        }
        /// <summary>
        /// 设置1对多情况下的行的样式
        /// </summary>
        /// <param name="view"></param>
        /// <param name="priKey"></param>
        /// <param name="hasTotal"></param>
        public static void SetRowStyle(DataGridView view, string priKey, bool hasTotal = false)
        {
            System.Windows.Forms.DataGridViewCellStyle primaryStyle = new System.Windows.Forms.DataGridViewCellStyle();
            primaryStyle.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(224)))), ((int)(((byte)(224)))), ((int)(((byte)(224)))));
            System.Windows.Forms.DataGridViewCellStyle secondStyle = new System.Windows.Forms.DataGridViewCellStyle();
            secondStyle.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(255)))), ((int)(((byte)(255)))), ((int)(((byte)(255)))));

            int num = view.Rows.Count;
            if (hasTotal)
                num--;
            for (int i = 0; i < num; i++)
            {
                if (view.Rows[i].Cells[priKey].Value.ToString() != "")
                    view.Rows[i].DefaultCellStyle = primaryStyle;
                else
                    view.Rows[i].DefaultCellStyle = secondStyle;
            }
        }
        /// <summary>
        /// 为对应的列计算合计
        /// </summary>
        /// <param name="table"></param>
        /// <param name="columns"></param>
        /// <param name="hasTotal"></param>
        /// <param name="hasUnit"></param>
        public static void computerTotal(DataTable table, int[] columns, bool hasTotal = false, bool hasUnit = false)
        {
            if (table.Rows.Count == 0)
                return;

            if (hasTotal && table.Rows.Count > 0)
            {
                table.Rows.RemoveAt(table.Rows.Count - 1);
            }
            decimal[] Totals = new decimal[columns.Length];
            foreach (DataRow row in table.Rows)
            {
                if (row.RowState != DataRowState.Deleted)
                {
                    for (int i = 0; i < Totals.Length; i++)
                    {
                        string value = row[columns[i]].ToString();
                        if (value != "" && (value.Contains("g") || value.Contains("ct")))
                        {
                            if (value.Contains("g"))
                                value = value.Substring(0, value.Length - 1);
                            if (value.Contains("ct"))
                            {
                                value = value.Substring(0, value.Length - 2);
                                value = (rui.typeHelper.toDecimal(value) / 5).ToString();
                            }
                        }
                        Totals[i] += rui.typeHelper.toDecimal(value);
                    }
                }
            }
            //给合计行增加单位
            DataRow NewRow = table.NewRow();
            for (int i = 0; i < Totals.Length; i++)
            {
                //配石合计转化为g
                if (table.Columns[columns[i]].ColumnName == "p重量")
                {
                    NewRow[columns[i]] = (Totals[i] / 5).ToString();
                }
                else
                    NewRow[columns[i]] = Totals[i].ToString();
            }
            table.Rows.Add(NewRow);
        }
        /// <summary>
        /// 增加全选功能，需要给将DataGridView的第一列设定为Checkbox列类型。
        /// </summary>
        /// <param name="view"></param>
        public static void addCheckBox(DataGridView view)
        {
            //设定操作权限
            view.AllowUserToAddRows = false;
            view.AllowUserToDeleteRows = false;

            DatagridViewCheckBoxHeaderCell cbHeader = new DatagridViewCheckBoxHeaderCell();
            cbHeader.Value = string.Empty;
            cbHeader.OnCheckBoxClicked += delegate(bool state)
            {
                foreach (DataGridViewRow row in view.Rows)
                {
                    row.Cells[0].Value = state;
                }
            };
            view.Columns[0].HeaderCell = cbHeader;
        }
        /// <summary>
        /// 设置通过主键值让指定的行选中
        /// </summary>
        /// <param name="view"></param>
        /// <param name="columnName"></param>
        /// <param name="columnValue"></param>
        public static void SetRowSelect(DataGridView view, string columnName, string columnValue)
        {
            foreach (DataGridViewRow row in view.Rows)
            {
                if (row.Cells[columnName].Value.ToString() == columnValue)
                {
                    row.Selected = true;
                    break;
                }
                else
                    row.Selected = false;
            }
        }
        /// <summary>
        /// 
        /// </summary>
        /// <param name="view"></param>
        /// <param name="ColumnNames"></param>
        /// <returns></returns>
        public static int[] getColumnsIndex(DataGridView view, string[] ColumnNames)
        {
            int[] result = new int[ColumnNames.Length];
            for (int i = 0; i < ColumnNames.Length; i++)
            {
                result[i] = view.Columns[ColumnNames[i]].Index;
            }
            return result;
        }
    }
}
