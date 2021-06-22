using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace rui
{
    /// <summary>
    /// 工厂辅助类
    /// 处理和Core代码差异性
    /// </summary>
    public class dbFactory : DbProviderFactory
    {
        private string prividerName;

        /// <summary>
        /// 实例化工厂
        /// </summary>
        /// <param name="PrividerName">提供程序名称</param>
        public dbFactory(string PrividerName)
        {
            this.prividerName = PrividerName;
        }

        /// <summary>
        /// 获取连接对象
        /// </summary>
        /// <returns></returns>
        public override DbConnection CreateConnection()
        {
            DbProviderFactory dbFactory = DbProviderFactories.GetFactory(prividerName);
            return dbFactory.CreateConnection();
        }
    }
}
