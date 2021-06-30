using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace db.client.view
{
    public class Register
    {
        [Required]
        public string customerCode { get; set; }
        [Required]
        public string cusomterName { get; set; }
        [Required]
        public string password { get; set; }
        [Compare("password",ErrorMessage ="两次输入的不一致")]
        public string Confirmpass { get; set; }
        [Required]
        public string telphone { get; set; }
        [Required]
        public string email { get; set; }
    }
}
