USE [ElectoralGiftSystem]
GO

/****** Object:  StoredProcedure [dbo].[sp_CloseElection]    Script Date: 6/13/2021 10:09:06 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_CloseElection] 
	@ElectionID int
AS
BEGIN
	SET NOCOUNT ON;

    UPDATE tbElection
	SET Closed = 1
	WHERE ElectionID = @ElectionID
END

GO

