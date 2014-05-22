USE [master]
GO
/****** Object:  Database [XenosEN]    Script Date: 22/05/2014 04:59:14 p.m. ******/
CREATE DATABASE [XenosEN]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'XenosEN', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\XenosEN.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'XenosEN_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\XenosEN_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [XenosEN] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [XenosEN].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [XenosEN] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [XenosEN] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [XenosEN] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [XenosEN] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [XenosEN] SET ARITHABORT OFF 
GO
ALTER DATABASE [XenosEN] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [XenosEN] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [XenosEN] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [XenosEN] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [XenosEN] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [XenosEN] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [XenosEN] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [XenosEN] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [XenosEN] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [XenosEN] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [XenosEN] SET  DISABLE_BROKER 
GO
ALTER DATABASE [XenosEN] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [XenosEN] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [XenosEN] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [XenosEN] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [XenosEN] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [XenosEN] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [XenosEN] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [XenosEN] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [XenosEN] SET  MULTI_USER 
GO
ALTER DATABASE [XenosEN] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [XenosEN] SET DB_CHAINING OFF 
GO
ALTER DATABASE [XenosEN] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [XenosEN] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [XenosEN]
GO
/****** Object:  Table [dbo].[loanTypes]    Script Date: 22/05/2014 04:59:14 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[loanTypes](
	[loanTypeId] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](40) NOT NULL,
	[description] [nvarchar](200) NOT NULL,
	[amount] [money] NOT NULL,
	[interestRate] [money] NOT NULL,
	[monthTerm] [int] NOT NULL,
	[paymentMonth] [int] NOT NULL,
	[totalPayments]  AS ([monthTerm]*[paymentMonth]),
	[totalAmount]  AS (([amount]*[interestRate])/(100)+[amount]),
	[amountFee]  AS ((([amount]*[interestRate])/(100)+[amount])/([monthTerm]*[paymentMonth])),
 CONSTRAINT [PK_loanTypes] PRIMARY KEY CLUSTERED 
(
	[loanTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[memberChilds]    Script Date: 22/05/2014 04:59:14 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[memberChilds](
	[memberChildId] [int] IDENTITY(1,1) NOT NULL,
	[memberId] [int] NOT NULL,
	[firtName] [nvarchar](20) NOT NULL,
	[lastName] [nvarchar](40) NOT NULL,
	[birthdate] [date] NOT NULL,
 CONSTRAINT [PK_memberChilds] PRIMARY KEY CLUSTERED 
(
	[memberChildId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[memberFees]    Script Date: 22/05/2014 04:59:14 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[memberFees](
	[memberFeeId] [int] IDENTITY(1,1) NOT NULL,
	[memberLoanId] [int] NOT NULL,
	[memberId] [int] NOT NULL,
	[payrollNumber] [int] NOT NULL,
	[startDate] [datetime] NOT NULL,
	[endDate] [datetime] NOT NULL,
	[recordDate] [datetime] NOT NULL,
	[amountFee] [money] NOT NULL,
	[previousBalance] [money] NOT NULL,
	[currentBalance] [money] NOT NULL,
	[feeBalance] [int] NOT NULL,
	[memberFeeStatusId] [int] NOT NULL,
	[notes] [nvarchar](200) NULL,
	[cancelDate] [datetime] NULL,
 CONSTRAINT [PK_memberFees_1] PRIMARY KEY CLUSTERED 
(
	[memberFeeId] ASC,
	[memberLoanId] ASC,
	[memberId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[memberFeeStatus]    Script Date: 22/05/2014 04:59:14 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[memberFeeStatus](
	[memberFeeStatusId] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_memberFeeStatus] PRIMARY KEY CLUSTERED 
(
	[memberFeeStatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[memberLoans]    Script Date: 22/05/2014 04:59:14 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[memberLoans](
	[memberLoanId] [int] IDENTITY(1,1) NOT NULL,
	[memberId] [int] NOT NULL,
	[loanTypeId] [int] NOT NULL,
	[memberLoanStatusId] [int] NOT NULL,
	[appDate] [datetime] NULL,
	[aprDate] [datetime] NULL,
	[Notes] [nvarchar](300) NULL,
 CONSTRAINT [PK_MemberLoans] PRIMARY KEY CLUSTERED 
(
	[memberLoanId] ASC,
	[memberId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[memberLoansStatus]    Script Date: 22/05/2014 04:59:14 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[memberLoansStatus](
	[memberLoanStatusId] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](30) NULL,
 CONSTRAINT [PK_memberLoansStatus] PRIMARY KEY CLUSTERED 
(
	[memberLoanStatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[members]    Script Date: 22/05/2014 04:59:14 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[members](
	[memberId] [int] IDENTITY(1,1) NOT NULL,
	[documentId] [nvarchar](20) NOT NULL,
	[firstName] [nvarchar](20) NOT NULL,
	[lastName] [nvarchar](40) NOT NULL,
	[maritalStatusId] [int] NOT NULL,
	[birthdate] [datetime] NOT NULL,
	[phoneNumber] [nvarchar](20) NULL,
	[cellNumber] [nvarchar](20) NULL,
	[address] [nvarchar](300) NULL,
	[officeId] [int] NOT NULL,
	[dischargedDate] [datetime] NOT NULL,
	[paymentTypeId] [int] NOT NULL,
	[active] [bit] NOT NULL,
 CONSTRAINT [PK_members] PRIMARY KEY CLUSTERED 
(
	[memberId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_members] UNIQUE NONCLUSTERED 
(
	[documentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[offices]    Script Date: 22/05/2014 04:59:14 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[offices](
	[officeId] [int] IDENTITY(1,1) NOT NULL,
	[officeName] [nvarchar](60) NOT NULL,
 CONSTRAINT [PK_offices] PRIMARY KEY CLUSTERED 
(
	[officeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[memberFees] ADD  CONSTRAINT [DF_memberFees_recordDate]  DEFAULT (getdate()) FOR [recordDate]
GO
ALTER TABLE [dbo].[members] ADD  CONSTRAINT [DF_members_active]  DEFAULT ((0)) FOR [active]
GO
ALTER TABLE [dbo].[memberChilds]  WITH CHECK ADD  CONSTRAINT [FK_memberChilds_members] FOREIGN KEY([memberId])
REFERENCES [dbo].[members] ([memberId])
GO
ALTER TABLE [dbo].[memberChilds] CHECK CONSTRAINT [FK_memberChilds_members]
GO
ALTER TABLE [dbo].[memberFees]  WITH CHECK ADD  CONSTRAINT [FK_memberFees_memberFeeStatus] FOREIGN KEY([memberFeeStatusId])
REFERENCES [dbo].[memberFeeStatus] ([memberFeeStatusId])
GO
ALTER TABLE [dbo].[memberFees] CHECK CONSTRAINT [FK_memberFees_memberFeeStatus]
GO
ALTER TABLE [dbo].[memberFees]  WITH CHECK ADD  CONSTRAINT [FK_memberFees_memberLoans] FOREIGN KEY([memberLoanId], [memberId])
REFERENCES [dbo].[memberLoans] ([memberLoanId], [memberId])
GO
ALTER TABLE [dbo].[memberFees] CHECK CONSTRAINT [FK_memberFees_memberLoans]
GO
ALTER TABLE [dbo].[memberLoans]  WITH CHECK ADD  CONSTRAINT [FK_memberLoans_loanTypes] FOREIGN KEY([loanTypeId])
REFERENCES [dbo].[loanTypes] ([loanTypeId])
GO
ALTER TABLE [dbo].[memberLoans] CHECK CONSTRAINT [FK_memberLoans_loanTypes]
GO
ALTER TABLE [dbo].[memberLoans]  WITH CHECK ADD  CONSTRAINT [FK_memberLoans_memberLoansStatus] FOREIGN KEY([memberLoanStatusId])
REFERENCES [dbo].[memberLoansStatus] ([memberLoanStatusId])
GO
ALTER TABLE [dbo].[memberLoans] CHECK CONSTRAINT [FK_memberLoans_memberLoansStatus]
GO
ALTER TABLE [dbo].[memberLoans]  WITH CHECK ADD  CONSTRAINT [FK_memberLoans_members] FOREIGN KEY([memberId])
REFERENCES [dbo].[members] ([memberId])
GO
ALTER TABLE [dbo].[memberLoans] CHECK CONSTRAINT [FK_memberLoans_members]
GO
ALTER TABLE [dbo].[members]  WITH CHECK ADD  CONSTRAINT [FK_members_offices] FOREIGN KEY([officeId])
REFERENCES [dbo].[offices] ([officeId])
GO
ALTER TABLE [dbo].[members] CHECK CONSTRAINT [FK_members_offices]
GO
USE [master]
GO
ALTER DATABASE [XenosEN] SET  READ_WRITE 
GO
