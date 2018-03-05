USE [master]
GO
/****** Object:  Database [ESC2]    Script Date: 2/23/2018 6:51:24 PM ******/
CREATE DATABASE [ESC2]
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ESC2].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ESC2] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ESC2] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ESC2] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ESC2] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ESC2] SET ARITHABORT OFF 
GO
ALTER DATABASE [ESC2] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ESC2] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ESC2] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ESC2] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ESC2] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ESC2] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ESC2] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ESC2] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ESC2] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ESC2] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ESC2] SET ALLOW_SNAPSHOT_ISOLATION ON 
GO
ALTER DATABASE [ESC2] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ESC2] SET READ_COMMITTED_SNAPSHOT ON 
GO
ALTER DATABASE [ESC2] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ESC2] SET  MULTI_USER 
GO
ALTER DATABASE [ESC2] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ESC2] SET ENCRYPTION ON
GO
ALTER DATABASE [ESC2] SET QUERY_STORE = ON
GO
ALTER DATABASE [ESC2] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 100, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO)
GO
USE [ESC2]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_diagramobjects]    Script Date: 2/23/2018 6:51:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE FUNCTION [dbo].[fn_diagramobjects]() 
	RETURNS int
	WITH EXECUTE AS N'dbo'
	AS
	BEGIN
		declare @id_upgraddiagrams		int
		declare @id_sysdiagrams			int
		declare @id_helpdiagrams		int
		declare @id_helpdiagramdefinition	int
		declare @id_creatediagram	int
		declare @id_renamediagram	int
		declare @id_alterdiagram 	int 
		declare @id_dropdiagram		int
		declare @InstalledObjects	int

		select @InstalledObjects = 0

		select 	@id_upgraddiagrams = object_id(N'dbo.sp_upgraddiagrams'),
			@id_sysdiagrams = object_id(N'dbo.sysdiagrams'),
			@id_helpdiagrams = object_id(N'dbo.sp_helpdiagrams'),
			@id_helpdiagramdefinition = object_id(N'dbo.sp_helpdiagramdefinition'),
			@id_creatediagram = object_id(N'dbo.sp_creatediagram'),
			@id_renamediagram = object_id(N'dbo.sp_renamediagram'),
			@id_alterdiagram = object_id(N'dbo.sp_alterdiagram'), 
			@id_dropdiagram = object_id(N'dbo.sp_dropdiagram')

		if @id_upgraddiagrams is not null
			select @InstalledObjects = @InstalledObjects + 1
		if @id_sysdiagrams is not null
			select @InstalledObjects = @InstalledObjects + 2
		if @id_helpdiagrams is not null
			select @InstalledObjects = @InstalledObjects + 4
		if @id_helpdiagramdefinition is not null
			select @InstalledObjects = @InstalledObjects + 8
		if @id_creatediagram is not null
			select @InstalledObjects = @InstalledObjects + 16
		if @id_renamediagram is not null
			select @InstalledObjects = @InstalledObjects + 32
		if @id_alterdiagram  is not null
			select @InstalledObjects = @InstalledObjects + 64
		if @id_dropdiagram is not null
			select @InstalledObjects = @InstalledObjects + 128
		
		return @InstalledObjects 
	END
	
