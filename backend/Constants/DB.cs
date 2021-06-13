using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace ElectoralGiftSystem.Constants
{

    public static class StoredProcedures
    {
        //authenticate staff by Username and Password, returns Staff record 
        public const string sp_AuthenticateStaff = "sp_AuthenticateStaff";

        //get all staff by StaffID(without provided StaffID)
        public const string sp_GetStaffForElection = "sp_GetStaffForElection";

        //check if staff is available for opening new election by StaffID and ElectionYear, return boolean
        public const string sp_CheckStaffAvailableForNewElection = "sp_CheckStaffAvailableForNewElection";

        //get election results - who voted for which gift / null if no vote present from specific user
        public const string sp_GetElectionResults = "sp_GetElectionResults";

        //get all elections (election of current staff will be filtered out & closed/opened ones will be differentiated on front-end)
        public const string sp_GetElections = "sp_GetElections";

        //close an election by ElectionID
        public const string sp_CloseElection = "sp_CloseElection";

        //create new election by CreateBy, CreateFor, CreateForYear
        public const string sp_CreateElection = "sp_CreateElection";

        //elect a gift by ElectionID, StaffID(who is electing), GiftID
        public const string sp_ElectGift = "sp_ElectGift";


    }

    public static class DBConnection
    {
        public static SqlConnection New()
        {
            return new SqlConnection(Properties.Resources.ConnectionString);
        }
    }

}