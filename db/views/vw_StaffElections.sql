USE [ElectoralGiftSystem]
GO

/****** Object:  View [dbo].[vw_StaffElections]    Script Date: 6/13/2021 10:07:55 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vw_StaffElections]
AS 
SELECT ElectionID, CreatedBy, CreatedFor, CreatedForYear, Closed, Name, BirthDate
FROM tbElection t1
INNER JOIN tbStaff t2
ON t1.CreatedFor = t2.StaffID
GO

