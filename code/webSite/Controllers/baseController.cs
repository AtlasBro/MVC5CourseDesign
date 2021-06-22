using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace web.Controllers
{
    public class baseController : Controller
    {
        /// <summary>
        /// 请求过程中所用的统一DbContent对象
        /// </summary>
        private db.dbEntities _dc = null;
        public db.dbEntities dc
        {
            get
            {
                if (_dc == null)
                {
                    _dc = db.efHelper.newDc();
                }
                return _dc;
            }
        }

        public string privResource { get; set; }
        public string privOperation { get; set; }
    }
}