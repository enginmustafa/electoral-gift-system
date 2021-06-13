USE [ElectoralGiftSystem]
GO

/****** Object:  StoredProcedure [dbo].[sp_GetStaffForElection]    Script Date: 6/13/2021 10:10:06 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_GetStaffForElection]
@StaffID int
AS
BEGIN
	SET NOCOUNT ON;

	SELECT StaffID, Name, Birthdate
	FROM tbStaff t1
	WHERE StaffID <> @StaffID AND NOT EXISTS (SELECT ElectionID FROM vw_StaffElections WHERE CreatedFor = t1.StaffID AND Closed = 0)
END


GO

