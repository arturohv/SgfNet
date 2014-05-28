USE [XenosEN]
GO
/****** Object:  Table [dbo].[loanTypes]    Script Date: 28/05/2014 11:31:50 a.m. ******/
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
/****** Object:  Table [dbo].[memberChilds]    Script Date: 28/05/2014 11:31:50 a.m. ******/
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
/****** Object:  Table [dbo].[memberFees]    Script Date: 28/05/2014 11:31:50 a.m. ******/
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
/****** Object:  Table [dbo].[memberFeeStatus]    Script Date: 28/05/2014 11:31:50 a.m. ******/
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
/****** Object:  Table [dbo].[memberLoans]    Script Date: 28/05/2014 11:31:50 a.m. ******/
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
/****** Object:  Table [dbo].[memberLoansStatus]    Script Date: 28/05/2014 11:31:50 a.m. ******/
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
/****** Object:  Table [dbo].[memberMaritalStatus]    Script Date: 28/05/2014 11:31:50 a.m. ******/
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
/****** Object:  Table [dbo].[memberPaymentTypes]    Script Date: 28/05/2014 11:31:50 a.m. ******/
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
/****** Object:  Table [dbo].[members]    Script Date: 28/05/2014 11:31:50 a.m. ******/
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
/****** Object:  Table [dbo].[offices]    Script Date: 28/05/2014 11:31:50 a.m. ******/
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
SET IDENTITY_INSERT [dbo].[loanTypes] ON 

INSERT [dbo].[loanTypes] ([loanTypeId], [name], [description], [amount], [interestRate], [monthTerm], [paymentMonth]) VALUES (1, N'Credito 75000', N'Credito con monto maximo a 75000', 75000.0000, 12.0000, 6, 2)
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

INSERT [dbo].[memberLoans] ([memberLoanId], [memberId], [loanTypeId], [memberLoanStatusId], [appDate], [aprDate], [Notes]) VALUES (1, 1, 1, 2, CAST(0x0000A33300000000 AS DateTime), NULL, N'Se solicita el credito')
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

INSERT [dbo].[members] ([memberId], [documentId], [firstName], [lastName], [maritalStatusId], [birthdate], [phoneNumber], [cellNumber], [address], [officeId], [dischargedDate], [paymentTypeId], [active]) VALUES (1, N'205780071', N'Arturo', N'Herrera', 1, CAST(0x0000763700000000 AS DateTime), N'50624601623', N'50683155049', N'La palmera', 1, CAST(0x0000957D00000000 AS DateTime), 1, 1)
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
/****** Object:  Index [IX_members]    Script Date: 28/05/2014 11:31:50 a.m. ******/
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
