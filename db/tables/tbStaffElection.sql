USE [ElectoralGiftSystem]
GO

/****** Object:  Table [dbo].[tbStaffElection]    Script Date: 6/13/2021 10:07:21 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tbStaffElection](
	[StaffElectionID] [int] IDENTITY(1,1) NOT NULL,
	[ElectionID] [int] NOT NULL,
	[StaffID] [int] NOT NULL,
	[GiftID] [int] NOT NULL,
 CONSTRAINT [PK_tbStaffElection] PRIMARY KEY CLUSTERED 
(
	[StaffElectionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[tbStaffElection]  WITH CHECK ADD  CONSTRAINT [FK_tbElection_tbStaffElection] FOREIGN KEY([ElectionID])
REFERENCES [dbo].[tbElection] ([ElectionID])
GO

ALTER TABLE [dbo].[tbStaffElection] CHECK CONSTRAINT [FK_tbElection_tbStaffElection]
GO

ALTER TABLE [dbo].[tbStaffElection]  WITH CHECK ADD  CONSTRAINT [FK_tbGift_tbStaffElection] FOREIGN KEY([GiftID])
REFERENCES [dbo].[tbGift] ([GiftID])
GO

ALTER TABLE [dbo].[tbStaffElection] CHECK CONSTRAINT [FK_tbGift_tbStaffElection]
GO

ALTER TABLE [dbo].[tbStaffElection]  WITH CHECK ADD  CONSTRAINT [FK_tbStaff_tbStaffElection] FOREIGN KEY([StaffID])
REFERENCES [dbo].[tbStaff] ([StaffID])
GO

ALTER TABLE [dbo].[tbStaffElection] CHECK CONSTRAINT [FK_tbStaff_tbStaffElection]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ensure election exists.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tbStaffElection', @level2type=N'CONSTRAINT',@level2name=N'FK_tbElection_tbStaffElection'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ensure gift exists.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tbStaffElection', @level2type=N'CONSTRAINT',@level2name=N'FK_tbGift_tbStaffElection'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ensure staff exists.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tbStaffElection', @level2type=N'CONSTRAINT',@level2name=N'FK_tbStaff_tbStaffElection'
GO

