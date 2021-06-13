USE [ElectoralGiftSystem]
GO

/****** Object:  StoredProcedure [dbo].[sp_GetElections]    Script Date: 6/13/2021 10:09:52 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_GetElections]
AS
BEGIN
	SET NOCOUNT ON;

	SELECT ElectionID, CreatedFor, CreatedBy, Name, Birthdate, CreatedForYear, Closed
	FROM vw_StaffElections

END

GO

