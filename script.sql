USE [HrManagementTool]
GO
/****** Object:  UserDefinedTableType [dbo].[CandidateType]    Script Date: 8/23/2017 4:28:29 PM ******/
CREATE TYPE [dbo].[CandidateType] AS TABLE(
	[FirstName] [varchar](255) NOT NULL,
	[LastName] [varchar](255) NOT NULL,
	[PhoneNumber] [varchar](20) NOT NULL,
	[Email] [varchar](254) NOT NULL,
	[Address] [varchar](254) NOT NULL,
	[CV] [varchar](max) NOT NULL,
	[PositionId] [int] NOT NULL,
	[RoleId] [int] NOT NULL,
	[StatusId] [int] NOT NULL,
	[CreatedBy] [int] NOT NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[EmployeeType]    Script Date: 8/23/2017 4:28:30 PM ******/
CREATE TYPE [dbo].[EmployeeType] AS TABLE(
	[FirstName] [varchar](255) NOT NULL,
	[LastName] [varchar](255) NOT NULL,
	[UserName] [varchar](255) NOT NULL,
	[PasswordHash] [varchar](255) NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[PositionId] [int] NOT NULL,
	[RoleId] [int] NOT NULL
)
GO
/****** Object:  UserDefinedFunction [dbo].[fnValidateEmail]    Script Date: 8/23/2017 4:28:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnValidateEmail] (
	@email VARCHAR(254)
)
RETURNS BIT
AS
BEGIN
RETURN (
SELECT
	CASE 
		WHEN 	@Email IS NULL THEN 0
		WHEN	CHARINDEX(' ', @email) 	<> 0 OR
				CHARINDEX('/', @email) 	<> 0 OR
				CHARINDEX(':', @email) 	<> 0 OR
				CHARINDEX(';', @email) 	<> 0 THEN 0
		WHEN LEN(@Email)-1 <= CHARINDEX('.', @Email) THEN 0
		WHEN 	@Email LIKE '%@%@%' OR 
				@Email NOT LIKE '%@%.%'  THEN 0
		ELSE 1
	END
)
END
GO
/****** Object:  UserDefinedFunction [dbo].[fnValidateJSON]    Script Date: 8/23/2017 4:28:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnValidateJSON] (
	@jsonData VARCHAR(max)
)
RETURNS BIT
AS
BEGIN
RETURN (
	SELECT ISJSON(@jsonData)
)
END
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 8/23/2017 4:28:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](255) NOT NULL,
	[LastName] [varchar](255) NOT NULL,
	[UserName] [varchar](255) NOT NULL,
	[PasswordHash] [varchar](255) NOT NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
	[PositionId] [int] NOT NULL,
	[RoleId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_Employee]    Script Date: 8/23/2017 4:28:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[vw_Employee]
as
select * from Employee
GO
/****** Object:  Table [dbo].[Candidate]    Script Date: 8/23/2017 4:28:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Candidate](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](255) NOT NULL,
	[LastName] [varchar](255) NOT NULL,
	[PhoneNumber] [varchar](20) NOT NULL,
	[Email] [varchar](254) NOT NULL,
	[Address] [varchar](254) NOT NULL,
	[CV] [varchar](max) NOT NULL,
	[PositionId] [int] NOT NULL,
	[RoleId] [int] NOT NULL,
	[StatusId] [int] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[testInt] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CandidatesIdTestGroup]    Script Date: 8/23/2017 4:28:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CandidatesIdTestGroup](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreatedDate] [datetime] NULL,
	[ScheduleId] [int] NOT NULL,
	[CandIdateId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CandidateStatusTypes]    Script Date: 8/23/2017 4:28:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CandidateStatusTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Status] [varchar](255) NOT NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Status] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ErrorLog]    Script Date: 8/23/2017 4:28:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ErrorLog](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Number] [int] NOT NULL,
	[Severity] [int] NOT NULL,
	[State] [int] NOT NULL,
	[Prodecure] [varchar](200) NOT NULL,
	[Line] [int] NOT NULL,
	[Message] [varchar](8000) NOT NULL,
	[CreatedDate] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EvaluationForm]    Script Date: 8/23/2017 4:28:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EvaluationForm](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Notes] [varchar](1000) NOT NULL,
	[CreatedDate] [datetime] NULL,
	[JSONData] [nvarchar](4000) NOT NULL,
	[EmployeeId] [int] NOT NULL,
	[ScheduleIntervieweId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PositionTypes]    Script Date: 8/23/2017 4:28:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PositionTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Position] [varchar](255) NOT NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Position] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RoleTypes]    Script Date: 8/23/2017 4:28:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoleTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Role] [varchar](255) NOT NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Role] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ScheduleInterview]    Script Date: 8/23/2017 4:28:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ScheduleInterview](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MeetingDate] [datetime] NOT NULL,
	[CandidateId] [int] NOT NULL,
	[HrId] [int] NOT NULL,
	[ModifedDate] [datetime] NULL,
	[ModifedBy] [int] NULL,
	[IsCancelled] [tinyint] NULL,
	[CreatedDate] [datetime] NULL,
	[Document] [varchar](8000) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ScheduleInterviewer]    Script Date: 8/23/2017 4:28:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ScheduleInterviewer](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreatedDate] [datetime] NULL,
	[Status] [tinyint] NULL,
	[Note] [varchar](2000) NULL,
	[ModifedDate] [datetime] NULL,
	[EmployeeId] [int] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[ScheduleId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ScheduleTest]    Script Date: 8/23/2017 4:28:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ScheduleTest](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MeetingDate] [datetime] NOT NULL,
	[IsCancelled] [tinyint] NULL,
	[CreatedDate] [datetime] NULL,
	[HrId] [int] NOT NULL,
	[ModifedDate] [datetime] NULL,
	[ModifedBy] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ScheduleTester]    Script Date: 8/23/2017 4:28:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ScheduleTester](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreatedDate] [datetime] NULL,
	[Status] [tinyint] NULL,
	[Note] [varchar](2000) NULL,
	[ModifedDate] [datetime] NULL,
	[EmployeeId] [int] NOT NULL,
	[CreatedBy] [int] NOT NULL,
	[ScheduleId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CandidatesIdTestGroup] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[CandidateStatusTypes] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[CandidateStatusTypes] ADD  DEFAULT (NULL) FOR [CreatedBy]
GO
ALTER TABLE [dbo].[Employee] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Employee] ADD  DEFAULT (NULL) FOR [CreatedBy]
GO
ALTER TABLE [dbo].[ErrorLog] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[EvaluationForm] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[PositionTypes] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[PositionTypes] ADD  DEFAULT (NULL) FOR [CreatedBy]
GO
ALTER TABLE [dbo].[RoleTypes] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[RoleTypes] ADD  DEFAULT (NULL) FOR [CreatedBy]
GO
ALTER TABLE [dbo].[ScheduleInterview] ADD  DEFAULT ((0)) FOR [IsCancelled]
GO
ALTER TABLE [dbo].[ScheduleInterview] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[ScheduleInterview] ADD  DEFAULT (NULL) FOR [Document]
GO
ALTER TABLE [dbo].[ScheduleInterviewer] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[ScheduleInterviewer] ADD  DEFAULT (NULL) FOR [Status]
GO
ALTER TABLE [dbo].[ScheduleInterviewer] ADD  DEFAULT (NULL) FOR [Note]
GO
ALTER TABLE [dbo].[ScheduleInterviewer] ADD  DEFAULT (NULL) FOR [ModifedDate]
GO
ALTER TABLE [dbo].[ScheduleTest] ADD  DEFAULT ((0)) FOR [IsCancelled]
GO
ALTER TABLE [dbo].[ScheduleTest] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[ScheduleTest] ADD  DEFAULT (NULL) FOR [ModifedDate]
GO
ALTER TABLE [dbo].[ScheduleTest] ADD  DEFAULT (NULL) FOR [ModifedBy]
GO
ALTER TABLE [dbo].[ScheduleTester] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[ScheduleTester] ADD  DEFAULT ((0)) FOR [Status]
GO
ALTER TABLE [dbo].[ScheduleTester] ADD  DEFAULT (NULL) FOR [Note]
GO
ALTER TABLE [dbo].[ScheduleTester] ADD  DEFAULT (NULL) FOR [ModifedDate]
GO
ALTER TABLE [dbo].[Candidate]  WITH CHECK ADD FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Employee] ([Id])
GO
ALTER TABLE [dbo].[Candidate]  WITH CHECK ADD FOREIGN KEY([PositionId])
REFERENCES [dbo].[PositionTypes] ([Id])
GO
ALTER TABLE [dbo].[Candidate]  WITH CHECK ADD FOREIGN KEY([RoleId])
REFERENCES [dbo].[RoleTypes] ([Id])
GO
ALTER TABLE [dbo].[Candidate]  WITH CHECK ADD FOREIGN KEY([StatusId])
REFERENCES [dbo].[CandidateStatusTypes] ([Id])
GO
ALTER TABLE [dbo].[CandidatesIdTestGroup]  WITH CHECK ADD FOREIGN KEY([CandIdateId])
REFERENCES [dbo].[Candidate] ([Id])
GO
ALTER TABLE [dbo].[CandidatesIdTestGroup]  WITH CHECK ADD FOREIGN KEY([ScheduleId])
REFERENCES [dbo].[ScheduleTest] ([Id])
GO
ALTER TABLE [dbo].[CandidateStatusTypes]  WITH CHECK ADD FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Employee] ([Id])
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Employee] ([Id])
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD FOREIGN KEY([PositionId])
REFERENCES [dbo].[PositionTypes] ([Id])
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD FOREIGN KEY([RoleId])
REFERENCES [dbo].[RoleTypes] ([Id])
GO
ALTER TABLE [dbo].[EvaluationForm]  WITH CHECK ADD FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[Employee] ([Id])
GO
ALTER TABLE [dbo].[EvaluationForm]  WITH CHECK ADD FOREIGN KEY([ScheduleIntervieweId])
REFERENCES [dbo].[ScheduleInterviewer] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PositionTypes]  WITH CHECK ADD FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Employee] ([Id])
GO
ALTER TABLE [dbo].[RoleTypes]  WITH CHECK ADD FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Employee] ([Id])
GO
ALTER TABLE [dbo].[ScheduleInterview]  WITH CHECK ADD FOREIGN KEY([CandidateId])
REFERENCES [dbo].[Candidate] ([Id])
GO
ALTER TABLE [dbo].[ScheduleInterview]  WITH CHECK ADD FOREIGN KEY([ModifedBy])
REFERENCES [dbo].[Employee] ([Id])
GO
ALTER TABLE [dbo].[ScheduleInterview]  WITH CHECK ADD FOREIGN KEY([HrId])
REFERENCES [dbo].[Employee] ([Id])
GO
ALTER TABLE [dbo].[ScheduleInterviewer]  WITH CHECK ADD FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Employee] ([Id])
GO
ALTER TABLE [dbo].[ScheduleInterviewer]  WITH CHECK ADD FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[Employee] ([Id])
GO
ALTER TABLE [dbo].[ScheduleInterviewer]  WITH CHECK ADD FOREIGN KEY([ScheduleId])
REFERENCES [dbo].[ScheduleInterview] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ScheduleTest]  WITH CHECK ADD FOREIGN KEY([ModifedBy])
REFERENCES [dbo].[Employee] ([Id])
GO
ALTER TABLE [dbo].[ScheduleTest]  WITH CHECK ADD FOREIGN KEY([HrId])
REFERENCES [dbo].[Employee] ([Id])
GO
ALTER TABLE [dbo].[ScheduleTester]  WITH CHECK ADD FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Employee] ([Id])
GO
ALTER TABLE [dbo].[ScheduleTester]  WITH CHECK ADD FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[Employee] ([Id])
GO
ALTER TABLE [dbo].[ScheduleTester]  WITH CHECK ADD FOREIGN KEY([ScheduleId])
REFERENCES [dbo].[ScheduleTest] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Candidate]  WITH CHECK ADD  CONSTRAINT [PEOPLE_CK_ValidEmail] CHECK  (([dbo].[fnValidateEmail]([Email])=(1)))
GO
ALTER TABLE [dbo].[Candidate] CHECK CONSTRAINT [PEOPLE_CK_ValidEmail]
GO
ALTER TABLE [dbo].[EvaluationForm]  WITH CHECK ADD  CONSTRAINT [CK_FORM_ValidJSON] CHECK  (([dbo].[fnValidateJSON]([JSONData])=(1)))
GO
ALTER TABLE [dbo].[EvaluationForm] CHECK CONSTRAINT [CK_FORM_ValidJSON]
GO
/****** Object:  StoredProcedure [dbo].[InsertError]    Script Date: 8/23/2017 4:28:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InsertError]
	@Number INT,
	@Severity INT,
	@State INT,
	@Procedure VARCHAR(255),
	@Line INT,
	@Message VARCHAR(8000)
AS
BEGIN
	INSERT INTO dbo.ErrorLog (Number, Severity, State, Prodecure, Line, Message)
	VALUES (@Number, @Severity, @State, @Procedure, @Line, @Message)
END;
GO
/****** Object:  StoredProcedure [dbo].[uspEditEvaluationFormJsonData]    Script Date: 8/23/2017 4:28:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspEditEvaluationFormJsonData]
	@employeeId INT,
	@scheduleId INT,
	@jsonDate nvarchar(4000)
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
		UPDATE dbo.EvaluationForm
		SET [JSONData] = @jsonDate
		WHERE ScheduleIntervieweId = @scheduleId
		  AND EmployeeId = @employeeId

		RETURN @employeeId 
	END	 TRY
	BEGIN CATCH
		DECLARE @Number INT;
		DECLARE @Severity INT;
		DECLARE @State INT;
		DECLARE @Procedure VARCHAR(255);
		DECLARE @Line INT;
		DECLARE @Message VARCHAR(8000);

		SELECT @Number = ERROR_NUMBER(),
			   @Severity = ERROR_SEVERITY(),
			   @State = ERROR_STATE(),
			   @Procedure = ERROR_PROCEDURE(),
			   @Line = ERROR_LINE(),
			   @Message = ERROR_MESSAGE();

		exec dbo.InsertError @Number, @Severity, @State, @Procedure, @Line, @Message

		RETURN -1

	END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[uspEditEvaluationFormNotes]    Script Date: 8/23/2017 4:28:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspEditEvaluationFormNotes]
	@employeeId INT,
	@scheduleId INT,
	@notes VARCHAR(1000)
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
		UPDATE dbo.EvaluationForm
		SET [Notes] = @notes
		WHERE ScheduleIntervieweId = @scheduleId
		  AND EmployeeId = @employeeId

		RETURN @employeeId 
	END	 TRY
	BEGIN CATCH
		DECLARE @Number INT;
		DECLARE @Severity INT;
		DECLARE @State INT;
		DECLARE @Procedure VARCHAR(255);
		DECLARE @Line INT;
		DECLARE @Message VARCHAR(8000);

		SELECT @Number = ERROR_NUMBER(),
			   @Severity = ERROR_SEVERITY(),
			   @State = ERROR_STATE(),
			   @Procedure = ERROR_PROCEDURE(),
			   @Line = ERROR_LINE(),
			   @Message = ERROR_MESSAGE();

		exec dbo.InsertError @Number, @Severity, @State, @Procedure, @Line, @Message

		RETURN -1

	END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[uspEditScheduleInterviewDocument]    Script Date: 8/23/2017 4:28:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspEditScheduleInterviewDocument]
	@hrId INT,
	@scheduleId INT,
	@document VARCHAR(8000)
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
		UPDATE dbo.ScheduleInterview
		SET Document = @document,
			ModifedDate = GETDATE(),
			ModifedBy = @hrId
		WHERE Id = @scheduleId

	END	 TRY
	BEGIN CATCH
		DECLARE @Number INT;
		DECLARE @Severity INT;
		DECLARE @State INT;
		DECLARE @Procedure VARCHAR(255);
		DECLARE @Line INT;
		DECLARE @Message VARCHAR(8000);

		SELECT @Number = ERROR_NUMBER(),
			   @Severity = ERROR_SEVERITY(),
			   @State = ERROR_STATE(),
			   @Procedure = ERROR_PROCEDURE(),
			   @Line = ERROR_LINE(),
			   @Message = ERROR_MESSAGE();

		exec dbo.InsertError @Number, @Severity, @State, @Procedure, @Line, @Message

		RETURN -1

	END CATCH
END;

GO
/****** Object:  StoredProcedure [dbo].[uspEditScheduleInterviewer]    Script Date: 8/23/2017 4:28:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspEditScheduleInterviewer]
	@employeeId INT,
	@scheduleId INT,
	@status TINYINT,
	@note VARCHAR(1000)
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
		UPDATE dbo.ScheduleInterviewer
		SET [Status] = @Status,
			Note = @Note,
			ModifedDate = GETDATE()
		WHERE ScheduleId = @scheduleId
		  AND EmployeeId = @employeeId

		RETURN @employeeId 
	END	 TRY
	BEGIN CATCH
		DECLARE @Number INT;
		DECLARE @Severity INT;
		DECLARE @State INT;
		DECLARE @Procedure VARCHAR(255);
		DECLARE @Line INT;
		DECLARE @Message VARCHAR(8000);

		SELECT @Number = ERROR_NUMBER(),
			   @Severity = ERROR_SEVERITY(),
			   @State = ERROR_STATE(),
			   @Procedure = ERROR_PROCEDURE(),
			   @Line = ERROR_LINE(),
			   @Message = ERROR_MESSAGE();

		exec dbo.InsertError @Number, @Severity, @State, @Procedure, @Line, @Message

		RETURN -1

	END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[uspGetCandidates]    Script Date: 8/23/2017 4:28:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspGetCandidates]
AS
BEGIN
	SELECT Id AS id,
	       FirstName AS firstName,
		   LastName AS lastName,		   
		   PhoneNumber AS phone,
		   Email AS email,
		   [Address] AS [address],
		   CV AS cv,
		   PositionId AS positionId,
		   RoleId AS roleId,
		   StatusId AS statusId
	FROM dbo.Candidate
END;
GO
/****** Object:  StoredProcedure [dbo].[uspGetCandidateStatusTypes]    Script Date: 8/23/2017 4:28:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspGetCandidateStatusTypes]
AS
BEGIN
	SELECT Id AS id,
		   [Status] AS [status]
	FROM dbo.CandidateStatusTypes
END;
GO
/****** Object:  StoredProcedure [dbo].[uspGetEmployeeById]    Script Date: 8/23/2017 4:28:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspGetEmployeeById]
	@id INT
AS
BEGIN
	SELECT Id AS id, 
		   FirstName AS firstName, 
		   LastName AS lastName,
		   UserName AS userName, 
		   PasswordHash AS passwordHash,
		   PositionId AS positionId,
		   RoleId AS roleId
	FROM dbo.Employee
	WHERE Id = @id
END;
GO
/****** Object:  StoredProcedure [dbo].[uspGetEmployeeByUserName]    Script Date: 8/23/2017 4:28:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspGetEmployeeByUserName]	
	@userName VARCHAR(255)
AS
BEGIN
	SELECT Id AS id, 
		   FirstName AS firstName, 
		   LastName AS lastName,
		   UserName AS userName, 
		   PasswordHash AS passwordHash,
		   PositionId AS positionId,
		   RoleId AS roleId
	FROM dbo.Employee
	WHERE UserName = @userName
END;
GO
/****** Object:  StoredProcedure [dbo].[uspGetEmployeesByPositionId]    Script Date: 8/23/2017 4:28:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspGetEmployeesByPositionId]
	@PositionId INT
AS
BEGIN
	SELECT Id AS id, 
		   FirstName AS firstName, 
		   LastName AS lastName
	FROM dbo.Employee
	WHERE PositionId = @PositionId
END;
GO
/****** Object:  StoredProcedure [dbo].[uspGetEvaluationFormByScheduleId]    Script Date: 8/23/2017 4:28:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspGetEvaluationFormByScheduleId]
	@scheduleId INT
AS
BEGIN
	SELECT eval.Id AS id,
		   eval.Notes AS notes,
		   eval.CreatedDate AS createdDate,
		   eval.JSONData AS jsonData,
		   e.FirstName AS EmployeeName,
		   e.LastName AS EmployeeSurname,
		   sIe.MeetingDate AS meetingDate
		   FROM dbo.EvaluationForm eval 
		   INNER JOIN dbo.Employee e
		   ON eval.EmployeeId = e.Id
		   INNER JOIN dbo.ScheduleInterview sIe
		   ON eval.ScheduleIntervieweId = sIe.Id
		   WHERE eval.ScheduleIntervieweId = @scheduleId
END;
GO
/****** Object:  StoredProcedure [dbo].[uspGetInterviewerSchedules]    Script Date: 8/23/2017 4:28:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspGetInterviewerSchedules]
	@id INT
AS
BEGIN
	SELECT sIr.Id AS id,
		   sI.CreatedDate AS createdDate,
		   sI.MeetingDate AS meetingDate,
		   sI.IsCancelled AS isCanceled,
		   sI.Document AS document,		   
		   e.FirstName AS hrName,
		   e.LastName AS hrSurname,
		   c.Id AS candidateId,
		   c.FirstName AS candidateName,
		   c.LastName AS candidateSurname,
		   c.PositionId AS candidatePositionId,
		   c.RoleId AS candidateRoleId,
		   c.StatusId AS candidateStatusId
	FROM dbo.ScheduleInterviewer sIr
	INNER JOIN dbo.ScheduleInterview sI
	On sIr.ScheduleId = sI.Id
	INNER JOIN dbo.Employee e
	On sI.HrId = e.Id
	INNER JOIN dbo.Candidate c
	On sI.CandidateId = c.Id
	WHERE sIr.EmployeeId = @id
END;

GO
/****** Object:  StoredProcedure [dbo].[uspGetInterviewSchedules]    Script Date: 8/23/2017 4:28:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspGetInterviewSchedules]
AS
BEGIN
	SELECT sI.Id AS id,
		   sI.CreatedDate AS createdDate,
		   sI.MeetingDate AS meetingDate,
		   sI.IsCancelled AS isCanceled,
		   sI.Document AS document,
		   e.FirstName AS hrName,
		   e.LastName AS hrSurname,
		   c.Id AS candidateId,
		   c.FirstName AS candidateName,
		   c.LastName AS candidateSurname,
		   c.PositionId AS candidatePositionId,
		   c.RoleId AS candidateRoleId
	FROM dbo.ScheduleInterview sI
	INNER JOIN dbo.Employee e
	On sI.HrId = e.Id
	INNER JOIN dbo.Candidate c
	On sI.CandidateId = c.Id
END;

GO
/****** Object:  StoredProcedure [dbo].[uspGetInterviewSchedulesWithEmplyeeResponse]    Script Date: 8/23/2017 4:28:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspGetInterviewSchedulesWithEmplyeeResponse]
AS
BEGIN
	SELECT sI.Id AS id,
		   sI.CreatedDate AS createdDate,
		   sI.MeetingDate AS meetingDate,
		   sI.IsCancelled AS isCanceled,
		   sI.Document AS document,
		   e.FirstName AS hrName,
		   e.LastName AS hrSurname,
		   c.FirstName AS candidateName,
		   c.LastName AS candidateSurname,
		   c.PositionId AS candidatePositionId,
		   c.PhoneNumber AS candidatePhone,
		   c.Email AS candidateEmail,
		   c.CV AS candidateCv,
		   c.Address AS candidateAddress
	FROM dbo.ScheduleInterview sI
	INNER JOIN dbo.Employee e
	On sI.HrId = e.Id
	INNER JOIN dbo.Candidate c
	On sI.CandidateId = c.Id

	SELECT sIr.Id AS id,
	       sIr.Status AS status,
		   sIr.Note AS note,
		   sIr.ScheduleId AS scheduleId,
		   e.FirstName AS firstName,
		   e.LastName AS lastName,
		   e.PositionId AS positionId,
		   e.RoleId AS roleId
	FROM dbo.ScheduleInterview sI
	INNER JOIN dbo.ScheduleInterviewer sIr
	ON sI.Id = sIr.ScheduleId
	INNER JOIN dbo.Employee e
	ON e.Id = sIr.EmployeeId
	ORDER BY sIr.ScheduleId;
END;

GO
/****** Object:  StoredProcedure [dbo].[uspGetPositionTypes]    Script Date: 8/23/2017 4:28:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspGetPositionTypes]
AS
BEGIN
	SELECT Id AS id,
		   Position AS position
	FROM dbo.PositionTypes
END;
GO
/****** Object:  StoredProcedure [dbo].[uspGetRoleTypes]    Script Date: 8/23/2017 4:28:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspGetRoleTypes]
AS
BEGIN
	SELECT Id AS id,
		   [Role] AS [role]
	FROM dbo.RoleTypes
END;
GO
/****** Object:  StoredProcedure [dbo].[uspGetTesterSchedules]    Script Date: 8/23/2017 4:28:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspGetTesterSchedules]
	@id INT
AS
BEGIN
	SELECT sTer.Id AS id,
		sT.CreatedDate AS createdDate,
		sT.MeetingDate AS meetingDate,
		sT.IsCancelled AS isCanceled,   
		e.FirstName AS hrName,
		e.LastName AS hrSurname,
		(SELECT COUNT(*) FROM dbo.CandidatesIdTestGroup WHERE ScheduleId = sT.Id) AS candidatesCount,
		(SELECT COUNT(*) FROM dbo.ScheduleTester WHERE ScheduleId = sT.Id) AS testersCount
	FROM dbo.ScheduleTester sTer
	INNER JOIN dbo.ScheduleTest sT
	ON sTer.ScheduleId = sT.Id
	INNER JOIN dbo.Employee e
	ON sT.HrId = e.Id	
	WHERE sTer.EmployeeId = @id
END;
GO
/****** Object:  StoredProcedure [dbo].[uspGetTestScheduleCandidates]    Script Date: 8/23/2017 4:28:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspGetTestScheduleCandidates]
	@scheduleId INT
AS
BEGIN
	SELECT c.FirstName AS firstName,
		   c.LastName AS lastName,
		   c.RoleId AS roleId,
		   c.PositionId AS positionId,
		   c.StatusId AS statusId
	FROM dbo.CandidatesIdTestGroup cG
	INNER JOIN dbo.Candidate c
	ON c.Id = cG.CandidateId
	WHERE cG.ScheduleId = @scheduleId
END;
GO
/****** Object:  StoredProcedure [dbo].[uspGetTestSchedules]    Script Date: 8/23/2017 4:28:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspGetTestSchedules]
AS
BEGIN
	SELECT sT.Id AS id,
		   sT.CreatedDate AS createdDate,
		   sT.MeetingDate AS meetingDate,
		   sT.IsCancelled AS isCanceled,
		   e.FirstName AS hrName,
		   e.LastName AS hrSurname,
		   (SELECT COUNT(*) FROM dbo.CandidatesIdTestGroup WHERE ScheduleId = sT.Id) AS candidatesCount,
		   (SELECT COUNT(*) FROM dbo.ScheduleTester WHERE ScheduleId = sT.Id) AS testersCount
	FROM dbo.ScheduleTest sT
	INNER JOIN dbo.Employee e
	ON sT.HrId = e.Id
END;
GO
/****** Object:  StoredProcedure [dbo].[uspGetTestScheduleTesters]    Script Date: 8/23/2017 4:28:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspGetTestScheduleTesters]
	@scheduleId INT
AS
BEGIN
	SELECT e.Id AS id,
		   e.FirstName AS firstName,
		   e.LastName AS lastName
	FROM dbo.ScheduleTester sTer
	INNER JOIN dbo.Employee e
	ON e.Id = sTer.EmployeeId
	WHERE sTer.ScheduleId = @scheduleId
END;
GO
/****** Object:  StoredProcedure [dbo].[uspInsertCandidate]    Script Date: 8/23/2017 4:28:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspInsertCandidate]
	@C CandidateType READONLY
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
		DECLARE @CandidateId INT

		INSERT INTO dbo.Candidate 
		SELECT TOP 1 * FROM @C

		SET @CandidateId = SCOPE_IDENTITY();

		RETURN @CandidateId 
	END	 TRY
	BEGIN CATCH
		DECLARE @Number INT;
		DECLARE @Severity INT;
		DECLARE @State INT;
		DECLARE @Procedure VARCHAR(255);
		DECLARE @Line INT;
		DECLARE @Message VARCHAR(8000);

		SELECT @Number = ERROR_NUMBER(),
			   @Severity = ERROR_SEVERITY(),
			   @State = ERROR_STATE(),
			   @Procedure = ERROR_PROCEDURE(),
			   @Line = ERROR_LINE(),
			   @Message = ERROR_MESSAGE();

		exec dbo.InsertError @Number, @Severity, @State, @Procedure, @Line, @Message

		RETURN -1

	END CATCH
END;

/*

@firstName VARCHAR(255),
@lastName VARCHAR(255),
@positionId INT,
@roleId INT,
@statusId INT,
@email VARCHAR(254),
@phone VARCHAR(20),
@address VARCHAR(255),
@cv VARCHAR(MAX),
@createdBy INT

*/
GO
/****** Object:  StoredProcedure [dbo].[uspInsertCandidateStatusType]    Script Date: 8/23/2017 4:28:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspInsertCandidateStatusType]
	@status VARCHAR(255),
	@createdBy INT
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
		DECLARE @RoleTypeId INT

		INSERT INTO dbo.CandidateStatusTypes([Status], CreatedBy)
		VALUES (@status, @createdBy)

		SET @RoleTypeId = SCOPE_IDENTITY();

		RETURN @RoleTypeId 
	END	 TRY
	BEGIN CATCH
		DECLARE @Number INT;
		DECLARE @Severity INT;
		DECLARE @State INT;
		DECLARE @Procedure VARCHAR(255);
		DECLARE @Line INT;
		DECLARE @Message VARCHAR(8000);

		SELECT @Number = ERROR_NUMBER(),
			   @Severity = ERROR_SEVERITY(),
			   @State = ERROR_STATE(),
			   @Procedure = ERROR_PROCEDURE(),
			   @Line = ERROR_LINE(),
			   @Message = ERROR_MESSAGE();

		exec [dbo].[InsertError] @Number, @Severity, @State, @Procedure, @Line, @Message

		RETURN -1

	END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[uspInsertCandidateToGroup]    Script Date: 8/23/2017 4:28:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspInsertCandidateToGroup]
	@scheduleId INT,
	@candidateId INT
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
		DECLARE @CandidateInGroupId INT

		INSERT INTO dbo.CandidatesIdTestGroup  (ScheduleId, CandidateId)
		VALUES (@scheduleId, @candidateId)

		SET @CandidateInGroupId = SCOPE_IDENTITY();

		RETURN @CandidateInGroupId 
	END	 TRY
	BEGIN CATCH
		DECLARE @Number INT;
		DECLARE @Severity INT;
		DECLARE @State INT;
		DECLARE @Procedure VARCHAR(255);
		DECLARE @Line INT;
		DECLARE @Message VARCHAR(8000);

		SELECT @Number = ERROR_NUMBER(),
			   @Severity = ERROR_SEVERITY(),
			   @State = ERROR_STATE(),
			   @Procedure = ERROR_PROCEDURE(),
			   @Line = ERROR_LINE(),
			   @Message = ERROR_MESSAGE();

		exec dbo.InsertError @Number, @Severity, @State, @Procedure, @Line, @Message

		RETURN -1

	END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[uspInsertEmployee]    Script Date: 8/23/2017 4:28:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspInsertEmployee]
	@E EmployeeType READONLY
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
		DECLARE @EmployeeId INT

		INSERT INTO dbo.Employee (FirstName, LastName, UserName, PasswordHash, CreatedBy, PositionId, RoleId)
		SELECT TOP 1 *
		FROM @E

		SET @EmployeeId = SCOPE_IDENTITY();

		RETURN @EmployeeId 
	END	 TRY
	BEGIN CATCH
		DECLARE @Number INT;
		DECLARE @Severity INT;
		DECLARE @State INT;
		DECLARE @Procedure VARCHAR(255);
		DECLARE @Line INT;
		DECLARE @Message VARCHAR(8000);

		SELECT @Number = ERROR_NUMBER(),
			   @Severity = ERROR_SEVERITY(),
			   @State = ERROR_STATE(),
			   @Procedure = ERROR_PROCEDURE(),
			   @Line = ERROR_LINE(),
			   @Message = ERROR_MESSAGE();

		exec dbo.InsertError @Number, @Severity, @State, @Procedure, @Line, @Message

		RETURN -1

	END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[uspInsertEvaluationForm]    Script Date: 8/23/2017 4:28:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspInsertEvaluationForm]
	@notes VARCHAR(8000),
	@jsonData NVARCHAR(4000),
	@employeeId INT,
	@scheduleIntervieweId INT
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
		DECLARE @evalFormId INT

		INSERT INTO dbo.EvaluationForm (Notes, JSONData, EmployeeId, ScheduleIntervieweId)
		VALUES (@notes, @jsonData, @employeeId, @scheduleIntervieweId)

		SET @evalFormId = SCOPE_IDENTITY();

		RETURN @evalFormId 
	END	 TRY
	BEGIN CATCH
		DECLARE @Number INT;
		DECLARE @Severity INT;
		DECLARE @State INT;
		DECLARE @Procedure VARCHAR(255);
		DECLARE @Line INT;
		DECLARE @Message VARCHAR(8000);

		SELECT @Number = ERROR_NUMBER(),
			   @Severity = ERROR_SEVERITY(),
			   @State = ERROR_STATE(),
			   @Procedure = ERROR_PROCEDURE(),
			   @Line = ERROR_LINE(),
			   @Message = ERROR_MESSAGE();

		exec dbo.InsertError @Number, @Severity, @State, @Procedure, @Line, @Message

		RETURN -1

	END CATCH
END;


GO
/****** Object:  StoredProcedure [dbo].[uspInsertOrUpdateCandidate]    Script Date: 8/23/2017 4:28:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspInsertOrUpdateCandidate]
	@Id INT,
	@C CandidateType READONLY
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
		DECLARE @CandidateId INT

		IF @Id IS NOT NULL
			BEGIN
				UPDATE c
				SET c.FirstName = isnull(vc.FirstName, c.FirstName),
					c.LastName = isnull(vc.LastName, c.LastName),
					c.Email = isnull(vc.Email, c.Email),
					c.CV = isnull(vc.CV, c.CV),
					c.[Address] = isnull(vc.[Address], c.[Address]),
					c.PhoneNumber = isnull(vc.PhoneNumber, c.PhoneNumber)
				FROM dbo.Candidate c
				INNER JOIN (select *, @Id AS Id FROM @C) vc
				ON vc.Id = c.Id

				SET @CandidateId = @Id
			END;
		ELSE
			BEGIN
				INSERT INTO dbo.Candidate 
				SELECT TOP 1 * FROM @C

				SET @CandidateId = SCOPE_IDENTITY();
			END;		

		RETURN @CandidateId 
	END	 TRY
	BEGIN CATCH
		DECLARE @Number INT;
		DECLARE @Severity INT;
		DECLARE @State INT;
		DECLARE @Procedure VARCHAR(255);
		DECLARE @Line INT;
		DECLARE @Message VARCHAR(8000);

		SELECT @Number = ERROR_NUMBER(),
			   @Severity = ERROR_SEVERITY(),
			   @State = ERROR_STATE(),
			   @Procedure = ERROR_PROCEDURE(),
			   @Line = ERROR_LINE(),
			   @Message = ERROR_MESSAGE();

		exec dbo.InsertError @Number, @Severity, @State, @Procedure, @Line, @Message

		RETURN -1

	END CATCH
END;

/*

@firstName VARCHAR(255),
@lastName VARCHAR(255),
@positionId INT,
@roleId INT,
@statusId INT,
@email VARCHAR(254),
@phone VARCHAR(20),
@address VARCHAR(255),
@cv VARCHAR(MAX),
@createdBy INT

*/
GO
/****** Object:  StoredProcedure [dbo].[uspInsertOrUpdateEmployee]    Script Date: 8/23/2017 4:28:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspInsertOrUpdateEmployee]
	@Id INT,
	@E EmployeeType READONLY
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
		DECLARE @EmployeeId INT

		IF @Id IS NOT NULL
			BEGIN
				UPDATE e
				SET e.FirstName = isnull(ve.FirstName, e.FirstName),
					e.LastName = isnull(ve.LastName, e.LastName),
					e.UserName = isnull(ve.UserName, e.UserName),
					e.RoleId = isnull(ve.RoleId, e.RoleId),
					e.PositionId = isnull(ve.PositionId, e.PositionId)
				FROM dbo.Employee e
				INNER JOIN (select *, @Id AS Id FROM @E) ve
				ON ve.Id = e.Id

				SET @EmployeeId = @Id
			END;
		ELSE
			BEGIN
				INSERT INTO dbo.Employee (FirstName, LastName, UserName, PasswordHash, CreatedBy, PositionId, RoleId)
				SELECT TOP 1 * FROM @E

				SET @EmployeeId = SCOPE_IDENTITY();
			END;		

		RETURN @EmployeeId 
	END	 TRY
	BEGIN CATCH
		DECLARE @Number INT;
		DECLARE @Severity INT;
		DECLARE @State INT;
		DECLARE @Procedure VARCHAR(255);
		DECLARE @Line INT;
		DECLARE @Message VARCHAR(8000);

		SELECT @Number = ERROR_NUMBER(),
			   @Severity = ERROR_SEVERITY(),
			   @State = ERROR_STATE(),
			   @Procedure = ERROR_PROCEDURE(),
			   @Line = ERROR_LINE(),
			   @Message = ERROR_MESSAGE();

		exec dbo.InsertError @Number, @Severity, @State, @Procedure, @Line, @Message

		RETURN -1

	END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[uspInsertPositionType]    Script Date: 8/23/2017 4:28:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspInsertPositionType]
	@position VARCHAR(255),
	@createdBy INT
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
		DECLARE @PositionTypeId INT

		INSERT INTO dbo.PositionTypes (Position, CreatedBy)
		VALUES (@position, @createdBy)

		SET @PositionTypeId = SCOPE_IDENTITY();

		RETURN @PositionTypeId 
	END	 TRY
	BEGIN CATCH
		DECLARE @Number INT;
		DECLARE @Severity INT;
		DECLARE @State INT;
		DECLARE @Procedure VARCHAR(255);
		DECLARE @Line INT;
		DECLARE @Message VARCHAR(8000);

		SELECT @Number = ERROR_NUMBER(),
			   @Severity = ERROR_SEVERITY(),
			   @State = ERROR_STATE(),
			   @Procedure = ERROR_PROCEDURE(),
			   @Line = ERROR_LINE(),
			   @Message = ERROR_MESSAGE();

		exec [dbo].[InsertError] @Number, @Severity, @State, @Procedure, @Line, @Message

		RETURN -1

	END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[uspInsertRoleType]    Script Date: 8/23/2017 4:28:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspInsertRoleType]
	@role VARCHAR(255),
	@createdBy INT
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
		DECLARE @RoleTypeId INT

		INSERT INTO dbo.RoleTypes([Role], CreatedBy)
		VALUES (@role, @createdBy)

		SET @RoleTypeId = SCOPE_IDENTITY();

		RETURN @RoleTypeId 
	END	 TRY
	BEGIN CATCH
		DECLARE @Number INT;
		DECLARE @Severity INT;
		DECLARE @State INT;
		DECLARE @Procedure VARCHAR(255);
		DECLARE @Line INT;
		DECLARE @Message VARCHAR(8000);

		SELECT @Number = ERROR_NUMBER(),
			   @Severity = ERROR_SEVERITY(),
			   @State = ERROR_STATE(),
			   @Procedure = ERROR_PROCEDURE(),
			   @Line = ERROR_LINE(),
			   @Message = ERROR_MESSAGE();

		exec [dbo].[InsertError] @Number, @Severity, @State, @Procedure, @Line, @Message

		RETURN -1

	END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[uspInsertScheduleInterview]    Script Date: 8/23/2017 4:28:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspInsertScheduleInterview]
	@meetingDate DATETIME,
	@candidateId INT,
	@hrId INT
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
		DECLARE @ScheduleInterviewId INT

		INSERT INTO dbo.ScheduleInterview (MeetingDate, CandidateId, HrId)
		VALUES (@meetingDate, @candidateId, @hrId)

		SET @ScheduleInterviewId = SCOPE_IDENTITY();

		RETURN @ScheduleInterviewId 
	END	 TRY
	BEGIN CATCH
		DECLARE @Number INT;
		DECLARE @Severity INT;
		DECLARE @State INT;
		DECLARE @Procedure VARCHAR(255);
		DECLARE @Line INT;
		DECLARE @Message VARCHAR(8000);

		SELECT @Number = ERROR_NUMBER(),
			   @Severity = ERROR_SEVERITY(),
			   @State = ERROR_STATE(),
			   @Procedure = ERROR_PROCEDURE(),
			   @Line = ERROR_LINE(),
			   @Message = ERROR_MESSAGE();

		exec [dbo].[InsertError] @Number, @Severity, @State, @Procedure, @Line, @Message

		RETURN -1

	END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[uspInsertScheduleInterviewer]    Script Date: 8/23/2017 4:28:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspInsertScheduleInterviewer]
	@scheduleInterviewId INT,
	@employeeId INT,
	@createdBy INT
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
		DECLARE @ScheduleInterviewerId INT

		INSERT INTO dbo.ScheduleInterviewer (ScheduleId, EmployeeId, CreatedBy)
		VALUES (@scheduleInterviewId, @employeeId, @createdBy)

		SET @ScheduleInterviewerId = SCOPE_IDENTITY();

		RETURN @ScheduleInterviewerId 
	END	 TRY
	BEGIN CATCH
		DECLARE @Number INT;
		DECLARE @Severity INT;
		DECLARE @State INT;
		DECLARE @Procedure VARCHAR(255);
		DECLARE @Line INT;
		DECLARE @Message VARCHAR(8000);

		SELECT @Number = ERROR_NUMBER(),
			   @Severity = ERROR_SEVERITY(),
			   @State = ERROR_STATE(),
			   @Procedure = ERROR_PROCEDURE(),
			   @Line = ERROR_LINE(),
			   @Message = ERROR_MESSAGE();

		exec [dbo].[InsertError] @Number, @Severity, @State, @Procedure, @Line, @Message

		RETURN -1

	END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[uspInsertScheduleTest]    Script Date: 8/23/2017 4:28:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspInsertScheduleTest]
	@meetingDate DATETIME,
	@hrId INT
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
		DECLARE @ScheduleTestId INT

		INSERT INTO dbo.ScheduleTest (MeetingDate, HrId)
		VALUES (@meetingDate, @hrId)

		SET @ScheduleTestId = SCOPE_IDENTITY();

		RETURN @ScheduleTestId 
	END	 TRY
	BEGIN CATCH
		DECLARE @Number INT;
		DECLARE @Severity INT;
		DECLARE @State INT;
		DECLARE @Procedure VARCHAR(255);
		DECLARE @Line INT;
		DECLARE @Message VARCHAR(8000);

		SELECT @Number = ERROR_NUMBER(),
			   @Severity = ERROR_SEVERITY(),
			   @State = ERROR_STATE(),
			   @Procedure = ERROR_PROCEDURE(),
			   @Line = ERROR_LINE(),
			   @Message = ERROR_MESSAGE();

		exec dbo.InsertError @Number, @Severity, @State, @Procedure, @Line, @Message

		RETURN -1

	END CATCH
END;
GO
/****** Object:  StoredProcedure [dbo].[uspInsertScheduleTester]    Script Date: 8/23/2017 4:28:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspInsertScheduleTester]
	@scheduleTestId INT,
	@employeeId INT,
	@createdBy INT
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
		DECLARE @ScheduleTesterId INT

		INSERT INTO dbo.ScheduleTester (ScheduleId, EmployeeId, CreatedBy)
		VALUES (@scheduleTestId, @employeeId, @createdBy)

		SET @ScheduleTesterId = SCOPE_IDENTITY();

		RETURN @ScheduleTesterId 
	END	 TRY
	BEGIN CATCH
		DECLARE @Number INT;
		DECLARE @Severity INT;
		DECLARE @State INT;
		DECLARE @Procedure VARCHAR(255);
		DECLARE @Line INT;
		DECLARE @Message VARCHAR(8000);

		SELECT @Number = ERROR_NUMBER(),
			   @Severity = ERROR_SEVERITY(),
			   @State = ERROR_STATE(),
			   @Procedure = ERROR_PROCEDURE(),
			   @Line = ERROR_LINE(),
			   @Message = ERROR_MESSAGE();

		exec dbo.InsertError @Number, @Severity, @State, @Procedure, @Line, @Message

		RETURN -1

	END CATCH
END;
GO
