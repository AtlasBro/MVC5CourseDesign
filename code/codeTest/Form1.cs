using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace codeTest
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            db.efHelper ef = new db.efHelper();
            string sql = " select * from rbac_Resource ";
            DataTable table = ef.ExecuteDataTable(sql);
            this.dataGridView1.DataSource = table;
        }

        private void Button3_Click(object sender, EventArgs e)
        {
            db.efHelper ef = new db.efHelper();
            string sql = " select * from rbac_Resource where rowNum=@rowNum ";
            DataTable table = ef.ExecuteDataTable(sql, new { rowNum=this.textBox1.Text });
            this.dataGridView1.DataSource = table;
        }

        private void button4_Click(object sender, EventArgs e)
        {
            db.efHelper ef = new db.efHelper();
            string sql = " select * from rbac_Resource where resourceName like @resourceName ";
            DataTable table = ef.ExecuteDataTable(sql, new { resourceName = rui.dbTools.getDpLike(this.textBox1.Text) });
            this.dataGridView1.DataSource = table;
        }

        private void button2_Click(object sender, EventArgs e)
        {
            db.efHelper ef = new db.efHelper();
            try
            {
                ef.beginTran();

                {
                    string sql = @"  insert into rbac_Resource(rowID,resourceCode,resourceName) values(@rowID,@resourceCode,@resourceName) ";
                    ef.Execute(sql, new { rowID = ef.newGuid(), resourceCode = "12", resourceName = "测试" });
                }
                {
                    string sql = @"  insert into rbac_Resource(rowID,resourceCode,resourceName) values(@rowID,@resourceCode,@resourceName) ";
                    ef.Execute(sql, new { rowID = ef.newGuid(), resourceCode = "sbs_Dept", resourceName = "测试" });
                }

                ef.commit();
            }
            catch(Exception ex)
            {
                rui.logHelper.log(ex);
                ef.rollBack();
            }
        }

        //跨方法事务，方法的参数需要有db.dbEntities对象
        public void subMethod(db.dbEntities dc)
        {
            db.efHelper ef = new db.efHelper(ref dc);

            try
            {
                ef.beginTran();

                {
                    string sql = @"  insert into rbac_Resource(rowID,resourceCode,resourceName) values(@rowID,@resourceCode,@resourceName) ";
                    ef.Execute(sql, new { rowID = ef.newGuid(), resourceCode = "34", resourceName = "测试" });
                }
                {
                    string sql = @"  insert into rbac_Resource(rowID,resourceCode,resourceName) values(@rowID,@resourceCode,@resourceName) ";
                    ef.Execute(sql, new { rowID = ef.newGuid(), resourceCode = "sbs_Dept", resourceName = "测试" });
                }

                ef.commit();
            }
            catch (Exception ex)
            {
                rui.logHelper.log(ex);
                ef.rollBack();
            }
        }


    }
}
