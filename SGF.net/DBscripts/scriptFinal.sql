USE [master]
GO
/****** Object:  Database [XenosEN]    Script Date: 17/06/2014 07:37:54 p.m. ******/
CREATE DATABASE [XenosEN]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'XenosEN', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\XenosEN.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'XenosEN_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\XenosEN_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
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
/****** Object:  UserDefinedFunction [dbo].[fn_xenosEN_actual_fee]    Script Date: 17/06/2014 07:37:55 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create FUNCTION [dbo].[fn_xenosEN_actual_fee] 
(
      @id_credito int,
	  @tipo_credito int,	
      @id_asociado int
      
)
RETURNS int
AS
BEGIN

DECLARE @cantidad money

      select top (1) @cantidad =  mf.feeBalance
      from memberFees mf WHERE mf.memberId = @id_asociado AND mf.memberLoanId = @id_credito
	  and mf.memberFeeStatusId = 1	 
   	  ORDER BY /*Fecha_Planilla*/ mf.memberFeeId DESC

	  if @cantidad is null
	  begin
		select @cantidad = lt.totalAmount
		from loanTypes lt where lt.loanTypeId = @tipo_credito
	  end			

      RETURN @cantidad
	  
END

GO
/****** Object:  UserDefinedFunction [dbo].[get_current_balance]    Script Date: 17/06/2014 07:37:55 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create FUNCTION [dbo].[get_current_balance] 
(
      @id_credito int,
	  @tipo_credito int,	
      @id_asociado int
      
)
RETURNS int
AS
BEGIN

DECLARE @cantidad money

      select top (1) @cantidad =  mf.currentBalance
      from memberFees mf WHERE mf.memberId = @id_asociado AND mf.memberLoanId = @id_credito
	  and mf.memberFeeStatusId = 1	 
   	  ORDER BY /*Fecha_Planilla*/ mf.memberFeeId DESC

	  if @cantidad is null
	  begin
		select @cantidad = lt.totalAmount
		from loanTypes lt where lt.loanTypeId = @tipo_credito
	  end			

      RETURN @cantidad
	  
END

