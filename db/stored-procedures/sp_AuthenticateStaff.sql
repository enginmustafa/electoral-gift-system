USE [ElectoralGiftSystem]
GO

/****** Object:  StoredProcedure [dbo].[sp_AuthenticateStaff]    Script Date: 6/13/2021 10:08:21 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_AuthenticateStaff]
@Username varchar(100),
@Password varchar(100)
AS
BEGIN
	SET NOCOUNT ON;


	SELECT StaffID, Name, BirthDate FROM tbStaff
	WHERE [Username] = @Username AND [Password] = @Password
END

GO

