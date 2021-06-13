USE [ElectoralGiftSystem]
GO

/****** Object:  StoredProcedure [dbo].[sp_CheckStaffAvailableForNewElection]    Script Date: 6/13/2021 10:08:39 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_CheckStaffAvailableForNewElection]
@StaffID int,
@ElectionYear smallint,
@IsAvailable bit OUTPUT 
AS
BEGIN
	SET NOCOUNT ON;

	IF EXISTS (SELECT ElectionID 
						FROM tbElection 
						WHERE CreatedForYear = @ElectionYear AND CreatedFor = @StaffID)
	  BEGIN
		SELECT @IsAvailable = CAST(0 AS bit);
	  END
	ELSE 
	  BEGIN
	    SELECT @IsAvailable = CAST(1 AS bit);
	  END
	
END

GO

