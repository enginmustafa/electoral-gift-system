USE [ElectoralGiftSystem]
GO

/****** Object:  StoredProcedure [dbo].[sp_CreateElection]    Script Date: 6/13/2021 10:09:19 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_CreateElection] 
	@CreatedBy int,
	@CreatedFor int,
	@CreatedForYear smallint
AS
BEGIN
	SET NOCOUNT ON;

    INSERT INTO tbElection(CreatedBy, CreatedFor, CreatedForYear) VALUES(@CreatedBy, @CreatedFor, @CreatedForYear);
END

GO

