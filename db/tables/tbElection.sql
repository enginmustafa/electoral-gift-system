USE [ElectoralGiftSystem]
GO

/****** Object:  Table [dbo].[tbElection]    Script Date: 6/13/2021 10:06:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tbElection](
	[ElectionID] [int] IDENTITY(1,1) NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[CreatedFor] [int] NOT NULL,
	[CreatedForYear] [smallint] NOT NULL,
	[Closed] [bit] NOT NULL CONSTRAINT [DF_tbElection_Closed]  DEFAULT ((0)),
 CONSTRAINT [PK_tbElection] PRIMARY KEY CLUSTERED 
(
	[ElectionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [UK_CreatedFor_CreatedForYear] UNIQUE NONCLUSTERED 
(
	[CreatedFor] ASC,
	[CreatedForYear] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[tbElection]  WITH CHECK ADD  CONSTRAINT [FK_tbStaff_tbElection_CreatedBy] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[tbStaff] ([StaffID])
GO

ALTER TABLE [dbo].[tbElection] CHECK CONSTRAINT [FK_tbStaff_tbElection_CreatedBy]
GO

ALTER TABLE [dbo].[tbElection]  WITH CHECK ADD  CONSTRAINT [FK_tbStaff_tbElection_CreatedFor] FOREIGN KEY([CreatedFor])
REFERENCES [dbo].[tbStaff] ([StaffID])
GO

ALTER TABLE [dbo].[tbElection] CHECK CONSTRAINT [FK_tbStaff_tbElection_CreatedFor]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ensure staff has only one vote per birthday for specific year.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tbElection', @level2type=N'CONSTRAINT',@level2name=N'UK_CreatedFor_CreatedForYear'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key to enforce staff exists.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tbElection', @level2type=N'CONSTRAINT',@level2name=N'FK_tbStaff_tbElection_CreatedBy'
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key to enforce staff exists.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tbElection', @level2type=N'CONSTRAINT',@level2name=N'FK_tbStaff_tbElection_CreatedFor'
GO