GO
/****** Object:  Table [dbo].[Center]    Script Date: 2/23/2018 6:51:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Center](
	[CenterID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[County] [nvarchar](50) NOT NULL,
	[Region] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Center] PRIMARY KEY CLUSTERED 
(
	[CenterID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[ECSUser]    Script Date: 2/23/2018 6:51:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ECSUser](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[Email] [varchar](150) NOT NULL,
	[FirstName] [varchar](50) NULL,
	[LastName] [varchar](50) NULL,
	[AccessLevel] [int] NOT NULL,
	[PasswordHash] [varchar](128) NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[Education]    Script Date: 2/23/2018 6:51:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Education](
	[EducationID] [int] IDENTITY(1,1) NOT NULL,
	[DegreeAbrv] [nvarchar](50) NULL,
	[DegreeLevel] [nvarchar](50) NULL,
	[DegreeType] [nvarchar](50) NULL,
	[DegreeDetail] [nvarchar](50) NULL,
 CONSTRAINT [PK_Education] PRIMARY KEY CLUSTERED 
(
	[EducationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[StaffEducation]    Script Date: 2/23/2018 6:51:29 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StaffEducation](
	[StaffMemberID] [int] NOT NULL,
	[EducationID] [int] NOT NULL,
 CONSTRAINT [PK_StaffEducation] PRIMARY KEY CLUSTERED 
(
	[StaffMemberID] ASC,
	[EducationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[StaffMember]    Script Date: 2/23/2018 6:51:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StaffMember](
	[StaffMemberID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
	[Email] [nvarchar](50) NULL,
	[DateOfHire] [date] NULL,
	[Position] [nvarchar](50) NULL,
	[CenterID] [int] NULL,
	[DirectorCredentials] [bit] NULL,
	[DCExpiration] [date] NULL,
	[CDAInProgress] [bit] NULL,
	[CDAType] [nvarchar](50) NULL,
	[CDAExpiration] [date] NULL,
	[CDARenewalProcess] [nvarchar](50) NULL,
	[Comments] [nvarchar](150) NULL,
	[Goal] [bit] NULL,
	[MidYear] [bit] NULL,
	[EndYear] [bit] NULL,
	[GoalMet] [bit] NULL,
	[TAndAApp] [bit] NULL,
	[AppApp] [bit] NULL,
	[ClassCompleted] [bit] NULL,
	[ClassPaid] [bit] NULL,
	[RequiredHours] [int] NULL,
	[HoursEarned] [int] NULL,
	[Notes] [nvarchar](200) NULL,
	[TermDate] [date] NULL,
	[IsInactive] [bit] NULL,
 CONSTRAINT [PK__StaffMem__2C1EBDA1C3E4047E] PRIMARY KEY CLUSTERED 
(
	[StaffMemberID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
/****** Object:  Table [dbo].[sysdiagrams]    Script Date: 2/23/2018 6:51:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sysdiagrams](
	[name] [sysname] NOT NULL,
	[principal_id] [int] NOT NULL,
	[diagram_id] [int] IDENTITY(1,1) NOT NULL,
	[version] [int] NULL,
	[definition] [varbinary](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[diagram_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
)

GO
SET IDENTITY_INSERT [dbo].[Center] ON 

INSERT [dbo].[Center] ([CenterID], [Name], [County], [Region]) VALUES (2, N'Orange Park', N'Clay', N'1A')
INSERT [dbo].[Center] ([CenterID], [Name], [County], [Region]) VALUES (3, N'CALLAHAN HS/EHS
', N'Nassau', N'1A')
INSERT [dbo].[Center] ([CenterID], [Name], [County], [Region]) VALUES (8, N'Jacksonville', N'Duval', N'1A')
INSERT [dbo].[Center] ([CenterID], [Name], [County], [Region]) VALUES (9, N'Middleburg', N'Clay', N'1A')
INSERT [dbo].[Center] ([CenterID], [Name], [County], [Region]) VALUES (10, N'FERNANDINA HS', N'Nassau', N'1A')
INSERT [dbo].[Center] ([CenterID], [Name], [County], [Region]) VALUES (11, N'CALLAHAN HS/EHS', N'Nassau', N'1A')
INSERT [dbo].[Center] ([CenterID], [Name], [County], [Region]) VALUES (13, N'Baker Complex', N'Baker', N'1A')
INSERT [dbo].[Center] ([CenterID], [Name], [County], [Region]) VALUES (14, N'O2B Kids College 7', N'Clay', N'1A')
SET IDENTITY_INSERT [dbo].[Center] OFF
SET IDENTITY_INSERT [dbo].[ECSUser] ON 

INSERT [dbo].[ECSUser] ([UserID], [Email], [FirstName], [LastName], [AccessLevel], [PasswordHash]) VALUES (3, N'myemail@test.org', N'test', N'user', 4, N'$2b$10$Zfw3j7ANamysNClXDaplzOD/jZapHBN3vYtPKESlcac7y4Qq8cYP.')
INSERT [dbo].[ECSUser] ([UserID], [Email], [FirstName], [LastName], [AccessLevel], [PasswordHash]) VALUES (5, N'ckgiveout@gmail.com', N'Chris', N'c', 1, N'$2b$10$6BbuqTsUgMSbvFRhL7vlLuQxu110qAk0C4R7G3.l.Q0c8tQOjJHjK')
INSERT [dbo].[ECSUser] ([UserID], [Email], [FirstName], [LastName], [AccessLevel], [PasswordHash]) VALUES (7, N'ckchessmaster@gmail.com', N'Christopher', N'Kingdon', 4, N'$2b$10$DT8Qz.ZwDHnvrxFHa7h0.us566jzPj4Nnf4FfSpvwzLHCqqQsmA4G')
SET IDENTITY_INSERT [dbo].[ECSUser] OFF
SET IDENTITY_INSERT [dbo].[Education] ON 

INSERT [dbo].[Education] ([EducationID], [DegreeAbrv], [DegreeLevel], [DegreeType], [DegreeDetail]) VALUES (1, N'AA', N'Associates', N'Education', N'Early Childhood')
INSERT [dbo].[Education] ([EducationID], [DegreeAbrv], [DegreeLevel], [DegreeType], [DegreeDetail]) VALUES (5, N'BFA', N'Bachelors', N'Finacial', NULL)
INSERT [dbo].[Education] ([EducationID], [DegreeAbrv], [DegreeLevel], [DegreeType], [DegreeDetail]) VALUES (21, N'AA', N'Associates', N'Computer', N'Networking')
INSERT [dbo].[Education] ([EducationID], [DegreeAbrv], [DegreeLevel], [DegreeType], [DegreeDetail]) VALUES (25, N'BS', N'Bachelors', N'Education', N'Early Childhood')
INSERT [dbo].[Education] ([EducationID], [DegreeAbrv], [DegreeLevel], [DegreeType], [DegreeDetail]) VALUES (30, N'BS', N'Bachelors', N'History', N'History')
INSERT [dbo].[Education] ([EducationID], [DegreeAbrv], [DegreeLevel], [DegreeType], [DegreeDetail]) VALUES (31, N'BS', N'Bachelors', N'History', N'')
INSERT [dbo].[Education] ([EducationID], [DegreeAbrv], [DegreeLevel], [DegreeType], [DegreeDetail]) VALUES (32, N'BS', N'Bachelors', N'History', N'Americana')
INSERT [dbo].[Education] ([EducationID], [DegreeAbrv], [DegreeLevel], [DegreeType], [DegreeDetail]) VALUES (44, N'MS', N'Masters', N'Education', N'Early Childhood')
INSERT [dbo].[Education] ([EducationID], [DegreeAbrv], [DegreeLevel], [DegreeType], [DegreeDetail]) VALUES (47, N'AA', N'Associates', N'Gen Studies', NULL)
INSERT [dbo].[Education] ([EducationID], [DegreeAbrv], [DegreeLevel], [DegreeType], [DegreeDetail]) VALUES (48, N'BA', N'Bachelors', N'Psychology', N'Child Psychology')
INSERT [dbo].[Education] ([EducationID], [DegreeAbrv], [DegreeLevel], [DegreeType], [DegreeDetail]) VALUES (59, N'AA', N'Associates', N'Gen Studies', N'Computer Science')
INSERT [dbo].[Education] ([EducationID], [DegreeAbrv], [DegreeLevel], [DegreeType], [DegreeDetail]) VALUES (60, N'MDS', N'Masters', N'Mathmatics', N'Americana')
INSERT [dbo].[Education] ([EducationID], [DegreeAbrv], [DegreeLevel], [DegreeType], [DegreeDetail]) VALUES (64, N'BA', N'Bachelors', N'Education', N'Americana')
INSERT [dbo].[Education] ([EducationID], [DegreeAbrv], [DegreeLevel], [DegreeType], [DegreeDetail]) VALUES (65, N'BA', N'Bachelors', N'Education', N'Early Childhood')
INSERT [dbo].[Education] ([EducationID], [DegreeAbrv], [DegreeLevel], [DegreeType], [DegreeDetail]) VALUES (66, NULL, NULL, NULL, NULL)
INSERT [dbo].[Education] ([EducationID], [DegreeAbrv], [DegreeLevel], [DegreeType], [DegreeDetail]) VALUES (67, NULL, NULL, NULL, NULL)
INSERT [dbo].[Education] ([EducationID], [DegreeAbrv], [DegreeLevel], [DegreeType], [DegreeDetail]) VALUES (68, N'BA', N'Bachelors', N'History', N'Americana')
INSERT [dbo].[Education] ([EducationID], [DegreeAbrv], [DegreeLevel], [DegreeType], [DegreeDetail]) VALUES (69, N'BS', N'Bachelors', N'Computer', N'Computer Science')
INSERT [dbo].[Education] ([EducationID], [DegreeAbrv], [DegreeLevel], [DegreeType], [DegreeDetail]) VALUES (70, N'AA', N'Associates', N'Gen Studies', N'Child Psychology')
SET IDENTITY_INSERT [dbo].[Education] OFF
INSERT [dbo].[StaffEducation] ([StaffMemberID], [EducationID]) VALUES (1, 44)
INSERT [dbo].[StaffEducation] ([StaffMemberID], [EducationID]) VALUES (1, 47)
INSERT [dbo].[StaffEducation] ([StaffMemberID], [EducationID]) VALUES (2, 30)
INSERT [dbo].[StaffEducation] ([StaffMemberID], [EducationID]) VALUES (4, 31)
INSERT [dbo].[StaffEducation] ([StaffMemberID], [EducationID]) VALUES (5, 32)
INSERT [dbo].[StaffEducation] ([StaffMemberID], [EducationID]) VALUES (5, 70)
INSERT [dbo].[StaffEducation] ([StaffMemberID], [EducationID]) VALUES (12, 1)
INSERT [dbo].[StaffEducation] ([StaffMemberID], [EducationID]) VALUES (12, 5)
INSERT [dbo].[StaffEducation] ([StaffMemberID], [EducationID]) VALUES (12, 59)
INSERT [dbo].[StaffEducation] ([StaffMemberID], [EducationID]) VALUES (20, 1)
INSERT [dbo].[StaffEducation] ([StaffMemberID], [EducationID]) VALUES (20, 5)
INSERT [dbo].[StaffEducation] ([StaffMemberID], [EducationID]) VALUES (20, 64)
INSERT [dbo].[StaffEducation] ([StaffMemberID], [EducationID]) VALUES (21, 1)
INSERT [dbo].[StaffEducation] ([StaffMemberID], [EducationID]) VALUES (23, 1)
INSERT [dbo].[StaffEducation] ([StaffMemberID], [EducationID]) VALUES (24, 1)
INSERT [dbo].[StaffEducation] ([StaffMemberID], [EducationID]) VALUES (24, 66)
INSERT [dbo].[StaffEducation] ([StaffMemberID], [EducationID]) VALUES (25, 21)
INSERT [dbo].[StaffEducation] ([StaffMemberID], [EducationID]) VALUES (27, 25)
INSERT [dbo].[StaffEducation] ([StaffMemberID], [EducationID]) VALUES (30, 21)
INSERT [dbo].[StaffEducation] ([StaffMemberID], [EducationID]) VALUES (30, 69)
INSERT [dbo].[StaffEducation] ([StaffMemberID], [EducationID]) VALUES (45, 48)
INSERT [dbo].[StaffEducation] ([StaffMemberID], [EducationID]) VALUES (45, 60)
INSERT [dbo].[StaffEducation] ([StaffMemberID], [EducationID]) VALUES (46, 60)
INSERT [dbo].[StaffEducation] ([StaffMemberID], [EducationID]) VALUES (48, 65)
INSERT [dbo].[StaffEducation] ([StaffMemberID], [EducationID]) VALUES (54, 21)
SET IDENTITY_INSERT [dbo].[StaffMember] ON 

INSERT [dbo].[StaffMember] ([StaffMemberID], [FirstName], [LastName], [Email], [DateOfHire], [Position], [CenterID], [DirectorCredentials], [DCExpiration], [CDAInProgress], [CDAType], [CDAExpiration], [CDARenewalProcess], [Comments], [Goal], [MidYear], [EndYear], [GoalMet], [TAndAApp], [AppApp], [ClassCompleted], [ClassPaid], [RequiredHours], [HoursEarned], [Notes], [TermDate], [IsInactive]) VALUES (1, N'Fancy', N'Davolio', N'NancyDavolio@ec4kids.org', CAST(N'2018-01-13' AS Date), N'Lead Teacher', 9, 0, CAST(N'2018-01-16' AS Date), 0, N'CDA typey', CAST(N'2022-01-13' AS Date), N'CDA Renewa', N'Commentsy', 1, 1, 1, 1, 1, 1, 1, 0, 40, 40, N'So many nosdsdsds', CAST(N'2018-01-19' AS Date), 0)
INSERT [dbo].[StaffMember] ([StaffMemberID], [FirstName], [LastName], [Email], [DateOfHire], [Position], [CenterID], [DirectorCredentials], [DCExpiration], [CDAInProgress], [CDAType], [CDAExpiration], [CDARenewalProcess], [Comments], [Goal], [MidYear], [EndYear], [GoalMet], [TAndAApp], [AppApp], [ClassCompleted], [ClassPaid], [RequiredHours], [HoursEarned], [Notes], [TermDate], [IsInactive]) VALUES (2, N'Andrews', N'Fuller', N'AndrewFuller@ecs4kids.org', CAST(N'1992-08-14' AS Date), N'Lead Teacher', 9, 0, CAST(N'2018-01-16' AS Date), 1, N'National CDA Infant Toddler', CAST(N'2018-02-28' AS Date), NULL, NULL, 1, 1, 1, 0, 1, 1, 1, 1, 40, 0, NULL, CAST(N'2018-01-19' AS Date), 0)
INSERT [dbo].[StaffMember] ([StaffMemberID], [FirstName], [LastName], [Email], [DateOfHire], [Position], [CenterID], [DirectorCredentials], [DCExpiration], [CDAInProgress], [CDAType], [CDAExpiration], [CDARenewalProcess], [Comments], [Goal], [MidYear], [EndYear], [GoalMet], [TAndAApp], [AppApp], [ClassCompleted], [ClassPaid], [RequiredHours], [HoursEarned], [Notes], [TermDate], [IsInactive]) VALUES (3, N'Janet', N'Leverling', N'JanetLeverling@ecs4kids.org', CAST(N'1992-04-01' AS Date), N'Lead Teacher', 11, 0, CAST(N'2018-01-16' AS Date), 1, N'National CDA Infant Toddler', CAST(N'2017-11-01' AS Date), NULL, NULL, 1, 1, 1, 0, 1, 1, 1, 0, 40, 0, NULL, CAST(N'2018-01-19' AS Date), 0)
INSERT [dbo].[StaffMember] ([StaffMemberID], [FirstName], [LastName], [Email], [DateOfHire], [Position], [CenterID], [DirectorCredentials], [DCExpiration], [CDAInProgress], [CDAType], [CDAExpiration], [CDARenewalProcess], [Comments], [Goal], [MidYear], [EndYear], [GoalMet], [TAndAApp], [AppApp], [ClassCompleted], [ClassPaid], [RequiredHours], [HoursEarned], [Notes], [TermDate], [IsInactive]) VALUES (4, N'Margaret', N'Peacock', N'MargaretPeacock@ecs4kids.org', CAST(N'1993-05-03' AS Date), N'Lead Teacher', 2, 0, CAST(N'2018-01-16' AS Date), 1, N'National CDA Infant Toddler/Pre-K', CAST(N'2018-01-04' AS Date), NULL, NULL, 1, 1, 1, 0, 1, 1, 1, 0, 40, 0, NULL, CAST(N'2018-01-19' AS Date), 0)
INSERT [dbo].[StaffMember] ([StaffMemberID], [FirstName], [LastName], [Email], [DateOfHire], [Position], [CenterID], [DirectorCredentials], [DCExpiration], [CDAInProgress], [CDAType], [CDAExpiration], [CDARenewalProcess], [Comments], [Goal], [MidYear], [EndYear], [GoalMet], [TAndAApp], [AppApp], [ClassCompleted], [ClassPaid], [RequiredHours], [HoursEarned], [Notes], [TermDate], [IsInactive]) VALUES (5, N'Steven', N'Buchanan', N'StevenBuchanan@ecs4kids.org', CAST(N'1993-10-17' AS Date), N'Lead Teacher', 9, 0, CAST(N'2018-01-16' AS Date), 0, N'National CDA Infant Toddler', CAST(N'2018-01-31' AS Date), NULL, NULL, 1, 1, 1, 0, 1, 1, 1, 1, 11, 2, NULL, CAST(N'2018-01-26' AS Date), 0)
INSERT [dbo].[StaffMember] ([StaffMemberID], [FirstName], [LastName], [Email], [DateOfHire], [Position], [CenterID], [DirectorCredentials], [DCExpiration], [CDAInProgress], [CDAType], [CDAExpiration], [CDARenewalProcess], [Comments], [Goal], [MidYear], [EndYear], [GoalMet], [TAndAApp], [AppApp], [ClassCompleted], [ClassPaid], [RequiredHours], [HoursEarned], [Notes], [TermDate], [IsInactive]) VALUES (6, N'Michael', N'Suyama', N'MichaelSuyama@ecs4kids.org', CAST(N'1993-10-17' AS Date), N'Lead Teacher', 2, 0, CAST(N'2018-01-16' AS Date), 0, NULL, NULL, NULL, NULL, 1, 1, 1, 0, 1, 1, 1, 1, 10, 0, NULL, CAST(N'2018-01-19' AS Date), 1)
INSERT [dbo].[StaffMember] ([StaffMemberID], [FirstName], [LastName], [Email], [DateOfHire], [Position], [CenterID], [DirectorCredentials], [DCExpiration], [CDAInProgress], [CDAType], [CDAExpiration], [CDARenewalProcess], [Comments], [Goal], [MidYear], [EndYear], [GoalMet], [TAndAApp], [AppApp], [ClassCompleted], [ClassPaid], [RequiredHours], [HoursEarned], [Notes], [TermDate], [IsInactive]) VALUES (9, N'Anne', N'Dodsworth', N'AnneDodsworth@ecs4kids.org', CAST(N'1994-11-15' AS Date), N'Lead Teacher', 8, 1, CAST(N'2018-01-16' AS Date), 0, NULL, CAST(N'2018-01-31' AS Date), NULL, NULL, 1, 1, 1, 0, 1, 1, 1, 0, 0, 0, NULL, CAST(N'2018-01-19' AS Date), 0)
INSERT [dbo].[StaffMember] ([StaffMemberID], [FirstName], [LastName], [Email], [DateOfHire], [Position], [CenterID], [DirectorCredentials], [DCExpiration], [CDAInProgress], [CDAType], [CDAExpiration], [CDARenewalProcess], [Comments], [Goal], [MidYear], [EndYear], [GoalMet], [TAndAApp], [AppApp], [ClassCompleted], [ClassPaid], [RequiredHours], [HoursEarned], [Notes], [TermDate], [IsInactive]) VALUES (12, N'George', N'Washington', N'GeorgeWashington@ecs4kids.org', CAST(N'1992-04-01' AS Date), N'Lead Teacher', 2, NULL, CAST(N'2018-01-16' AS Date), NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, 1, 1, 1, NULL, NULL, NULL, NULL, CAST(N'2018-01-19' AS Date), NULL)
INSERT [dbo].[StaffMember] ([StaffMemberID], [FirstName], [LastName], [Email], [DateOfHire], [Position], [CenterID], [DirectorCredentials], [DCExpiration], [CDAInProgress], [CDAType], [CDAExpiration], [CDARenewalProcess], [Comments], [Goal], [MidYear], [EndYear], [GoalMet], [TAndAApp], [AppApp], [ClassCompleted], [ClassPaid], [RequiredHours], [HoursEarned], [Notes], [TermDate], [IsInactive]) VALUES (13, N'Sam ', N'Houston', N'SamHouston@ecs4kids.org', CAST(N'1993-05-03' AS Date), N'Lead Teacher', 2, 0, CAST(N'2018-01-16' AS Date), 0, NULL, CAST(N'2018-01-31' AS Date), NULL, NULL, 1, 1, 1, 0, 1, 1, 1, 0, 0, 0, NULL, CAST(N'2018-01-19' AS Date), 0)
INSERT [dbo].[StaffMember] ([StaffMemberID], [FirstName], [LastName], [Email], [DateOfHire], [Position], [CenterID], [DirectorCredentials], [DCExpiration], [CDAInProgress], [CDAType], [CDAExpiration], [CDARenewalProcess], [Comments], [Goal], [MidYear], [EndYear], [GoalMet], [TAndAApp], [AppApp], [ClassCompleted], [ClassPaid], [RequiredHours], [HoursEarned], [Notes], [TermDate], [IsInactive]) VALUES (14, N'Bob', N'Johnson', N'BobJohnson@ecs4kids.org', CAST(N'1993-10-17' AS Date), N'Lead Teacher', 2, 0, CAST(N'2018-01-16' AS Date), 0, NULL, CAST(N'2018-01-31' AS Date), NULL, NULL, 1, 1, 1, 0, 1, 1, 1, 0, 0, 0, NULL, CAST(N'2018-01-19' AS Date), 0)
INSERT [dbo].[StaffMember] ([StaffMemberID], [FirstName], [LastName], [Email], [DateOfHire], [Position], [CenterID], [DirectorCredentials], [DCExpiration], [CDAInProgress], [CDAType], [CDAExpiration], [CDARenewalProcess], [Comments], [Goal], [MidYear], [EndYear], [GoalMet], [TAndAApp], [AppApp], [ClassCompleted], [ClassPaid], [RequiredHours], [HoursEarned], [Notes], [TermDate], [IsInactive]) VALUES (15, N'Alice', N'Wonderland', N'AliceWonderland@ecs4kids.org', CAST(N'1993-10-17' AS Date), N'Lead Teacher', 2, NULL, CAST(N'2018-01-16' AS Date), NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, 1, 1, 1, NULL, NULL, NULL, NULL, CAST(N'2018-01-19' AS Date), NULL)
INSERT [dbo].[StaffMember] ([StaffMemberID], [FirstName], [LastName], [Email], [DateOfHire], [Position], [CenterID], [DirectorCredentials], [DCExpiration], [CDAInProgress], [CDAType], [CDAExpiration], [CDARenewalProcess], [Comments], [Goal], [MidYear], [EndYear], [GoalMet], [TAndAApp], [AppApp], [ClassCompleted], [ClassPaid], [RequiredHours], [HoursEarned], [Notes], [TermDate], [IsInactive]) VALUES (16, N'Poor', N'Johnson', N'PoorJohnson@ecs4kids.org', CAST(N'1994-01-02' AS Date), N'Lead Teacher', 2, NULL, CAST(N'2018-01-16' AS Date), NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, 1, 1, 1, NULL, NULL, NULL, NULL, CAST(N'2018-01-19' AS Date), NULL)
INSERT [dbo].[StaffMember] ([StaffMemberID], [FirstName], [LastName], [Email], [DateOfHire], [Position], [CenterID], [DirectorCredentials], [DCExpiration], [CDAInProgress], [CDAType], [CDAExpiration], [CDARenewalProcess], [Comments], [Goal], [MidYear], [EndYear], [GoalMet], [TAndAApp], [AppApp], [ClassCompleted], [ClassPaid], [RequiredHours], [HoursEarned], [Notes], [TermDate], [IsInactive]) VALUES (18, N'Tom', N'Thumb', N'TomThumb@ecs4kids.org', CAST(N'1994-11-15' AS Date), N'Lead Teacher', 2, NULL, CAST(N'2018-01-16' AS Date), NULL, NULL, NULL, NULL, NULL, 1, 1, 1, NULL, 1, 1, 1, NULL, NULL, NULL, NULL, CAST(N'2018-01-19' AS Date), NULL)
INSERT [dbo].[StaffMember] ([StaffMemberID], [FirstName], [LastName], [Email], [DateOfHire], [Position], [CenterID], [DirectorCredentials], [DCExpiration], [CDAInProgress], [CDAType], [CDAExpiration], [CDARenewalProcess], [Comments], [Goal], [MidYear], [EndYear], [GoalMet], [TAndAApp], [AppApp], [ClassCompleted], [ClassPaid], [RequiredHours], [HoursEarned], [Notes], [TermDate], [IsInactive]) VALUES (20, N'abraham', N'Monagan', N'j@ecs4kids.org', CAST(N'2017-01-19' AS Date), N'Lead Teacher', 2, 1, CAST(N'2018-01-16' AS Date), 1, N'1', NULL, NULL, N'1', 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, N'1         ', CAST(N'2018-01-19' AS Date), 0)
INSERT [dbo].[StaffMember] ([StaffMemberID], [FirstName], [LastName], [Email], [DateOfHire], [Position], [CenterID], [DirectorCredentials], [DCExpiration], [CDAInProgress], [CDAType], [CDAExpiration], [CDARenewalProcess], [Comments], [Goal], [MidYear], [EndYear], [GoalMet], [TAndAApp], [AppApp], [ClassCompleted], [ClassPaid], [RequiredHours], [HoursEarned], [Notes], [TermDate], [IsInactive]) VALUES (21, N'Bruce', N'Wayne', N'bwayne@ecs4kids.org', CAST(N'2017-11-15' AS Date), N'Lead Teacher', 2, 1, CAST(N'2018-01-16' AS Date), 1, N'1', CAST(N'2018-03-15' AS Date), N'1         ', N'1', 1, 1, 1, 1, 1, 1, 1, 1, 40, 40, N'1         ', CAST(N'2018-01-19' AS Date), NULL)
INSERT [dbo].[StaffMember] ([StaffMemberID], [FirstName], [LastName], [Email], [DateOfHire], [Position], [CenterID], [DirectorCredentials], [DCExpiration], [CDAInProgress], [CDAType], [CDAExpiration], [CDARenewalProcess], [Comments], [Goal], [MidYear], [EndYear], [GoalMet], [TAndAApp], [AppApp], [ClassCompleted], [ClassPaid], [RequiredHours], [HoursEarned], [Notes], [TermDate], [IsInactive]) VALUES (23, N'Cowboy', N'Jefferson', N'a@.com', CAST(N'2017-11-15' AS Date), N'Lead Teacher', 2, 1, CAST(N'2018-01-16' AS Date), 1, N'1', CAST(N'2017-11-15' AS Date), N'1         ', N'1', 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, N'1         ', CAST(N'2018-01-19' AS Date), NULL)
INSERT [dbo].[StaffMember] ([StaffMemberID], [FirstName], [LastName], [Email], [DateOfHire], [Position], [CenterID], [DirectorCredentials], [DCExpiration], [CDAInProgress], [CDAType], [CDAExpiration], [CDARenewalProcess], [Comments], [Goal], [MidYear], [EndYear], [GoalMet], [TAndAApp], [AppApp], [ClassCompleted], [ClassPaid], [RequiredHours], [HoursEarned], [Notes], [TermDate], [IsInactive]) VALUES (24, N'Brian', N'Houston', N'bhouston@ecs4kids.org', CAST(N'2017-01-19' AS Date), N'Lead Teacher', 2, 0, CAST(N'2018-01-16' AS Date), 0, NULL, CAST(N'2018-03-15' AS Date), NULL, N'Hello', 1, 1, 1, 0, 1, 1, 1, 1, 40, 8, N'notes here', CAST(N'2018-01-19' AS Date), 0)
INSERT [dbo].[StaffMember] ([StaffMemberID], [FirstName], [LastName], [Email], [DateOfHire], [Position], [CenterID], [DirectorCredentials], [DCExpiration], [CDAInProgress], [CDAType], [CDAExpiration], [CDARenewalProcess], [Comments], [Goal], [MidYear], [EndYear], [GoalMet], [TAndAApp], [AppApp], [ClassCompleted], [ClassPaid], [RequiredHours], [HoursEarned], [Notes], [TermDate], [IsInactive]) VALUES (25, N'Alex', N'Houston', N'bhouston@ecs4kids.org', CAST(N'2017-01-19' AS Date), N'Lead Teacher', 2, 0, CAST(N'2018-01-16' AS Date), 0, NULL, CAST(N'2018-05-21' AS Date), NULL, NULL, 1, 1, 1, 0, 1, 1, 1, 1, 40, 8, N'notes here', CAST(N'2018-01-19' AS Date), 0)
INSERT [dbo].[StaffMember] ([StaffMemberID], [FirstName], [LastName], [Email], [DateOfHire], [Position], [CenterID], [DirectorCredentials], [DCExpiration], [CDAInProgress], [CDAType], [CDAExpiration], [CDARenewalProcess], [Comments], [Goal], [MidYear], [EndYear], [GoalMet], [TAndAApp], [AppApp], [ClassCompleted], [ClassPaid], [RequiredHours], [HoursEarned], [Notes], [TermDate], [IsInactive]) VALUES (27, N'Froto', N'Baggins', N'fbaggins@ecs4kids.org', CAST(N'2018-01-19' AS Date), N'Lead Teacher', 2, 1, CAST(N'2018-01-16' AS Date), 1, N'DA', CAST(N'2022-01-19' AS Date), N'yes please', N'none', 1, 1, 1, 1, 1, 1, 1, 1, 5, 40, N'notes here', CAST(N'2018-01-19' AS Date), 1)
INSERT [dbo].[StaffMember] ([StaffMemberID], [FirstName], [LastName], [Email], [DateOfHire], [Position], [CenterID], [DirectorCredentials], [DCExpiration], [CDAInProgress], [CDAType], [CDAExpiration], [CDARenewalProcess], [Comments], [Goal], [MidYear], [EndYear], [GoalMet], [TAndAApp], [AppApp], [ClassCompleted], [ClassPaid], [RequiredHours], [HoursEarned], [Notes], [TermDate], [IsInactive]) VALUES (28, N'Sam', N'Baggins', N'sbaggins@ecs4kids.org', CAST(N'2018-01-19' AS Date), N'Substitute', 9, 1, CAST(N'2018-01-20' AS Date), 1, N'DA', CAST(N'2018-06-12' AS Date), N'yes please', N'none', 1, 1, 1, 1, 1, 1, 1, 1, 5, 40, N'notes here', CAST(N'2018-01-19' AS Date), 0)
INSERT [dbo].[StaffMember] ([StaffMemberID], [FirstName], [LastName], [Email], [DateOfHire], [Position], [CenterID], [DirectorCredentials], [DCExpiration], [CDAInProgress], [CDAType], [CDAExpiration], [CDARenewalProcess], [Comments], [Goal], [MidYear], [EndYear], [GoalMet], [TAndAApp], [AppApp], [ClassCompleted], [ClassPaid], [RequiredHours], [HoursEarned], [Notes], [TermDate], [IsInactive]) VALUES (30, N'Alex', N'Baggins', N'abaggins@ecs4kids.org', CAST(N'2018-01-19' AS Date), N'Lead Teacher', 2, 1, CAST(N'2018-01-16' AS Date), 1, N'CDA type', CAST(N'2022-01-19' AS Date), N'CDA Renewa', N'Comments', 1, 1, 1, 1, 1, 1, 1, 1, 5, 40, N'notes here', CAST(N'2018-01-19' AS Date), 0)
INSERT [dbo].[StaffMember] ([StaffMemberID], [FirstName], [LastName], [Email], [DateOfHire], [Position], [CenterID], [DirectorCredentials], [DCExpiration], [CDAInProgress], [CDAType], [CDAExpiration], [CDARenewalProcess], [Comments], [Goal], [MidYear], [EndYear], [GoalMet], [TAndAApp], [AppApp], [ClassCompleted], [ClassPaid], [RequiredHours], [HoursEarned], [Notes], [TermDate], [IsInactive]) VALUES (33, N'Chris', N'kingdon', N'ck@ec4kids.org', CAST(N'2018-01-19' AS Date), N'Lead Teacher', 9, 1, CAST(N'2018-01-16' AS Date), 1, N'CDA type', CAST(N'2018-01-19' AS Date), N'CDA Renewa', N'Comments', 1, 1, 1, 1, 1, 1, 1, 1, 5, 40, N'notes here', CAST(N'2018-01-19' AS Date), 0)
INSERT [dbo].[StaffMember] ([StaffMemberID], [FirstName], [LastName], [Email], [DateOfHire], [Position], [CenterID], [DirectorCredentials], [DCExpiration], [CDAInProgress], [CDAType], [CDAExpiration], [CDARenewalProcess], [Comments], [Goal], [MidYear], [EndYear], [GoalMet], [TAndAApp], [AppApp], [ClassCompleted], [ClassPaid], [RequiredHours], [HoursEarned], [Notes], [TermDate], [IsInactive]) VALUES (40, N'Bobby', N'Kingdon', N'asdfasdf', CAST(N'2018-01-20' AS Date), N'Lead Teacher', 9, 1, CAST(N'2018-01-16' AS Date), 1, N'asdf', CAST(N'2018-01-05' AS Date), N'asdf      ', N'asf', 1, 1, 1, 1, 1, 1, 1, 1, 123, 123, N'adsf      ', CAST(N'2018-01-19' AS Date), NULL)
INSERT [dbo].[StaffMember] ([StaffMemberID], [FirstName], [LastName], [Email], [DateOfHire], [Position], [CenterID], [DirectorCredentials], [DCExpiration], [CDAInProgress], [CDAType], [CDAExpiration], [CDARenewalProcess], [Comments], [Goal], [MidYear], [EndYear], [GoalMet], [TAndAApp], [AppApp], [ClassCompleted], [ClassPaid], [RequiredHours], [HoursEarned], [Notes], [TermDate], [IsInactive]) VALUES (43, N'Alexuss', N'Baggins', N'abaggins@ecs4kids.org', CAST(N'2018-01-19' AS Date), N'Lead Teacher', 2, 1, CAST(N'2018-01-16' AS Date), 1, N'CDA type', CAST(N'2022-01-19' AS Date), N'CDA Renewa', N'Comments', 1, 1, 1, 1, 1, 1, 1, 1, 5, 40, N'notes here', CAST(N'2018-01-19' AS Date), 0)
INSERT [dbo].[StaffMember] ([StaffMemberID], [FirstName], [LastName], [Email], [DateOfHire], [Position], [CenterID], [DirectorCredentials], [DCExpiration], [CDAInProgress], [CDAType], [CDAExpiration], [CDARenewalProcess], [Comments], [Goal], [MidYear], [EndYear], [GoalMet], [TAndAApp], [AppApp], [ClassCompleted], [ClassPaid], [RequiredHours], [HoursEarned], [Notes], [TermDate], [IsInactive]) VALUES (44, N'Johnsasas', N'Smithasa', N'jsmith@ecs4kids.org', CAST(N'2019-02-02' AS Date), N'Lead Teacher', 2, 1, CAST(N'2018-01-16' AS Date), 1, N'dsad', CAST(N'2018-01-31' AS Date), N'sda       ', N'sa', 1, 1, 1, 1, 1, 1, 1, 1, 3, 4, N'ds        ', CAST(N'2018-01-19' AS Date), 0)
INSERT [dbo].[StaffMember] ([StaffMemberID], [FirstName], [LastName], [Email], [DateOfHire], [Position], [CenterID], [DirectorCredentials], [DCExpiration], [CDAInProgress], [CDAType], [CDAExpiration], [CDARenewalProcess], [Comments], [Goal], [MidYear], [EndYear], [GoalMet], [TAndAApp], [AppApp], [ClassCompleted], [ClassPaid], [RequiredHours], [HoursEarned], [Notes], [TermDate], [IsInactive]) VALUES (45, N'Shelly', N'Hattersley', N'shattersley@ecs4kids.org', CAST(N'2012-05-01' AS Date), N'Lead Teacher', 13, 1, CAST(N'2018-01-16' AS Date), 0, NULL, CAST(N'2018-01-31' AS Date), NULL, NULL, 1, 1, 1, 0, 1, 1, 1, 1, 15, 15, NULL, CAST(N'2018-01-19' AS Date), 0)
INSERT [dbo].[StaffMember] ([StaffMemberID], [FirstName], [LastName], [Email], [DateOfHire], [Position], [CenterID], [DirectorCredentials], [DCExpiration], [CDAInProgress], [CDAType], [CDAExpiration], [CDARenewalProcess], [Comments], [Goal], [MidYear], [EndYear], [GoalMet], [TAndAApp], [AppApp], [ClassCompleted], [ClassPaid], [RequiredHours], [HoursEarned], [Notes], [TermDate], [IsInactive]) VALUES (46, N'Chloe', N'Kingdon', N'chloem@o2bkids.com', CAST(N'2014-09-05' AS Date), N'Lead Teacher', 14, 0, CAST(N'2018-01-16' AS Date), 0, N'FCCPC', CAST(N'2021-11-19' AS Date), NULL, NULL, 1, 1, 1, 0, 1, 1, 1, 0, 40, 52, NULL, CAST(N'2018-01-19' AS Date), 0)
INSERT [dbo].[StaffMember] ([StaffMemberID], [FirstName], [LastName], [Email], [DateOfHire], [Position], [CenterID], [DirectorCredentials], [DCExpiration], [CDAInProgress], [CDAType], [CDAExpiration], [CDARenewalProcess], [Comments], [Goal], [MidYear], [EndYear], [GoalMet], [TAndAApp], [AppApp], [ClassCompleted], [ClassPaid], [RequiredHours], [HoursEarned], [Notes], [TermDate], [IsInactive]) VALUES (48, N'paul', N'kisss', N'pk@ecs.org', CAST(N'2018-02-12' AS Date), N'Assistant Teacher', 2, 0, NULL, 0, N'NA', NULL, N'NA', NULL, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, NULL, NULL, 0)
INSERT [dbo].[StaffMember] ([StaffMemberID], [FirstName], [LastName], [Email], [DateOfHire], [Position], [CenterID], [DirectorCredentials], [DCExpiration], [CDAInProgress], [CDAType], [CDAExpiration], [CDARenewalProcess], [Comments], [Goal], [MidYear], [EndYear], [GoalMet], [TAndAApp], [AppApp], [ClassCompleted], [ClassPaid], [RequiredHours], [HoursEarned], [Notes], [TermDate], [IsInactive]) VALUES (54, N'A', N'kk', N'alex@c.om', CAST(N'2018-02-16' AS Date), N'Lead Teacher', 2, 1, CAST(N'2018-04-12' AS Date), 0, N'sa', CAST(N'2018-04-12' AS Date), N'sa', N'as', 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, N'as', CAST(N'2018-02-16' AS Date), 0)
SET IDENTITY_INSERT [dbo].[StaffMember] OFF
SET IDENTITY_INSERT [dbo].[sysdiagrams] ON 

INSERT [dbo].[sysdiagrams] ([name], [principal_id], [diagram_id], [version], [definition]) VALUES (N'Diagram_1', 1, 2, 1, 0xD0CF11E0A1B11AE1000000000000000000000000000000003E000300FEFF0900060000000000000000000000010000000100000000000000001000000200000002000000FEFFFFFF0000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFFFFFF0E0000000F0000000400000005000000060000000700000008000000090000000A0000000B0000000C0000000D00000010000000FEFFFFFFFEFFFFFF11000000120000001300000014000000150000001600000017000000FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF52006F006F007400200045006E00740072007900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000016000500FFFFFFFFFFFFFFFF0200000000000000000000000000000000000000000000000000000000000000C0FD517328A7D3010300000040250000000000006600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004000201FFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000000000000000000000000000000000000000000000000000000000005A040000000000006F000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000040002010100000004000000FFFFFFFF00000000000000000000000000000000000000000000000000000000000000000000000012000000550F000000000000010043006F006D0070004F0062006A0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000012000201FFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000000000000000000000000000000000000000000000000000500000005F000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A0000000B0000000C0000000D0000000E0000000F0000001000000011000000FEFFFFFF130000001400000015000000160000001700000018000000190000001A0000001B0000001C0000001D0000001E0000001F000000200000002100000022000000230000002400000025000000260000002700000028000000290000002A0000002B0000002C0000002D0000002E0000002F000000300000003100000032000000330000003400000035000000360000003700000038000000390000003A0000003B0000003C0000003D0000003E0000003F000000400000004100000042000000430000004400000045000000460000004700000048000000490000004A0000004B0000004C0000004D0000004E0000004F000000FEFFFFFF51000000FEFFFFFF530000005400000055000000560000005700000058000000590000005A0000005B0000005C0000005D0000005E0000005F000000600000006100000062000000630000006400000065000000660000006700000068000000690000006A0000006B0000006C0000006D0000006E0000006F000000700000007100000072000000730000007400000075000000760000007700000078000000790000007A0000007B0000007C0000007D0000007E0000007F00000080000000000430000A1E100C050000800B0000000F00FFFF0B000000007D00004CA300006E5D00007CB400008A970000000000000EEDFFFFDE805B10F195D011B0A000AA00BDCB5C0000080030000000000200000300000038002B00000009000000D9E6B0E91C81D011AD5100A0C90F5739F43B7F847F61C74385352986E1D552F8A0327DB2D86295428D98273C25A2DA2D00002C0043200000000000000000000053444DD2011FD1118E63006097D2DF4834C9D2777977D811907000065B840D9C00002C0043200000000000000000000051444DD2011FD1118E63006097D2DF4834C9D2777977D811907000065B840D9C0B00000064030000008B010000003400A509000007000080010000009E020000008000000C0000805363684772696400B61C00009600000043656E746572202864626F2900003800A50900000700008002000000A0020000008000000D0000805363684772696400960000009600000045435355736572202864626F2909000000003800A50900000700008003000000A4020000008000000F000080536368477269640058020000E02E0000456475636174696F6E202864626F290000003C00A50900000700008004000000AE0200000080000014000080536368477269640058020000201C00005374616666456475636174696F6E202864626F2900009000A50900000700008005000000520000000180000065000080436F6E74726F6C008B0900000223000052656C6174696F6E736869702027464B5F5374616666456475636174696F6E5F456475636174696F6E202864626F2927206265747765656E2027456475636174696F6E202864626F292720616E6420275374616666456475636174696F6E202864626F292700803F00002800B50100000700008006000000310000006900000002800000436F6E74726F6C00D10B00002629000000003C00A50900000700008007000000A802000000800000110000805363684772696400B61C0000AE15000053746166664D656D626572202864626F29626F2900008C00A50900000700008008000000520000000180000063000080436F6E74726F6C00B41700001F1B000052656C6174696F6E736869702027464B5F5374616666456475636174696F6E5F5374616666202864626F2927206265747765656E202753746166664D656D626572202864626F292720616E6420275374616666456475636174696F6E202864626F29272900002800B50100000700008009000000310000006100000002800000436F6E74726F6C0017140000651D000000008400A5090000070000800A000000520000000180000059000080436F6E74726F6C002F290000720C000052656C6174696F6E736869702027464B5F53746166664D656D6265725F43656E746572202864626F2927206265747765656E202743656E746572202864626F292720616E64202753746166664D656D626572202864626F292700000000002800B5010000070000800B000000310000005D00000002800000436F6E74726F6C00AF1C0000791200000000000000000000000000000000000000000000000000000000000000000000000000000000214334120800000088160000930E0000785634120700000014010000430065006E0074006500720020002800640062006F002900000000000C0000000200000003000000040000000C00000000000000000000000C0000000300000003000000040000000800000000000000000000000C0000000400000003000000040000000400000000000000000000000C00000000000000000000000100000004000000000000000C0000002D00000000000000000000000700000004000000000000000C0000003300000002000000030000000500000010000000000000000C000000360000000300000003000000050000000C000000000000000C0000003900000004000000030000000500000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C0100000609000062070000480300001A040000DF020000EC04000027060000B103000027060000CB07000055050000000000000100000088160000930E000000000000040000000400000002000000020000001C010000F50A00000000000001000000391300007A05000000000000010000000100000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000005600000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F00000007000000430065006E00740065007200000021433412080000008816000089130000785634120700000014010000450043005300550073006500720020002800640062006F002900000018A56400D0A46400B0B7640050B764003CB8640000B86400C4BC640084BC64004900000078296400882864000000000000000000000000000C0064001CC164004CBD64004900000080296400942864000000000000000000000000000C00640000000000000000004900000070296400A02864000000000000000000000000000800640064C2640024C7640049000000AC296400AC2864000000000000000000000000000800640018BB6400D0BA64004900000088296400B82864000000000000000000000000000800640040BE640090BF000000000000000000000100000005000000540000002C0000002C0000002C00000034000000000000000000000022290000AB170000000000002D010000080000000C000000070000001C0100000609000062070000480300001A040000DF020000EC04000027060000B103000027060000CB070000550500000000000001000000881600008913000000000000060000000600000002000000020000001C010000F50A00000000000001000000391300007A05000000000000010000000100000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000005800000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F00000008000000450043005300550073006500720000002143341208000000881600000E11000078563412070000001401000045006400750063006100740069006F006E0020002800640062006F00290000002000460069006C00650073002000280078003800360029002F004D006900630072006F0073006F00660074002000530051004C0020005300650072007600650072002F003100330030002F0054006F006F006C0073002F00420069006E006E002F004D0061006E006100670065006D0065006E007400530074007500640069006F002F004900440045002F0043006F006D006D006F006E0045007800740065006E00730069006F006E0073002F004D006900630072006F0073006F00660074002F0045006400690074006F007200000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C0100000609000062070000480300001A040000DF020000EC04000027060000B103000027060000CB070000550500000000000001000000881600000E11000000000000050000000500000002000000020000001C010000F50A00000000000001000000391300007A05000000000000010000000100000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000005C00000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F0000000A00000045006400750063006100740069006F006E0000002143341208000000881600009D0900007856341207000000140100005300740061006600660045006400750063006100740069006F006E0020002800640062006F002900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000065150000000000002D010000070000000C000000070000001C0100000609000062070000480300001A040000DF020000EC04000027060000B103000027060000CB070000550500000000000001000000881600009D09000000000000020000000200000002000000020000001C010000F50A0000000000000100000039130000C007000000000000020000000200000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000006600000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F0000000F0000005300740061006600660045006400750063006100740069006F006E00000002000B00220B0000E02E0000220B0000BD2500000000000002000000F0F0F00000000000000000000000000000000000010000000600000000000000D10B000026290000FF0F00005801000038000000010000020000FF0F000058010000020000000000050000800800008001000000150001000000900144420100065461686F6D611B0046004B005F005300740061006600660045006400750063006100740069006F006E005F0045006400750063006100740069006F006E00214334120800000088160000A0470000785634120700000014010000530074006100660066004D0065006D0062006500720020002800640062006F0029000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000B33AB18300050080B344F01F70CD23013C7EA31F0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000005000000540000002C0000002C0000002C0000003400000000000000000000002229000009230000000000002D0100000D0000000C000000070000001C0100000609000062070000480300001A040000DF020000EC04000027060000B103000027060000CB07000055050000000000000100000088160000A0470000000000001B0000000C00000002000000020000001C010000F50A0000000000000100000039130000C007000000000000020000000200000002000000020000001C010000060900000100000000000000391300003403000000000000000000000000000002000000020000001C010000060900000000000000000000D13100000923000000000000000000000D00000004000000040000001C01000006090000AA0A00009006000078563412040000006000000001000000010000000B000000000000000100000002000000030000000400000005000000060000000700000008000000090000000A00000004000000640062006F0000000C000000530074006100660066004D0065006D00620065007200000002000B00B61C0000B61C0000E0180000B61C00000000000002000000F0F0F0000000000000000000000000000000000001000000090000000000000017140000651D0000680D00005801000032000000010000020000680D000058010000020000000000FFFFFF000800008001000000150001000000900144420100065461686F6D61170046004B005F005300740061006600660045006400750063006100740069006F006E005F005300740061006600660002000B00C62A0000290F0000C62A0000AE1500000000000002000000F0F0F00000000000000000000000000000000000010000000B00000000000000AF1C000079120000680D00005801000040000000010000020000680D000058010000020000000000FFFFFF000800008001000000150001000000900144420100065461686F6D61150046004B005F00530074006100660066004D0065006D006200650072005F00430065006E00740065007200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100FEFF030A0000FFFFFFFF00000000000000000000000000000000170000004D6963726F736F66742044445320466F726D20322E300010000000456D626564646564204F626A6563740000000000F439B2710000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000C000000000000000EEDFFFF0100260000007300630068005F006C006100620065006C0073005F00760069007300690062006C0065000000010000000B0000001E000000000000000000000000000000000000006400000000000000000000000000000000000000000000000000010000000100000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C00320038003000350000002000000054000300440064007300530074007200650061006D000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000160002000300000006000000FFFFFFFF00000000000000000000000000000000000000000000000000000000000000000000000052000000910C00000000000053006300680065006D00610020005500440056002000440065006600610075006C0074000000000000000000000000000000000000000000000000000000000026000200FFFFFFFFFFFFFFFFFFFFFFFF000000000000000000000000000000000000000000000000000000000000000000000000850000001600000000000000440053005200450046002D0053004300480045004D0041002D0043004F004E00540045004E0054005300000000000000000000000000000000000000000000002C0002010500000007000000FFFFFFFF00000000000000000000000000000000000000000000000000000000000000000000000086000000620300000000000053006300680065006D00610020005500440056002000440065006600610075006C007400200050006F007300740020005600360000000000000000000000000036000200FFFFFFFFFFFFFFFFFFFFFFFF00000000000000000000000000000000000000000000000000000000000000000000000094000000120000000000000081000000820000008300000084000000FEFFFFFFFEFFFFFF8700000088000000890000008A0000008B0000008C0000008D0000008E0000008F00000090000000910000009200000093000000FEFFFFFFFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C0031003600380030000000020000000200000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003800300035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C0031003600380030000000030000000300000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003800300035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C0031003600380030000000040000000400000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003800300035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C00310036003800300000000500000005000000000000004800000001CAA67101000000640062006F00000046004B005F005300740061006600660045006400750063006100740069006F006E005F0045006400750063006100740069006F006E0000000000000000000000C402000000000600000006000000050000000800000001E4D80DE8E4D80D0000000000000000AD0F0000010000070000000700000000000000000000000000000000000000D00200000600280000004100630074006900760065005400610062006C00650056006900650077004D006F006400650000000100000008000400000031000000200000005400610062006C00650056006900650077004D006F00640065003A00300000000100000008003A00000034002C0030002C003200380034002C0030002C0032003300310030002C0031002C0031003800390030002C0035002C0031003200360030000000200000005400610062006C00650056006900650077004D006F00640065003A00310000000100000008001E00000032002C0030002C003200380034002C0030002C0032003800300035000000200000005400610062006C00650056006900650077004D006F00640065003A00320000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00330000000100000008001E00000032002C0030002C003200380034002C0030002C0032003300310030000000200000005400610062006C00650056006900650077004D006F00640065003A00340000000100000008003E00000034002C0030002C003200380034002C0030002C0032003300310030002C00310032002C0032003700330030002C00310031002C0031003600380030000000080000000800000000000000400000000161BA2201000000640062006F00000046004B005F005300740061006600660045006400750063006100740069006F006E005F005300740061006600660000000000000000000000C40200000000090000000900000008000000080000000144A80D5844A80D0000000000000000AD0F00000100000A0000000A000000000000003C0000000100000001000000640062006F00000046004B005F00530074006100660066004D0065006D006200650072005F00430065006E0074006500720000000000000000000000C402000000000B0000000B0000000A000000080000000146A80DD846A80D0000000000000000AD0F00000100000F0000000A00000001000000070000002F0000002E0000000500000003000000040000001C0000001D000000080000000700000004000000600000004B0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010003000000000000000C0000000B0000004E61BC00000000000000000000000000000000000000000000000000000000000000000000000000000000000000DBE6B0E91C81D011AD5100A0C90F57390000020020954B7328A7D301020200001048450000000000000000000000000000000000DA0100004400610074006100200053006F0075007200630065003D0065006300730032002E00640061007400610062006100730065002E00770069006E0064006F00770073002E006E00650074003B0049006E0069007400690061006C00200043006100740061006C006F0067003D0045005300430032003B005000650072007300690073007400200053006500630075007200690074007900200049006E0066006F003D0054007200750065003B0055007300650072002000490044003D00450043005300410064006D0069006E003B004D0075006C007400690070006C00650041006300740069007600650052006500730075006C00740053006500740073003D00460061006C00730065003B0054007200750073007400530065007200760065007200430065007200740069006600690063006100740065003D0054007200750065003B005000610063006B00650074002000530069007A0065003D0034003000390036003B004100700070006C00690063006100740069006F006E0020004E0061006D0065003D0022004D006900630072006F0073006F00660074002000530051004C00200053006500720076006500720020004D0061006E006100670065006D0065006E0074002000530074007500640069006F002200000000800500140000004400690061006700720061006D005F0031000000000226000E000000430065006E00740065007200000008000000640062006F00000000022600100000004500430053005500730065007200000008000000640062006F000000000226001400000045006400750063006100740069006F006E00000008000000640062006F000000000226001E0000005300740061006600660045006400750063006100740069006F006E00000008000000640062006F0000000002240018000000530074006100660066004D0065006D00620065007200000008000000640062006F00000001000000D68509B3BB6BF2459AB8371664F0327008004E0000007B00310036003300340043004400440037002D0030003800380038002D0034003200450033002D0039004600410032002D004200360044003300320035003600330042003900310044007D000000000000000000000000000000000000000000000000000000000000000000010003000000000000000C0000000B0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000062885214)
SET IDENTITY_INSERT [dbo].[sysdiagrams] OFF
SET ANSI_PADDING ON

GO
/****** Object:  Index [UK_principal_name]    Script Date: 2/23/2018 6:51:31 PM ******/
ALTER TABLE [dbo].[sysdiagrams] ADD  CONSTRAINT [UK_principal_name] UNIQUE NONCLUSTERED 
(
	[principal_id] ASC,
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON)
GO
ALTER TABLE [dbo].[Center] ADD  CONSTRAINT [DF_Center_Name]  DEFAULT (NULL) FOR [Name]
GO
ALTER TABLE [dbo].[Center] ADD  CONSTRAINT [DF_Center_County]  DEFAULT (NULL) FOR [County]
GO
ALTER TABLE [dbo].[Center] ADD  CONSTRAINT [DF_Center_Region]  DEFAULT (NULL) FOR [Region]
GO
ALTER TABLE [dbo].[StaffMember] ADD  CONSTRAINT [DF_StaffMember_Email]  DEFAULT (NULL) FOR [Email]
GO
ALTER TABLE [dbo].[StaffMember] ADD  CONSTRAINT [DF_StaffMember_DateOfHire]  DEFAULT (NULL) FOR [DateOfHire]
GO
ALTER TABLE [dbo].[StaffMember] ADD  CONSTRAINT [DF_StaffMember_Position]  DEFAULT (NULL) FOR [Position]
GO
ALTER TABLE [dbo].[StaffMember] ADD  CONSTRAINT [DF_StaffMember_DirectorCredentials]  DEFAULT ((0)) FOR [DirectorCredentials]
GO
ALTER TABLE [dbo].[StaffMember] ADD  CONSTRAINT [DF_StaffMember_DCExpiration]  DEFAULT (NULL) FOR [DCExpiration]
GO
ALTER TABLE [dbo].[StaffMember] ADD  CONSTRAINT [DF_StaffMember_CDAInProgress]  DEFAULT ((0)) FOR [CDAInProgress]
GO
ALTER TABLE [dbo].[StaffMember] ADD  CONSTRAINT [DF_StaffMember_CDAType]  DEFAULT (NULL) FOR [CDAType]
GO
ALTER TABLE [dbo].[StaffMember] ADD  CONSTRAINT [DF_StaffMember_CDAExpiration]  DEFAULT (NULL) FOR [CDAExpiration]
GO
ALTER TABLE [dbo].[StaffMember] ADD  CONSTRAINT [DF_StaffMember_CDARenewalProcess]  DEFAULT (NULL) FOR [CDARenewalProcess]
GO
ALTER TABLE [dbo].[StaffMember] ADD  CONSTRAINT [DF_StaffMember_Comments]  DEFAULT (NULL) FOR [Comments]
GO
ALTER TABLE [dbo].[StaffMember] ADD  CONSTRAINT [DF_StaffMember_Goal]  DEFAULT (NULL) FOR [Goal]
GO
ALTER TABLE [dbo].[StaffMember] ADD  CONSTRAINT [DF_StaffMember_MidYear]  DEFAULT (NULL) FOR [MidYear]
GO
ALTER TABLE [dbo].[StaffMember] ADD  CONSTRAINT [DF_StaffMember_EndYear]  DEFAULT (NULL) FOR [EndYear]
GO
ALTER TABLE [dbo].[StaffMember] ADD  CONSTRAINT [DF_StaffMember_GoalMet]  DEFAULT ((0)) FOR [GoalMet]
GO
ALTER TABLE [dbo].[StaffMember] ADD  CONSTRAINT [DF_StaffMember_TAndAApp]  DEFAULT (NULL) FOR [TAndAApp]
GO
ALTER TABLE [dbo].[StaffMember] ADD  CONSTRAINT [DF_StaffMember_AppApp]  DEFAULT (NULL) FOR [AppApp]
GO
ALTER TABLE [dbo].[StaffMember] ADD  CONSTRAINT [DF_StaffMember_ClassCompleted]  DEFAULT (NULL) FOR [ClassCompleted]
GO
ALTER TABLE [dbo].[StaffMember] ADD  CONSTRAINT [DF_StaffMember_ClassPaid]  DEFAULT ((0)) FOR [ClassPaid]
GO
ALTER TABLE [dbo].[StaffMember] ADD  CONSTRAINT [DF_StaffMember_RequiredHours]  DEFAULT ((0)) FOR [RequiredHours]
GO
ALTER TABLE [dbo].[StaffMember] ADD  CONSTRAINT [DF_StaffMember_HoursEarned]  DEFAULT ((0)) FOR [HoursEarned]
GO
ALTER TABLE [dbo].[StaffMember] ADD  CONSTRAINT [DF_StaffMember_Notes]  DEFAULT (NULL) FOR [Notes]
GO
ALTER TABLE [dbo].[StaffMember] ADD  CONSTRAINT [DF_StaffMember_TermDate]  DEFAULT (NULL) FOR [TermDate]
GO
ALTER TABLE [dbo].[StaffEducation]  WITH CHECK ADD  CONSTRAINT [FK_StaffEducation_Education] FOREIGN KEY([EducationID])
REFERENCES [dbo].[Education] ([EducationID])
GO
ALTER TABLE [dbo].[StaffEducation] CHECK CONSTRAINT [FK_StaffEducation_Education]
GO
ALTER TABLE [dbo].[StaffEducation]  WITH CHECK ADD  CONSTRAINT [FK_StaffEducation_Staff] FOREIGN KEY([StaffMemberID])
REFERENCES [dbo].[StaffMember] ([StaffMemberID])
GO
ALTER TABLE [dbo].[StaffEducation] CHECK CONSTRAINT [FK_StaffEducation_Staff]
GO
ALTER TABLE [dbo].[StaffMember]  WITH CHECK ADD  CONSTRAINT [FK_StaffMember_Center] FOREIGN KEY([CenterID])
REFERENCES [dbo].[Center] ([CenterID])
GO
ALTER TABLE [dbo].[StaffMember] CHECK CONSTRAINT [FK_StaffMember_Center]
GO
/****** Object:  StoredProcedure [dbo].[AddNewCenter]    Script Date: 2/23/2018 6:51:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



--Allows for the retrieval of one center an all its staffmemers by using @CenterId param or no param returns all centers and their respective staffmembers ordered by the centers Region, then name  both ascending



CREATE Procedure [dbo].[AddNewCenter] 
@StaffMemberID int,
@CenterName nvarchar(50) = NULL,
@CenterCounty nvarchar(50)= NULL,
@CenterRegion nvarchar(50)= NULL
as
begin

Declare @CenterID int



Select @CenterID = CenterID from Center where Name = @CenterName


If (@CenterID is null)
begin
Insert into Center(Name,County,Region) values(@CenterName,@CenterCounty,@CenterRegion) 
Select @CenterID = SCOPE_IDENTITY()
end
update StaffMember set centerID=@CenterID  where StaffMemberID=@StaffmemberID
end

GO
/****** Object:  StoredProcedure [dbo].[AddNewEducation]    Script Date: 2/23/2018 6:51:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



--Allows for the retrieval of one center an all its staffmemers by using @CenterId param or no param returns all centers and their respective staffmembers ordered by the centers Region, then name  both ascending



CREATE Procedure [dbo].[AddNewEducation] 
@StaffMemberID int,
@DegreeAbrv nvarchar(50)= NULL,
@DegreeLevel nvarchar(50)= NULL,
@DegreeType nvarchar(50)= NULL,
@DegreeDetail nvarchar(50)= NULL
as
begin
Declare @EducationID int
Select @EducationID = EducationID from Education where ((DegreeAbrv = @DegreeAbrv) and (DegreeType=@DegreeType))and (DegreeDetail=@DegreeDetail)
If (@EducationID is null)
begin
Insert into Education(DegreeAbrv, DegreeLevel,DegreeType,DegreeDetail) values(@DegreeAbrv, @DegreeLevel,@DegreeType,@DegreeDetail) 
Select @EducationID = SCOPE_IDENTITY()
end
begin 
insert into StaffEducation (StaffMemberID,EducationID) values (@StaffMemberID,@EducationID)
end

end

GO
/****** Object:  StoredProcedure [dbo].[AddNewStaffMember]    Script Date: 2/23/2018 6:51:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--@Params as follows @FirstName,@LastName,@Email,@DateOfHire,@Position,
--@DirectorCredentials,@DCExpiration,@CDAInProgress,@CDAType,@CDAExpiration,@CDARenewalProcess,@Comments,@Goal,@MidYear,@EndYear,@GoalMet,@TAndAApp,@AppApp,
--@ClassCompleted,@ClassPaid,@RequiredHours,@HoursEarned,@Notes,@TermDate
--All nullable except @FirstName and @LastName


CREATE procedure [dbo].[AddNewStaffMember]
@StaffMemberID int, 
@FirstName nvarchar(50),
@LastName nvarchar(50),
@Email nvarchar(50)= NULL,
@DateOfHire date= NULL,
@Position nvarchar(50)= NULL,
@DirectorCredentials bit= NULL,
@DCExpiration date= NULL,
@CDAInProgress bit= False,
@CDAType nvarchar(50)= NULL,
@CDAExpiration date= NULL,
@CDARenewalProcess nvarchar(50)= NULL,
@Comments nvarchar(150)= NULL,
@Goal bit= NULL,
@MidYear bit= NULL,
@EndYear bit= NULL,
@GoalMet bit= False,
@TAndAApp bit= NULL,
@AppApp bit= NULL,
@ClassCompleted bit= NULL,
@ClassPaid bit= False,
@RequiredHours int= NULL,
@HoursEarned int= NULL,
@Notes nvarchar(200)= NULL,
@TermDate date= NULL,
@IsInactive bit =False
as  
begin 


Begin
Insert into StaffMember (FirstName,LastName,Email,DateOfHire,Position,DirectorCredentials,DCExpiration,CDAInProgress,CDAType,CDAExpiration,CDARenewalProcess,Comments,Goal,MidYear,EndYear,GoalMet,TAndAApp,AppApp,ClassCompleted,ClassPaid,RequiredHours,HoursEarned,Notes,
TermDate,IsInactive) output inserted.staffMemberID values(@FirstName,@LastName,@Email,@DateOfHire,@Position,@DirectorCredentials,@DCExpiration,@CDAInProgress,@CDAType,@CDAExpiration,@CDARenewalProcess,@Comments,@Goal,@MidYear,@EndYear,@GoalMet,@TAndAApp,@AppApp,@ClassCompleted,@ClassPaid,@RequiredHours,@HoursEarned,@Notes,@TermDate,@IsInactive)
Select @StaffMemberID = SCOPE_IDENTITY()

End


End

GO
/****** Object:  StoredProcedure [dbo].[AddNewUser]    Script Date: 2/23/2018 6:51:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Takes variables @Email,@FirstName,@LastName,@AccessLevel,@PasswordHash  to creates a system user to administer and view staff members


CREATE procedure [dbo].[AddNewUser]
@UserID int =null,
@Email varchar (150),
@FirstName varchar(50)=null,
@LastName varchar(50)=null,
@AccessLevel int,
@Passwordhash varchar(128)

as 

Begin
Insert into ECSUser (Email,FirstName,LastName,AccessLevel,PasswordHash) output inserted.UserID values(@Email,@FirstName,@LastName,@AccessLevel,@PasswordHash)
Select @UserID = SCOPE_IDENTITY()

End


GO
/****** Object:  StoredProcedure [dbo].[AuthenticateUser]    Script Date: 2/23/2018 6:51:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE Procedure [dbo].[AuthenticateUser]  
@Email varchar(150),
@PasswordHash varchar(128)
as 
begin
Select * FROM ECSUser 
where Email=@Email and PasswordHash = @PasswordHash
end


GO
/****** Object:  StoredProcedure [dbo].[deleteStaffMember]    Script Date: 2/23/2018 6:51:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



--Deletes the staff members education from the junction table and then deletes the staff member 



CREATE Procedure [dbo].[deleteStaffMember]  
@staffMemberID int
as
begin

begin
delete from StaffEducation where staffMemberID=@staffMemberID
end

begin
delete from StaffMember where StaffMemberID=@staffMemberID
end

end

GO
/****** Object:  StoredProcedure [dbo].[deleteUser]    Script Date: 2/23/2018 6:51:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--deletes the user from the database






CREATE Procedure [dbo].[deleteUser]  
@UserID int
as

if (@UserID != 3)
begin
delete from ECSUser where UserID=@UserID
end




GO
/****** Object:  StoredProcedure [dbo].[GetCenter]    Script Date: 2/23/2018 6:51:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--Allows for the retrieval of one center an all its staffmemers by using @CenterId param or no param returns all centers and their respective staffmembers ordered by the centers Region, then name  both ascending



CREATE Procedure [dbo].[GetCenter]  
@CenterID int = NULL
as
begin
Select c.CenterID,c.Name,c.County,c.Region,sm.StaffMemberID,sm.FirstName,sm.LastName,sm.Email,sm.DateofHire,sm.Position,sm.DirectorCredentials,sm.DCExpiration,sm.CDAInProgress,sm.CDAType,sm.CDARenewalProcess,sm.Comments,sm.Goal,sm.MidYear,
sm.EndYear,sm.GoalMet,sm.TAndAApp,sm.AppApp,sm.ClassCompleted,sm.ClassPaid,sm.RequiredHours,sm.HoursEarned,sm.Notes,sm.TermDate
FROM Center as c
Left OUTER JOIN StaffMember as sm on c.CenterID=sm.CenterID
where sm.CenterID=@CenterID OR ISNULL(@CenterID, '') = ''
order by Region asc , Name asc
end
GO
/****** Object:  StoredProcedure [dbo].[GetEmptyEducations]    Script Date: 2/23/2018 6:51:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE Procedure [dbo].[GetEmptyEducations]  
as
begin
select e.EducationID from StaffEducation as se 
right join Education as e on se.EducationID=e.EducationID 
where StaffMemberID is Null
end

GO
/****** Object:  StoredProcedure [dbo].[GetStaffMember]    Script Date: 2/23/2018 6:51:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--@params are @StaffMemberID

--Allows the user to get a list of StaffMembers with their associated education and centers, use the @StaffMemberID to retrieve just one StaffMember


CREATE Procedure [dbo].[GetStaffMember]  
@StaffMemberID int =NULL
as 
begin
Select *, c.Name as [CenterName], c.County as[CenterCounty],c.Region as[CenterRegion]
FROM StaffMember as sm
Left Outer JOIN Center as c on c.CenterID=sm.CenterID
Left Outer JOIN StaffEducation as se on se.StaffMemberID=sm.StaffMemberID
Left Outer JOIN Education as e on e.educationID=se.EducationID
where sm.StaffMemberID=@StaffMemberID OR ISNULL(@StaffMemberID, '') = ''
order by LastName asc
end
GO
/****** Object:  StoredProcedure [dbo].[RemoveStaffEducation]    Script Date: 2/23/2018 6:51:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



--Takes the input of staffMemberID and the educationID you want to remove from that staff members and deletes it from the junction table to dissacciate



CREATE Procedure [dbo].[RemoveStaffEducation]  
@staffMemberID int,
@educationID int
as
begin
delete from StaffEducation where staffMemberID=@staffMemberID and educationID=@educationID
end

GO
/****** Object:  StoredProcedure [dbo].[sp_alterdiagram]    Script Date: 2/23/2018 6:51:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_alterdiagram]
	(
		@diagramname 	sysname,
		@owner_id	int	= null,
		@version 	int,
		@definition 	varbinary(max)
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
	
		declare @theId 			int
		declare @retval 		int
		declare @IsDbo 			int
		
		declare @UIDFound 		int
		declare @DiagId			int
		declare @ShouldChangeUID	int
	
		if(@diagramname is null)
		begin
			RAISERROR ('Invalid ARG', 16, 1)
			return -1
		end
	
		execute as caller;
		select @theId = DATABASE_PRINCIPAL_ID();	 
		select @IsDbo = IS_MEMBER(N'db_owner'); 
		if(@owner_id is null)
			select @owner_id = @theId;
		revert;
	
		select @ShouldChangeUID = 0
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
		
		if(@DiagId IS NULL or (@IsDbo = 0 and @theId <> @UIDFound))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1);
			return -3
		end
	
		if(@IsDbo <> 0)
		begin
			if(@UIDFound is null or USER_NAME(@UIDFound) is null) -- invalid principal_id
			begin
				select @ShouldChangeUID = 1 ;
			end
		end

		-- update dds data			
		update dbo.sysdiagrams set definition = @definition where diagram_id = @DiagId ;

		-- change owner
		if(@ShouldChangeUID = 1)
			update dbo.sysdiagrams set principal_id = @theId where diagram_id = @DiagId ;

		-- update dds version
		if(@version is not null)
			update dbo.sysdiagrams set version = @version where diagram_id = @DiagId ;

		return 0
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_creatediagram]    Script Date: 2/23/2018 6:51:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_creatediagram]
	(
		@diagramname 	sysname,
		@owner_id		int	= null, 	
		@version 		int,
		@definition 	varbinary(max)
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
	
		declare @theId int
		declare @retval int
		declare @IsDbo	int
		declare @userName sysname
		if(@version is null or @diagramname is null)
		begin
			RAISERROR (N'E_INVALIDARG', 16, 1);
			return -1
		end
	
		execute as caller;
		select @theId = DATABASE_PRINCIPAL_ID(); 
		select @IsDbo = IS_MEMBER(N'db_owner');
		revert; 
		
		if @owner_id is null
		begin
			select @owner_id = @theId;
		end
		else
		begin
			if @theId <> @owner_id
			begin
				if @IsDbo = 0
				begin
					RAISERROR (N'E_INVALIDARG', 16, 1);
					return -1
				end
				select @theId = @owner_id
			end
		end
		-- next 2 line only for test, will be removed after define name unique
		if EXISTS(select diagram_id from dbo.sysdiagrams where principal_id = @theId and name = @diagramname)
		begin
			RAISERROR ('The name is already used.', 16, 1);
			return -2
		end
	
		insert into dbo.sysdiagrams(name, principal_id , version, definition)
				VALUES(@diagramname, @theId, @version, @definition) ;
		
		select @retval = @@IDENTITY 
		return @retval
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_dropdiagram]    Script Date: 2/23/2018 6:51:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_dropdiagram]
	(
		@diagramname 	sysname,
		@owner_id	int	= null
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
		declare @theId 			int
		declare @IsDbo 			int
		
		declare @UIDFound 		int
		declare @DiagId			int
	
		if(@diagramname is null)
		begin
			RAISERROR ('Invalid value', 16, 1);
			return -1
		end
	
		EXECUTE AS CALLER;
		select @theId = DATABASE_PRINCIPAL_ID();
		select @IsDbo = IS_MEMBER(N'db_owner'); 
		if(@owner_id is null)
			select @owner_id = @theId;
		REVERT; 
		
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1)
			return -3
		end
	
		delete from dbo.sysdiagrams where diagram_id = @DiagId;
	
		return 0;
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_helpdiagramdefinition]    Script Date: 2/23/2018 6:51:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_helpdiagramdefinition]
	(
		@diagramname 	sysname,
		@owner_id	int	= null 		
	)
	WITH EXECUTE AS N'dbo'
	AS
	BEGIN
		set nocount on

		declare @theId 		int
		declare @IsDbo 		int
		declare @DiagId		int
		declare @UIDFound	int
	
		if(@diagramname is null)
		begin
			RAISERROR (N'E_INVALIDARG', 16, 1);
			return -1
		end
	
		execute as caller;
		select @theId = DATABASE_PRINCIPAL_ID();
		select @IsDbo = IS_MEMBER(N'db_owner');
		if(@owner_id is null)
			select @owner_id = @theId;
		revert; 
	
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname;
		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId ))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1);
			return -3
		end

		select version, definition FROM dbo.sysdiagrams where diagram_id = @DiagId ; 
		return 0
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_helpdiagrams]    Script Date: 2/23/2018 6:51:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_helpdiagrams]
	(
		@diagramname sysname = NULL,
		@owner_id int = NULL
	)
	WITH EXECUTE AS N'dbo'
	AS
	BEGIN
		DECLARE @user sysname
		DECLARE @dboLogin bit
		EXECUTE AS CALLER;
			SET @user = USER_NAME();
			SET @dboLogin = CONVERT(bit,IS_MEMBER('db_owner'));
		REVERT;
		SELECT
			[Database] = DB_NAME(),
			[Name] = name,
			[ID] = diagram_id,
			[Owner] = USER_NAME(principal_id),
			[OwnerID] = principal_id
		FROM
			sysdiagrams
		WHERE
			(@dboLogin = 1 OR USER_NAME(principal_id) = @user) AND
			(@diagramname IS NULL OR name = @diagramname) AND
			(@owner_id IS NULL OR principal_id = @owner_id)
		ORDER BY
			4, 5, 1
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_renamediagram]    Script Date: 2/23/2018 6:51:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_renamediagram]
	(
		@diagramname 		sysname,
		@owner_id		int	= null,
		@new_diagramname	sysname
	
	)
	WITH EXECUTE AS 'dbo'
	AS
	BEGIN
		set nocount on
		declare @theId 			int
		declare @IsDbo 			int
		
		declare @UIDFound 		int
		declare @DiagId			int
		declare @DiagIdTarg		int
		declare @u_name			sysname
		if((@diagramname is null) or (@new_diagramname is null))
		begin
			RAISERROR ('Invalid value', 16, 1);
			return -1
		end
	
		EXECUTE AS CALLER;
		select @theId = DATABASE_PRINCIPAL_ID();
		select @IsDbo = IS_MEMBER(N'db_owner'); 
		if(@owner_id is null)
			select @owner_id = @theId;
		REVERT;
	
		select @u_name = USER_NAME(@owner_id)
	
		select @DiagId = diagram_id, @UIDFound = principal_id from dbo.sysdiagrams where principal_id = @owner_id and name = @diagramname 
		if(@DiagId IS NULL or (@IsDbo = 0 and @UIDFound <> @theId))
		begin
			RAISERROR ('Diagram does not exist or you do not have permission.', 16, 1)
			return -3
		end
	
		-- if((@u_name is not null) and (@new_diagramname = @diagramname))	-- nothing will change
		--	return 0;
	
		if(@u_name is null)
			select @DiagIdTarg = diagram_id from dbo.sysdiagrams where principal_id = @theId and name = @new_diagramname
		else
			select @DiagIdTarg = diagram_id from dbo.sysdiagrams where principal_id = @owner_id and name = @new_diagramname
	
		if((@DiagIdTarg is not null) and  @DiagId <> @DiagIdTarg)
		begin
			RAISERROR ('The name is already used.', 16, 1);
			return -2
		end		
	
		if(@u_name is null)
			update dbo.sysdiagrams set [name] = @new_diagramname, principal_id = @theId where diagram_id = @DiagId
		else
			update dbo.sysdiagrams set [name] = @new_diagramname where diagram_id = @DiagId
		return 0
	END
	
GO
/****** Object:  StoredProcedure [dbo].[sp_upgraddiagrams]    Script Date: 2/23/2018 6:51:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

	CREATE PROCEDURE [dbo].[sp_upgraddiagrams]
	AS
	BEGIN
		IF OBJECT_ID(N'dbo.sysdiagrams') IS NOT NULL
			return 0;
	
		CREATE TABLE dbo.sysdiagrams
		(
			name sysname NOT NULL,
			principal_id int NOT NULL,	-- we may change it to varbinary(85)
			diagram_id int PRIMARY KEY IDENTITY,
			version int,
	
			definition varbinary(max)
			CONSTRAINT UK_principal_name UNIQUE
			(
				principal_id,
				name
			)
		);


		/* Add this if we need to have some form of extended properties for diagrams */
		/*
		IF OBJECT_ID(N'dbo.sysdiagram_properties') IS NULL
		BEGIN
			CREATE TABLE dbo.sysdiagram_properties
			(
				diagram_id int,
				name sysname,
				value varbinary(max) NOT NULL
			)
		END
		*/

		IF OBJECT_ID(N'dbo.dtproperties') IS NOT NULL
		begin
			insert into dbo.sysdiagrams
			(
				[name],
				[principal_id],
				[version],
				[definition]
			)
			select	 
				convert(sysname, dgnm.[uvalue]),
				DATABASE_PRINCIPAL_ID(N'dbo'),			-- will change to the sid of sa
				0,							-- zero for old format, dgdef.[version],
				dgdef.[lvalue]
			from dbo.[dtproperties] dgnm
				inner join dbo.[dtproperties] dggd on dggd.[property] = 'DtgSchemaGUID' and dggd.[objectid] = dgnm.[objectid]	
				inner join dbo.[dtproperties] dgdef on dgdef.[property] = 'DtgSchemaDATA' and dgdef.[objectid] = dgnm.[objectid]
				
			where dgnm.[property] = 'DtgSchemaNAME' and dggd.[uvalue] like N'_EA3E6268-D998-11CE-9454-00AA00A3F36E_' 
			return 2;
		end
		return 1;
	END
	
