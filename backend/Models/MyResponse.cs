using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace ElectoralGiftSystem.Models
{
    public class MyResponse
    {
        public DataTable Table;
        public bool Success = true;
        public string ErrorMessage;
    }
}