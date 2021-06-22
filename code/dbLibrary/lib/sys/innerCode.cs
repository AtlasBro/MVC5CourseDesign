using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace rui
{
    /// <summary>
    /// 内定编码-名称对应表
    /// 通过名称获取对应的编码
    /// 
    /// 存放系统的配置，自己增加的增加在innerCodeAdd类中
    /// </summary>
    public partial class innerCode
    {
        //mime类型
        public static string mime(string name)
        {
            switch (name)
            {
                case ".xlsx":
                    return "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            }
            return "";
        }
    }
}
