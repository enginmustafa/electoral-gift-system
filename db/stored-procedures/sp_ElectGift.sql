USE [ElectoralGiftSystem]
GO

/****** Object:  StoredProcedure [dbo].[sp_ElectGift]    Script Date: 6/13/2021 10:09:30 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_ElectGift] 
	@ElectionID int,
	@StaffID int,
	@GiftID int
AS
BEGIN
	SET NOCOUNT ON;

    INSERT INTO tbStaffElection(ElectionID, StaffID, GiftID) VALUES(@ElectionID, @StaffID, @GiftID);
END

GO

