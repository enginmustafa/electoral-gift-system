using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Http;

using ElectoralGiftSystem.Models;
using ElectoralGiftSystem.Models.Staff;
using ElectoralGiftSystem.Constants;

namespace ElectoralGiftSystem.Controllers
{
    public class StaffController : ApiController
    {

        //this might be a GET request as well, my purpose of using otherwise is
        //to hide parameters from url (GET doesn't have a request body)
        [HttpPost]
        [Route("api/staff/authorize")]
        public MyResponse Authorize(Auhtorize_IN model)
        {
            DataTable tb = new DataTable();
            MyResponse response = new MyResponse();

            using (SqlConnection cnn = DBConnection.New())
            {
                using (SqlCommand cmd = new SqlCommand(StoredProcedures.sp_AuthenticateStaff, cnn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Username", model.Username);
                    cmd.Parameters.AddWithValue("@Password", model.Password);

                    SqlDataAdapter adapter = new SqlDataAdapter(cmd);

                    try
                    {
                        cnn.Open();
                        adapter.Fill(tb);
                    }
                    catch (Exception ex)
                    {
                        response.ErrorMessage = ex.Message;
                        response.Success = false;
                    }
                }
            }

            response.Table = tb;
            return response;
        }

        //api/staff
        [HttpPost]
        public MyResponse GetStaffAvailableForElection([FromBody]int StaffID)
        {
            DataTable tb = new DataTable();
            MyResponse response = new MyResponse();

            using (SqlConnection cnn = DBConnection.New())
            {
                using (SqlCommand cmd = new SqlCommand(StoredProcedures.sp_GetStaffForElection, cnn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@StaffID", StaffID);

                    SqlDataAdapter adapter = new SqlDataAdapter(cmd);

                    try
                    {
                        cnn.Open();
                        adapter.Fill(tb);
                    }
                    catch (Exception ex)
                    {
                        response.ErrorMessage = ex.Message;
                        response.Success = false;
                    }
                }
            }

            response.Table = tb;
            return response;
        }
    }
}