GO
/****** Object:  StoredProcedure [dbo].[UpdateStaffMember]    Script Date: 2/23/2018 6:51:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--@Params as follows @FirstName,@LastName,@Email,@DateOfHire,@Position,
--@DirectorCredentials,@DCExpiration,@CDAInProgress,@CDAType,@CDAExpiration,@CDARenewalProcess,@Comments,@Goal,@MidYear,@EndYear,@GoalMet,@TAndAApp,@AppApp,
--@ClassCompleted,@ClassPaid,@RequiredHours,@HoursEarned,@Notes,@TermDate,@IsInactive
--All nullable except @FirstName and @LastName


CREATE procedure [dbo].[UpdateStaffMember] 
@StaffMemberID int, 
@FirstName nvarchar(50),
@LastName nvarchar(50),
@Email nvarchar(50)= NULL,
@DateOfHire date= NULL,
@Position nvarchar(50)= NULL,
@DirectorCredentials bit= NULL,
@DCExpiration date= NULL,
@CDAInProgress bit= False,
@CDAType nvarchar(50)= NULL,
@CDAExpiration date= NULL,
@CDARenewalProcess nvarchar(50)= NULL,
@Comments nvarchar(150)= NULL,
@Goal bit= NULL,
@MidYear bit= NULL,
@EndYear bit= NULL,
@GoalMet bit= False,
@TAndAApp bit= NULL,
@AppApp bit= NULL,
@ClassCompleted bit= NULL,
@ClassPaid bit= False,
@RequiredHours int= NULL,
@HoursEarned int= NULL,
@Notes nvarchar(200)= NULL,
@TermDate date= NULL,
@IsInactive bit =False

as  
Begin
Update StaffMember  set FirstName=@FirstName,LastName=@LastName,Email=@Email,DateOfHire=@DateOfHire,Position=@Position,DirectorCredentials=@DirectorCredentials,DCExpiration=@DCExpiration,CDAInProgress=@CDAInProgress,CDAType=@CDAType,CDAExpiration=@CDAExpiration,CDARenewalProcess=@CDARenewalProcess,Comments=@Comments,Goal=@Goal,MidYear=@MidYear,EndYear=@EndYear,GoalMet=@GoalMet,TAndAApp=@TAndAApp,AppApp=@AppApp,ClassCompleted=@ClassCompleted,ClassPaid=@ClassPaid,RequiredHours=@RequiredHours,HoursEarned=@HoursEarned,Notes=@Notes,
TermDate=@TermDate, IsInactive=@IsInactive
where StaffMemberID=@StaffmemberID
End




GO
/****** Object:  StoredProcedure [dbo].[UpdateUser]    Script Date: 2/23/2018 6:51:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE procedure [dbo].[UpdateUser]
@UserID int, 
@Email varchar(150),
@FirstName varchar(50)=null,
@LastName varchar(50)=null,
@AccessLevel int,
@PasswordHash varchar(128)
as  
Begin
Update ECSUser set Email=@Email,FirstName=@FirstName,LastName=@LastName,AccessLevel=@AccessLevel
where UserID=@UserID 
End





GO
USE [master]
GO
ALTER DATABASE [ESC2] SET  READ_WRITE 
GO