GO
/****** Object:  UserDefinedFunction [dbo].[get_current_fee]    Script Date: 17/06/2014 07:37:55 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREate FUNCTION [dbo].[get_current_fee] 
(
      @id_credito int,
      @id_asociado int
      
)
RETURNS int
AS
BEGIN

DECLARE @cantidad int

      select @cantidad = count(*)
      from memberFees mf WHERE mf.memberId = @id_asociado AND mf.memberLoanId = @id_credito
      and mf.memberFeeStatusId = 1
	  RETURN @cantidad
END

GO
/****** Object:  Table [dbo].[loanTypes]    Script Date: 17/06/2014 07:37:55 p.m. ******/
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
/****** Object:  Table [dbo].[memberChilds]    Script Date: 17/06/2014 07:37:55 p.m. ******/
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
/****** Object:  Table [dbo].[memberFees]    Script Date: 17/06/2014 07:37:55 p.m. ******/
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
/****** Object:  Table [dbo].[memberFeeStatus]    Script Date: 17/06/2014 07:37:55 p.m. ******/
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
/****** Object:  Table [dbo].[memberLoans]    Script Date: 17/06/2014 07:37:55 p.m. ******/
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
/****** Object:  Table [dbo].[memberLoansStatus]    Script Date: 17/06/2014 07:37:55 p.m. ******/
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
/****** Object:  Table [dbo].[memberMaritalStatus]    Script Date: 17/06/2014 07:37:55 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[memberMaritalStatus](
	[maritalStatusId] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_memberMaritalStatus] PRIMARY KEY CLUSTERED 
(
	[maritalStatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[memberPaymentTypes]    Script Date: 17/06/2014 07:37:55 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[memberPaymentTypes](
	[paymentTypeId] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_memberPaymentTypes] PRIMARY KEY CLUSTERED 
(
	[paymentTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[members]    Script Date: 17/06/2014 07:37:55 p.m. ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[offices]    Script Date: 17/06/2014 07:37:55 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[offices](
	[officeId] [int] IDENTITY(1,1) NOT NULL,
	[officeName] [nvarchar](60) NOT NULL,
	[description] [nvarchar](255) NULL,
 CONSTRAINT [PK_offices] PRIMARY KEY CLUSTERED 
(
	[officeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[View_PendingsPayments]    Script Date: 17/06/2014 07:37:55 p.m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_PendingsPayments]
AS
SELECT        ml.memberLoanId AS Operacion, m.firstName + ' ' + m.lastName AS NombreFull, lt.name AS nombreCredito, lt.totalAmount AS montoTotal, lt.amountFee AS montoCuota, 
                         dbo.get_current_balance(ml.memberLoanId, lt.loanTypeId, ml.memberId) AS MontoSaldoActual, dbo.get_current_fee(ml.memberLoanId, ml.memberId) AS CuotasHechas, 
                         lt.totalPayments - dbo.get_current_fee(ml.memberLoanId, ml.memberId) AS SaldoCuotas
FROM            dbo.memberLoans AS ml INNER JOIN
                         dbo.members AS m ON m.memberId = ml.memberId INNER JOIN
                         dbo.loanTypes AS lt ON ml.loanTypeId = lt.loanTypeId
WHERE        (ml.memberLoanStatusId = 2)

GO
SET IDENTITY_INSERT [dbo].[loanTypes] ON 

INSERT [dbo].[loanTypes] ([loanTypeId], [name], [description], [amount], [interestRate], [monthTerm], [paymentMonth]) VALUES (1, N'Credito 85000', N'Credito con monto maximo a 85000', 85000.0000, 12.0000, 6, 2)
SET IDENTITY_INSERT [dbo].[loanTypes] OFF
SET IDENTITY_INSERT [dbo].[memberChilds] ON 

INSERT [dbo].[memberChilds] ([memberChildId], [memberId], [firtName], [lastName], [birthdate]) VALUES (1, 1, N'Sebastian', N'Herrera', CAST(0x782A0B00 AS Date))
SET IDENTITY_INSERT [dbo].[memberChilds] OFF
SET IDENTITY_INSERT [dbo].[memberFees] ON 

INSERT [dbo].[memberFees] ([memberFeeId], [memberLoanId], [memberId], [payrollNumber], [startDate], [endDate], [recordDate], [amountFee], [previousBalance], [currentBalance], [feeBalance], [memberFeeStatusId], [notes], [cancelDate]) VALUES (1, 1, 1, 201401, CAST(0x0000A2A600000000 AS DateTime), CAST(0x0000A2B300000000 AS DateTime), CAST(0x0000A2B400000000 AS DateTime), 7000.0000, 84000.0000, 77000.0000, 11, 1, N'Se realiza el pago', NULL)
SET IDENTITY_INSERT [dbo].[memberFees] OFF
SET IDENTITY_INSERT [dbo].[memberFeeStatus] ON 

INSERT [dbo].[memberFeeStatus] ([memberFeeStatusId], [name]) VALUES (1, N'Aplicado')
INSERT [dbo].[memberFeeStatus] ([memberFeeStatusId], [name]) VALUES (2, N'Anulado')
SET IDENTITY_INSERT [dbo].[memberFeeStatus] OFF
SET IDENTITY_INSERT [dbo].[memberLoans] ON 

INSERT [dbo].[memberLoans] ([memberLoanId], [memberId], [loanTypeId], [memberLoanStatusId], [appDate], [aprDate], [Notes]) VALUES (1, 1, 1, 2, CAST(0x0000A34900000000 AS DateTime), CAST(0x0000A35700000000 AS DateTime), N'Se solicita el credito')
INSERT [dbo].[memberLoans] ([memberLoanId], [memberId], [loanTypeId], [memberLoanStatusId], [appDate], [aprDate], [Notes]) VALUES (2, 2, 1, 2, CAST(0x0000A34900000000 AS DateTime), CAST(0x0000A34900000000 AS DateTime), N'prueba de modificacion')
INSERT [dbo].[memberLoans] ([memberLoanId], [memberId], [loanTypeId], [memberLoanStatusId], [appDate], [aprDate], [Notes]) VALUES (4, 1, 1, 2, CAST(0x0000A34900000000 AS DateTime), CAST(0x0000A34A00000000 AS DateTime), N'Se aprueba en la junta 3.2.1')
INSERT [dbo].[memberLoans] ([memberLoanId], [memberId], [loanTypeId], [memberLoanStatusId], [appDate], [aprDate], [Notes]) VALUES (5, 1, 1, 2, CAST(0x0000A34A00000000 AS DateTime), CAST(0x0000A34A00000000 AS DateTime), N'hsjhfsjfhjdhjfdshfjhsdjfhdsfhjdshfjhdsjfhsd')
INSERT [dbo].[memberLoans] ([memberLoanId], [memberId], [loanTypeId], [memberLoanStatusId], [appDate], [aprDate], [Notes]) VALUES (6, 1, 1, 1, CAST(0x0000A34A00000000 AS DateTime), NULL, N'Prueba de credito 2')
SET IDENTITY_INSERT [dbo].[memberLoans] OFF
SET IDENTITY_INSERT [dbo].[memberLoansStatus] ON 

INSERT [dbo].[memberLoansStatus] ([memberLoanStatusId], [name]) VALUES (1, N'Solicitado')
INSERT [dbo].[memberLoansStatus] ([memberLoanStatusId], [name]) VALUES (2, N'Aprobado')
INSERT [dbo].[memberLoansStatus] ([memberLoanStatusId], [name]) VALUES (3, N'Cancelado')
INSERT [dbo].[memberLoansStatus] ([memberLoanStatusId], [name]) VALUES (4, N'Anulado')
SET IDENTITY_INSERT [dbo].[memberLoansStatus] OFF
SET IDENTITY_INSERT [dbo].[memberMaritalStatus] ON 

INSERT [dbo].[memberMaritalStatus] ([maritalStatusId], [name]) VALUES (1, N'Soltero')
INSERT [dbo].[memberMaritalStatus] ([maritalStatusId], [name]) VALUES (2, N'Casado')
INSERT [dbo].[memberMaritalStatus] ([maritalStatusId], [name]) VALUES (3, N'Divorciado')
INSERT [dbo].[memberMaritalStatus] ([maritalStatusId], [name]) VALUES (4, N'Union Libre')
SET IDENTITY_INSERT [dbo].[memberMaritalStatus] OFF
SET IDENTITY_INSERT [dbo].[memberPaymentTypes] ON 

INSERT [dbo].[memberPaymentTypes] ([paymentTypeId], [name]) VALUES (1, N'Bisemanal')
INSERT [dbo].[memberPaymentTypes] ([paymentTypeId], [name]) VALUES (2, N'Semanal')
SET IDENTITY_INSERT [dbo].[memberPaymentTypes] OFF
SET IDENTITY_INSERT [dbo].[members] ON 

INSERT [dbo].[members] ([memberId], [documentId], [firstName], [lastName], [maritalStatusId], [birthdate], [phoneNumber], [cellNumber], [address], [officeId], [dischargedDate], [paymentTypeId], [active]) VALUES (1, N'205780071', N'Arturo', N'Herrera Vargas', 1, CAST(0x0000A34700000000 AS DateTime), N'50624601623', N'50683155049', N'La palmera', 1, CAST(0x0000A34700000000 AS DateTime), 1, 1)
INSERT [dbo].[members] ([memberId], [documentId], [firstName], [lastName], [maritalStatusId], [birthdate], [phoneNumber], [cellNumber], [address], [officeId], [dischargedDate], [paymentTypeId], [active]) VALUES (2, N'205780072', N'Yadira', N'Cespedes Vega', 2, CAST(0x000076B800000000 AS DateTime), N'83155049', N'83155049', N'La palmera', 1, CAST(0x0000A34500000000 AS DateTime), 1, 1)
SET IDENTITY_INSERT [dbo].[members] OFF
SET IDENTITY_INSERT [dbo].[offices] ON 

INSERT [dbo].[offices] ([officeId], [officeName], [description]) VALUES (1, N'Tecnologias de Informacion', NULL)
INSERT [dbo].[offices] ([officeId], [officeName], [description]) VALUES (2, N'Contabilidad', NULL)
INSERT [dbo].[offices] ([officeId], [officeName], [description]) VALUES (3, N'Recursos Humanos', NULL)
INSERT [dbo].[offices] ([officeId], [officeName], [description]) VALUES (4, N'Proveeduria', NULL)
INSERT [dbo].[offices] ([officeId], [officeName], [description]) VALUES (5, N'Secretaria', NULL)
SET IDENTITY_INSERT [dbo].[offices] OFF
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_members]    Script Date: 17/06/2014 07:37:55 p.m. ******/
ALTER TABLE [dbo].[members] ADD  CONSTRAINT [IX_members] UNIQUE NONCLUSTERED 
(
	[documentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
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
ALTER TABLE [dbo].[members]  WITH CHECK ADD  CONSTRAINT [FK_members_memberMaritalStatus] FOREIGN KEY([maritalStatusId])
REFERENCES [dbo].[memberMaritalStatus] ([maritalStatusId])
GO
ALTER TABLE [dbo].[members] CHECK CONSTRAINT [FK_members_memberMaritalStatus]
GO
ALTER TABLE [dbo].[members]  WITH CHECK ADD  CONSTRAINT [FK_members_memberPaymentTypes] FOREIGN KEY([paymentTypeId])
REFERENCES [dbo].[memberPaymentTypes] ([paymentTypeId])
GO
ALTER TABLE [dbo].[members] CHECK CONSTRAINT [FK_members_memberPaymentTypes]
GO
ALTER TABLE [dbo].[members]  WITH CHECK ADD  CONSTRAINT [FK_members_offices] FOREIGN KEY([officeId])
REFERENCES [dbo].[offices] ([officeId])
GO
ALTER TABLE [dbo].[members] CHECK CONSTRAINT [FK_members_offices]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "ml"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 240
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "m"
            Begin Extent = 
               Top = 6
               Left = 278
               Bottom = 136
               Right = 450
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "lt"
            Begin Extent = 
               Top = 138
               Left = 38
               Bottom = 268
               Right = 210
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_PendingsPayments'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_PendingsPayments'
GO
USE [master]
GO
ALTER DATABASE [XenosEN] SET  READ_WRITE 
GO
