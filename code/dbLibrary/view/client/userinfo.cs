using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace db.view.client
{
    public class userinfo
    {
        [Required]
       //[DisplayName("用户编号")]
        public string CustomerCode { get; set; }

        [Required]
        [MaxLength(10)]
        //[DisplayName("用户名")]
        public string CustomerName { get; set; }

        [Required]
        //[DisplayName("密码")]
        //[Range(6, 25, ErrorMessage = "长度应在6-25个字符之间")]
        public string password { get; set; }

        [Required]
        //[DisplayName("邮箱")]
        [DataType(DataType.EmailAddress, ErrorMessage = "格式错误")]
        public string email { get; set; }

        [Required]
        [DataType(DataType.PhoneNumber, ErrorMessage = "手机号格式错误")]
        public string telephone { get; set; }
    }
}
