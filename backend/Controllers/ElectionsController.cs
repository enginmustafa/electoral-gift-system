using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Http;

using ElectoralGiftSystem.Constants;
using ElectoralGiftSystem.Models;
using ElectoralGiftSystem.Models.Elections;

namespace ElectoralGiftSystem.Controllers
{
    public class ElectionsController : ApiController
    {
        #region Controllers


        //api/elections
        [HttpGet]
        public MyResponse Get()
        {
            DataTable tb = new DataTable();
            MyResponse response = new MyResponse();


            //This part is quite repetitive(creating connection/command, executing, try/cath, and extracting result), 
            //might be a good idea to create a utility class that creates, executes and returns the needed result from DB
            //with given needed parameters without all the hassle if more alike controllers are planned to be used.
            using (SqlConnection cnn = DBConnection.New())
            {
                using (SqlCommand cmd = new SqlCommand(StoredProcedures.sp_GetElections, cnn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

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

        //api/elections/
        [HttpPost]
        public MyResponse Create(Create_IN model)
        {
            MyResponse response = new MyResponse();
            Int16 createForYear = GetElectionYearByBirthdate(model.Birthdate);
            bool isStaffAvailable = CheckStaffAvailableForNewElection(model.CreateFor, createForYear);

            //if new election cannot be created, exit function without executing further procedures
            if(!isStaffAvailable)
            {
                response.ErrorMessage = ErrorMessages.OnlyOneElectionPerBirthYearAllowed;
                return response;
            }

            using (SqlConnection cnn = DBConnection.New())
            {
                using (SqlCommand cmd = new SqlCommand(StoredProcedures.sp_CreateElection, cnn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@CreatedBy", model.CreateBy);
                    cmd.Parameters.AddWithValue("@CreatedFor", model.CreateFor);
                    cmd.Parameters.AddWithValue("@CreatedForYear", createForYear);

                    try
                    {
                        cnn.Open();
                        cmd.ExecuteNonQuery();
                    }
                    catch (Exception ex)
                    {
                        response.ErrorMessage = ex.Message;
                        response.Success = false;
                    }
                }

            }

            return response;
        }

        //api/elections/
        [HttpPut]
        public MyResponse Close([FromBody]int ElectionID)
        {
            MyResponse response = new MyResponse();

            using (SqlConnection cnn = DBConnection.New())
            {
                using (SqlCommand cmd = new SqlCommand(StoredProcedures.sp_CloseElection, cnn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@ElectionID", ElectionID);

                    try
                    {
                        cnn.Open();
                        cmd.ExecuteNonQuery();
                    }
                    catch (Exception ex)
                    {
                        response.ErrorMessage = ex.Message;
                        response.Success = false;
                    }
                }

            }

            return response;
        }

        [HttpPost]
        [Route("api/elections/elect")]
        public MyResponse ElectGift(ElectGift_IN model)
        {
            MyResponse response = new MyResponse();

            using (SqlConnection cnn = DBConnection.New())
            {
                using (SqlCommand cmd = new SqlCommand(StoredProcedures.sp_ElectGift, cnn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@ElectionID", model.ElectionID);
                    cmd.Parameters.AddWithValue("@StaffID", model.StaffID);
                    cmd.Parameters.AddWithValue("@GiftID", model.GiftID);

                    try
                    {
                        cnn.Open();
                        cmd.ExecuteNonQuery();
                    }
                    catch (Exception ex)
                    {
                        response.ErrorMessage = ex.Message;
                        response.Success = false;
                    }
                }

            }

            return response;
        }


        [HttpPost]
        [Route("api/elections/results")]
        public MyResponse GetResultsOfElection([FromBody]int ElectionID)
        {
            DataTable tb = new DataTable();
            MyResponse response = new MyResponse();

            using (SqlConnection cnn = DBConnection.New())
            {
                using (SqlCommand cmd = new SqlCommand(StoredProcedures.sp_GetElectionResults, cnn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@ElectionID", ElectionID);

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


        # endregion


        #region Methods


        //check if an election can be created for the staff for specified year(only one election per year/birthday allowed)
        private bool CheckStaffAvailableForNewElection(int staffID, Int16 electionYear)
        {
            bool isAvailable = false;

            using (SqlConnection cnn = DBConnection.New())
            {
                using (SqlCommand cmd = new SqlCommand(StoredProcedures.sp_CheckStaffAvailableForNewElection, cnn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@StaffID", staffID);
                    cmd.Parameters.AddWithValue("@ElectionYear", electionYear);
                    cmd.Parameters.Add("@IsAvailable", SqlDbType.Bit).Direction = ParameterDirection.Output;


                    try
                    {
                        cnn.Open();
                        cmd.ExecuteNonQuery();

                        isAvailable = (bool)(cmd.Parameters["@IsAvailable"].Value);
                    }
                    catch (Exception)
                    {
                        //implement error catchto return to UI
                    }
                }

            }

            return isAvailable;
        }

        //get the year of birthday based on birthdate an current date
        private Int16 GetElectionYearByBirthdate(DateTime birthDate)
        {
            Int16 nextBirthYear = (Int16)(DateTime.Now.Year);

            if(birthDate.Month > DateTime.Now.Month)
            {
                nextBirthYear += + 1;
            }

            return nextBirthYear;

        }


        #endregion
    }
}
