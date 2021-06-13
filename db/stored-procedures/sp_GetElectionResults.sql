USE [ElectoralGiftSystem]
GO

/****** Object:  StoredProcedure [dbo].[sp_GetElectionResults]    Script Date: 6/13/2021 10:09:41 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_GetElectionResults]
@ElectionID int
AS
BEGIN
	SET NOCOUNT ON;

	CREATE TABLE #ttbResults 
	(
		StaffID int primary key, 
		GiftID int null,
		GiftName varchar(250) null
	)

	INSERT INTO #ttbResults 
	SELECT StaffID, null, null
	FROM tbStaff 
	WHERE StaffID <> (SELECT CreatedFor FROM tbElection WHERE ElectionID = @ElectionID)

	UPDATE #ttbResults
	SET GiftID = t2.GiftID
	FROM #ttbResults t1 
	INNER JOIN tbStaffElection t2
	ON t1.StaffID = t2.StaffID 
	WHERE t2.ElectionID = @ElectionID

	UPDATE #ttbResults
	SET GiftName = t2.Name
	FROM #ttbResults t1
	INNER JOIN tbGift t2 
	ON t1.GiftID = t2.GiftID 

	SELECT StaffID, GiftName
	FROM #ttbResults

	DROP TABLE #ttbResults;
END

GO

