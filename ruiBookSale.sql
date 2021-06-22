CREATE DATABASE ruiBookSale
GO

USE [ruiBookSale]
GO
/****** Object:  Table [dbo].[af_AuditFlow]    Script Date: 2021/4/26 13:26:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[af_AuditFlow](
	[rowNum] [bigint] IDENTITY(1,1) NOT NULL,
	[rowID] [nchar](32) NOT NULL,
	[flowCode] [nvarchar](50) NOT NULL,
	[flowName] [nvarchar](50) NULL,
	[auditTypeCode] [nvarchar](50) NULL,
	[isUse] [nchar](1) NULL,
	[orgCode] [nvarchar](50) NULL,
	[remark] [nvarchar](500) NULL,
 CONSTRAINT [PK__af_Audit__4437DCF814270015] PRIMARY KEY CLUSTERED 
(
	[flowCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[af_AuditFlowDept]    Script Date: 2021/4/26 13:26:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[af_AuditFlowDept](
	[rowNum] [bigint] IDENTITY(1,1) NOT NULL,
	[rowID] [nchar](32) NOT NULL,
	[flowCode] [nvarchar](50) NOT NULL,
	[deptCode] [nvarchar](50) NOT NULL,
	[remark] [nvarchar](500) NULL,
 CONSTRAINT [PK_af_AuditFlowDept] PRIMARY KEY CLUSTERED 
(
	[flowCode] ASC,
	[deptCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[af_AuditLog]    Script Date: 2021/4/26 13:26:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[af_AuditLog](
	[rowNum] [bigint] IDENTITY(1,1) NOT NULL,
	[rowID] [nchar](32) NOT NULL,
	[relatedRowID] [bigint] NOT NULL,
	[relatedKeyCode] [nvarchar](50) NULL,
	[relatedUserCode] [nvarchar](50) NULL,
	[relatedDeptCode] [nvarchar](50) NULL,
	[auditTypeCode] [nvarchar](50) NOT NULL,
	[flowCode] [nvarchar](50) NOT NULL,
	[startNodeCode] [nvarchar](50) NULL,
	[nodeCode] [nvarchar](50) NOT NULL,
	[userCode] [nvarchar](50) NOT NULL,
	[createDate] [datetime] NOT NULL,
	[passType] [nchar](2) NULL,
	[printTag] [nvarchar](50) NULL,
	[fromType] [nvarchar](10) NULL,
	[recordType] [nchar](2) NULL,
	[auditDate] [datetime] NULL,
	[auditResult] [nvarchar](10) NULL,
	[auditRemark] [nvarchar](500) NULL,
	[remark] [nvarchar](500) NULL,
 CONSTRAINT [PK_af_AuditLog_1] PRIMARY KEY CLUSTERED 
(
	[rowNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[af_AuditNode]    Script Date: 2021/4/26 13:26:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[af_AuditNode](
	[rowNum] [bigint] IDENTITY(1,1) NOT NULL,
	[rowID] [nchar](32) NOT NULL,
	[flowCode] [nvarchar](50) NOT NULL,
	[nodeCode] [nvarchar](50) NOT NULL,
	[nodeJson] [nvarchar](max) NULL,
	[nodeDesc] [nvarchar](50) NULL,
	[nodeType] [nvarchar](10) NULL,
	[printTag] [nvarchar](10) NULL,
	[passType] [nchar](2) NULL,
	[auditUserCodes] [nvarchar](500) NULL,
	[auditRoleCodes] [nvarchar](500) NULL,
	[auditPostCodes] [nvarchar](500) NULL,
	[selectUserCodes] [nvarchar](500) NULL,
	[selectRoleCodes] [nvarchar](500) NULL,
	[selectPostCodes] [nvarchar](500) NULL,
	[editFieldCodes] [nvarchar](500) NULL,
	[isNoteInform] [nchar](1) NULL,
	[isEmailInform] [nchar](1) NULL,
	[remark] [nvarchar](500) NULL,
 CONSTRAINT [PK__af_Audit__733CFBC117F790F9] PRIMARY KEY CLUSTERED 
(
	[flowCode] ASC,
	[nodeCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[af_AuditPost]    Script Date: 2021/4/26 13:26:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[af_AuditPost](
	[rowNum] [bigint] IDENTITY(1,1) NOT NULL,
	[rowID] [nchar](32) NOT NULL,
	[postCode] [nvarchar](50) NOT NULL,
	[postName] [nvarchar](50) NULL,
	[isDeptPost] [nchar](1) NULL,
	[sourceFrom] [nvarchar](20) NULL,
	[importDate] [datetime] NULL,
	[remark] [nvarchar](500) NULL,
 CONSTRAINT [PK_af_AuditPost] PRIMARY KEY CLUSTERED 
(
	[postCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[af_AuditPostUser]    Script Date: 2021/4/26 13:26:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[af_AuditPostUser](
	[rowNum] [bigint] IDENTITY(1,1) NOT NULL,
	[rowID] [nchar](32) NOT NULL,
	[userCode] [nvarchar](50) NULL,
	[postCode] [nvarchar](50) NULL,
	[orgCode] [nvarchar](50) NULL,
	[deptCode] [nvarchar](50) NULL,
	[sourceFrom] [nvarchar](20) NULL,
	[importDate] [datetime] NULL,
	[remark] [nvarchar](500) NULL,
 CONSTRAINT [PK_af_AuditPostUser] PRIMARY KEY CLUSTERED 
(
	[rowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[af_AuditType]    Script Date: 2021/4/26 13:26:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[af_AuditType](
	[rowNum] [bigint] IDENTITY(1,1) NOT NULL,
	[rowID] [nchar](32) NOT NULL,
	[auditTypeCode] [nvarchar](50) NOT NULL,
	[auditTypeName] [nvarchar](50) NULL,
	[isAudit] [nchar](1) NULL,
	[remark] [nvarchar](500) NULL,
 CONSTRAINT [PK__af_BillT__319292880C85DE4D] PRIMARY KEY CLUSTERED 
(
	[auditTypeCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[af_BillCdnField]    Script Date: 2021/4/26 13:26:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[af_BillCdnField](
	[rowNum] [bigint] IDENTITY(1,1) NOT NULL,
	[rowID] [nchar](32) NOT NULL,
	[auditTypeCode] [nvarchar](50) NOT NULL,
	[fieldCode] [nvarchar](50) NOT NULL,
	[fieldName] [nvarchar](50) NULL,
	[remark] [nvarchar](500) NULL,
 CONSTRAINT [PK__af_BillF__CDBED7DF10566F31] PRIMARY KEY CLUSTERED 
(
	[auditTypeCode] ASC,
	[fieldCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[af_BillEditField]    Script Date: 2021/4/26 13:26:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[af_BillEditField](
	[rowNum] [bigint] IDENTITY(1,1) NOT NULL,
	[rowID] [nchar](32) NOT NULL,
	[auditTypeCode] [nvarchar](50) NOT NULL,
	[fieldCode] [nvarchar](50) NOT NULL,
	[fieldName] [nvarchar](50) NULL,
	[remark] [nvarchar](500) NULL,
 CONSTRAINT [PK_af_BillCtlField] PRIMARY KEY CLUSTERED 
(
	[auditTypeCode] ASC,
	[fieldCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[af_NodeRelation]    Script Date: 2021/4/26 13:26:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[af_NodeRelation](
	[rowNum] [bigint] IDENTITY(1,1) NOT NULL,
	[rowID] [nchar](32) NOT NULL,
	[flowCode] [nvarchar](50) NOT NULL,
	[startNodeCode] [nvarchar](50) NOT NULL,
	[endNodeCode] [nvarchar](50) NOT NULL,
	[passExpression] [nvarchar](500) NULL,
	[nodeGuid] [nvarchar](50) NULL,
	[nodeJson] [nvarchar](max) NULL,
	[remark] [nvarchar](500) NULL,
 CONSTRAINT [PK__af_NodeR__3F1C4A441BC821DD] PRIMARY KEY CLUSTERED 
(
	[flowCode] ASC,
	[startNodeCode] ASC,
	[endNodeCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[bks_Book]    Script Date: 2021/4/26 13:26:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bks_Book](
	[rowNum] [bigint] IDENTITY(1,1) NOT NULL,
	[rowID] [nchar](32) NULL,
	[bookCode] [nvarchar](50) NOT NULL,
	[bookName] [nvarchar](100) NULL,
	[isbnNO] [nvarchar](100) NULL,
	[price] [decimal](18, 2) NULL,
	[authorName] [nvarchar](100) NULL,
	[authorIntroduce] [nvarchar](max) NULL,
	[bookIntroduce] [nvarchar](max) NULL,
	[bookDirectory] [nvarchar](max) NULL,
	[bookTypeCode] [nvarchar](50) NULL,
	[pressCode] [nvarchar](50) NULL,
	[pressDate] [date] NULL,
	[release] [nvarchar](100) NULL,
	[surfacePic] [nvarchar](200) NULL,
	[isSell] [nchar](1) NULL,
	[stockSum] [int] NULL,
	[sellSum] [int] NULL,
	[remark] [nvarchar](500) NULL,
 CONSTRAINT [PK__bks_Book__3BB8DAE793C24461] PRIMARY KEY CLUSTERED 
(
	[bookCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[bks_BookStock]    Script Date: 2021/4/26 13:26:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bks_BookStock](
	[rowNum] [bigint] IDENTITY(1,1) NOT NULL,
	[rowID] [nchar](32) NULL,
	[stockCode] [nvarchar](50) NOT NULL,
	[stockDate] [datetime] NULL,
	[userCode] [nvarchar](50) NULL,
	[supplierCode] [nvarchar](50) NULL,
	[status] [nvarchar](10) NULL,
	[remark] [nvarchar](500) NULL,
 CONSTRAINT [PK__bks_Book__F476A7E3C5AA7D34] PRIMARY KEY CLUSTERED 
(
	[stockCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[bks_BookStockDetail]    Script Date: 2021/4/26 13:26:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bks_BookStockDetail](
	[rowNum] [bigint] IDENTITY(1,1) NOT NULL,
	[rowID] [nchar](32) NULL,
	[stockCode] [nvarchar](50) NOT NULL,
	[detailNo] [int] NOT NULL,
	[bookCode] [nvarchar](50) NOT NULL,
	[quantity] [int] NULL,
	[sellQuantity] [int] NULL,
	[price] [decimal](18, 2) NULL,
	[remark] [nvarchar](500) NULL,
 CONSTRAINT [PK__bks_Book__97CD2A4D1A4C798A] PRIMARY KEY CLUSTERED 
(
	[stockCode] ASC,
	[detailNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[bks_BookType]    Script Date: 2021/4/26 13:26:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bks_BookType](
	[rowNum] [bigint] IDENTITY(1,1) NOT NULL,
	[rowID] [nchar](32) NULL,
	[bookTypeCode] [nvarchar](50) NOT NULL,
	[bookTypeName] [nvarchar](100) NULL,
	[showOrder] [int] NULL,
	[remark] [nvarchar](500) NULL,
 CONSTRAINT [PK__bks_Book__6F8ADFA12614DB1E] PRIMARY KEY CLUSTERED 
(
	[bookTypeCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[bks_Customer]    Script Date: 2021/4/26 13:26:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bks_Customer](
	[rowNum] [bigint] IDENTITY(1,1) NOT NULL,
	[rowID] [nchar](32) NULL,
	[customerCode] [nvarchar](50) NOT NULL,
	[cusomterName] [nvarchar](50) NULL,
	[password] [nchar](32) NULL,
	[telphone] [nvarchar](20) NULL,
	[email] [nvarchar](50) NULL,
	[remark] [nvarchar](500) NULL,
 CONSTRAINT [PK__bks_Cust__47BC9F2C1466A378] PRIMARY KEY CLUSTERED 
(
	[customerCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[bks_CustomerAddress]    Script Date: 2021/4/26 13:26:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bks_CustomerAddress](
	[rowNum] [bigint] IDENTITY(1,1) NOT NULL,
	[rowID] [nchar](32) NULL,
	[addressCode] [uniqueidentifier] NULL,
	[customerCode] [nvarchar](50) NOT NULL,
	[addressName] [nvarchar](500) NULL,
	[isDefault] [bit] NULL,
	[remark] [nvarchar](500) NULL,
 CONSTRAINT [PK_bks_CustomerAddress] PRIMARY KEY CLUSTERED 
(
	[rowNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[bks_OrderDetail]    Script Date: 2021/4/26 13:26:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bks_OrderDetail](
	[rowNum] [bigint] IDENTITY(1,1) NOT NULL,
	[rowID] [nchar](32) NULL,
	[orderCode] [uniqueidentifier] NOT NULL,
	[bookCode] [nvarchar](50) NOT NULL,
	[quantity] [int] NULL,
	[price] [decimal](18, 2) NULL,
	[costPrice] [decimal](18, 2) NULL,
	[subTotal] [decimal](18, 2) NULL,
	[isComment] [bit] NULL,
	[commentDate] [datetime] NULL,
	[commentContent] [nvarchar](max) NULL,
 CONSTRAINT [PK__bks_Orde__40D210C7EEC11709] PRIMARY KEY CLUSTERED 
(
	[orderCode] ASC,
	[bookCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[bks_OrderInfo]    Script Date: 2021/4/26 13:26:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bks_OrderInfo](
	[rowNum] [bigint] IDENTITY(1,1) NOT NULL,
	[rowID] [nchar](32) NULL,
	[orderCode] [uniqueidentifier] NOT NULL,
	[customerCode] [nvarchar](50) NULL,
	[addressCode] [uniqueidentifier] NULL,
	[orderDate] [datetime] NULL,
	[totalPrice] [decimal](18, 2) NULL,
	[status] [nvarchar](10) NULL,
	[employeeCode] [nvarchar](50) NULL,
	[remark] [nvarchar](500) NULL,
 CONSTRAINT [PK__bks_Orde__23699D6991B2797A] PRIMARY KEY CLUSTERED 
(
	[orderCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[bks_Press]    Script Date: 2021/4/26 13:26:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bks_Press](
	[rowNum] [bigint] IDENTITY(1,1) NOT NULL,
	[rowID] [nchar](32) NULL,
	[pressCode] [nvarchar](50) NOT NULL,
	[pressName] [nvarchar](100) NULL,
	[showOrder] [int] NULL,
	[remark] [nvarchar](500) NULL,
 CONSTRAINT [PK__bks_Pres__3FDC40D0CA4EE686] PRIMARY KEY CLUSTERED 
(
	[pressCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[bks_ShoppingTrolley]    Script Date: 2021/4/26 13:26:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bks_ShoppingTrolley](
	[rowNum] [bigint] IDENTITY(1,1) NOT NULL,
	[rowID] [nchar](32) NULL,
	[customerCode] [nvarchar](100) NOT NULL,
	[bookCode] [nvarchar](50) NOT NULL,
	[quantity] [int] NULL,
	[remark] [nvarchar](500) NULL,
 CONSTRAINT [PK__bks_Shop__24071282E91D23B3] PRIMARY KEY CLUSTERED 
(
	[customerCode] ASC,
	[bookCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[bks_Supplier]    Script Date: 2021/4/26 13:26:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bks_Supplier](
	[rowNum] [bigint] IDENTITY(1,1) NOT NULL,
	[rowID] [nchar](32) NULL,
	[supplierCode] [nvarchar](50) NOT NULL,
	[supplierName] [nvarchar](100) NULL,
	[contactUser] [nvarchar](10) NULL,
	[contactPhone] [nvarchar](20) NULL,
	[remark] [nvarchar](500) NULL,
 CONSTRAINT [PK__bks_Supp__35C84801CD56DEBC] PRIMARY KEY CLUSTERED 
(
	[supplierCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[rbac_Config]    Script Date: 2021/4/26 13:26:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rbac_Config](
	[rowNum] [bigint] IDENTITY(1,1) NOT NULL,
	[rowID] [nchar](32) NOT NULL,
	[keyType] [int] NULL,
 CONSTRAINT [PK_rbac_config] PRIMARY KEY CLUSTERED 
(
	[rowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[rbac_DataPriv]    Script Date: 2021/4/26 13:26:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rbac_DataPriv](
	[rowNum] [bigint] IDENTITY(1,1) NOT NULL,
	[rowID] [nchar](32) NOT NULL,
	[dataPrivCode] [nvarchar](50) NOT NULL,
	[dataPrivName] [nvarchar](50) NULL,
	[remark] [nvarchar](500) NULL,
 CONSTRAINT [PK_rbac_DataPriv] PRIMARY KEY CLUSTERED 
(
	[dataPrivCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[rbac_Module]    Script Date: 2021/4/26 13:26:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rbac_Module](
	[rowNum] [bigint] IDENTITY(1,1) NOT NULL,
	[rowID] [nchar](32) NOT NULL,
	[moduleCode] [nvarchar](50) NOT NULL,
	[moduleName] [nvarchar](50) NULL,
	[upModuleCode] [nvarchar](50) NULL,
	[userType] [nvarchar](50) NULL,
	[showOrder] [int] NULL,
	[remark] [nvarchar](500) NULL,
 CONSTRAINT [PK__rbac_Mod__B16D3ED4145C0A3F] PRIMARY KEY CLUSTERED 
(
	[rowNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[rbac_Operation]    Script Date: 2021/4/26 13:26:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rbac_Operation](
	[rowNum] [bigint] IDENTITY(1,1) NOT NULL,
	[rowID] [nchar](32) NOT NULL,
	[operationCode] [nvarchar](50) NOT NULL,
	[operationName] [nvarchar](50) NULL,
	[showOrder] [int] NULL,
	[remark] [nvarchar](500) NULL,
 CONSTRAINT [PK__rbac_Ope__6F4D8917108B795B] PRIMARY KEY CLUSTERED 
(
	[rowNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[rbac_Resource]    Script Date: 2021/4/26 13:26:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rbac_Resource](
	[rowNum] [bigint] IDENTITY(1,1) NOT NULL,
	[rowID] [nchar](32) NOT NULL,
	[resourceCode] [nvarchar](200) NOT NULL,
	[resourceName] [nvarchar](50) NULL,
	[moduleCode] [nvarchar](50) NULL,
	[isShow] [nchar](1) NULL,
	[showOrder] [int] NULL,
	[haveOperations] [nvarchar](500) NULL,
	[resourceUrl] [nvarchar](200) NULL,
	[opControl] [nchar](1) NULL,
	[dataControl] [nchar](1) NULL,
	[pageWidth] [int] NULL,
	[pagerCount] [int] NULL,
	[remark] [nvarchar](max) NULL,
 CONSTRAINT [PK__rbac_Res__06B50AD61CF15040] PRIMARY KEY CLUSTERED 
(
	[resourceCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[rbac_ResourceOp]    Script Date: 2021/4/26 13:26:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rbac_ResourceOp](
	[rowNum] [bigint] IDENTITY(1,1) NOT NULL,
	[rowID] [nchar](32) NOT NULL,
	[resourceCode] [nvarchar](50) NULL,
	[operationCode] [nvarchar](50) NULL,
	[operationName] [nvarchar](50) NULL,
	[showOrder] [bigint] NULL,
 CONSTRAINT [PK_rbac_ResourceOp] PRIMARY KEY CLUSTERED 
(
	[rowNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[rbac_Role]    Script Date: 2021/4/26 13:26:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rbac_Role](
	[rowNum] [bigint] IDENTITY(1,1) NOT NULL,
	[rowID] [nchar](32) NOT NULL,
	[roleCode] [nvarchar](50) NOT NULL,
	[roleName] [nvarchar](50) NULL,
	[userType] [nvarchar](50) NULL,
	[remark] [nvarchar](500) NULL,
 CONSTRAINT [PK__rbac_Rol__44FD4F9121B6055D] PRIMARY KEY CLUSTERED 
(
	[roleCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[rbac_RolePriv]    Script Date: 2021/4/26 13:26:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rbac_RolePriv](
	[rowNum] [bigint] IDENTITY(1,1) NOT NULL,
	[rowID] [nchar](32) NOT NULL,
	[roleCode] [nvarchar](50) NOT NULL,
	[resourceCode] [nvarchar](200) NOT NULL,
	[opPriv] [nvarchar](1000) NULL,
	[dataPriv] [nvarchar](50) NULL,
	[remark] [nvarchar](500) NULL,
 CONSTRAINT [PK_rbac_RolePriv_1] PRIMARY KEY CLUSTERED 
(
	[roleCode] ASC,
	[resourceCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[rbac_RoleUser]    Script Date: 2021/4/26 13:26:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rbac_RoleUser](
	[rowNum] [bigint] IDENTITY(1,1) NOT NULL,
	[rowID] [nchar](32) NOT NULL,
	[roleCode] [nvarchar](50) NOT NULL,
	[userCode] [nvarchar](50) NOT NULL,
	[orgCode] [nvarchar](50) NOT NULL,
	[remark] [nvarchar](500) NULL,
 CONSTRAINT [PK__rbac_Rol__EB6ABD3F29572725] PRIMARY KEY CLUSTERED 
(
	[roleCode] ASC,
	[userCode] ASC,
	[orgCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[rbac_User]    Script Date: 2021/4/26 13:26:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rbac_User](
	[rowNum] [bigint] IDENTITY(1,1) NOT NULL,
	[rowID] [nchar](32) NOT NULL,
	[userCode] [nvarchar](50) NOT NULL,
	[userName] [nvarchar](50) NULL,
	[password] [nchar](32) NULL,
	[isAdmin] [nchar](1) NULL,
	[relatedCode] [nvarchar](50) NULL,
	[remark] [nvarchar](500) NULL,
 CONSTRAINT [PK__rbac_Use__F97F2AEB25869641] PRIMARY KEY CLUSTERED 
(
	[userCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[rbac_UserOrg]    Script Date: 2021/4/26 13:26:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rbac_UserOrg](
	[rowNum] [bigint] IDENTITY(1,1) NOT NULL,
	[rowID] [nchar](32) NOT NULL,
	[userCode] [nvarchar](50) NOT NULL,
	[orgCode] [nvarchar](50) NOT NULL,
	[deptCode] [nvarchar](50) NULL,
	[isLogin] [nchar](1) NULL,
	[isAllPrj] [nchar](1) NULL,
	[remark] [nvarchar](500) NULL,
 CONSTRAINT [PK__rbac_Use__D9CF477A7D575101] PRIMARY KEY CLUSTERED 
(
	[userCode] ASC,
	[orgCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[rbac_UserPriv]    Script Date: 2021/4/26 13:26:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rbac_UserPriv](
	[rowNum] [bigint] IDENTITY(1,1) NOT NULL,
	[rowID] [nchar](32) NOT NULL,
	[userCode] [nvarchar](50) NOT NULL,
	[orgCode] [nvarchar](50) NOT NULL,
	[resourceCode] [nvarchar](200) NOT NULL,
	[opPriv] [nvarchar](1000) NULL,
	[dataPriv] [nvarchar](50) NULL,
	[remark] [nvarchar](500) NULL,
 CONSTRAINT [PK_rbac_UserPriv] PRIMARY KEY CLUSTERED 
(
	[userCode] ASC,
	[orgCode] ASC,
	[resourceCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[sbs_Dept]    Script Date: 2021/4/26 13:26:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sbs_Dept](
	[rowNum] [bigint] IDENTITY(1,1) NOT NULL,
	[rowID] [nchar](32) NOT NULL,
	[deptCode] [nvarchar](50) NOT NULL,
	[deptName] [nvarchar](50) NULL,
	[deptType] [nvarchar](50) NULL,
	[upDeptCode] [nvarchar](50) NULL,
	[orgCode] [nvarchar](50) NULL,
	[sourceFrom] [nvarchar](20) NULL,
	[importDate] [datetime] NULL,
	[remark] [nvarchar](500) NULL,
 CONSTRAINT [PK__bs_Dept__87AC853A282DF8C2] PRIMARY KEY CLUSTERED 
(
	[deptCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[sbs_Empl]    Script Date: 2021/4/26 13:26:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sbs_Empl](
	[rowNum] [bigint] IDENTITY(1,1) NOT NULL,
	[rowID] [nchar](32) NOT NULL,
	[emplCode] [nvarchar](50) NOT NULL,
	[emplName] [nvarchar](50) NULL,
	[deptCode] [nvarchar](50) NULL,
	[orgCode] [nvarchar](50) NULL,
	[status] [nvarchar](10) NULL,
	[sex] [nchar](1) NULL,
	[IDCard] [nvarchar](18) NULL,
	[phoneNumber] [nvarchar](20) NULL,
	[sourceFrom] [nvarchar](50) NULL,
	[importDate] [datetime] NULL,
	[remark] [nvarchar](500) NULL,
 CONSTRAINT [PK__bs_Empl__4AC032552FCF1A8A] PRIMARY KEY CLUSTERED 
(
	[emplCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[sbs_Org]    Script Date: 2021/4/26 13:26:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sbs_Org](
	[rowNum] [bigint] IDENTITY(1,1) NOT NULL,
	[rowID] [nchar](32) NOT NULL,
	[orgCode] [nvarchar](50) NOT NULL,
	[orgName] [nvarchar](50) NULL,
	[isDefault] [nchar](1) NULL,
	[isWHOnline] [nchar](1) NULL,
	[whOnlineValue] [nvarchar](10) NULL,
	[sourceFrom] [nvarchar](20) NULL,
	[importDate] [datetime] NULL,
	[remark] [nvarchar](500) NULL,
 CONSTRAINT [PK__rbac_Org__0B06D9136C190EBB] PRIMARY KEY CLUSTERED 
(
	[orgCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[sys_BillAttach]    Script Date: 2021/4/26 13:26:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sys_BillAttach](
	[rowNum] [bigint] IDENTITY(1,1) NOT NULL,
	[rowID] [nchar](32) NOT NULL,
	[attachCode] [nvarchar](50) NOT NULL,
	[relatedResourceCode] [nvarchar](50) NULL,
	[relatedKeyCode] [nvarchar](50) NULL,
	[relatedDetailNo] [int] NULL,
	[attachUrl] [nvarchar](500) NULL,
	[prieviewUrl] [nvarchar](500) NULL,
	[attachName] [nvarchar](100) NULL,
	[attachLength] [bigint] NULL,
	[attachMIME] [nvarchar](200) NULL,
	[attachContent] [nvarchar](1000) NULL,
	[uploadUserCode] [nvarchar](50) NULL,
	[uploadDateTime] [datetime] NULL,
	[remark] [nvarchar](500) NULL,
 CONSTRAINT [PK__sys_Bill__A1F5CF8808362A7C] PRIMARY KEY CLUSTERED 
(
	[attachCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[sys_Column]    Script Date: 2021/4/26 13:26:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sys_Column](
	[rowNum] [bigint] IDENTITY(1,1) NOT NULL,
	[rowID] [nchar](32) NULL,
	[resourceCode] [nvarchar](50) NOT NULL,
	[fieldCode] [nvarchar](50) NOT NULL,
	[fieldName] [nvarchar](50) NULL,
	[isShow] [bit] NULL,
	[showOrder] [int] NULL,
	[isOrder] [bit] NULL,
	[colWidth] [int] NULL,
	[isResize] [bit] NULL,
	[fixedValue] [nvarchar](10) NULL,
	[alignType] [nvarchar](10) NULL,
	[optionValue] [nvarchar](1000) NULL,
	[remark] [nvarchar](500) NULL,
 CONSTRAINT [PK__sys_Colu__FA994F814222D4EF] PRIMARY KEY CLUSTERED 
(
	[resourceCode] ASC,
	[fieldCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[sys_DataSyncInterface]    Script Date: 2021/4/26 13:26:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sys_DataSyncInterface](
	[rowNum] [bigint] IDENTITY(1,1) NOT NULL,
	[rowID] [nchar](32) NULL,
	[sysTableName] [nvarchar](50) NOT NULL,
	[sysInsertTableName] [nvarchar](50) NULL,
	[syskeyFieldName] [nvarchar](50) NULL,
	[sourceTableName] [nvarchar](50) NULL,
	[sourceTableJoinExpression] [nvarchar](1000) NULL,
	[sourceTableWhereExpression] [nvarchar](1000) NULL,
	[sourceTableOrderExpression] [nvarchar](1000) NULL,
	[isPrimary] [nchar](1) NULL,
	[remark] [nvarchar](1000) NULL,
 CONSTRAINT [PK__dataSync__1D94F95902FC7413] PRIMARY KEY CLUSTERED 
(
	[rowNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[sys_DataSyncInterfaceDetail]    Script Date: 2021/4/26 13:26:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sys_DataSyncInterfaceDetail](
	[rowNum] [bigint] IDENTITY(1,1) NOT NULL,
	[rowID] [nchar](32) NULL,
	[sysTableName] [nvarchar](50) NULL,
	[sysFieldName] [nvarchar](50) NULL,
	[sourceFieldName] [nvarchar](50) NULL,
	[sourceFieldAliasName] [nvarchar](50) NULL,
	[checkOrder] [int] NULL,
	[show] [nchar](1) NULL,
	[import] [nchar](1) NULL,
	[showOrder] [int] NULL,
	[filter] [nchar](1) NULL,
	[remark] [nvarchar](1000) NULL,
 CONSTRAINT [PK_DataSyncInterfaceDetail] PRIMARY KEY CLUSTERED 
(
	[rowNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[sys_UCColumn]    Script Date: 2021/4/26 13:26:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sys_UCColumn](
	[rowNum] [bigint] IDENTITY(1,1) NOT NULL,
	[rowID] [nchar](32) NULL,
	[resourceCode] [nvarchar](50) NOT NULL,
	[userCode] [nvarchar](50) NOT NULL,
	[fieldCode] [nvarchar](50) NOT NULL,
	[fieldName] [nvarchar](50) NULL,
	[isShow] [bit] NULL,
	[showOrder] [int] NULL,
	[isOrder] [bit] NULL,
	[colWidth] [int] NULL,
	[isResize] [bit] NULL,
	[fixedValue] [nvarchar](10) NULL,
	[alignType] [nvarchar](10) NULL,
	[remark] [nvarchar](500) NULL,
 CONSTRAINT [PK__sys_UCCo__D6E03C2D45F365D3] PRIMARY KEY CLUSTERED 
(
	[resourceCode] ASC,
	[userCode] ASC,
	[fieldCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[sys_UCPager]    Script Date: 2021/4/26 13:26:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sys_UCPager](
	[rowNum] [bigint] IDENTITY(1,1) NOT NULL,
	[rowID] [nchar](32) NULL,
	[resourceCode] [nvarchar](50) NOT NULL,
	[userCode] [nvarchar](50) NOT NULL,
	[pageSize] [int] NULL,
	[pageWidth] [int] NULL,
	[remark] [nvarchar](500) NULL,
 CONSTRAINT [PK__sys_UCPa__A922F8784AB81AF0] PRIMARY KEY CLUSTERED 
(
	[resourceCode] ASC,
	[userCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[sys_WebLog]    Script Date: 2021/4/26 13:26:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sys_WebLog](
	[rowNum] [bigint] IDENTITY(1,1) NOT NULL,
	[rowID] [nchar](32) NULL,
	[logDate] [datetime] NULL,
	[logType] [nvarchar](10) NULL,
	[userCode] [nvarchar](50) NULL,
	[fromIP] [nvarchar](50) NULL,
	[ipLoc] [nvarchar](50) NULL,
	[fromLoc] [nvarchar](250) NULL,
	[accessLoc] [nvarchar](250) NULL,
	[requestType] [nchar](10) NULL,
	[remark] [nvarchar](max) NULL,
 CONSTRAINT [PK_sys_WebLog] PRIMARY KEY CLUSTERED 
(
	[rowNum] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[wx_User]    Script Date: 2021/4/26 13:26:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[wx_User](
	[rowNum] [bigint] IDENTITY(1,1) NOT NULL,
	[rowID] [nchar](32) NOT NULL,
	[weixinUserCode] [nvarchar](50) NOT NULL,
	[nickName] [nvarchar](50) NULL,
	[userName] [nvarchar](50) NULL,
	[userSex] [nchar](1) NULL,
	[headerImg] [nvarchar](500) NULL,
	[isAttentive] [nchar](1) NULL,
	[sourceFrom] [nvarchar](20) NULL,
	[importDate] [datetime] NULL,
	[remark] [nvarchar](max) NULL,
 CONSTRAINT [PK__prj_User__F97F2AEBD667FC8F] PRIMARY KEY CLUSTERED 
(
	[weixinUserCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  View [dbo].[sv_af_AuditCenter]    Script Date: 2021/4/26 13:26:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[sv_af_AuditCenter]
AS
SELECT   dbo.af_AuditLog.*, auditUser.userName AS auditUserName, dbo.af_AuditType.auditTypeName, dbo.sbs_Dept.deptName, 
                sendUser.userName AS sendUserName
FROM      dbo.af_AuditLog INNER JOIN
                dbo.sbs_Dept ON dbo.af_AuditLog.relatedDeptCode = dbo.sbs_Dept.deptCode INNER JOIN
                dbo.rbac_User AS sendUser ON dbo.af_AuditLog.relatedUserCode = sendUser.userCode INNER JOIN
                dbo.rbac_User AS auditUser ON dbo.af_AuditLog.userCode = auditUser.userCode INNER JOIN
                dbo.af_AuditType ON dbo.af_AuditLog.auditTypeCode = dbo.af_AuditType.auditTypeCode

GO
/****** Object:  View [dbo].[sv_af_AuditFlow]    Script Date: 2021/4/26 13:26:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[sv_af_AuditFlow]
AS
SELECT   dbo.af_AuditFlow.*, dbo.sbs_Org.orgName, dbo.af_AuditType.auditTypeName
FROM      dbo.af_AuditFlow LEFT OUTER JOIN
                dbo.af_AuditType ON dbo.af_AuditFlow.auditTypeCode = dbo.af_AuditType.auditTypeCode LEFT OUTER JOIN
                dbo.sbs_Org ON dbo.af_AuditFlow.orgCode = dbo.sbs_Org.orgCode

GO
/****** Object:  View [dbo].[sv_af_AuditPostUser]    Script Date: 2021/4/26 13:26:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[sv_af_AuditPostUser]
AS
SELECT   dbo.af_AuditPostUser.*, dbo.rbac_User.userName, dbo.af_AuditPost.postName, dbo.sbs_Dept.deptName, 
                dbo.af_AuditPost.isDeptPost
FROM      dbo.af_AuditPostUser LEFT OUTER JOIN
                dbo.rbac_User ON dbo.af_AuditPostUser.userCode = dbo.rbac_User.userCode LEFT OUTER JOIN
                dbo.af_AuditPost ON dbo.af_AuditPostUser.postCode = dbo.af_AuditPost.postCode LEFT OUTER JOIN
                dbo.sbs_Dept ON dbo.af_AuditPostUser.deptCode = dbo.sbs_Dept.deptCode

GO
/****** Object:  View [dbo].[sv_rbac_Resource]    Script Date: 2021/4/26 13:26:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[sv_rbac_Resource]
AS
SELECT   dbo.rbac_Resource.*, dbo.rbac_Module.moduleName
FROM      dbo.rbac_Resource LEFT OUTER JOIN
                dbo.rbac_Module ON dbo.rbac_Resource.moduleCode = dbo.rbac_Module.moduleCode

GO
/****** Object:  View [dbo].[sv_rbac_User]    Script Date: 2021/4/26 13:26:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[sv_rbac_User]
AS
SELECT rbac_User.*,dbo.rbac_UserOrg.orgCode,dbo.rbac_UserOrg.deptCode,deptName,isLogin 
FROM dbo.rbac_User
LEFT JOIN dbo.rbac_UserOrg ON dbo.rbac_User.userCode = dbo.rbac_UserOrg.userCode
LEFT JOIN dbo.sbs_Dept ON dbo.rbac_UserOrg.deptCode = dbo.sbs_Dept.deptCode

GO
/****** Object:  View [dbo].[sv_rbac_UserOrg]    Script Date: 2021/4/26 13:26:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[sv_rbac_UserOrg]
AS
SELECT   dbo.rbac_UserOrg.*, dbo.sbs_Org.orgName, dbo.sbs_Dept.deptName
FROM      dbo.rbac_UserOrg LEFT OUTER JOIN
                dbo.sbs_Dept ON dbo.rbac_UserOrg.deptCode = dbo.sbs_Dept.deptCode LEFT OUTER JOIN
                dbo.sbs_Org ON dbo.rbac_UserOrg.orgCode = dbo.sbs_Org.orgCode

GO
/****** Object:  View [dbo].[sv_sbs_Dept]    Script Date: 2021/4/26 13:26:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[sv_sbs_Dept]
AS
SELECT   dbo.sbs_Dept.*, dept2.deptName AS upDeptName, dbo.sbs_Org.orgName
FROM      dbo.sbs_Dept LEFT OUTER JOIN
                dbo.sbs_Org ON dbo.sbs_Dept.orgCode = dbo.sbs_Org.orgCode LEFT OUTER JOIN
                dbo.sbs_Dept AS dept2 ON dept2.deptCode = dbo.sbs_Dept.upDeptCode

GO
/****** Object:  View [dbo].[sv_sbs_Empl]    Script Date: 2021/4/26 13:26:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[sv_sbs_Empl]
AS 

SELECT sbs_Empl.*,deptName,orgName,dbo.sbs_Empl.remark AS isLogin FROM dbo.sbs_Empl
LEFT JOIN dbo.sbs_Dept ON dbo.sbs_Empl.deptCode = dbo.sbs_Dept.deptCode
LEFT JOIN dbo.sbs_Org ON dbo.sbs_Dept.orgCode = dbo.sbs_Org.orgCode 


GO
/****** Object:  View [dbo].[sv_sys_BillAttach]    Script Date: 2021/4/26 13:26:38 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[sv_sys_BillAttach]
AS
SELECT   dbo.sys_BillAttach.*, dbo.rbac_User.userName AS uploadUserName
FROM      dbo.sys_BillAttach 
LEFT OUTER JOIN dbo.rbac_User ON dbo.sys_BillAttach.uploadUserCode = dbo.rbac_User.userCode
WHERE   (1 = 1)

GO
SET IDENTITY_INSERT [dbo].[af_AuditFlow] ON 

GO
INSERT [dbo].[af_AuditFlow] ([rowNum], [rowID], [flowCode], [flowName], [auditTypeCode], [isUse], [orgCode], [remark]) VALUES (1, N'680bf8b36b9842bea9e6557e24857bad', N'AF0001', N'24', NULL, N'是', N'11', NULL)
GO
INSERT [dbo].[af_AuditFlow] ([rowNum], [rowID], [flowCode], [flowName], [auditTypeCode], [isUse], [orgCode], [remark]) VALUES (4, N'fc578849a81f474fbd31d7b6f847b27c', N'AF001', N'测试审批', N'T001', N'否', N'sju', NULL)
GO
SET IDENTITY_INSERT [dbo].[af_AuditFlow] OFF
GO
SET IDENTITY_INSERT [dbo].[af_AuditFlowDept] ON 

GO
INSERT [dbo].[af_AuditFlowDept] ([rowNum], [rowID], [flowCode], [deptCode], [remark]) VALUES (1, N'861ab17df4164954b89c7911916f628a', N'AF0002', N'B002', NULL)
GO
SET IDENTITY_INSERT [dbo].[af_AuditFlowDept] OFF
GO
SET IDENTITY_INSERT [dbo].[af_AuditNode] ON 

GO
INSERT [dbo].[af_AuditNode] ([rowNum], [rowID], [flowCode], [nodeCode], [nodeJson], [nodeDesc], [nodeType], [printTag], [passType], [auditUserCodes], [auditRoleCodes], [auditPostCodes], [selectUserCodes], [selectRoleCodes], [selectPostCodes], [editFieldCodes], [isNoteInform], [isEmailInform], [remark]) VALUES (43, N'8d3b007241f1401095685ee58d46c503', N'AF001', N'2da1f08b-4ef1-8c7c-6a32-cff3bcf36e17', N'{"id":"2da1f08b-4ef1-8c7c-6a32-cff3bcf36e17","name":"","x":113,"y":183,"w":100,"h":50,"hightShow":false,"dragRadius":15,"centerX":163,"centerY":208}', NULL, N'active', N'部门经理', N'单人', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'是', N'是', NULL)
GO
INSERT [dbo].[af_AuditNode] ([rowNum], [rowID], [flowCode], [nodeCode], [nodeJson], [nodeDesc], [nodeType], [printTag], [passType], [auditUserCodes], [auditRoleCodes], [auditPostCodes], [selectUserCodes], [selectRoleCodes], [selectPostCodes], [editFieldCodes], [isNoteInform], [isEmailInform], [remark]) VALUES (41, N'8687e445fea44f6397b48d66051d3878', N'AF001', N'6817691c-4011-03b0-6663-c4d055bd6c2a', N'{"id":"6817691c-4011-03b0-6663-c4d055bd6c2a","x":25,"y":25,"radius":25,"dragRadius":12.5,"centerX":25,"centerY":25}', NULL, N'start', N'经办人', N'单人', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'是', N'是', NULL)
GO
INSERT [dbo].[af_AuditNode] ([rowNum], [rowID], [flowCode], [nodeCode], [nodeJson], [nodeDesc], [nodeType], [printTag], [passType], [auditUserCodes], [auditRoleCodes], [auditPostCodes], [selectUserCodes], [selectRoleCodes], [selectPostCodes], [editFieldCodes], [isNoteInform], [isEmailInform], [remark]) VALUES (42, N'e32f50bb2b4e400bbe2451f8780450b3', N'AF001', N'9ba38a78-4835-fa9a-a7c8-82907763d29e', N'{"id":"9ba38a78-4835-fa9a-a7c8-82907763d29e","x":25,"y":836,"radius":25,"centerX":25,"centerY":836}', NULL, N'end', NULL, N'单人', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'是', N'是', NULL)
GO
SET IDENTITY_INSERT [dbo].[af_AuditNode] OFF
GO
SET IDENTITY_INSERT [dbo].[af_AuditPost] ON 

GO
INSERT [dbo].[af_AuditPost] ([rowNum], [rowID], [postCode], [postName], [isDeptPost], [sourceFrom], [importDate], [remark]) VALUES (1, N'e90a97f3e26f4e57a2dda870c6d38347', N'001', N'校长', N'否', N'新增', CAST(0x0000AAD600B7FDFC AS DateTime), NULL)
GO
INSERT [dbo].[af_AuditPost] ([rowNum], [rowID], [postCode], [postName], [isDeptPost], [sourceFrom], [importDate], [remark]) VALUES (2, N'ffb44e56a7ad4a4297bc88a29d7e7523', N'002', N'副校长', N'否', N'新增', CAST(0x0000AAD600B80AFA AS DateTime), NULL)
GO
INSERT [dbo].[af_AuditPost] ([rowNum], [rowID], [postCode], [postName], [isDeptPost], [sourceFrom], [importDate], [remark]) VALUES (3, N'e739c61a9ef343609b6e361ff3c715b4', N'003', N'院长', N'是', N'新增', CAST(0x0000AAD600B8159B AS DateTime), NULL)
GO
INSERT [dbo].[af_AuditPost] ([rowNum], [rowID], [postCode], [postName], [isDeptPost], [sourceFrom], [importDate], [remark]) VALUES (4, N'003bef42b7c74aa4aef343ad977870d9', N'004', N'副院长', N'是', N'新增', CAST(0x0000AAD600B81EE2 AS DateTime), NULL)
GO
SET IDENTITY_INSERT [dbo].[af_AuditPost] OFF
GO
SET IDENTITY_INSERT [dbo].[af_AuditPostUser] ON 

GO
INSERT [dbo].[af_AuditPostUser] ([rowNum], [rowID], [userCode], [postCode], [orgCode], [deptCode], [sourceFrom], [importDate], [remark]) VALUES (12, N'457229e96ee342f192363d6a4af5c4f4', N'001702', N'001', N'sju', NULL, N'新增', CAST(0x0000AB43015CFE3A AS DateTime), NULL)
GO
INSERT [dbo].[af_AuditPostUser] ([rowNum], [rowID], [userCode], [postCode], [orgCode], [deptCode], [sourceFrom], [importDate], [remark]) VALUES (13, N'bebd75f99d1b4485a2cb8b15e154ec1f', N'001703', N'001', N'sju', NULL, N'新增', CAST(0x0000AB43015CFE3F AS DateTime), NULL)
GO
INSERT [dbo].[af_AuditPostUser] ([rowNum], [rowID], [userCode], [postCode], [orgCode], [deptCode], [sourceFrom], [importDate], [remark]) VALUES (11, N'd21152fdd16a4932b217dfed9f1edf42', N'sysAdmin', N'003', N'sju', N'B001', N'新增', CAST(0x0000AB43015B2F86 AS DateTime), NULL)
GO
INSERT [dbo].[af_AuditPostUser] ([rowNum], [rowID], [userCode], [postCode], [orgCode], [deptCode], [sourceFrom], [importDate], [remark]) VALUES (9, N'e85d63b38afa4fecb0b67cd4c3b76d79', N'001702', N'003', N'sju', N'B002', N'新增', CAST(0x0000AB43015B2F79 AS DateTime), NULL)
GO
INSERT [dbo].[af_AuditPostUser] ([rowNum], [rowID], [userCode], [postCode], [orgCode], [deptCode], [sourceFrom], [importDate], [remark]) VALUES (10, N'fdbbd6b7d4c5413bbb65e5c9a54feea6', N'001703', N'003', N'sju', N'B002', N'新增', CAST(0x0000AB43015B2F80 AS DateTime), NULL)
GO
SET IDENTITY_INSERT [dbo].[af_AuditPostUser] OFF
GO
SET IDENTITY_INSERT [dbo].[af_AuditType] ON 

GO
INSERT [dbo].[af_AuditType] ([rowNum], [rowID], [auditTypeCode], [auditTypeName], [isAudit], [remark]) VALUES (1, N'ddb753dd3c0a449085e27e97239089b0', N'T001', N'测试', N'是', N'1')
GO
SET IDENTITY_INSERT [dbo].[af_AuditType] OFF
GO
SET IDENTITY_INSERT [dbo].[af_NodeRelation] ON 

GO
INSERT [dbo].[af_NodeRelation] ([rowNum], [rowID], [flowCode], [startNodeCode], [endNodeCode], [passExpression], [nodeGuid], [nodeJson], [remark]) VALUES (3, N'3222de9530f449c18eb2ba8eddb5b2bf', N'AF001', N'2da1f08b-4ef1-8c7c-6a32-cff3bcf36e17', N'9ba38a78-4835-fa9a-a7c8-82907763d29e', NULL, N'0769c2e3-019b-519a-d73b-f0f47884a4d2', N'{"id":"0769c2e3-019b-519a-d73b-f0f47884a4d2","name":"","beginID":"2da1f08b-4ef1-8c7c-6a32-cff3bcf36e17","endID":"9ba38a78-4835-fa9a-a7c8-82907763d29e","x1":157.5063694267516,"y1":233,"x2":30.365610606451526,"y2":811.5825836170177,"checked":false,"routeType":0}', NULL)
GO
INSERT [dbo].[af_NodeRelation] ([rowNum], [rowID], [flowCode], [startNodeCode], [endNodeCode], [passExpression], [nodeGuid], [nodeJson], [remark]) VALUES (2, N'f8f91d1c7590441795788e52c8392b2c', N'AF001', N'6817691c-4011-03b0-6663-c4d055bd6c2a', N'2da1f08b-4ef1-8c7c-6a32-cff3bcf36e17', NULL, N'36da0b03-0834-99bf-30c9-cb6517540083', N'{"id":"36da0b03-0834-99bf-30c9-cb6517540083","name":"","beginID":"6817691c-4011-03b0-6663-c4d055bd6c2a","endID":"2da1f08b-4ef1-8c7c-6a32-cff3bcf36e17","x1":40.05230444519525,"y1":44.960664590367614,"x2":144.14754098360655,"y2":183,"checked":false,"routeType":0}', NULL)
GO
SET IDENTITY_INSERT [dbo].[af_NodeRelation] OFF
GO
SET IDENTITY_INSERT [dbo].[bks_Book] ON 

GO
INSERT [dbo].[bks_Book] ([rowNum], [rowID], [bookCode], [bookName], [isbnNO], [price], [authorName], [authorIntroduce], [bookIntroduce], [bookDirectory], [bookTypeCode], [pressCode], [pressDate], [release], [surfacePic], [isSell], [stockSum], [sellSum], [remark]) VALUES (1, N'f068ffd76441435f9cda42792ad11038', N'B001', N'测试1', N'1234', CAST(20.14 AS Decimal(18, 2)), N'王志瑞', NULL, NULL, NULL, N'BT001', N'P001', CAST(0xFE410B00 AS Date), NULL, NULL, N'否', NULL, NULL, NULL)
GO
INSERT [dbo].[bks_Book] ([rowNum], [rowID], [bookCode], [bookName], [isbnNO], [price], [authorName], [authorIntroduce], [bookIntroduce], [bookDirectory], [bookTypeCode], [pressCode], [pressDate], [release], [surfacePic], [isSell], [stockSum], [sellSum], [remark]) VALUES (2, N'bd995a9a5c474a559619ad00fa303852', N'B002', N'测试2', N'456783', CAST(40.10 AS Decimal(18, 2)), N'张琳', NULL, NULL, NULL, N'BT002', N'P002', CAST(0xFE410B00 AS Date), NULL, NULL, N'否', NULL, NULL, NULL)
GO
INSERT [dbo].[bks_Book] ([rowNum], [rowID], [bookCode], [bookName], [isbnNO], [price], [authorName], [authorIntroduce], [bookIntroduce], [bookDirectory], [bookTypeCode], [pressCode], [pressDate], [release], [surfacePic], [isSell], [stockSum], [sellSum], [remark]) VALUES (4, N'f990bc40ee934aeeb8c0cb1a0dd0d29c', N'B003', N'测试3', N'4561', CAST(35.00 AS Decimal(18, 2)), N'曹阳', NULL, NULL, NULL, N'BT001', N'P001', CAST(0xFE410B00 AS Date), NULL, NULL, N'否', NULL, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[bks_Book] OFF
GO
SET IDENTITY_INSERT [dbo].[bks_BookType] ON 

GO
INSERT [dbo].[bks_BookType] ([rowNum], [rowID], [bookTypeCode], [bookTypeName], [showOrder], [remark]) VALUES (1, N'400749f48f124d609bfc0057b3a4c13a', N'BT001', N'计算机', 1, NULL)
GO
INSERT [dbo].[bks_BookType] ([rowNum], [rowID], [bookTypeCode], [bookTypeName], [showOrder], [remark]) VALUES (4, N'216385b575bf46a48c1e904b699ae559', N'BT002', N'艺术', 2, NULL)
GO
SET IDENTITY_INSERT [dbo].[bks_BookType] OFF
GO
SET IDENTITY_INSERT [dbo].[bks_Press] ON 

GO
INSERT [dbo].[bks_Press] ([rowNum], [rowID], [pressCode], [pressName], [showOrder], [remark]) VALUES (1, N'b3c21de551ec43e4a783452162c68ec3', N'P001', N'清大大学出版社', 1, NULL)
GO
INSERT [dbo].[bks_Press] ([rowNum], [rowID], [pressCode], [pressName], [showOrder], [remark]) VALUES (2, N'faec9d88597e45578488264910dfc752', N'P002', N'机械工业出版社', 2, NULL)
GO
SET IDENTITY_INSERT [dbo].[bks_Press] OFF
GO
SET IDENTITY_INSERT [dbo].[rbac_Module] ON 

GO
INSERT [dbo].[rbac_Module] ([rowNum], [rowID], [moduleCode], [moduleName], [upModuleCode], [userType], [showOrder], [remark]) VALUES (1, N'c6d310ccc0fe4dd09726b4b0698e2471', N'admin.rbac', N'权限审批', NULL, N'后端', 1, NULL)
GO
INSERT [dbo].[rbac_Module] ([rowNum], [rowID], [moduleCode], [moduleName], [upModuleCode], [userType], [showOrder], [remark]) VALUES (2, N'bb4f5420dc2b4c03852247b5451d1c56', N'admin.sysbasic', N'系统基础数据', NULL, N'后端', 2, NULL)
GO
INSERT [dbo].[rbac_Module] ([rowNum], [rowID], [moduleCode], [moduleName], [upModuleCode], [userType], [showOrder], [remark]) VALUES (3, N'8cd6b32a61af41de969970eedeabbcd6', N'admin.system', N'系统配置', NULL, N'后端', 3, NULL)
GO
SET IDENTITY_INSERT [dbo].[rbac_Module] OFF
GO
SET IDENTITY_INSERT [dbo].[rbac_Operation] ON 

GO
INSERT [dbo].[rbac_Operation] ([rowNum], [rowID], [operationCode], [operationName], [showOrder], [remark]) VALUES (1, N'2c2bb7a7381f49a5ab4517057e07f1b5', N'Select', N'查询', 1, NULL)
GO
INSERT [dbo].[rbac_Operation] ([rowNum], [rowID], [operationCode], [operationName], [showOrder], [remark]) VALUES (2, N'c15f1ce5933d4958b9feb8ce23de9c39', N'Detail', N'详情', 2, NULL)
GO
INSERT [dbo].[rbac_Operation] ([rowNum], [rowID], [operationCode], [operationName], [showOrder], [remark]) VALUES (3, N'176d66cd60404a3b8ac6803e48b61676', N'Insert', N'新增', 3, NULL)
GO
INSERT [dbo].[rbac_Operation] ([rowNum], [rowID], [operationCode], [operationName], [showOrder], [remark]) VALUES (4, N'2be1edb2ed74421aae22eccbaef109c3', N'Update', N'更新', 4, NULL)
GO
INSERT [dbo].[rbac_Operation] ([rowNum], [rowID], [operationCode], [operationName], [showOrder], [remark]) VALUES (5, N'1030a5e20e6340bd9ddbb88df941dceb', N'Delete', N'删除', 5, NULL)
GO
INSERT [dbo].[rbac_Operation] ([rowNum], [rowID], [operationCode], [operationName], [showOrder], [remark]) VALUES (6, N'8be2580ff5db4160b3aa947cc6fe6287', N'Import', N'导入', 6, NULL)
GO
INSERT [dbo].[rbac_Operation] ([rowNum], [rowID], [operationCode], [operationName], [showOrder], [remark]) VALUES (7, N'426f457a1ad24ddaab5de8d0f1853d35', N'Export', N'导出', 7, NULL)
GO
INSERT [dbo].[rbac_Operation] ([rowNum], [rowID], [operationCode], [operationName], [showOrder], [remark]) VALUES (8, N'692d36fcd91842fe9b956638967da857', N'Print', N'打印', 8, NULL)
GO
INSERT [dbo].[rbac_Operation] ([rowNum], [rowID], [operationCode], [operationName], [showOrder], [remark]) VALUES (9, N'ea0cae92298845a29d7384fd68dcf79a', N'AllowLogin', N'允许登录', 9, NULL)
GO
INSERT [dbo].[rbac_Operation] ([rowNum], [rowID], [operationCode], [operationName], [showOrder], [remark]) VALUES (10, N'b8dd4e84e6264369a15da338cdf81d83', N'resetPW', N'重置密码', 10, NULL)
GO
INSERT [dbo].[rbac_Operation] ([rowNum], [rowID], [operationCode], [operationName], [showOrder], [remark]) VALUES (11, N'c9414f97e8c448818b3913b548dc4afb', N'Priv', N'授权', 11, NULL)
GO
INSERT [dbo].[rbac_Operation] ([rowNum], [rowID], [operationCode], [operationName], [showOrder], [remark]) VALUES (12, N'e9d2d327879a45b0ae809216c4f35d47', N'AttachUpload', N'附件上传', 12, NULL)
GO
INSERT [dbo].[rbac_Operation] ([rowNum], [rowID], [operationCode], [operationName], [showOrder], [remark]) VALUES (13, N'a0a70fe993b54c829a518846e9a8f6ae', N'AttachDownload', N'附件下载', 13, NULL)
GO
INSERT [dbo].[rbac_Operation] ([rowNum], [rowID], [operationCode], [operationName], [showOrder], [remark]) VALUES (14, N'a1d19451e32e40aa9466f1e3c0e4ed8b', N'AttachDelete', N'附件删除', 14, NULL)
GO
INSERT [dbo].[rbac_Operation] ([rowNum], [rowID], [operationCode], [operationName], [showOrder], [remark]) VALUES (15, N'27724708836942ae9c6653f5fd15a80f', N'BatchSave', N'批量保存', 18, NULL)
GO
INSERT [dbo].[rbac_Operation] ([rowNum], [rowID], [operationCode], [operationName], [showOrder], [remark]) VALUES (16, N'1b8a105cb6c84e4b8c1abea18c088ff4', N'BatchOp', N'批量操作', 19, NULL)
GO
INSERT [dbo].[rbac_Operation] ([rowNum], [rowID], [operationCode], [operationName], [showOrder], [remark]) VALUES (17, N'9bc65f0a5eee461f9fa183dbaa1ec0c5', N'Link', N'关联XXX', 20, NULL)
GO
INSERT [dbo].[rbac_Operation] ([rowNum], [rowID], [operationCode], [operationName], [showOrder], [remark]) VALUES (18, N'ff903971553d4592b2676a3a68f161c2', N'Enable', N'启用', 21, NULL)
GO
INSERT [dbo].[rbac_Operation] ([rowNum], [rowID], [operationCode], [operationName], [showOrder], [remark]) VALUES (19, N'c8e5adc64c17436ebfae0f3923296adc', N'Disable', N'禁用', 22, NULL)
GO
INSERT [dbo].[rbac_Operation] ([rowNum], [rowID], [operationCode], [operationName], [showOrder], [remark]) VALUES (20, N'fcfd047becb64c51b422f56c6619eb48', N'Confirm', N'单据确认', 23, NULL)
GO
INSERT [dbo].[rbac_Operation] ([rowNum], [rowID], [operationCode], [operationName], [showOrder], [remark]) VALUES (21, N'ab57831aa71a43d1b2b9a0d6843c5c29', N'Cancel', N'单据取消', 24, NULL)
GO
SET IDENTITY_INSERT [dbo].[rbac_Operation] OFF
GO
SET IDENTITY_INSERT [dbo].[rbac_Resource] ON 

GO
INSERT [dbo].[rbac_Resource] ([rowNum], [rowID], [resourceCode], [resourceName], [moduleCode], [isShow], [showOrder], [haveOperations], [resourceUrl], [opControl], [dataControl], [pageWidth], [pagerCount], [remark]) VALUES (1, N'36543c032be34ae6b1f0bc7b952c038d', N'af_AuditCenter', N'审批中心', N'admin.rbac', N'是', 7, N'Select,BillAudit,AuditLog,', N'/admin/af_AuditCenter/select', N'否', N'否', 0, 0, NULL)
GO
INSERT [dbo].[rbac_Resource] ([rowNum], [rowID], [resourceCode], [resourceName], [moduleCode], [isShow], [showOrder], [haveOperations], [resourceUrl], [opControl], [dataControl], [pageWidth], [pagerCount], [remark]) VALUES (2, N'675bcf61ce9e442dbba55b29e0dad455', N'af_AuditFlow', N'审批流', N'admin.rbac', N'是', 6, N'Select,Detail,Insert,Update,Delete,LinkDepts,Design,Enable,Disable,', N'/admin/af_AuditFlow/select', N'是', N'否', 0, 0, NULL)
GO
INSERT [dbo].[rbac_Resource] ([rowNum], [rowID], [resourceCode], [resourceName], [moduleCode], [isShow], [showOrder], [haveOperations], [resourceUrl], [opControl], [dataControl], [pageWidth], [pagerCount], [remark]) VALUES (3, N'76e349b8f04443748894495b59b93002', N'af_AuditPost', N'审批职务', N'admin.rbac', N'是', 3, N'Select,Detail,Insert,Update,Delete,', N'/admin/af_AuditPost/Select', N'是', N'否', 0, 0, NULL)
GO
INSERT [dbo].[rbac_Resource] ([rowNum], [rowID], [resourceCode], [resourceName], [moduleCode], [isShow], [showOrder], [haveOperations], [resourceUrl], [opControl], [dataControl], [pageWidth], [pagerCount], [remark]) VALUES (4, N'f3280a206b8c4579b76a905ee4031e74', N'af_AuditPostUse', N'审批职务任职', N'admin.rbac', N'是', 4, N'Delete,Select,BatchSave,', N'/admin/af_AuditPostUser/Select', N'是', N'否', 0, 0, N'<p>上看到了就发链接都是来看静静地上了看积分剑圣来肯</p><p>德基福利开机速度发来看几点收来路口都是减肥拉金德</p><p>是肯德基付款多少离开的时间发可但是减肥说带飞了看</p>')
GO
INSERT [dbo].[rbac_Resource] ([rowNum], [rowID], [resourceCode], [resourceName], [moduleCode], [isShow], [showOrder], [haveOperations], [resourceUrl], [opControl], [dataControl], [pageWidth], [pagerCount], [remark]) VALUES (5, N'a6bb1697f6b34f03813a21f9e767de7f', N'af_AuditType', N'审批流类型', N'admin.rbac', N'是', 5, N'Select,Detail,Insert,Update,Delete,', N'/admin/af_AuditType/select', N'是', N'否', 0, 0, NULL)
GO
INSERT [dbo].[rbac_Resource] ([rowNum], [rowID], [resourceCode], [resourceName], [moduleCode], [isShow], [showOrder], [haveOperations], [resourceUrl], [opControl], [dataControl], [pageWidth], [pagerCount], [remark]) VALUES (6, N'2b316eaf87dc41ffa4545f63c6f6f7d4', N'rbac_Module', N'系统模块', N'admin.system', N'是', 1, N'Select,Detail,Insert,Update,Delete,BatchSave,', N'/admin/rbac_Module/select', N'是', N'否', 0, 0, N'<p>看到手机福利开机都是来看福利款的健身房里看离开手机垫付老家凉快就是的甲方可绝对是浪费快点减肥里俩快递拒收福利开机都是离开房间肯德基分离</p>')
GO
INSERT [dbo].[rbac_Resource] ([rowNum], [rowID], [resourceCode], [resourceName], [moduleCode], [isShow], [showOrder], [haveOperations], [resourceUrl], [opControl], [dataControl], [pageWidth], [pagerCount], [remark]) VALUES (7, N'cbdcb07970fb45eea29caa78e4c33607', N'rbac_Resource', N'系统资源', N'admin.system', N'是', 2, N'Select,Detail,Insert,Update,Delete,BatchSave,batchShow,batchNoShow,batchAdd,batchSub,Export,', N'/admin/rbac_Resource/select', N'是', N'否', 0, 5, N'<p>sdfdfds32324324324</p><p>中文内容</p><p style="line-height: 16px;"><img src="/uEditor/dialogs/attachment/fileTypeImages/icon_pdf.gif"/><a style="font-size:12px; color:#0066cc;" href="/upload/ueditor/file/20190620/6369664803556074855914397.pdf" title="6369664803556074855914397.pdf">6369664803556074855914397.pdf</a></p><p style="line-height: 16px;"><img src="/uEditor/dialogs/attachment/fileTypeImages/icon_pdf.gif"/><a style="font-size:12px; color:#0066cc;" href="/upload/ueditor/file/20190620/6369664803556374875021093.pdf" title="6369664803556374875021093.pdf">6369664803556374875021093.pdf</a></p><p>啥决定离开房间但是客服就看电视剧来库房<br/></p><p>死了看见对方来看书进来开始加电费但是看积分</p><p><img src="/upload/ueditor/image/20190620/6369664798262372074216811.jpg" title="IMG_5316.jpg"/></p><p><img src="/upload/ueditor/image/20190620/6369664798261572023039267.jpg" title="IMG_5335.jpg"/></p><p><img src="/upload/ueditor/image/20190620/6369664798261672033533152.jpg" title="IMG_5184.jpg"/></p><p><img src="/upload/ueditor/image/20190620/6369664798289873644931328.jpg" title="IMG_5337.jpg"/></p><p><br/></p>')
GO
INSERT [dbo].[rbac_Resource] ([rowNum], [rowID], [resourceCode], [resourceName], [moduleCode], [isShow], [showOrder], [haveOperations], [resourceUrl], [opControl], [dataControl], [pageWidth], [pagerCount], [remark]) VALUES (8, N'faec821672c849e3ad35ac99e0bd6303', N'rbac_Role', N'角色管理', N'admin.rbac', N'是', 1, N'Select,Detail,Insert,Delete,Link,Update,LinkUsers,Priv,', N'/admin/rbac_Role/select', N'是', N'否', 0, 0, N'<p>收到就发空间的说法叫</p><p>是肯德基付款的时间来看<img src="/upload/ueditor/image/20190620/6369664798261672033533152.jpg" alt="6369664798261672033533152.jpg"/></p><p>收到就发神经</p><p>可是大家快放假了都时间法律角度来看分</p><p>时空的减肥可是加电费快乐暑假可但是减肥</p>')
GO
INSERT [dbo].[rbac_Resource] ([rowNum], [rowID], [resourceCode], [resourceName], [moduleCode], [isShow], [showOrder], [haveOperations], [resourceUrl], [opControl], [dataControl], [pageWidth], [pagerCount], [remark]) VALUES (9, N'18a75b26d4584bd3b489335dea3a3405', N'rbac_User', N'用户管理', N'admin.rbac', N'是', 2, N'Select,Detail,Update,Delete,resetPW,Priv,PrivList,userBatchPost,allowLogin,cancelLogin,', N'/admin/rbac_User/Select', N'是', N'否', 0, 0, N'<p>山东会计分离开的时间谁看见对方楼开始了开始减肥类库几点收就是了看积分立刻就冷疯了快睡觉分空间的说法看电视剧可但是减肥都是击飞 但是看积分了解多少发来的数据</p>')
GO
INSERT [dbo].[rbac_Resource] ([rowNum], [rowID], [resourceCode], [resourceName], [moduleCode], [isShow], [showOrder], [haveOperations], [resourceUrl], [opControl], [dataControl], [pageWidth], [pagerCount], [remark]) VALUES (10, N'f2e4128599174acba1d25915ef766960', N'sbs_Dept', N'部门', N'admin.sysbasic', N'是', 2, N'Select,Detail,Insert,Update,Delete,', N'/admin/sbs_Dept/select', N'是', N'否', 0, 0, N'<p>公共基础数据</p>')
GO
INSERT [dbo].[rbac_Resource] ([rowNum], [rowID], [resourceCode], [resourceName], [moduleCode], [isShow], [showOrder], [haveOperations], [resourceUrl], [opControl], [dataControl], [pageWidth], [pagerCount], [remark]) VALUES (11, N'814f04d2aa25407e95946e51daabf55e', N'sbs_Empl', N'员工', N'admin.sysbasic', N'是', 4, N'Select,Detail,Insert,Update,Delete,AllowLogin,', N'/admin/sbs_Empl/select', N'是', N'否', 0, 0, N'<p>公共基础数据</p>')
GO
INSERT [dbo].[rbac_Resource] ([rowNum], [rowID], [resourceCode], [resourceName], [moduleCode], [isShow], [showOrder], [haveOperations], [resourceUrl], [opControl], [dataControl], [pageWidth], [pagerCount], [remark]) VALUES (12, N'2e25420b424c4cd1a874b82baab35402', N'sbs_Org', N'组织', N'admin.sysbasic', N'是', 2, N'Select,Detail,Insert,Update,Delete,', N'/admin/sbs_Org/select', N'是', N'否', 0, 0, N'<p>公共基础数据</p>')
GO
SET IDENTITY_INSERT [dbo].[rbac_Resource] OFF
GO
SET IDENTITY_INSERT [dbo].[rbac_ResourceOp] ON 

GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (1, N'36e126e12b004f819870e40e14ba9e6d', N'rbac_Resource', N'Select', N'查询', 1)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (2, N'85562ee05bd149069ebad86fa7f2a6a3', N'rbac_Resource', N'Detail', N'详情', 2)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (3, N'abf55080fb87460ab9ea4ae9a92325e0', N'rbac_Resource', N'Insert', N'新增', 3)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (4, N'6ec59091bb4b47b6bb3981e3b3516520', N'rbac_Resource', N'Update', N'更新', 4)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (5, N'c2ae82b279a546afa82893eb86b1dcbb', N'rbac_Resource', N'Delete', N'删除', 5)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (6, N'aa6ed57b756e4eeca8fa624235cbeb23', N'rbac_Role', N'Select', N'查询', 9)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (7, N'c97210ec3069426d8caddc8d35bee0c2', N'rbac_Role', N'Detail', N'详情', 10)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (8, N'bd91b30767e349e1a388939eb10b5acb', N'rbac_Role', N'Insert', N'新增', 11)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (9, N'02d199e35b144b739e6b8fb7af627359', N'rbac_Role', N'Delete', N'删除', 12)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (10, N'e9a45d5da5884b8b926e0d9c32c3632b', N'rbac_User', N'Select', N'查询', 13)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (11, N'2d1ee1e5a6e94d90ba881037d469f2ce', N'rbac_User', N'Detail', N'详情', 14)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (12, N'3051f27070df4ce68299f25ab23df141', N'rbac_User', N'Update', N'更新', 15)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (13, N'39393e91b26e45469644aaf35ce1f5d4', N'rbac_User', N'Delete', N'删除', 16)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (14, N'5047378e2e754145ab7ae8e8ec010ca5', N'rbac_User', N'resetPW', N'重置密码', 17)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (15, N'bda18e0a41a348ddbcedd426c5932f7a', N'rbac_User', N'Priv', N'授权', 18)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (16, N'81af243a7db446f7845a0c0278ee0df9', N'sbs_Dept', N'Select', N'查询', 19)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (17, N'7229dda1da55482b839512e6801abbb3', N'sbs_Dept', N'Detail', N'详情', 20)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (18, N'38230261c8924e56bf22708b1ed7528a', N'sbs_Dept', N'Insert', N'新增', 21)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (19, N'8cf640a89b2a47928492f75e67d9d2a1', N'sbs_Dept', N'Update', N'更新', 22)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (20, N'99255e11d18a46b1b0bd7e793ba08792', N'sbs_Dept', N'Delete', N'删除', 23)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (21, N'4379bca88de842ccae981440cb990989', N'sbs_Empl', N'Select', N'查询', 26)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (22, N'bce258fb24034563a01f7b7f5cdf04a1', N'sbs_Empl', N'Detail', N'详情', 27)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (23, N'10c0c5bed7d344ed85d0d89a183ddb0e', N'sbs_Empl', N'Insert', N'新增', 28)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (24, N'dd41b1bc972c41a89b8176aaa342a8e6', N'sbs_Empl', N'Update', N'更新', 29)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (25, N'04a82923e05146fbb1711f0b767ea401', N'sbs_Empl', N'Delete', N'删除', 30)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (26, N'9ec506943858480499f38298a090c272', N'rbac_Module', N'Select', N'查询', 33)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (27, N'c58223affcb343fd98ae1f8daaf2bd3a', N'rbac_Module', N'Detail', N'详情', 34)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (28, N'907a346127804310a8627d3e8251c0a6', N'rbac_Module', N'Insert', N'新增', 35)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (29, N'155e1c465bb5431091eacc74989af566', N'rbac_Module', N'Update', N'更新', 36)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (30, N'72ee71d69c644877b97726872213b412', N'rbac_Module', N'Delete', N'删除', 37)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (31, N'ca817d07d7e941acb52386aa7c3baf8f', N'af_AuditType', N'Select', N'查询', 38)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (32, N'3ab0ab88c0fb4109b762bb57cfd3878e', N'af_AuditType', N'Detail', N'详情', 39)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (33, N'ee2a32bee99344c2b08b9479a81666c9', N'af_AuditType', N'Insert', N'新增', 40)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (34, N'98c8779c0ffe455895fc408f09f08cf2', N'af_AuditType', N'Update', N'更新', 41)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (35, N'150bb438d76143a89852001d1fb3d4cf', N'af_AuditType', N'Delete', N'删除', 42)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (36, N'9007754acda9480faf785f0e72e322fe', N'af_AuditFlow', N'Select', N'查询', 43)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (37, N'959518bd53364eaaa01dd0f88ab7fc5d', N'af_AuditFlow', N'Detail', N'详情', 44)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (38, N'259897fd69e5446a89375f7ce78e844d', N'af_AuditFlow', N'Insert', N'新增', 45)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (39, N'166ae1ee2e0e4a71855decfd30d141ac', N'af_AuditFlow', N'Update', N'更新', 46)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (40, N'abcce19ae9914ffabd2bb856caf342f6', N'sbs_Org', N'Select', N'查询', 50)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (41, N'a83faea766954e2a8f3c59c55c29707e', N'sbs_Org', N'Detail', N'详情', 51)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (42, N'f245be33c4b547a48bf64aa263bf5500', N'sbs_Org', N'Insert', N'新增', 52)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (43, N'd64b2a85cad749b7b8e1e51b3dbe0409', N'sbs_Org', N'Update', N'更新', 53)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (44, N'73da2905af484f98b2c7d57ca1d297dd', N'sbs_Org', N'Delete', N'删除', 54)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (45, N'4bc6282f2b704611b685602d615c2dc9', N'af_AuditCenter', N'Select', N'查询', 55)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (46, N'73a592294afb4403abee9bed8c79d6bc', N'sbs_Materiel', N'Select', N'查询', 56)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (47, N'18f795653c2a44f09911e16b6af85d3b', N'sbs_Materiel', N'Detail', N'详情', 57)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (48, N'155e6a87cdf746a494ab101ea93e87b2', N'sbs_Materiel', N'Insert', N'新增', 58)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (49, N'54098e3260fa45fdbf7d2b27fc228894', N'sbs_Materiel', N'Update', N'更新', 59)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (50, N'c389ddb1d4604bfb9d4a0252266a2316', N'sbs_Materiel', N'Delete', N'删除', 60)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (51, N'05c2db92a8de4e829be50886238b4e58', N'sbs_Post', N'Select', N'查询', 61)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (52, N'2777a55a5d5b4cc8a444f28cf805052b', N'sbs_Post', N'Detail', N'详情', 62)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (53, N'481b5d91f0a147ebb0a65bf5be9124c3', N'sbs_Post', N'Insert', N'新增', 63)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (54, N'79b4408e5c2c4f0f847a462e1830bd90', N'sbs_Post', N'Update', N'更新', 64)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (55, N'000863ab10bf44f18c653d90783c1b0d', N'sbs_Post', N'Delete', N'删除', 65)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (56, N'05947a0c16b8497d9c93b1ac07488705', N'sbs_UserPost', N'Select', N'查询', 66)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (57, N'4d7472be1f124566b4c8ef6b3f3aeb03', N'sbs_UserPost', N'Delete', N'删除', 70)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (58, N'f4564ece66d04fb28e98f3cf9d9aa15d', N'rbac_Role', N'Update', N'更新', 87)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (59, N'2485b379241645e6b24a55f375052746', N'rbac_Role', N'LinkUsers', N'关联用户', 88)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (60, N'f7ab7a43a3644331ba9ed16e87dc8a22', N'rbac_Role', N'Priv', N'授权', 89)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (61, N'ad34d107f5844cc585ed329a176ccd6d', N'rbac_User', N'PrivList', N'权限列表', 90)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (62, N'02036b9bf1b740e0bbf6d60c9c54e483', N'rbac_Module', N'BatchSave', N'批量保存', 91)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (63, N'48632b3ff4e645768277a75071c88d71', N'rbac_Resource', N'BatchSave', N'批量保存', 92)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (64, N'c2be6db2d8c7433380402006eac7b504', N'rbac_Resource', N'batchShow', N'批量显示', 93)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (65, N'70844aa7ed4e40c1b80010068ef3de29', N'rbac_Resource', N'batchNoShow', N'批量隐藏', 94)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (66, N'bb3c0f2270a248a0b6251f85dd1c7a0e', N'rbac_Resource', N'batchAdd', N'批量+1', 95)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (67, N'8c79d8a1967542aba2b11a58361b89d1', N'rbac_Resource', N'batchSub', N'批量-1', 96)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (68, N'9023e90c7060489b9c9be06e4ea1c13a', N'rbac_Resource', N'Export', N'导出', 97)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (69, N'3d255e0a322b4885a907273b6357c24a', N'rbac_User', N'userBatchPost', N'审批职务任职', 98)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (70, N'f576899a7ee943a7bd28df1905c60346', N'rbac_User', N'allowLogin', N'允许登录', 99)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (71, N'702e1bf57f4946719acd354fc0cf87bb', N'rbac_User', N'cancelLogin', N'取消登录', 100)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (72, N'd717ae2463aa4772baa9d1f1d6bab1dd', N'sbs_UserPost', N'BatchSave', N'批量保存', 102)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (73, N'0c1bb0abcc4246e0b2527628727e3b74', N'sbs_Empl', N'AllowLogin', N'允许登录', 104)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (74, N'75b37c3ca14646cc9272b63163d345c1', N'af_AuditFlow', N'Delete', N'删除', 105)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (75, N'cd7361e1d889486e8a102b5f400f338f', N'af_AuditFlow', N'LinkDepts', N'关联部门', 106)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (76, N'798821c1e81946a8980723688e14a0a1', N'af_AuditFlow', N'Design', N'设计', 107)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (77, N'4a0985e475704a8a904e55923bd286e5', N'af_AuditFlow', N'Enable', N'启用', 109)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (78, N'd0fa89f6746a4dd38d6931035d9b13dc', N'af_AuditFlow', N'Disable', N'禁用', 110)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (79, N'1da00163f03340ad973cb098f7fbc1f9', N'af_AuditCenter', N'BillAudit', N'单据审批', 111)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (80, N'73246cbbc27d49b2800f901ffb84b078', N'af_AuditCenter', N'AuditLog', N'审批日志', 112)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (82, N'1352d99c57e945748c7e70d1e5632cd3', N'rbac_Role', N'Link', N'关联XXX', 82)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (87, N'98387b799af5457284d6d51b440ac845', N'af_AuditPost', N'Select', N'查询', 87)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (88, N'58d3c3029d5a4c198ceda38f076b95ce', N'af_AuditPost', N'Detail', N'详情', 88)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (89, N'1b77c5525058453ab878db397adc7663', N'af_AuditPost', N'Insert', N'新增', 89)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (90, N'3e049253b6854b82a0781759466c3dad', N'af_AuditPost', N'Update', N'更新', 90)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (91, N'372f701cdfda477ca0a3d45945dfa895', N'af_AuditPost', N'Delete', N'删除', 91)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (92, N'667abada3a4c4d339f229056cb40bfbc', N'af_AuditPostUse', N'Delete', N'删除', 93)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (93, N'50ce4f0e923b42abb90bc4fc722f9756', N'af_AuditPostUse', N'Select', N'查询', 92)
GO
INSERT [dbo].[rbac_ResourceOp] ([rowNum], [rowID], [resourceCode], [operationCode], [operationName], [showOrder]) VALUES (94, N'5aad509491a74a3cace1330b0fbdffd9', N'af_AuditPostUse', N'BatchSave', N'批量保存', 94)
GO
SET IDENTITY_INSERT [dbo].[rbac_ResourceOp] OFF
GO
SET IDENTITY_INSERT [dbo].[rbac_Role] ON 

GO
INSERT [dbo].[rbac_Role] ([rowNum], [rowID], [roleCode], [roleName], [userType], [remark]) VALUES (1, N'68d1962acc714679a4618ac7449a7c41', N'R0001', N'232', NULL, N'234')
GO
INSERT [dbo].[rbac_Role] ([rowNum], [rowID], [roleCode], [roleName], [userType], [remark]) VALUES (2, N'8a4f8a15dd394c779d3338b30296e63e', N'R0002', N'121121', NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[rbac_Role] OFF
GO
SET IDENTITY_INSERT [dbo].[rbac_RolePriv] ON 

GO
INSERT [dbo].[rbac_RolePriv] ([rowNum], [rowID], [roleCode], [resourceCode], [opPriv], [dataPriv], [remark]) VALUES (13, N'9730d40a11994efaba3f56ea5877c85e', N'R0001', N'af_AuditFlow', N'Select,Detail,Insert,Update,Delete,LinkDepts,Design,Enable,Disable', N'', NULL)
GO
INSERT [dbo].[rbac_RolePriv] ([rowNum], [rowID], [roleCode], [resourceCode], [opPriv], [dataPriv], [remark]) VALUES (10, N'b256e3b4a51840a59e4b6146d159b2f0', N'R0001', N'af_AuditPost', N'Select,Detail,Insert,Update,Delete', N'', NULL)
GO
INSERT [dbo].[rbac_RolePriv] ([rowNum], [rowID], [roleCode], [resourceCode], [opPriv], [dataPriv], [remark]) VALUES (11, N'27ba33f4712840d98747456282860ff1', N'R0001', N'af_AuditPostUse', N'Delete,Select,BatchSave', N'', NULL)
GO
INSERT [dbo].[rbac_RolePriv] ([rowNum], [rowID], [roleCode], [resourceCode], [opPriv], [dataPriv], [remark]) VALUES (12, N'd0343a3dbaa04cfa8142f73977f79023', N'R0001', N'af_AuditType', N'Select,Detail,Insert,Update,Delete', N'', NULL)
GO
INSERT [dbo].[rbac_RolePriv] ([rowNum], [rowID], [roleCode], [resourceCode], [opPriv], [dataPriv], [remark]) VALUES (1, N'824b61ce33ce48e482dae5dd0a331bc1', N'R0001', N'rbac_Module', N'Select,Detail,Insert,Update,Delete,', N'', NULL)
GO
INSERT [dbo].[rbac_RolePriv] ([rowNum], [rowID], [roleCode], [resourceCode], [opPriv], [dataPriv], [remark]) VALUES (2, N'70a3352052de4520a4e31e1961e3549f', N'R0001', N'rbac_Resource', N'Select,Detail,Insert,Update,Delete,Download,Import,Export,', N'', NULL)
GO
INSERT [dbo].[rbac_RolePriv] ([rowNum], [rowID], [roleCode], [resourceCode], [opPriv], [dataPriv], [remark]) VALUES (8, N'd134c8cfb63949e1adbeb9459c788fcb', N'R0001', N'rbac_Role', N'Select,Detail,Insert,Delete,Link,Update,LinkUsers,Priv', N'', NULL)
GO
INSERT [dbo].[rbac_RolePriv] ([rowNum], [rowID], [roleCode], [resourceCode], [opPriv], [dataPriv], [remark]) VALUES (9, N'2f786a0721634418917413b3fe0ce3ce', N'R0001', N'rbac_User', N'Select,Detail,Update,Delete,resetPW,Priv,PrivList,userBatchPost,allowLogin,cancelLogin', N'', NULL)
GO
SET IDENTITY_INSERT [dbo].[rbac_RolePriv] OFF
GO
SET IDENTITY_INSERT [dbo].[rbac_RoleUser] ON 

GO
INSERT [dbo].[rbac_RoleUser] ([rowNum], [rowID], [roleCode], [userCode], [orgCode], [remark]) VALUES (1, N'69ef5caf7364420a9303601ea089d1fe', N'', N'sysAdmin', N'sju', NULL)
GO
INSERT [dbo].[rbac_RoleUser] ([rowNum], [rowID], [roleCode], [userCode], [orgCode], [remark]) VALUES (2, N'9d4cf9ba3a3447adbe6b7ab26d69bbcb', N'R0001', N'001702', N'sju', NULL)
GO
INSERT [dbo].[rbac_RoleUser] ([rowNum], [rowID], [roleCode], [userCode], [orgCode], [remark]) VALUES (3, N'e6f682b58d464101a421547e9c3a6d77', N'R0001', N'ewre', N'sju', NULL)
GO
INSERT [dbo].[rbac_RoleUser] ([rowNum], [rowID], [roleCode], [userCode], [orgCode], [remark]) VALUES (8, N'5e1b00efeea94607b6680928b71dbfba', N'R0001', N'sysAdmin', N'sju', NULL)
GO
SET IDENTITY_INSERT [dbo].[rbac_RoleUser] OFF
GO
SET IDENTITY_INSERT [dbo].[rbac_User] ON 

GO
INSERT [dbo].[rbac_User] ([rowNum], [rowID], [userCode], [userName], [password], [isAdmin], [relatedCode], [remark]) VALUES (1, N'14e39f6c908b49c5a4870064be747cfe', N'001702', N'王志瑞', N'a5a45efb9e4e64b1d1e0804eceeb0542', N'否', N'001702', NULL)
GO
INSERT [dbo].[rbac_User] ([rowNum], [rowID], [userCode], [userName], [password], [isAdmin], [relatedCode], [remark]) VALUES (2, N'8d57381f36af46a884aa3ae6712ad5e2', N'001703', N'曹阳', N'df39fa6c3288cea19096dc38d0e50617', N'否', N'ewre', NULL)
GO
INSERT [dbo].[rbac_User] ([rowNum], [rowID], [userCode], [userName], [password], [isAdmin], [relatedCode], [remark]) VALUES (3, N'16586d32d4d848b8a6f244f8b76e015b', N'sysAdmin', N'王志瑞', N'e10adc3949ba59abbe56e057f20f883e', N'是', N'sysAdmin', NULL)
GO
SET IDENTITY_INSERT [dbo].[rbac_User] OFF
GO
SET IDENTITY_INSERT [dbo].[rbac_UserOrg] ON 

GO
INSERT [dbo].[rbac_UserOrg] ([rowNum], [rowID], [userCode], [orgCode], [deptCode], [isLogin], [isAllPrj], [remark]) VALUES (1, N'14b0c0bb352d462e92879ed9784e4b9e', N'001702', N'hhu', N'C003', N'是', N'否', NULL)
GO
INSERT [dbo].[rbac_UserOrg] ([rowNum], [rowID], [userCode], [orgCode], [deptCode], [isLogin], [isAllPrj], [remark]) VALUES (2, N'de2feb01796141d789a62926e09430d6', N'001702', N'sju', N'B002', N'是', N'否', NULL)
GO
INSERT [dbo].[rbac_UserOrg] ([rowNum], [rowID], [userCode], [orgCode], [deptCode], [isLogin], [isAllPrj], [remark]) VALUES (3, N'47112f15fc594d849160d5d359d1d3ea', N'001703', N'sju', N'B001', N'是', N'否', NULL)
GO
INSERT [dbo].[rbac_UserOrg] ([rowNum], [rowID], [userCode], [orgCode], [deptCode], [isLogin], [isAllPrj], [remark]) VALUES (4, N'4ddb9cd468864514a944d20cff5b9e86', N'sysAdmin', N'hhu', N'C001', N'是', N'是', NULL)
GO
INSERT [dbo].[rbac_UserOrg] ([rowNum], [rowID], [userCode], [orgCode], [deptCode], [isLogin], [isAllPrj], [remark]) VALUES (5, N'8361d6d9e7fd49bb92e8ca92fe4e05c1', N'sysAdmin', N'sju', N'B001', N'是', N'是', NULL)
GO
SET IDENTITY_INSERT [dbo].[rbac_UserOrg] OFF
GO
SET IDENTITY_INSERT [dbo].[rbac_UserPriv] ON 

GO
INSERT [dbo].[rbac_UserPriv] ([rowNum], [rowID], [userCode], [orgCode], [resourceCode], [opPriv], [dataPriv], [remark]) VALUES (1, N'e69554876aa94a059b6b903b2f4d41fe', N'001702', N'sju', N'af_AuditFlow', N'Select,Detail,Insert,Update,Delete,LinkDepts,Design,Enable,Disable', N'', NULL)
GO
INSERT [dbo].[rbac_UserPriv] ([rowNum], [rowID], [userCode], [orgCode], [resourceCode], [opPriv], [dataPriv], [remark]) VALUES (12, N'b047931c0ace4e91b9f61f4003775048', N'001702', N'sju', N'af_AuditPostUse', N'Delete,Select,BatchSave', N'', NULL)
GO
INSERT [dbo].[rbac_UserPriv] ([rowNum], [rowID], [userCode], [orgCode], [resourceCode], [opPriv], [dataPriv], [remark]) VALUES (2, N'f303ab33c4234f5f83ac19363333a4c6', N'001702', N'sju', N'af_AuditType', N'Select,Detail,Insert,Update,Delete', N'', NULL)
GO
INSERT [dbo].[rbac_UserPriv] ([rowNum], [rowID], [userCode], [orgCode], [resourceCode], [opPriv], [dataPriv], [remark]) VALUES (3, N'ecc8c0d751c54e54aca74c6fa9d06a55', N'001702', N'sju', N'rbac_Module', N'Select,Detail,Insert,Update,Delete,BatchSave,', N'', NULL)
GO
INSERT [dbo].[rbac_UserPriv] ([rowNum], [rowID], [userCode], [orgCode], [resourceCode], [opPriv], [dataPriv], [remark]) VALUES (4, N'062c35c0e8024f099d08eff6e7410547', N'001702', N'sju', N'rbac_Resource', N'Select,Detail,Insert,Update,Delete,BatchSave,batchShow,batchNoShow,batchAdd,batchSub,Export,', N'', NULL)
GO
INSERT [dbo].[rbac_UserPriv] ([rowNum], [rowID], [userCode], [orgCode], [resourceCode], [opPriv], [dataPriv], [remark]) VALUES (5, N'ad02297dee67486f9635bb33d0129119', N'001702', N'sju', N'rbac_Role', N'Select,Detail,Insert,Delete,Link,Update,LinkUsers,Priv', N'', NULL)
GO
INSERT [dbo].[rbac_UserPriv] ([rowNum], [rowID], [userCode], [orgCode], [resourceCode], [opPriv], [dataPriv], [remark]) VALUES (6, N'cf9c42cf8bba4e8f956f0c318ecf8faa', N'001702', N'sju', N'rbac_User', N'Select,Detail,Update,Delete,resetPW,Priv,PrivList,userBatchPost,allowLogin,cancelLogin', N'', NULL)
GO
INSERT [dbo].[rbac_UserPriv] ([rowNum], [rowID], [userCode], [orgCode], [resourceCode], [opPriv], [dataPriv], [remark]) VALUES (7, N'4974c14f271340899fdd4d3fbb4d2444', N'001702', N'sju', N'sbs_UserPost', N'Select,Delete,BatchSave,', N'', NULL)
GO
INSERT [dbo].[rbac_UserPriv] ([rowNum], [rowID], [userCode], [orgCode], [resourceCode], [opPriv], [dataPriv], [remark]) VALUES (8, N'b312b646471e460cae7a9dddc73a1002', N'001703', N'sju', N'rbac_Module', N'Select,Detail,Insert,Update,Delete,', N'', NULL)
GO
INSERT [dbo].[rbac_UserPriv] ([rowNum], [rowID], [userCode], [orgCode], [resourceCode], [opPriv], [dataPriv], [remark]) VALUES (9, N'a82ea59f276a4e7b965a813f22591eb1', N'001703', N'sju', N'rbac_Resource', N'Select,Detail,Insert,Update,Delete,Download,Import,Export,', N'', NULL)
GO
INSERT [dbo].[rbac_UserPriv] ([rowNum], [rowID], [userCode], [orgCode], [resourceCode], [opPriv], [dataPriv], [remark]) VALUES (10, N'a9643ef574e14617ba36dee6141f833c', N'ewre', N'sju', N'rbac_Module', N'Select,Detail,Insert,Update,Delete,', NULL, NULL)
GO
INSERT [dbo].[rbac_UserPriv] ([rowNum], [rowID], [userCode], [orgCode], [resourceCode], [opPriv], [dataPriv], [remark]) VALUES (11, N'c77b6c8f998d4d7e9528adce55b62be4', N'ewre', N'sju', N'rbac_Resource', N'Select,Detail,Insert,Update,Delete,', NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[rbac_UserPriv] OFF
GO
SET IDENTITY_INSERT [dbo].[sbs_Dept] ON 

GO
INSERT [dbo].[sbs_Dept] ([rowNum], [rowID], [deptCode], [deptName], [deptType], [upDeptCode], [orgCode], [sourceFrom], [importDate], [remark]) VALUES (1, N'99c9b71033924652a9bbc927df2d8440', N'B001', N'市场部', NULL, NULL, N'sju', N'系统', CAST(0x0000A8B900E65C03 AS DateTime), N'12')
GO
INSERT [dbo].[sbs_Dept] ([rowNum], [rowID], [deptCode], [deptName], [deptType], [upDeptCode], [orgCode], [sourceFrom], [importDate], [remark]) VALUES (2, N'eb96eb71528749968fa088a2203159b4', N'B002', N'计算机科学与工程学院', NULL, N'B001', N'sju', N'系统', CAST(0x0000AA6C008E5AE6 AS DateTime), NULL)
GO
INSERT [dbo].[sbs_Dept] ([rowNum], [rowID], [deptCode], [deptName], [deptType], [upDeptCode], [orgCode], [sourceFrom], [importDate], [remark]) VALUES (3, N'cd7d7910a2424707bd42be17168f3832', N'C001', N'教务处', NULL, NULL, N'hhu', N'系统', CAST(0x0000AA6E0146DD4F AS DateTime), NULL)
GO
INSERT [dbo].[sbs_Dept] ([rowNum], [rowID], [deptCode], [deptName], [deptType], [upDeptCode], [orgCode], [sourceFrom], [importDate], [remark]) VALUES (4, N'd16c87edde954584a8b72c3c1b57b176', N'C002', N'计算机科学与工程学院', NULL, NULL, N'hhu', NULL, NULL, NULL)
GO
INSERT [dbo].[sbs_Dept] ([rowNum], [rowID], [deptCode], [deptName], [deptType], [upDeptCode], [orgCode], [sourceFrom], [importDate], [remark]) VALUES (5, N'9f2b399bd0144fe593af05a81be7530c', N'C003', N'财务处', NULL, NULL, N'hhu', N'系统', CAST(0x0000AA6E0146F0C7 AS DateTime), NULL)
GO
SET IDENTITY_INSERT [dbo].[sbs_Dept] OFF
GO
SET IDENTITY_INSERT [dbo].[sbs_Empl] ON 

GO
INSERT [dbo].[sbs_Empl] ([rowNum], [rowID], [emplCode], [emplName], [deptCode], [orgCode], [status], [sex], [IDCard], [phoneNumber], [sourceFrom], [importDate], [remark]) VALUES (1, N'377015af23764d9d9a03ee52853c9d39', N'001702', N'王志瑞', N'B002', N'sju', N'在职', NULL, NULL, NULL, N'系统', CAST(0x0000AA6E01485E1C AS DateTime), NULL)
GO
INSERT [dbo].[sbs_Empl] ([rowNum], [rowID], [emplCode], [emplName], [deptCode], [orgCode], [status], [sex], [IDCard], [phoneNumber], [sourceFrom], [importDate], [remark]) VALUES (2, N'92f09c0d515c465da0b5844e2b63862b', N'001703', N'曹阳', N'B001', N'sju', N'在职', NULL, NULL, NULL, N'系统', CAST(0x0000A8B900E76D50 AS DateTime), N'wer')
GO
INSERT [dbo].[sbs_Empl] ([rowNum], [rowID], [emplCode], [emplName], [deptCode], [orgCode], [status], [sex], [IDCard], [phoneNumber], [sourceFrom], [importDate], [remark]) VALUES (3, N'4a5bf7e8ab4b4e45b7708f42e6677acc', N'sysAdmin', N'王志瑞', N'B001', N'sju', N'在职', NULL, NULL, NULL, N'系统', CAST(0x0000A8BD01539FC0 AS DateTime), NULL)
GO
SET IDENTITY_INSERT [dbo].[sbs_Empl] OFF
GO
SET IDENTITY_INSERT [dbo].[sbs_Org] ON 

GO
INSERT [dbo].[sbs_Org] ([rowNum], [rowID], [orgCode], [orgName], [isDefault], [isWHOnline], [whOnlineValue], [sourceFrom], [importDate], [remark]) VALUES (1, N'f5c66f86bb254a56b2e09cecffded698', N'hhu', N'河海大学', N'否', NULL, NULL, N'系统', CAST(0x0000AA6C008D5F04 AS DateTime), NULL)
GO
INSERT [dbo].[sbs_Org] ([rowNum], [rowID], [orgCode], [orgName], [isDefault], [isWHOnline], [whOnlineValue], [sourceFrom], [importDate], [remark]) VALUES (2, N'5ccd47bdfd644a8c8ea5ea0efa0a2808', N'sju', N'三江学院', N'是', NULL, NULL, NULL, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[sbs_Org] OFF
GO
SET IDENTITY_INSERT [dbo].[sys_BillAttach] ON 

GO
INSERT [dbo].[sys_BillAttach] ([rowNum], [rowID], [attachCode], [relatedResourceCode], [relatedKeyCode], [relatedDetailNo], [attachUrl], [prieviewUrl], [attachName], [attachLength], [attachMIME], [attachContent], [uploadUserCode], [uploadDateTime], [remark]) VALUES (1, N'766af3c812b14cd3a163998fb57483bb', N'032ab727-c97b-4267-816a-c6e836e49af4', N'rbac_Resource', N'sbs_Dept', NULL, N'\upload\bill\rbac_Resource\2019\6\20190620112408期末测试卷2.docx', N'upload\preview\rbac_Resource\2019\0620110824\index.html', N'期末测试卷2.docx', 753622, N'application/vnd.openxmlformats-officedocument.wordprocessingml.document', NULL, N'sysAdmin', CAST(0x0000AA7200BBE72A AS DateTime), NULL)
GO
INSERT [dbo].[sys_BillAttach] ([rowNum], [rowID], [attachCode], [relatedResourceCode], [relatedKeyCode], [relatedDetailNo], [attachUrl], [prieviewUrl], [attachName], [attachLength], [attachMIME], [attachContent], [uploadUserCode], [uploadDateTime], [remark]) VALUES (2, N'0deb8d0875104582a16ea2776a9e7af0', N'208999d9-049c-4c1f-a5af-420a245e4b65', N'rbac_Resource', N'rbac_Role', NULL, N'\upload\bill\rbac_Resource\2019\6\20190620111227debug.log', N':\Projecting\_mvcCore开发框架 三江服务器\code\ruiWebsite\wwwroot\upload\bill\rbac_Resource\2019\6\20190620111227debug.log', N'debug.log', 1325763, N'application/octet-stream', NULL, N'sysAdmin', CAST(0x0000AA7200B8B25A AS DateTime), NULL)
GO
INSERT [dbo].[sys_BillAttach] ([rowNum], [rowID], [attachCode], [relatedResourceCode], [relatedKeyCode], [relatedDetailNo], [attachUrl], [prieviewUrl], [attachName], [attachLength], [attachMIME], [attachContent], [uploadUserCode], [uploadDateTime], [remark]) VALUES (3, N'5cdacffec3c9451c9aa4de08442b4de0', N'217f500d-05c2-422a-a5b4-13c725820b49', N'rbac_Resource', N'rbac_Resource', NULL, N'\upload\bill\rbac_Resource\2019\6\20190620111841MxCrashCatch.dll', N':\Projecting\_mvcCore开发框架 三江服务器\code\ruiWebsite\wwwroot\upload\bill\rbac_Resource\2019\6\20190620111841MxCrashCatch.dll', N'MxCrashCatch.dll', 177976, N'application/x-msdownload', NULL, N'sysAdmin', CAST(0x0000AA7200BA6915 AS DateTime), NULL)
GO
INSERT [dbo].[sys_BillAttach] ([rowNum], [rowID], [attachCode], [relatedResourceCode], [relatedKeyCode], [relatedDetailNo], [attachUrl], [prieviewUrl], [attachName], [attachLength], [attachMIME], [attachContent], [uploadUserCode], [uploadDateTime], [remark]) VALUES (4, N'21e62c1108d64c2d96521aabbf4f8909', N'2ad8a35e-6e52-40f5-9014-3ec5f6a3711a', N'rbac_Resource', N'rbac_Role', NULL, N'\upload\bill\rbac_Resource\2019\6\20190620101558default.dat', N':\Projecting\_mvcCore开发框架 三江服务器\code\ruiWebsite\wwwroot\upload\bill\rbac_Resource\2019\6\20190620101558default.dat', N'default.dat', 437248, N'application/octet-stream', NULL, N'sysAdmin', CAST(0x0000AA7200A932DB AS DateTime), N'2')
GO
INSERT [dbo].[sys_BillAttach] ([rowNum], [rowID], [attachCode], [relatedResourceCode], [relatedKeyCode], [relatedDetailNo], [attachUrl], [prieviewUrl], [attachName], [attachLength], [attachMIME], [attachContent], [uploadUserCode], [uploadDateTime], [remark]) VALUES (5, N'9fb75b09799744c2a687203e50f33d14', N'2de73e53-d774-4e65-a4ee-943437c607b7', N'rbac_Resource', N'rbac_Role', NULL, N'\upload\bill\rbac_Resource\2019\6\20190620101532debug.log', N':\Projecting\_mvcCore开发框架 三江服务器\code\ruiWebsite\wwwroot\upload\bill\rbac_Resource\2019\6\20190620101532debug.log', N'debug.log', 1325763, N'application/octet-stream', NULL, N'sysAdmin', CAST(0x0000AA7200A92643 AS DateTime), N'3')
GO
INSERT [dbo].[sys_BillAttach] ([rowNum], [rowID], [attachCode], [relatedResourceCode], [relatedKeyCode], [relatedDetailNo], [attachUrl], [prieviewUrl], [attachName], [attachLength], [attachMIME], [attachContent], [uploadUserCode], [uploadDateTime], [remark]) VALUES (19, N'c19164ea8aed408da9cb94c2da3df1df', N'2fcc059671294ce0b91c5ca181376919', N'rbac_Resource', N'rbac_Role', NULL, N'upload/bill/rbac_Resource/2020/1//20200106205457marvin.cnblogs.js', N'upload/bill/rbac_Resource/2020/1//20200106205457marvin.cnblogs.js', N'marvin.cnblogs.js', 2442, N'text/javascript', NULL, N'sysAdmin', CAST(0x0000AB3A0158AF4A AS DateTime), NULL)
GO
INSERT [dbo].[sys_BillAttach] ([rowNum], [rowID], [attachCode], [relatedResourceCode], [relatedKeyCode], [relatedDetailNo], [attachUrl], [prieviewUrl], [attachName], [attachLength], [attachMIME], [attachContent], [uploadUserCode], [uploadDateTime], [remark]) VALUES (6, N'cc67fb2fd0e445d2a3f770db4f627346', N'36278fba-f3ef-4450-8860-429c37970c3d', N'rbac_Resource', N'rbac_Module', NULL, N'\upload\bill\rbac_Resource\2019\7\20190719184209X-admin-v2.2.zip', N':\Projecting\2019 CoreMVC开发框架 - 三江服务器\code\ruiWebsite\wwwroot\upload\bill\rbac_Resource\2019\7\20190719184209X-admin-v2.2.zip', N'X-admin-v2.2.zip', 997203, N'application/zip', NULL, N'sysAdmin', CAST(0x0000AA8F01343566 AS DateTime), NULL)
GO
INSERT [dbo].[sys_BillAttach] ([rowNum], [rowID], [attachCode], [relatedResourceCode], [relatedKeyCode], [relatedDetailNo], [attachUrl], [prieviewUrl], [attachName], [attachLength], [attachMIME], [attachContent], [uploadUserCode], [uploadDateTime], [remark]) VALUES (7, N'266b23802e8042af8d87e6f45c8f326e', N'38f23dfd-9c29-4807-9df0-8439ce4be69d', N'rbac_Resource', N'rbac_User', NULL, N'\upload\bill\rbac_Resource\2019\6\20190620112125期末测试卷2.docx', N'upload\preview\rbac_Resource\2019\0620112521\index.html', N'期末测试卷2.docx', 753622, N'application/vnd.openxmlformats-officedocument.wordprocessingml.document', NULL, N'sysAdmin', CAST(0x0000AA7200BB28AE AS DateTime), NULL)
GO
INSERT [dbo].[sys_BillAttach] ([rowNum], [rowID], [attachCode], [relatedResourceCode], [relatedKeyCode], [relatedDetailNo], [attachUrl], [prieviewUrl], [attachName], [attachLength], [attachMIME], [attachContent], [uploadUserCode], [uploadDateTime], [remark]) VALUES (8, N'd9dd78e595c8429582d61cd12848f854', N'41da3a80-9fd8-4770-a576-5f8f40fda900', N'rbac_Resource', N'rbac_Role', NULL, N'\upload\bill\rbac_Resource\2019\6\20190620105351default.dat', N':\Projecting\_mvcCore开发框架 三江服务器\code\ruiWebsite\wwwroot\upload\bill\rbac_Resource\2019\6\20190620105351default.dat', N'default.dat', 437248, N'application/octet-stream', NULL, N'sysAdmin', CAST(0x0000AA7200B39603 AS DateTime), NULL)
GO
INSERT [dbo].[sys_BillAttach] ([rowNum], [rowID], [attachCode], [relatedResourceCode], [relatedKeyCode], [relatedDetailNo], [attachUrl], [prieviewUrl], [attachName], [attachLength], [attachMIME], [attachContent], [uploadUserCode], [uploadDateTime], [remark]) VALUES (9, N'b2d94bf225e248e28810dc0122fa0669', N'42f9179e-87f9-414b-9e26-3bd9533bf75b', N'rbac_Resource', N'rbac_Resource', NULL, N'\upload\bill\rbac_Resource\2019\6\20190620111702Maxthon.dll', N':\Projecting\_mvcCore开发框架 三江服务器\code\ruiWebsite\wwwroot\upload\bill\rbac_Resource\2019\6\20190620111702Maxthon.dll', N'Maxthon.dll', 4021160, N'application/x-msdownload', NULL, N'sysAdmin', CAST(0x0000AA7200B9F4A4 AS DateTime), NULL)
GO
INSERT [dbo].[sys_BillAttach] ([rowNum], [rowID], [attachCode], [relatedResourceCode], [relatedKeyCode], [relatedDetailNo], [attachUrl], [prieviewUrl], [attachName], [attachLength], [attachMIME], [attachContent], [uploadUserCode], [uploadDateTime], [remark]) VALUES (10, N'a72d1508fcda4f8698e7351ae49f08cd', N'4bfce0cd-f09a-4b64-9ee7-25ca7ab07907', N'rbac_Resource', N'rbac_Role', NULL, N'\upload\bill\rbac_Resource\2019\6\20190620101715Maxzlib.dll', N':\Projecting\_mvcCore开发框架 三江服务器\code\ruiWebsite\wwwroot\upload\bill\rbac_Resource\2019\6\20190620101715Maxzlib.dll', N'Maxzlib.dll', 258944, N'application/x-msdownload', NULL, N'sysAdmin', CAST(0x0000AA7200A98918 AS DateTime), N'45')
GO
INSERT [dbo].[sys_BillAttach] ([rowNum], [rowID], [attachCode], [relatedResourceCode], [relatedKeyCode], [relatedDetailNo], [attachUrl], [prieviewUrl], [attachName], [attachLength], [attachMIME], [attachContent], [uploadUserCode], [uploadDateTime], [remark]) VALUES (11, N'9db09ff61309488c8e284d8fc4f57a22', N'50f643e6-a4d3-432c-be4a-25e42aaa1f1e', N'rbac_Resource', N'rbac_Role', NULL, N'\upload\bill\rbac_Resource\2019\6\20190620101605Maxthon.dll', N':\Projecting\_mvcCore开发框架 三江服务器\code\ruiWebsite\wwwroot\upload\bill\rbac_Resource\2019\6\20190620101605Maxthon.dll', N'Maxthon.dll', 4021160, N'application/x-msdownload', NULL, N'sysAdmin', CAST(0x0000AA7200A93F90 AS DateTime), N'1')
GO
INSERT [dbo].[sys_BillAttach] ([rowNum], [rowID], [attachCode], [relatedResourceCode], [relatedKeyCode], [relatedDetailNo], [attachUrl], [prieviewUrl], [attachName], [attachLength], [attachMIME], [attachContent], [uploadUserCode], [uploadDateTime], [remark]) VALUES (12, N'cd9bbabf79ec4760b3e1c345addaae6d', N'71e5f237-036a-456d-b968-328e8f884790', N'rbac_Resource', N'rbac_Module', NULL, N'\upload\bill\rbac_Resource\2019\6\20190620112502期末测试卷2.docx', N'upload\preview\rbac_Resource\2019\0620110225\index.html', N'期末测试卷2.docx', 753622, N'application/vnd.openxmlformats-officedocument.wordprocessingml.document', NULL, N'sysAdmin', CAST(0x0000AA7200BC26ED AS DateTime), NULL)
GO
INSERT [dbo].[sys_BillAttach] ([rowNum], [rowID], [attachCode], [relatedResourceCode], [relatedKeyCode], [relatedDetailNo], [attachUrl], [prieviewUrl], [attachName], [attachLength], [attachMIME], [attachContent], [uploadUserCode], [uploadDateTime], [remark]) VALUES (13, N'd4cc276b2c2e47eb83d2f6dbf5bbaeea', N'8d2bcb93-55d9-43a2-8b83-b30b2f79fce1', N'rbac_Resource', N'rbac_Module', NULL, N'\upload\bill\rbac_Resource\2019\7\2019071918414320190715测试.docx', NULL, N'20190715测试.docx', 336819, N'application/vnd.openxmlformats-officedocument.wordprocessingml.document', NULL, N'sysAdmin', CAST(0x0000AA8F013417A3 AS DateTime), NULL)
GO
INSERT [dbo].[sys_BillAttach] ([rowNum], [rowID], [attachCode], [relatedResourceCode], [relatedKeyCode], [relatedDetailNo], [attachUrl], [prieviewUrl], [attachName], [attachLength], [attachMIME], [attachContent], [uploadUserCode], [uploadDateTime], [remark]) VALUES (14, N'804cb0f78525440db801cf57accf39fd', N'b2b61cf0-95ee-4b45-bb0b-e2401dadd381', N'rbac_Resource', N'rbac_User', NULL, N'\upload\bill\rbac_Resource\2019\6\20190620112054期末测试卷2.docx', N'upload\preview\rbac_Resource\2019\0620115420\index.html', N'期末测试卷2.docx', 753622, N'application/vnd.openxmlformats-officedocument.wordprocessingml.document', NULL, N'sysAdmin', CAST(0x0000AA7200BB04C1 AS DateTime), NULL)
GO
INSERT [dbo].[sys_BillAttach] ([rowNum], [rowID], [attachCode], [relatedResourceCode], [relatedKeyCode], [relatedDetailNo], [attachUrl], [prieviewUrl], [attachName], [attachLength], [attachMIME], [attachContent], [uploadUserCode], [uploadDateTime], [remark]) VALUES (15, N'a400115f359c40e88c943d40db15433a', N'bed5af45-fb08-438e-8645-0f1d5747a837', N'rbac_Resource', N'sbs_Org', NULL, N'\upload\bill\rbac_Resource\2019\6\20190620112820default.dat', N':\Projecting\_mvcCore开发框架 三江服务器\code\ruiWebsite\wwwroot\upload\bill\rbac_Resource\2019\6\20190620112820default.dat', N'default.dat', 437248, N'application/octet-stream', NULL, N'sysAdmin', CAST(0x0000AA7200BD0F7A AS DateTime), NULL)
GO
INSERT [dbo].[sys_BillAttach] ([rowNum], [rowID], [attachCode], [relatedResourceCode], [relatedKeyCode], [relatedDetailNo], [attachUrl], [prieviewUrl], [attachName], [attachLength], [attachMIME], [attachContent], [uploadUserCode], [uploadDateTime], [remark]) VALUES (16, N'3cb675b7b0a24960b05b06a008af6404', N'c9ed2e3e-df59-4964-97e1-3aa3b9641aa8', N'rbac_Resource', N'rbac_Role', NULL, N'\upload\bill\rbac_Resource\2019\6\20190620110857default.dat', N':\Projecting\_mvcCore开发框架 三江服务器\code\ruiWebsite\wwwroot\upload\bill\rbac_Resource\2019\6\20190620110857default.dat', N'default.dat', 437248, N'application/octet-stream', NULL, N'sysAdmin', CAST(0x0000AA7200B7BC83 AS DateTime), NULL)
GO
INSERT [dbo].[sys_BillAttach] ([rowNum], [rowID], [attachCode], [relatedResourceCode], [relatedKeyCode], [relatedDetailNo], [attachUrl], [prieviewUrl], [attachName], [attachLength], [attachMIME], [attachContent], [uploadUserCode], [uploadDateTime], [remark]) VALUES (17, N'342811849fae4323835aaeabd06ac9a7', N'ca4774b3-1bfd-4637-9c03-90e9733d5b68', N'rbac_Resource', N'rbac_Resource', NULL, N'\upload\bill\rbac_Resource\2019\6\20190620111643default.dat', N':\Projecting\_mvcCore开发框架 三江服务器\code\ruiWebsite\wwwroot\upload\bill\rbac_Resource\2019\6\20190620111643default.dat', N'default.dat', 437248, N'application/octet-stream', NULL, N'sysAdmin', CAST(0x0000AA7200B9DDAA AS DateTime), NULL)
GO
INSERT [dbo].[sys_BillAttach] ([rowNum], [rowID], [attachCode], [relatedResourceCode], [relatedKeyCode], [relatedDetailNo], [attachUrl], [prieviewUrl], [attachName], [attachLength], [attachMIME], [attachContent], [uploadUserCode], [uploadDateTime], [remark]) VALUES (18, N'0dc90daa00af44d6a80862eb27bca72a', N'ec5490b6-8394-4e35-af5e-5587756803c8', N'rbac_Resource', N'rbac_Resource', NULL, N'\upload\bill\rbac_Resource\2019\6\20190620111740default.dat', N':\Projecting\_mvcCore开发框架 三江服务器\code\ruiWebsite\wwwroot\upload\bill\rbac_Resource\2019\6\20190620111740default.dat', N'default.dat', 437248, N'application/octet-stream', NULL, N'sysAdmin', CAST(0x0000AA7200BA20AB AS DateTime), NULL)
GO
SET IDENTITY_INSERT [dbo].[sys_BillAttach] OFF
GO
SET IDENTITY_INSERT [dbo].[sys_Column] ON 

GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (1, N'6a486a77cdf043ac99955f5d6a5bdae2', N'af_AuditCenter', N'auditResult', N'审批结果', 1, 18, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (2, N'9f5955d606634161a2c3084ca6838830', N'af_AuditCenter', N'auditUserName', N'审批人', 1, 21, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (3, N'2bfeb89fd01842ef93a38ac3fe149764', N'af_AuditCenter', N'createDate', N'创建时间', 1, 13, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (4, N'00cd559bf0ea4b4f8679186c0f7fa522', N'af_AuditCenter', N'deptName', N'所属部门', 1, 25, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (5, N'43a7184330c54a63ba6a1a4aa1971bc8', N'af_AuditCenter', N'flowCode', N'flowCode', 0, 9, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (6, N'a78eaab47d334c488d6c0d39e7498827', N'af_AuditCenter', N'fromType', N'fromType', 0, 15, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (7, N'9f1438ad536f43af83bd6c6d17bff088', N'af_AuditCenter', N'nodeCode', N'nodeCode', 0, 11, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (8, N'81a5884cde814a9293b50965f282fada', N'af_AuditCenter', N'passType', N'通过类型', 1, 14, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (9, N'5139857861f746a4b8b268196ed141c8', N'af_AuditCenter', N'printTag', N'记录类型', 1, 24, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (10, N'1983a93a8c7d427a88c2c693399b04fc', N'af_AuditCenter', N'recordType', N'recordType', 0, 16, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (11, N'6c04938e4c104dde9892b1ffabfb48e6', N'af_AuditCenter', N'relatedDeptCode', N'relatedDeptCode', 0, 7, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (12, N'd4510227c5a942f39a94f523fc0596d4', N'af_AuditCenter', N'relatedKeyCode', N'单据编号', 1, 23, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (13, N'84f3c344174b4d1dad38dd0950782ea3', N'af_AuditCenter', N'relatedRowID', N'relatedRowID', 0, 5, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (14, N'0f5cae8d2189461fb253644ccf812bd2', N'af_AuditCenter', N'relatedUserCode', N'relatedUserCode', 0, 6, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (15, N'e86d1f1f45164a10af75adb49a2f0e0d', N'af_AuditCenter', N'remark', N'remark', 0, 20, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (16, N'9fd17d5c3a374665ba901f2d0fe84362', N'af_AuditCenter', N'rowID', N'rowID', 0, 4, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (17, N'8dd9ecbdc1a84a14ae16c615c7b35f95', N'af_AuditCenter', N'sendUserName', N'经办人', 1, 26, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (18, N'75e22f8652174c6a89f93c2ac66ee8b1', N'af_AuditCenter', N'startNodeCode', N'startNodeCode', 0, 10, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (19, N'99ee6cd8e0994622bf5fd202ad5abe3d', N'af_AuditCenter', N'userCode', N'userCode', 0, 12, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (20, N'e4983bff825549489303d8078bd721ee', N'af_AuditCenter', N'操作', N'操作', 1, 100, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (21, N'5bb40953b65d4746b9b62024dd984aa9', N'af_AuditCenter', N'序号', N'序号', 1, 2, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (22, N'2f66d7465bbc44c58cab212d1f787b6d', N'af_AuditFlow', N'auditTypeName', N'所属类型', 1, 12, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (23, N'8d30a7194ff746109949572d438b4fa2', N'af_AuditFlow', N'flowCode', N'审批流编码', 1, 5, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (24, N'be852878386d4fc78f0030538aaf1714', N'af_AuditFlow', N'flowName', N'审批流名称', 1, 6, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (25, N'849d083983a94bdb9f0a0d2e689be426', N'af_AuditFlow', N'isUse', N'是否启用', 1, 7, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (26, N'faccae8bd0784107a17c2eeb1522f2ce', N'af_AuditFlow', N'orgName', N'所属组织', 1, 10, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (27, N'de5d90df16a14fa096d23f9b94f6dd44', N'af_AuditFlow', N'remark', N'备注', 1, 9, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (28, N'9f9733ecff6842c291640a93dba50c12', N'af_AuditFlow', N'操作', N'操作', 1, 100, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (30, N'3eb5b642e6ea47f2907f3056facd6f7f', N'af_AuditPost', N'importDate', N'导入时间', 1, 9, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (31, N'63327991a14144e88f8a45a2fce3c534', N'af_AuditPost', N'isDeptPost', N'是否部门职务', 1, 7, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (32, N'02b2ba3f0734491dad6ef58c39645549', N'af_AuditPost', N'postCode', N'职务编号', 1, 5, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (33, N'cd582180d0a94387a3d51a588a907de9', N'af_AuditPost', N'postName', N'职务名称', 1, 6, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (34, N'c2c3c6e6962c49218025d1061e6f3a75', N'af_AuditPost', N'remark', N'备注', 1, 10, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (35, N'5781902cbf30447b9c48ac64e3f20a7c', N'af_AuditPost', N'rowID', N'rowID', 0, 4, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (36, N'8e0f5aec9f534edb89432ad7930a78ec', N'af_AuditPost', N'sourceFrom', N'来源', 1, 8, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (37, N'd830de02e72a46cab4387a45127798c4', N'af_AuditPost', N'操作', N'操作', 1, 100, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (38, N'0e57bc784f6b44cb90cfac4513edb83c', N'af_AuditPost', N'序号', N'序号', 1, 1, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (39, N'3e4b93e48ff84df39fea60a631705895', N'af_AuditPostUser', N'deptCode', N'deptCode', 0, 6, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (40, N'cca2add9ca7f44e2994e9f353fad7452', N'af_AuditPostUser', N'deptName', N'任职部门', 1, 8, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (41, N'6c03bd55b0eb445abe769e05bf8ac358', N'af_AuditPostUser', N'importDate', N'importDate', 0, 10, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (42, N'e0081dddd843405ebf3728cd667f9a06', N'af_AuditPostUser', N'isDeptPost', N'是否部分职务', 1, 7, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (43, N'8f4f37ac56564b58a5d5553e960a2047', N'af_AuditPostUser', N'postName', N'职务名', 1, 6, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (44, N'6e8f79f6e76e469ca63bfceff6d31b87', N'af_AuditPostUser', N'remark', N'备注', 0, 11, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (45, N'9a31b4fe8d9f4dcc8ac41f0f9ed43532', N'af_AuditPostUser', N'rowID', N'rowID', 0, 4, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (46, N'e104c64d5ca240d9a00632f4b80732a4', N'af_AuditPostUser', N'sourceFrom', N'sourceFrom', 0, 9, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (47, N'0eab1d614bdc4352b5d2903a99b84c1b', N'af_AuditPostUser', N'userCode', N'登录账号', 1, 5, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (48, N'06066a4d83ee4cad8ae925f89e7c0344', N'af_AuditPostUser', N'userName', N'姓名', 1, 5, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (49, N'64eaa3542d5a4356b7cc4451108fe095', N'af_AuditPostUser', N'操作', N'操作', 1, 101, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (50, N'c04614f9e5b34dafa42a24ebf8709641', N'af_AuditPostUser', N'序号', N'序号', 1, 1, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (51, N'1fbaf1ee5763488aaaf2f8c1d163c7d5', N'af_AuditType', N'auditTypeCode', N'类型编号', 1, 5, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (52, N'579a2e312e424241a1522163984172f0', N'af_AuditType', N'auditTypeName', N'类型名称', 1, 6, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (53, N'dd9205db19984dfda3cc923b57a1f990', N'af_AuditType', N'isAudit', N'是否启用', 1, 7, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (54, N'043aea0895e748188bc81603bd89e9de', N'af_AuditType', N'remark', N'备注', 1, 8, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (55, N'c38d7f941f06434fa1031a4444889346', N'af_AuditType', N'rowID', N'rowID', 0, 4, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (56, N'96e26c643d1a4ec99ca2f8a27cacc164', N'af_AuditType', N'操作', N'操作', 1, 100, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (57, N'61669d5e446e43e8b119c3be27c1ede3', N'af_AuditType', N'序号', N'序号', 1, 2, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (58, N'8ba21af9e99d42969dc3b19e5a4390f1', N'rbac_Module', N'moduleCode', N'模块编号', 1, 5, 1, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (59, N'5b84a3c2e5cf42df870ca53131ca278e', N'rbac_Module', N'moduleName', N'模块名称', 1, 6, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (60, N'605735a833834bf9ba86a592fc037e11', N'rbac_Module', N'remark', N'remark', 0, 10, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (61, N'ab1b35bbc8d840fda20889fd5e66373f', N'rbac_Module', N'showOrder', N'显示顺序', 1, 9, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (62, N'73611b6b77884f03a2a5490756623be3', N'rbac_Module', N'userType', N'用户类型', 1, 8, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (63, N'55ce241d253340e88d5ebeea908e9efa', N'rbac_Module', N'操作', N'操作', 1, 100, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (64, N'9d4e60371f0045cdadcfd5417e54bab9', N'rbac_Module', N'序号', N'序号', 1, 2, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (65, N'fba78e25ed4f413886bc819001bb6ab3', N'rbac_Resource', N'dataControl', N'数据权限', 1, 12, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (66, N'16d069ccf45440948f8e54a77cb37f50', N'rbac_Resource', N'isShow', N'是否显示', 1, 7, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (67, N'0f492740c1294faba373990067d0223d', N'rbac_Resource', N'moduleName', N'所属模块', 1, 14, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (68, N'50fe21f1361247f9a742bbb9eefe2709', N'rbac_Resource', N'opControl', N'权限控制', 1, 11, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (69, N'ab2275e112014c75a101181866e230d7', N'rbac_Resource', N'pagerCount', N'分页大小', 1, 16, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (70, N'25cd0b0ef42e4af89c7dacc07d7c0538', N'rbac_Resource', N'pageWidth', N'页面宽度', 1, 15, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (71, N'404767a7c5be49b2a1837299946b24b0', N'rbac_Resource', N'resourceCode', N'资源编号', 1, 5, 1, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (72, N'80226eb36878471984957f84f9b0541f', N'rbac_Resource', N'resourceName', N'资源名称', 1, 6, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (249, N'd1ad7362566a4ea98ca5aca0f7251bc4', N'rbac_Resource', N'resourceUrl', N'访问路径', 1, 100, 0, 100, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (73, N'c6acf5a14f4a413a88c19873fbff1237', N'rbac_Resource', N'showOrder', N'排序号', 1, 8, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (248, N'a770c3e1f40a4783b7605315c5700bdc', N'rbac_Resource', N'操作', N'操作', 1, 2, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (247, N'3e47767d509e49a49e1ecf2b17deb8b4', N'rbac_Resource', N'序号', N'序号', 1, 1, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (76, N'0a115c14d5e344848e402cdcc6aac169', N'rbac_ResourceOp', N'operationCode', N'操作编码', 1, 6, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (77, N'823e11922db54aa9a4fe740558e6bb59', N'rbac_ResourceOp', N'operationName', N'操作名称', 1, 7, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (78, N'a11b14f22df34e4cb45b58af231effec', N'rbac_ResourceOp', N'resourceCode', N'resourceCode', 0, 5, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (80, N'2ebb217a140e409594f27521ae89d296', N'rbac_ResourceOp', N'showOrder', N'排序号', 1, 8, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (81, N'fcf7a87b72ff4be58044dd2bec7ec2ad', N'rbac_ResourceOp', N'操作', N'操作', 1, 10, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (82, N'76c919c9c66448dd9ce7839d5eb0f7f2', N'rbac_ResourceOp', N'序号', N'序号', 1, 1, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (83, N'd71158e6005c4519af103435f54df4ea', N'rbac_Role', N'remark', N'备注', 1, 8, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (84, N'59ad79d6a2eb455093305b22e66ef9f5', N'rbac_Role', N'roleCode', N'角色编号', 1, 5, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (85, N'384de5744e434bc5add52582cf404108', N'rbac_Role', N'roleName', N'角色名称', 1, 6, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (86, N'cb73c2ed867347fc809250b301d4aff4', N'rbac_Role', N'rowID', N'rowID', 0, 4, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (87, N'd3e8656856774a4fac5c8d895ede0b47', N'rbac_Role', N'userType', N'角色类型', 0, 7, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (88, N'96c4c95df35846f78d3894852900a052', N'rbac_Role', N'操作', N'操作', 1, 100, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (89, N'92a1cf485d504da3a79dde521cf588cd', N'rbac_Role', N'序号', N'序号', 1, 2, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (90, N'740c5e57d11d455686798a86854a67f8', N'rbac_User', N'deptCode', N'deptCode', 0, 6, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (91, N'e2411177a20346f8a67e36a80eb09fe1', N'rbac_User', N'deptName', N'所属部门', 1, 9, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (92, N'9a7820ceef6c4f778fe60840d4b97700', N'rbac_User', N'isAdmin', N'是否超管', 1, 8, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (93, N'6bbfa85758984de59cb31fcf84d0978c', N'rbac_User', N'isAllPrj', N'isAllPrj', 0, 5, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (94, N'ea1c6b317a0648a2b193dc2cdbd2eb6a', N'rbac_User', N'isLogin', N'可登陆', 1, 7, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (95, N'9541e5288cda41d79d6dfde12b635c08', N'rbac_User', N'orgCode', N'orgCode', 0, 7, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (96, N'6e9e82852afa4d9792baa190b6befd91', N'rbac_User', N'password', N'password', 0, 4, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (97, N'7d1b46497a184120a913f9e4910ee947', N'rbac_User', N'relatedCode', N'关联职工号', 1, 8, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (98, N'4a2006149edb4d7d831e01eb29ecca1b', N'rbac_User', N'remark', N'备注', 1, 11, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (99, N'f3597bf2c43d469fa8e6eba6798cd5ae', N'rbac_User', N'rowID', N'rowID', 0, 100, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (100, N'3ef67eb92afa45cb83075d61a0687e0b', N'rbac_User', N'userCode', N'用户编号', 1, 5, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (101, N'63587eaf58354700be20a508348fe369', N'rbac_User', N'userName', N'用户名称', 1, 6, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (102, N'9aa21c4d0d68433e8528210e24b66657', N'rbac_User', N'操作', N'操作', 1, 100, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (103, N'9c71e5ee58dd4d1e9ee0a02e514f2aa0', N'rbac_User', N'序号', N'序号', 1, 2, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (104, N'263a0196ec41458aa8407d0e62a483db', N'rbac_UserOrg', N'deptCode', N'所属部门', 1, 8, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (105, N'4dcc84c0ba5e4b8aad4f7e3a529c80b6', N'rbac_UserOrg', N'deptName', N'deptName', 0, 12, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (106, N'bf97610384214c40b6f44d2bf56cbb5b', N'rbac_UserOrg', N'isAllPrj', N'所有项目权限', 1, 10, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (107, N'1f031ebb75a14d12947ead28c4a04e4d', N'rbac_UserOrg', N'isLogin', N'是否登录', 1, 9, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (108, N'e1026858c38e42f9b280cb12ee6b3224', N'rbac_UserOrg', N'orgCode', N'组织编码', 1, 6, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (109, N'63bc7f91e39145989658e0425a8e58eb', N'rbac_UserOrg', N'orgName', N'组织名称', 1, 7, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (110, N'9246b9915baf44bab96e37c1e9e542a7', N'rbac_UserOrg', N'remark', N'备注', 0, 10, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (111, N'de4f52ba9d824de5945fbce2e3eeaed8', N'rbac_UserOrg', N'rowID', N'rowID', 0, 4, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (112, N'6055d0ad36844b3da22bb3cb6f41ca1c', N'rbac_UserOrg', N'userCode', N'userCode', 0, 5, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (113, N'd2923fd9b04f48ba8d59abe32c51dd7c', N'rbac_UserOrg', N'操作', N'操作', 1, 100, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (114, N'ced82e045a5848668251e5793785331b', N'rbac_UserOrg', N'序号', N'序号', 1, 2, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (115, N'96f2776838034a54b82f9755f72f4dc3', N'rbac_UserPriv', N'resourceName', N'资源名称', 1, 4, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (116, N'75a77d30a53747a889f9693642e1c968', N'rbac_UserPriv', N'序号', N'序号', 1, 2, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (117, N'6ddf305f6c1444b68b9b90883ddcae28', N'sbs_Dept', N'deptCode', N'部门编号', 1, 5, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (118, N'1a4aedcd31f2445d91066da20b11d6d1', N'sbs_Dept', N'deptName', N'部门名称', 1, 6, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (119, N'1bfcdebaf7fa4bc0be08e4426a09c0e2', N'sbs_Dept', N'importDate', N'导入时间', 0, 10, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (120, N'455135bd2467434f82ceb2214e4eac9f', N'sbs_Dept', N'orgCode', N'组织编号', 1, 9, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (121, N'be41498897504de59e1bf3f1b2579604', N'sbs_Dept', N'orgName', N'组织名称', 1, 10, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (122, N'a3c94d60ff904349a715c07254d044b4', N'sbs_Dept', N'remark', N'remark', 0, 11, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (123, N'5af7b27598b940b9922020bcc92ff37e', N'sbs_Dept', N'rowID', N'rowID', 0, 4, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (124, N'8e57a9985daf4f609ce60f2de6fe1141', N'sbs_Dept', N'sourceFrom', N'来源', 0, 9, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (125, N'adce9f3986f24f0f8b97dbc4651030d1', N'sbs_Dept', N'upDeptCode', N'上层部门编号', 1, 7, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (126, N'de78483f7e094049a0ecc4f9df43da31', N'sbs_Dept', N'upDeptName', N'上层部门名称', 1, 8, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (127, N'a8e1446897784fca8e13fc1ac9a42397', N'sbs_Dept', N'操作', N'操作', 1, 100, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (128, N'13c070218f53454dbc537cad37faaa11', N'sbs_Dept', N'序号', N'序号', 1, 2, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (129, N'da11843fcc6c42758d098e4c120e3ac6', N'sbs_Empl', N'deptCode', N'部门编号', 0, 9, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (130, N'8e95308b202e4d66a1c4d2a57731982b', N'sbs_Empl', N'deptName', N'部门名称', 1, 10, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (131, N'4f8da5e7a96d4e0086c3edb8e9a5734b', N'sbs_Empl', N'emplCode', N'职工编号', 1, 5, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (132, N'3a594ed5547f434fb187885b6e318a55', N'sbs_Empl', N'emplName', N'职工名称', 1, 6, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (133, N'd039363965464d07a0fbe05294d59031', N'sbs_Empl', N'importDate', N'导入时间', 0, 11, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (134, N'543b0958bcb54d33858c66c00b833c92', N'sbs_Empl', N'isLogin', N'是否可登陆', 1, 7, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (135, N'26ac9464c7374a539718046254f2efd4', N'sbs_Empl', N'orgCode', N'组织编号', 0, 11, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (136, N'93bf783de2d64fc8b4b5b8e1a56821f1', N'sbs_Empl', N'orgName', N'组织名称', 1, 12, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (137, N'b06466f8f057440ea8a5adcc2b4953ab', N'sbs_Empl', N'remark', N'remark', 0, 12, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (138, N'98cd14e72c694ff39a9dad2ea5c4deea', N'sbs_Empl', N'rowID', N'rowID', 0, 4, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (139, N'8563f5e943fe414c85dd75db9e43ac0e', N'sbs_Empl', N'sourceFrom', N'sourceFrom', 0, 10, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (140, N'dc3b301162f4425db4bf3d70b54e55b6', N'sbs_Empl', N'status', N'状态', 1, 8, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (141, N'ea9d5092b0054bde90f748f610281ae8', N'sbs_Empl', N'操作', N'操作', 1, 100, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (142, N'1b5ec746269249049fa4a48e43696dd8', N'sbs_Empl', N'序号', N'序号', 1, 2, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (143, N'edbd294fb5db4ab3821535cb4f3d8bf3', N'sbs_EmplJob', N'emplSysCode', N'emplSysCode', 0, 9, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (144, N'2194b84696bd497a84019a744253c37d', N'sbs_EmplJob', N'isMain', N'是否主要', 1, 6, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (145, N'b2a5b43e0af84472a181d0eec7d1ad9b', N'sbs_EmplJob', N'jobCode', N'职工编码', 1, 4, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (146, N'07f9ec288e46493298a56576ccc830bd', N'sbs_EmplJob', N'jobName', N'职工名称', 1, 5, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (147, N'd21d330c647c43f4a8812acb74e697a6', N'sbs_EmplJob', N'remark', N'备注', 1, 8, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (148, N'37de2a237bdb4b30a1d4ea4e9d7da860', N'sbs_EmplJob', N'rowID', N'rowID', 0, 7, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (149, N'5e3c8fb2122f44f19720ae727d243c5f', N'sbs_EmplJob', N'操作', N'操作', 1, 100, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (150, N'c253d698d8484950a1c4ade6190e3967', N'sbs_EmplJob', N'序号', N'序号', 1, 2, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (151, N'50b63e72519a45b4b7c1e09b1a15097c', N'sbs_Job', N'deptName', N'所属部门', 1, 11, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (152, N'e777a21db6284be1b366b8208f4430eb', N'sbs_Job', N'jobCode', N'岗位编号', 1, 5, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (153, N'9ec8455ed0dd4323a937908d1f802221', N'sbs_Job', N'jobName', N'岗位名称', 1, 6, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (154, N'ddb5f52d912c482f8a30b5c74ede35bb', N'sbs_Job', N'orgName', N'所属组织', 1, 12, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (155, N'550a08dbeccf4feb809533f883f95218', N'sbs_Job', N'upJobName', N'上级岗位', 1, 10, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (156, N'0c1d317cd0794dcc86d82dd94bd2018b', N'sbs_Job', N'操作', N'操作', 1, 100, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (157, N'a5e2994d933f44e59980a08d4dae2083', N'sbs_Job', N'序号', N'序号', 1, 2, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (158, N'c657bd6b31864ed9bcb8443571512691', N'sbs_Org', N'isDefault', N'是否默认', 1, 7, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (159, N'2caa1c5d0df74ef3a478e65ab7914f59', N'sbs_Org', N'orgCode', N'组织编号', 1, 5, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (160, N'85aa9effc1ac41618d57845b2e955504', N'sbs_Org', N'orgName', N'组织名称', 1, 6, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (161, N'3d63a3e92a7e43e1b331e13ee3da7840', N'sbs_Org', N'remark', N'备注', 1, 12, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (162, N'df39573a90f14590bcf3a71c8152f5bc', N'sbs_Org', N'rowID', N'rowID', 0, 4, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (163, N'acfc95d4c45e4bf7ae4899fdabf686ba', N'sbs_Org', N'操作', N'操作', 1, 100, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (164, N'89afb3e22ccf4ade93408626d2348162', N'sbs_Org', N'序号', N'序号', 1, 2, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (165, N'3837fe40d98341d88f429c171f14c05a', N'sbs_Post', N'importDate', N'导入时间', 1, 9, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (166, N'68445b04802e419a81d1785228c39f8d', N'sbs_Post', N'isDeptPost', N'是否部门职务', 1, 7, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (167, N'383e128aa6944b7d9f517d6bf35886a5', N'sbs_Post', N'postCode', N'职务编号', 1, 5, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (168, N'0ddeaf1192864e04bcfcb76ad43fce98', N'sbs_Post', N'postName', N'职务名称', 1, 6, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (169, N'3ef94cd2e04946d4bfc1ecd21be24582', N'sbs_Post', N'remark', N'备注', 1, 10, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (170, N'ea289a40e2114b0a9d5ed30207ddf84a', N'sbs_Post', N'rowID', N'rowID', 0, 4, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (171, N'c1935de79c4246c6b2d3e2a3b1af8708', N'sbs_Post', N'sourceFrom', N'来源', 1, 8, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (172, N'88ac32a88df44d859c6eebb9b54c1772', N'sbs_Post', N'操作', N'操作', 1, 100, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (173, N'8115d1727aca45659f47c22d1764d3df', N'sbs_Post', N'序号', N'序号', 1, 1, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (174, N'cae1b21bf57a4f77933199d6bf71e3bb', N'sys_BillAttach', N'attachCode', N'附件编号', 0, 5, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (175, N'870312fa9bac4ddbb90bf2b4c630846e', N'sys_BillAttach', N'attachContent', N'attachContent', 0, 14, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (176, N'fc589159578d40148a80a1279ae33737', N'sys_BillAttach', N'attachLength', N'附件大小(KB)', 1, 12, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (177, N'e8a993c16d6446f782d993608ba7f79e', N'sys_BillAttach', N'attachMIME', N'attachMIME', 0, 13, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (178, N'a01ef01e6d9541798d87c2c5e12d085e', N'sys_BillAttach', N'attachName', N'附件名称', 1, 11, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (179, N'56d8156c8ff94a23b1f064c56d730ec4', N'sys_BillAttach', N'attachUrl', N'附件地址', 0, 9, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (180, N'd4e45ce0a3954be5b75914bb094d79b0', N'sys_BillAttach', N'prieviewUrl', N'预览地址', 0, 10, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (181, N'e63b222b94d34663be0977a5cf71b27b', N'sys_BillAttach', N'relatedDetailNo', N'关联单据行号', 0, 8, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (182, N'd8ae6924cbe04a75997b9e19e6b3be84', N'sys_BillAttach', N'relatedKeyCode', N'关联单据编号', 0, 7, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (183, N'b3906f31e2c44b2a9492fd1c0aa546cb', N'sys_BillAttach', N'relatedResourceCode', N'关联单据类型', 0, 6, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (184, N'0a390aa3cf3d45559b5af8f9098b371d', N'sys_BillAttach', N'remark', N'备注', 1, 17, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (185, N'507807e6b9a84b1da6a9970703fbd735', N'sys_BillAttach', N'rowID', N'rowID', 0, 4, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (186, N'539f7748e42e4b8daa4e71abd76879c6', N'sys_BillAttach', N'uploadDateTime', N'上传时间', 1, 16, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (187, N'd094b343789d4c89a896136d7a403b79', N'sys_BillAttach', N'uploadUserCode', N'上传人', 0, 15, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (188, N'0da41b58aff74bfdbb7dfb83bf2ca228', N'sys_BillAttach', N'uploadUserName', N'上传人', 1, 15, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (189, N'f8a35bb00a9f40439e07e2216d5b3bb5', N'sys_BillAttach', N'操作', N'操作', 1, 100, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (190, N'fe21b10b3a6a4a7e93b5884d5805a6c3', N'sys_BillAttach', N'序号', N'序号', 1, 2, 0, NULL, 1, N'no', N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (191, N'374bd04c9a654acf8250a6e7ac08918f', N'sys_Column', N'alignType', N'对其', 1, 14, 0, NULL, 1, NULL, N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (192, N'0142c6c6f78041bd95f070fb27dcf64b', N'sys_Column', N'CFieldName', N'显示别名', 1, 7, 0, NULL, 1, NULL, N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (193, N'7d9de81b886a43a1bab144cd94132786', N'sys_Column', N'colWidth', N'数据列宽', 1, 10, 0, NULL, 1, NULL, N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (194, N'6b83a5d781eb4b1f84b65ba919bb59bf', N'sys_Column', N'fieldCode', N'字段名', 1, 5, 0, NULL, 1, NULL, N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (195, N'6a62a09b982343a5a4d3d3b9f931e650', N'sys_Column', N'fieldName', N'字段显示名', 1, 6, 0, NULL, 1, NULL, N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (196, N'32f51fcf0c3649fda65a350510771222', N'sys_Column', N'fixedValue', N'停靠', 1, 13, 0, NULL, 1, NULL, N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (197, N'eba0e25a3be74a1e9751d4279c004e58', N'sys_Column', N'isOrder', N'是否排序', 1, 11, 0, NULL, 1, NULL, N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (198, N'140b6e4a22ed475abac41ba26de5d5b2', N'sys_Column', N'isResize', N'是否可调', 1, 12, 0, NULL, 1, NULL, N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (199, N'ba4562f034d54b61a871461d33aed243', N'sys_Column', N'isShow', N'是否显示', 1, 8, 0, NULL, 1, NULL, N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (200, N'b0f28cf792664912a65914c330abb495', N'sys_Column', N'rowID', N'rowID', 0, 4, 0, NULL, 1, NULL, N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (201, N'f7c4b52a8e3342f5a0f462d865be17ef', N'sys_Column', N'showOrder', N'显示顺序', 1, 9, 0, NULL, 1, NULL, N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (202, N'81b4e61f8891474c8dfd1a05c705f40a', N'sys_Column', N'操作', N'操作', 1, 100, 0, NULL, 1, NULL, N'left', NULL, NULL)
GO
INSERT [dbo].[sys_Column] ([rowNum], [rowID], [resourceCode], [fieldCode], [fieldName], [isShow], [showOrder], [isOrder], [colWidth], [isResize], [fixedValue], [alignType], [optionValue], [remark]) VALUES (203, N'ae3889db0aac4de687482c4d66f42522', N'sys_Column', N'序号', N'序号', 1, 1, 0, NULL, 1, NULL, N'left', NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[sys_Column] OFF
GO
SET IDENTITY_INSERT [dbo].[sys_DataSyncInterface] ON 

GO
INSERT [dbo].[sys_DataSyncInterface] ([rowNum], [rowID], [sysTableName], [sysInsertTableName], [syskeyFieldName], [sourceTableName], [sourceTableJoinExpression], [sourceTableWhereExpression], [sourceTableOrderExpression], [isPrimary], [remark]) VALUES (1, N'2666a520dbff407bb003419a33ed840c', N'lib_Article', NULL, NULL, NULL, NULL, NULL, NULL, N'是', NULL)
GO
SET IDENTITY_INSERT [dbo].[sys_DataSyncInterface] OFF
GO
SET IDENTITY_INSERT [dbo].[sys_WebLog] ON 

GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (1, N'c20e4470c08842dcbd85b8d81755ec14', CAST(0x0000AAA700966E4A AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (2, N'b88376e35180469b8e8f4062c73d6029', CAST(0x0000AAA700967258 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (3, N'96ad2c90d8904801aa6455d24293466a', CAST(0x0000AAA700967657 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/Login/AdminLogin', N'POST      ', N'&tbxUserName=sysAdmin&tbxPassword=e10adc3949ba59abbe56e057f20f883e&orgCode=sju')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (4, N'e10f21cec0314bb58c7f9fc1f0fb917f', CAST(0x0000AAA700967685 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (5, N'e923ad018c5d4d90aa7eff320eee4e03', CAST(0x0000AAA70096768C AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (6, N'3ee3eda2795240d382ea933424e6c55e', CAST(0x0000AAA700967820 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sys_Home/desktop', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (7, N'6d3887955d0147969587f62bdf9467ee', CAST(0x0000AAA700967CD8 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/rbac_Role/select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (8, N'dddc82c5c34348f0983416af99bbe058', CAST(0x0000AAA700967F26 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/rbac_User/Select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (9, N'4044381413a345c881e7c4a881d5ab7e', CAST(0x0000AAA700968125 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sbs_UserPost/Select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (10, N'a6d46e7723024856b1c1c79117542cf1', CAST(0x0000AAA7009997F5 AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (11, N'd898beb855a24986b850221579614bb4', CAST(0x0000AAA700999CA0 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (12, N'40a1d8e37d0f4162a9ae46640188ba39', CAST(0x0000AAA70099A11D AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/Login/AdminLogin', N'POST      ', N'&tbxUserName=sysAdmin&tbxPassword=e10adc3949ba59abbe56e057f20f883e&orgCode=sju')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (13, N'184e044a2a5d4853b522c0b24dd31656', CAST(0x0000AAA70099A149 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (14, N'88d0a7cd8ea1446cb6ab8c058490c0e2', CAST(0x0000AAA70099A14E AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (15, N'0df7beabedb74024972a27227283fe19', CAST(0x0000AAA70099A2E6 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sys_Home/desktop', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (16, N'b73cc53657c34d12b4af910605ad09b5', CAST(0x0000AAA70099A464 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/rbac_Role/select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (17, N'19cb956f8efe475ba08367b03da75d12', CAST(0x0000AAA7009A6C35 AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (18, N'852e3add32394749b19c0e5638d1da19', CAST(0x0000AAA7009A7157 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (19, N'4b8b7dd6f13a408aa4ccf1fadfa17d8a', CAST(0x0000AAA7009A74E4 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/Login/AdminLogin', N'POST      ', N'&tbxUserName=sysAdmin&tbxPassword=e10adc3949ba59abbe56e057f20f883e&orgCode=sju')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (20, N'22ca7a7fc5b84881b9a45fa8b023839c', CAST(0x0000AAA7009A7507 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (21, N'b8ad19ebc94a4379a97f089f302b1770', CAST(0x0000AAA7009A750A AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (22, N'df35945165b44683950c16dafccf9298', CAST(0x0000AAA7009A7684 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sys_Home/desktop', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (23, N'c23bf2b457374b5ea3161fe3f2a0ef7f', CAST(0x0000AAA7009A7814 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/rbac_Role/select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (24, N'09e71224ae7f4aa195112099430769bf', CAST(0x0000AAA700A19FA4 AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (25, N'ba237673e49a49e9a23a39c31f43093c', CAST(0x0000AAA700A1A3E5 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (26, N'65ed46bf3b1a43ebb0b35b17087ebc78', CAST(0x0000AAA700A1A794 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/Login/AdminLogin', N'POST      ', N'&tbxUserName=sysAdmin&tbxPassword=e10adc3949ba59abbe56e057f20f883e&orgCode=sju')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (27, N'4ced8c0202ff4fc89c91ef366afef776', CAST(0x0000AAA700A1A7C3 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (28, N'ae30a26d33de42958dfba857a7894579', CAST(0x0000AAA700A1A7C8 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (29, N'd1ffb0df8d554dafbb0881620c819806', CAST(0x0000AAA700A1A94D AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sys_Home/desktop', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (30, N'8b4da9f4c1ce4a0282e39071152aadd8', CAST(0x0000AAA700A1AD99 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/rbac_Role/select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (31, N'5cc7ce6576a445469cfd08822ddd031a', CAST(0x0000AAA700A24F89 AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (32, N'f761d81425e74a3282f104a6d3293e86', CAST(0x0000AAA700A253B7 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (33, N'35ef2e4723b64d27bf71c928b972544c', CAST(0x0000AAA700A25711 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/Login/AdminLogin', N'POST      ', N'&tbxUserName=sysAdmin&tbxPassword=e10adc3949ba59abbe56e057f20f883e&orgCode=sju')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (34, N'61e758e3bbf14ca291ba9344f3f43baf', CAST(0x0000AAA700A2573C AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (35, N'd6540fdf507647e4966b4a7f6c4a7212', CAST(0x0000AAA700A25741 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (36, N'a23940d4fe6f4223bdf50761a9d6c168', CAST(0x0000AAA700A258BB AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sys_Home/desktop', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (37, N'a052229c4e4945b4ace1fad7e90756bd', CAST(0x0000AAA700A260FF AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/rbac_Role/select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (38, N'5122fdc4cd4d4c12aeef227677e6e972', CAST(0x0000AAA700A264A7 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/rbac_User/Select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (39, N'04835386e0994787b812456d29d555ae', CAST(0x0000AABC00F7DB40 AS DateTime), N'登录', N'sysAdmin', N'', N'', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (40, N'141ad3c4b8034d52b5e783ab5b4aa6c9', CAST(0x0000AABF01592428 AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (41, N'a8ced69ffa1f452e9ddde9fba43605d0', CAST(0x0000AABF01592B6D AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (42, N'69964e2f4c744b278de614c550c6654f', CAST(0x0000AABF01592B86 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/Login/AdminLogin', N'POST      ', N'&tbxUserName=sysAdmin&tbxPassword=e10adc3949ba59abbe56e057f20f883e&orgCode=sju')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (43, N'55ec1d91d76548a39eea35e6187341bc', CAST(0x0000AABF01592BAE AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (44, N'ec0b2020f62344febea3a8012948e5b2', CAST(0x0000AABF01592BB3 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (45, N'fe656b7141844ebea951363199af6ec6', CAST(0x0000AABF01592D8E AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sys_Home/desktop', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (46, N'7b759c27d0344caa8fa176d1bf5c9ae4', CAST(0x0000AABF0159328F AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/rbac_Resource/select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (47, N'2859d8e2fdc54267b42e116cb47d42ef', CAST(0x0000AABF015936D6 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/rbac_Resource/select', N'http://localhost:9021/admin/rbac_Resource/Update?rowID=192', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (48, N'0493a51f68254372911c207293b53911', CAST(0x0000AABF01593735 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/rbac_Resource/select', N'http://localhost:9021/admin/rbac_Resource/Update?rowID=192', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (49, N'3694d39c69954555899c99a43a4561a2', CAST(0x0000AABF015937C7 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/rbac_Resource/select', N'http://localhost:9021/admin/rbac_Resource/Update?rowID=192', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (50, N'14f7eb9c051841b8aa5199cf42b201f8', CAST(0x0000AABF01593E9F AS DateTime), N'提交', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/rbac_Resource/Update?rowID=192', N'http://localhost:9021/admin/rbac_ResourceOp/Insert?resourceCode=rbac_Role', N'POST      ', N'&resourceCode=rbac_Role')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (51, N'2bde6cc7fed14c4f94102987f3919f03', CAST(0x0000AABF01593EB5 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/rbac_Resource/Update?rowID=192', N'http://localhost:9021/admin/rbac_ResourceOp/SelectPartial?PageIndex=1&orderField=showOrder&orderWay=asc&upCode=rbac_Role&opMode=Update&exeCountSql=true', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (52, N'e0792b6900414b18af0cbcde18ead74f', CAST(0x0000AABF015944ED AS DateTime), N'提交', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/rbac_Resource/Update?rowID=192', N'http://localhost:9021/admin/rbac_ResourceOp/Insert?resourceCode=rbac_Role', N'POST      ', N'&resourceCode=rbac_Role')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (53, N'c2711b53643d497ca9678d262070fc14', CAST(0x0000AABF01594502 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/rbac_Resource/Update?rowID=192', N'http://localhost:9021/admin/rbac_ResourceOp/SelectPartial?PageIndex=1&orderField=showOrder&orderWay=asc&upCode=rbac_Role&opMode=Update&exeCountSql=true', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (54, N'0c32e1957edc4fdebaec4d1e786ef258', CAST(0x0000AACB0159AECB AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (55, N'70e7832c79594cf496ee054691c54007', CAST(0x0000AACB0159B4E1 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (56, N'a0867fb0b80543a2b552eb09ccc75492', CAST(0x0000AACB0159B894 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/Login/AdminLogin', N'POST      ', N'&tbxUserName=sysAdmin&tbxPassword=5d9401acb908d134421456917f8ff4c6&orgCode=sju')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (57, N'018346257d474070a8a285d87d45b581', CAST(0x0000AACB0159C15C AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/Login/AdminLogin', N'POST      ', N'&tbxUserName=sysAdmin&tbxPassword=e10adc3949ba59abbe56e057f20f883e&orgCode=sju')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (58, N'6ebe6fd297ed45008744990b575becdd', CAST(0x0000AACB0159C190 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (59, N'3ead1d269129422fa7d49463dae46dc2', CAST(0x0000AACB0159C194 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (60, N'1e41e438fa214e5792552e9e3d8cd64e', CAST(0x0000AACB0159C438 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sys_Home/desktop', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (61, N'91751f0f07f947499ce1ac631c911db0', CAST(0x0000AACB0159C84F AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/rbac_Role/select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (62, N'2d75e23125c948b9abd951d8c7fbe4ec', CAST(0x0000AACB0159C9B8 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/rbac_User/Select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (63, N'4c754a67f7924b2ea47766b92871b421', CAST(0x0000AACB0169EB34 AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/weixin/Info/Index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (64, N'a04fd738febc4a65aa2b06bdf8b54c51', CAST(0x0000AAD600A24BFB AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (65, N'3f4e79d86aff407bbc712eadf33d8147', CAST(0x0000AAD600A250E0 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (66, N'861d7e84f574491087908140db63383f', CAST(0x0000AAD600A250FF AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/Login/AdminLogin', N'POST      ', N'&tbxUserName=sysAdmin&tbxPassword=e10adc3949ba59abbe56e057f20f883e&orgCode=sju')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (67, N'7975fce116e7416cb8d0781d64f4655e', CAST(0x0000AAD600A25123 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (68, N'0a5fa4748e504710a05bae94e3e945a5', CAST(0x0000AAD600A25126 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (69, N'b51c5ce8d9424f398f84edf7795db29f', CAST(0x0000AAD600A252DE AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sys_Home/desktop', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (70, N'ae32b97616e1467b9d0b032dfe830791', CAST(0x0000AAD600A25A86 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/rbac_User/Select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (71, N'31dff167d42f412fa12ad7f716914b88', CAST(0x0000AAD600A25E10 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/rbac_User/Select', N'http://localhost:9021/admin/rbac_User/Priv?rowID=9', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (72, N'298de0f989994d63970f52a067854dd0', CAST(0x0000AAD600A26486 AS DateTime), N'提交', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/rbac_User/Priv?rowID=9', N'http://localhost:9021/admin/rbac_User/Priv', N'POST      ', N'&rowID=9&moduleCode=admin.rbac&detail.resourceCode=rbac_Role,rbac_User,sbs_UserPost,af_AuditType,af_AuditFlow&rbac_Role.cbx=Select,Detail,Insert,Delete,Update,LinkUsers,Priv&rbac_Role.dataPriv=seeOrg&rbac_Role.haveDataPriv=&rbac_User.cbx=Select,Detail,Update,Delete,resetPW,Priv,PrivList,userBatchPost,allowLogin,cancelLogin&rbac_User.dataPriv=seeOrg&rbac_User.haveDataPriv=&sbs_UserPost.cbx=Select,Delete,BatchSave&sbs_UserPost.dataPriv=seeOrg&sbs_UserPost.haveDataPriv=&af_AuditType.cbx=Select,Detail,Insert,Update,Delete&af_AuditType.dataPriv=seeOrg&af_AuditType.haveDataPriv=&af_AuditFlow.cbx=Select,Detail,Insert,Update,Delete,LinkDepts,Design,Enable,Disable&af_AuditFlow.dataPriv=seeOrg&af_AuditFlow.haveDataPriv=')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (73, N'e7ab6b79755241b7b79e3c4a50010b5b', CAST(0x0000AAD600A282C5 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/rbac_User/Select', N'http://localhost:9021/admin/rbac_User/Priv?rowID=9', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (74, N'490ec7c7f46542d1ba2f1a5530027a84', CAST(0x0000AAD600A28523 AS DateTime), N'提交', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/rbac_User/Priv?rowID=9', N'http://localhost:9021/admin/rbac_User/Priv', N'POST      ', N'&rowID=9&moduleCode=admin.rbac&detail.resourceCode=rbac_Role,rbac_User,sbs_UserPost,af_AuditType,af_AuditFlow&rbac_Role.cbx=Select,Detail,Insert,Delete,Update,LinkUsers,Priv&rbac_Role.dataPriv=seeOrg&rbac_Role.haveDataPriv=&rbac_User.cbx=Select,Detail,Update,Delete,resetPW,Priv,PrivList,userBatchPost,allowLogin,cancelLogin&rbac_User.dataPriv=seeOrg&rbac_User.haveDataPriv=&sbs_UserPost.cbx=Select,Delete,BatchSave&sbs_UserPost.dataPriv=seeOrg&sbs_UserPost.haveDataPriv=&af_AuditType.cbx=Select,Detail,Insert,Update,Delete&af_AuditType.dataPriv=seeOrg&af_AuditType.haveDataPriv=&af_AuditFlow.cbx=Select,Detail,Insert,Update,Delete,LinkDepts,Design,Enable,Disable&af_AuditFlow.dataPriv=seeOrg&af_AuditFlow.haveDataPriv=')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (75, N'bb62a3913e604e47b1140ccb2875ab7e', CAST(0x0000AAD600A32E70 AS DateTime), N'请求', NULL, NULL, NULL, N'http://localhost:9021/admin/sys_Home/desktop', N'http://localhost:9021/admin/sys_Home/desktop', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (76, N'd837cf0fc05041d2b9102f79324fe4bf', CAST(0x0000AAD600A32E70 AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (77, N'50406dda6698406dbb475c8a33a990a1', CAST(0x0000AAD600A33181 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (78, N'4382643b721249ad83fb0385f1e04aec', CAST(0x0000AAD600A3318C AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/Login/AdminLogin', N'POST      ', N'&tbxUserName=sysAdmin&tbxPassword=e10adc3949ba59abbe56e057f20f883e&orgCode=sju')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (79, N'3abf7fbe2d2a4ba59b040af68eda839c', CAST(0x0000AAD600A331B7 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (80, N'9d9fb7c675bd45bc8f2de235d6920aa1', CAST(0x0000AAD600A331B7 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (81, N'bb90dd10ea48452a8a5a4ef0b5dd4c03', CAST(0x0000AAD600A3331C AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sys_Home/desktop', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (82, N'9b44ceb4762b4ee6a89213238f1b7c15', CAST(0x0000AAD600A3356D AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/rbac_Role/select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (83, N'8ff821a6548b49979cd53f3e1504974e', CAST(0x0000AAD600A3375B AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/rbac_Role/select', N'http://localhost:9021/admin/rbac_Role/LinkUsers?rowID=1', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (84, N'b459368e046a401fb475cd950753c7fa', CAST(0x0000AAD600A33767 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/rbac_Role/select', N'http://localhost:9021/admin/rbac_Role/LinkUsers?rowID=1', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (85, N'be268472bf2a4317a5d9b52c2c94337f', CAST(0x0000AAD600A33790 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/rbac_Role/select', N'http://localhost:9021/admin/rbac_Role/LinkUsers?rowID=1', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (86, N'4a63b9e5741b4eb58118a27b2f374768', CAST(0x0000AAD600A790A5 AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (87, N'2657ba13505a48f686427620d402ec58', CAST(0x0000AAD600A7938C AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (88, N'703e429218eb41d6a3a99a3e1e5cafc0', CAST(0x0000AAD600A793A1 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/Login/AdminLogin', N'POST      ', N'&tbxUserName=sysAdmin&tbxPassword=e10adc3949ba59abbe56e057f20f883e&orgCode=sju')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (89, N'fee44ea8116a4f82ad89e4f33fda7b1d', CAST(0x0000AAD600A793C4 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (90, N'14fe3b2185134c60b925ce9e566b064c', CAST(0x0000AAD600A793C7 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (91, N'412ae97a3630409f8d1b2b32c08e1375', CAST(0x0000AAD600A7946E AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sys_Home/desktop', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (92, N'45e70080a71b45b686a81e759e89ab48', CAST(0x0000AAD600A95E01 AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (93, N'90701895b0ec4d7e90cef0d31b9594c6', CAST(0x0000AAD600A9610B AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (94, N'718bed5bd1fc49718b21ed60600a6f89', CAST(0x0000AAD600A9622D AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/Login/AdminLogin', N'POST      ', N'&tbxUserName=sysAdmin&tbxPassword=e10adc3949ba59abbe56e057f20f883e&orgCode=hhu')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (95, N'7b1bbe9f9017464da22bb672d7e489f7', CAST(0x0000AAD600A96251 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (96, N'8b51e8dab04e4af8933032663b5631a9', CAST(0x0000AAD600A9625B AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (97, N'48e6e6b366b04101b2f1a73f046b4e40', CAST(0x0000AAD600A96305 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sys_Home/desktop', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (98, N'd32586cd3f1c42debfc22be1c7bde2d4', CAST(0x0000AAD600A96B16 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/rbac_User/Select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (99, N'82b093fee74c40fb8254948407896112', CAST(0x0000AAD600A9761F AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sys_Home/exit', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (100, N'2510d320645d4bc59a9d39a4a88a10d2', CAST(0x0000AAD600A97625 AS DateTime), N'请求', NULL, NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/Login/admintoLogin', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (101, N'84fb22fb653e43d487bc6786c05dcebd', CAST(0x0000AAD600A9762F AS DateTime), N'请求', NULL, NULL, NULL, N'http://localhost:9021/Login/admintoLogin', N'http://localhost:9021/login/adminLogin', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (102, N'cf408d5eee684e0c927326c3469ca8a8', CAST(0x0000AAD600A977E3 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/login/adminLogin', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (103, N'09dd973008ed43d4a1d47c4a58064095', CAST(0x0000AAD600A977FB AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/login/adminLogin', N'http://localhost:9021/Login/AdminLogin', N'POST      ', N'&tbxUserName=sysAdmin&tbxPassword=e10adc3949ba59abbe56e057f20f883e&orgCode=sju')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (104, N'dfd2291009354760a472a4323b8a1f3f', CAST(0x0000AAD600A9780B AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (105, N'48868ea543694bd68c08f52e10e294ed', CAST(0x0000AAD600A97810 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/login/adminLogin', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (106, N'4f983596e2414c4b9393c2293b80ad64', CAST(0x0000AAD600A9784D AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sys_Home/desktop', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (107, N'07704b93b21a4553a6e2c918a541cb1e', CAST(0x0000AAD600A979A9 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/rbac_User/Select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (108, N'f5aa593b335048398faa8b9a2f9b37f9', CAST(0x0000AAD600A985DD AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sbs_UserPost/Select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (109, N'4a1fd19d48e84879b47c960a7983cd8d', CAST(0x0000AAD600A989F6 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/af_AuditType/select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (110, N'e392b0a4a906443a9a6cae1d24f1e275', CAST(0x0000AAD600A98BAF AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/af_AuditFlow/select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (111, N'1de312adaa7f4b22a7f13b5c5311d938', CAST(0x0000AAD600A98D71 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/af_AuditCenter/select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (112, N'cb85b9fba3d04e52a3e73f853c7c3039', CAST(0x0000AAD600B50B56 AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (113, N'a562763b64d949d6a5bfbd83327efc73', CAST(0x0000AAD600B50F33 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (114, N'ae48f985320546099aac861941380fb0', CAST(0x0000AAD600B50F4D AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/Login/AdminLogin', N'POST      ', N'&tbxUserName=sysAdmin&tbxPassword=e10adc3949ba59abbe56e057f20f883e&orgCode=sju')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (115, N'75e5279bca514a8391fa90b2560aee7c', CAST(0x0000AAD600B50F75 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (116, N'0f7e76ac2d9c446f82e47eb0c30b447c', CAST(0x0000AAD600B50F7A AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (117, N'735bdf0486304391b659056b0bd003c6', CAST(0x0000AAD600B5110A AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sys_Home/desktop', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (118, N'432d04ac33c24e09a9fa3b5417fbc4da', CAST(0x0000AAD600B5136F AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/rbac_Resource/select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (119, N'45838fd73f21401db7d86fe200673a1e', CAST(0x0000AAD600B518CD AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/rbac_Resource/select', N'http://localhost:9021/admin/rbac_Resource/Select?PageIndex=1&exeCountSql=true&moduleCode=admin.rbac&resourceName=', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (120, N'a3b45644fd574b49a29059c8e2ed0c7e', CAST(0x0000AAD600B527ED AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/rbac_Resource/select', N'http://localhost:9021/admin/rbac_Resource/Update?rowID=213', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (121, N'b65f1c4fa65e47c4b2639e795e09e35b', CAST(0x0000AAD600B5284D AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/rbac_Resource/select', N'http://localhost:9021/admin/rbac_Resource/Update?rowID=213', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (122, N'9674ecb14a1b466c82e0c6f0c2452a4b', CAST(0x0000AAD600B528DF AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/rbac_Resource/select', N'http://localhost:9021/admin/rbac_Resource/Update?rowID=213', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (123, N'e50f91f8bc8f4202ae938a8f37e6e78d', CAST(0x0000AAD600B535FC AS DateTime), N'提交', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/rbac_Resource/Update?rowID=213', N'http://localhost:9021/admin/rbac_Resource/Update?rowID=213', N'POST      ', N'&rowID=213&resourceCode=sbs_UserPost&resourceName=审批职务任职&moduleCode=admin.rbac&showOrder=3&resourceUrl=/admin/sbs_UserPost/Select&opControl=是&dataControl=否&pageWidth=0&isShow=是&haveOperations=Select,Delete,BatchSave&upCode=sbs_UserPost&opMode=Update&detail.rowID=66,70,102&detail.operationCode=Select,Delete,BatchSave&detail.operationName=查询,删除,批量保存&detail.showOrder=66,70,102&remark=&editorValue=')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (124, N'4aa0e3737c5d41888c9cfeb92702cb50', CAST(0x0000AAD600B53628 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/rbac_Resource/Update?rowID=213', N'http://localhost:9021/admin/rbac_ResourceOp/SelectPartial?PageIndex=1&orderField=showOrder&orderWay=asc&upCode=sbs_UserPost&opMode=Update&exeCountSql=true', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (125, N'f16b2477f0cb4d9db71db75c9944aa4a', CAST(0x0000AAD600B54F4E AS DateTime), N'提交', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/rbac_Resource/Update?rowID=213', N'http://localhost:9021/admin/rbac_Resource/Update?rowID=213', N'POST      ', N'&rowID=213&resourceCode=sbs_UserPost&resourceName=审批职务任职&moduleCode=admin.rbac&showOrder=3&resourceUrl=/admin/af_AuditPostUser/Select&opControl=是&dataControl=否&pageWidth=0&isShow=是&haveOperations=Select,Delete,BatchSave&upCode=sbs_UserPost&opMode=Update&detail.rowID=66,70,102&detail.operationCode=Select,Delete,BatchSave&detail.operationName=查询,删除,批量保存&detail.showOrder=66,70,102&remark=&editorValue=')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (126, N'33457d9ec34642009b9593bcccc9c70c', CAST(0x0000AAD600B54F68 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/rbac_Resource/Update?rowID=213', N'http://localhost:9021/admin/rbac_ResourceOp/SelectPartial?PageIndex=1&orderField=showOrder&orderWay=asc&upCode=sbs_UserPost&opMode=Update&exeCountSql=true', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (127, N'4017b2b0e58441a8bf52a61d84b5ae61', CAST(0x0000AAD600B56EB1 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/rbac_Resource/select', N'http://localhost:9021/admin/rbac_Resource/Select?PageIndex=1&orderField=showOrder&orderWay=asc&moduleCode=admin.rbac&resourceName=&exeCountSql=true', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (128, N'7231cadefaad4eabadc513c7069052fa', CAST(0x0000AAD600B57152 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (129, N'837670c826bf4389bad736798c93387b', CAST(0x0000AAD600B5718F AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sys_Home/desktop', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (130, N'e0c79eb6c5454e25a7d547efdcd19665', CAST(0x0000AAD600B5741A AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/rbac_User/Select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (131, N'b5bb1203bfc34a7caf9c252fc2429693', CAST(0x0000AAD600B5F507 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (132, N'47fc2c59253d45a69ce8fc5b32f618f1', CAST(0x0000AAD600B5F558 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sys_Home/desktop', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (133, N'6759f08f3b504eaf8f68ab8f38775d4c', CAST(0x0000AAD600B5FE79 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/rbac_Resource/select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (134, N'8dce13bec1aa46d5bbdc632af5af0759', CAST(0x0000AAD600B602A1 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/rbac_Resource/select', N'http://localhost:9021/admin/rbac_Resource/Select?PageIndex=1&exeCountSql=true&moduleCode=admin.sysbasic&resourceName=', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (135, N'ecb4a7d94e634cdeb4a50e71f267091d', CAST(0x0000AAD600B605FF AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/rbac_Resource/select', N'http://localhost:9021/admin/rbac_Resource/Update?rowID=212', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (136, N'52cabfd11a234ea1b32d8e5289dbf1ef', CAST(0x0000AAD600B60615 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/rbac_Resource/select', N'http://localhost:9021/admin/rbac_Resource/Update?rowID=212', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (137, N'ec350850f67c47aab2e46c89e65db170', CAST(0x0000AAD600B6062D AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/rbac_Resource/select', N'http://localhost:9021/admin/rbac_Resource/Update?rowID=212', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (138, N'94e4390a4edf41b48dcc8437747aeccb', CAST(0x0000AAD600B6149A AS DateTime), N'提交', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/rbac_Resource/Update?rowID=212', N'http://localhost:9021/admin/rbac_Resource/Update?rowID=212', N'POST      ', N'&rowID=212&resourceCode=sbs_Post&resourceName=审批职务&moduleCode=admin.sysbasic&showOrder=5&resourceUrl=/admin/af_AuditPost/Select&opControl=是&dataControl=否&pageWidth=0&isShow=是&haveOperations=Select,Detail,Insert,Update,Delete&upCode=sbs_Post&opMode=Update&detail.rowID=61,62,63,64,65&detail.operationCode=Select,Detail,Insert,Update,Delete&detail.operationName=查询,详情,新增,更新,删除&detail.showOrder=61,62,63,64,65&remark=&editorValue=')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (139, N'af2209ec7a654ef19fa7783e8d8dceae', CAST(0x0000AAD600B614C1 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/rbac_Resource/Update?rowID=212', N'http://localhost:9021/admin/rbac_ResourceOp/SelectPartial?PageIndex=1&orderField=showOrder&orderWay=asc&upCode=sbs_Post&opMode=Update&exeCountSql=true', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (140, N'8143cc8c6eef4c759544d7af17852474', CAST(0x0000AAD600B630DA AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (141, N'01e5305b785a40708171261ca1c3161d', CAST(0x0000AAD600B63118 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sys_Home/desktop', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (142, N'ad570e77682e423097b6fb227550dbb7', CAST(0x0000AAD600B6354F AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/rbac_Resource/select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (143, N'15662dee119a48428483615f77219bc1', CAST(0x0000AAD600B638B6 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/rbac_Resource/select', N'http://localhost:9021/admin/rbac_Resource/Select?PageIndex=1&exeCountSql=true&moduleCode=admin.sysbasic&resourceName=', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (144, N'bbd6bc5857d8493c8fe6c646b9e94ba2', CAST(0x0000AAD600B63B6D AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/rbac_Resource/select', N'http://localhost:9021/admin/rbac_Resource/Update?rowID=212', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (145, N'95fff14fe6274bff992204921ec59400', CAST(0x0000AAD600B63B7C AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/rbac_Resource/select', N'http://localhost:9021/admin/rbac_Resource/Update?rowID=212', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (146, N'8d15fd30661f40ed81aac46731e6e855', CAST(0x0000AAD600B63B8F AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/rbac_Resource/select', N'http://localhost:9021/admin/rbac_Resource/Update?rowID=212', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (147, N'f9849b0a04a44b45ad6430b0472dd242', CAST(0x0000AAD600B641BF AS DateTime), N'提交', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/rbac_Resource/Update?rowID=212', N'http://localhost:9021/admin/rbac_Resource/Update?rowID=212', N'POST      ', N'&rowID=212&resourceCode=af_AuditPost&resourceName=审批职务&moduleCode=admin.rbac&showOrder=5&resourceUrl=/admin/af_AuditPost/Select&opControl=是&dataControl=否&pageWidth=0&isShow=是&haveOperations=Select,Detail,Insert,Update,Delete&upCode=af_AuditPost&opMode=Update&remark=&editorValue=')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (148, N'00b93ed93ffc4382b671eef83bef9371', CAST(0x0000AAD600B641D6 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/rbac_Resource/Update?rowID=212', N'http://localhost:9021/admin/rbac_ResourceOp/SelectPartial?PageIndex=1&orderField=showOrder&orderWay=asc&upCode=af_AuditPost&opMode=Update&exeCountSql=true', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (149, N'aa576daa3588413bb0cfdda62002de0b', CAST(0x0000AAD600B64381 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/rbac_Resource/select', N'http://localhost:9021/admin/rbac_Resource/Select?PageIndex=1&orderField=showOrder&orderWay=asc&moduleCode=admin.sysbasic&resourceName=&exeCountSql=true', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (150, N'635b6a8dbac445f7957372851580f10f', CAST(0x0000AAD600B64560 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (151, N'decd833ef0fc40f1aa37a7605b071fdc', CAST(0x0000AAD600B6459B AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sys_Home/desktop', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (152, N'87f046f07b174bad8058d43e5555ca7c', CAST(0x0000AAD600B650C7 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sbs_Materiel/Select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (153, N'3667676711d643dea1910d06ef6ff3f9', CAST(0x0000AAD600B658D6 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/rbac_Resource/select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (154, N'8c20bfc77cab4a64a3547be5a426a3d2', CAST(0x0000AAD600B6747B AS DateTime), N'提交', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/rbac_Resource/select', N'http://localhost:9021/admin/rbac_Resource/Delete?rowID=211', N'POST      ', N'&rowID=211')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (155, N'fe18008df23d4146a42cfdcd7d704bb0', CAST(0x0000AAD600B6748F AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/rbac_Resource/select', N'http://localhost:9021/admin/rbac_Resource/Select?PageIndex=1&orderField=showOrder&orderWay=asc&moduleCode=&resourceName=&exeCountSql=true', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (156, N'23f94a8223674c8cadad0ce0ef49cc3a', CAST(0x0000AAD600B67920 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (157, N'9e1426e571d845a4a190515d83f38a97', CAST(0x0000AAD600B67959 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sys_Home/desktop', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (158, N'8cf932e3d67f46689bbe9b95746f4feb', CAST(0x0000AAD600B6800E AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/rbac_Resource/select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (159, N'8d1ddd290f514296948ac7baaee1c00e', CAST(0x0000AAD600B68445 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/rbac_Resource/select', N'http://localhost:9021/admin/rbac_Resource/Select?PageIndex=1&exeCountSql=true&moduleCode=admin.rbac&resourceName=', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (160, N'07e1b82545fe4c168cb0fa40a838dd73', CAST(0x0000AAD600B68FBA AS DateTime), N'提交', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/rbac_Resource/select', N'http://localhost:9021/admin/rbac_Resource/batchAdd', N'POST      ', N'&selectedkeyCodes=af_AuditPostUse,')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (161, N'44eb1fa76cda4925a0e13f3c691e6cc2', CAST(0x0000AAD600B68FC5 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/rbac_Resource/select', N'http://localhost:9021/admin/rbac_Resource/Select?PageIndex=1&orderField=showOrder&orderWay=asc&moduleCode=admin.rbac&resourceName=&exeCountSql=true', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (162, N'59b37f161358460895ffb9c74cf27574', CAST(0x0000AAD600B6ADDF AS DateTime), N'提交', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/rbac_Resource/select', N'http://localhost:9021/admin/rbac_Resource/batchSave', N'POST      ', N'&detail.rowID=192,193,198,213,212,199,205&detail.showOrder=1,2,5,4,3,6,7&detail.pageWidth=0,0,0,0,0,0,0&detail.pagerCount=0,0,0,0,0,0,0')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (163, N'ddd34b3f96ea46b7936c4e3f597882a4', CAST(0x0000AAD600B6B045 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (164, N'e5c5e48cda594631b312fd243804c3f9', CAST(0x0000AAD600B6B07D AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sys_Home/desktop', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (165, N'd002c4cc91d64ff9adc4f931c17673b9', CAST(0x0000AAD600B6B378 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/rbac_Resource/select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (166, N'23602418b9a540289bb03afcc2d6b20e', CAST(0x0000AAD600B6B654 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/rbac_Resource/select', N'http://localhost:9021/admin/rbac_Resource/Select?PageIndex=1&exeCountSql=true&moduleCode=admin.rbac&resourceName=', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (167, N'c07b5222c5e444db8d4ff3e1925c372d', CAST(0x0000AAD600B6BBAA AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/af_AuditPost/Select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (168, N'c61ca0bdd3f54432a6d7b555475e6eb5', CAST(0x0000AAD600B6E47D AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (169, N'4cf6b3cd6a34450b8b19bdba8b77d215', CAST(0x0000AAD600B6E87B AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (170, N'65a169dd1d1d4f2e92b5e904f3dd1bda', CAST(0x0000AAD600B6E88F AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/Login/AdminLogin', N'POST      ', N'&tbxUserName=sysAdmin&tbxPassword=e10adc3949ba59abbe56e057f20f883e&orgCode=sju')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (171, N'70ef0654805b466db9a82c870559437f', CAST(0x0000AAD600B6E8B4 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (172, N'a6b2f8cd2ad945828319b8dc1abeaa3c', CAST(0x0000AAD600B6E8B7 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (173, N'2af57767e02a4d53956691d5c81d29a7', CAST(0x0000AAD600B6E97A AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sys_Home/desktop', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (174, N'77d8f0d47bc74e51932e1f7ef24dc080', CAST(0x0000AAD600B6EAC9 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/af_AuditPost/Select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (175, N'fe99b2da9c574737b905bcf98db32536', CAST(0x0000AAD600B715EF AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (176, N'82d368932d864a1da943792c97192cc9', CAST(0x0000AAD600B77A0B AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (177, N'3e706c1e1376484eacf2860c6ca15420', CAST(0x0000AAD600B7806E AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (178, N'a265e6b8937e4a34aa727938d0136299', CAST(0x0000AAD600B78087 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/Login/AdminLogin', N'POST      ', N'&tbxUserName=sysAdmin&tbxPassword=e10adc3949ba59abbe56e057f20f883e&orgCode=sju')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (179, N'565e02c9199f4abf9ffe6d08ac318a9b', CAST(0x0000AAD600B780B0 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (180, N'ead14c72817e4bd5bfd8d219a5b7de9d', CAST(0x0000AAD600B780B4 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (181, N'11f730365bef42bfb7197019592f583b', CAST(0x0000AAD600B7823D AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sys_Home/desktop', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (182, N'62ee37906da94d7eadca5a5104baa793', CAST(0x0000AAD600B784AB AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/af_AuditPost/Select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (183, N'7ed79472aa33499189eeacd9cf1723fd', CAST(0x0000AAD600B78799 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/af_AuditPost/Select', N'http://localhost:9021/admin/af_AuditPost/Insert', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (184, N'da11e3fbee3e4975a20fc27cd185a8e9', CAST(0x0000AAD600B79300 AS DateTime), N'提交', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/af_AuditPost/Insert', N'http://localhost:9021/admin/af_AuditPost/Insert', N'POST      ', N'&postCode=001&postName=校长&isDeptPost=否&remark=')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (185, N'2eeb0b9026d5466f9fe8e02bd226bc83', CAST(0x0000AAD600B79345 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/af_AuditPost/Insert', N'http://localhost:9021/admin/af_AuditPost/Update?rowID=1', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (186, N'11667ef9d76b40d9a512a857885fa667', CAST(0x0000AAD600B793E0 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/af_AuditPost/Select', N'http://localhost:9021/admin/af_AuditPost/Select?PageIndex=1&orderField=postCode&orderWay=desc&postCode=&postName=&exeCountSql=true', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (187, N'b20784d158a94672843e971614c23292', CAST(0x0000AAD600B795EC AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/af_AuditPost/Select', N'http://localhost:9021/admin/af_AuditPost/Insert', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (188, N'ad52417c69af45fea9c0e0c93862a465', CAST(0x0000AAD600B7A02F AS DateTime), N'提交', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/af_AuditPost/Insert', N'http://localhost:9021/admin/af_AuditPost/Insert', N'POST      ', N'&postCode=002&postName=副校长&isDeptPost=否&remark=')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (189, N'8f2fe7c78f6d43c4b16b2f41af70a653', CAST(0x0000AAD600B7A040 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/af_AuditPost/Insert', N'http://localhost:9021/admin/af_AuditPost/Update?rowID=2', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (190, N'5da5ecf6daba4f7ba37112d1eacb341f', CAST(0x0000AAD600B7A0DB AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/af_AuditPost/Select', N'http://localhost:9021/admin/af_AuditPost/Select?PageIndex=1&orderField=postCode&orderWay=desc&postCode=&postName=&exeCountSql=true', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (191, N'325e16ef08764bbd883b954d428bf744', CAST(0x0000AAD600B7A238 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/af_AuditPost/Select', N'http://localhost:9021/admin/af_AuditPost/Insert', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (192, N'6513f661fc61487889c884839c02f054', CAST(0x0000AAD600B7AAD3 AS DateTime), N'提交', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/af_AuditPost/Insert', N'http://localhost:9021/admin/af_AuditPost/Insert', N'POST      ', N'&postCode=003&postName=院长&isDeptPost=是&remark=')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (193, N'e3bde2c731c04905a72464c4fce88545', CAST(0x0000AAD600B7AAE5 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/af_AuditPost/Insert', N'http://localhost:9021/admin/af_AuditPost/Update?rowID=3', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (194, N'ed570ade359841058794cf21cb87d6f5', CAST(0x0000AAD600B7AB7D AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/af_AuditPost/Select', N'http://localhost:9021/admin/af_AuditPost/Select?PageIndex=1&orderField=postCode&orderWay=desc&postCode=&postName=&exeCountSql=true', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (195, N'dc8949f52f9d4f239b1cc468048a8134', CAST(0x0000AAD600B7ACBA AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/af_AuditPost/Select', N'http://localhost:9021/admin/af_AuditPost/Insert', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (196, N'e002d490e76b4f519d60e3911795984a', CAST(0x0000AAD600B7B41A AS DateTime), N'提交', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/af_AuditPost/Insert', N'http://localhost:9021/admin/af_AuditPost/Insert', N'POST      ', N'&postCode=004&postName=副院长&isDeptPost=是&remark=')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (197, N'02a63422550241c88a335e72c85da54c', CAST(0x0000AAD600B7B42D AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/af_AuditPost/Insert', N'http://localhost:9021/admin/af_AuditPost/Update?rowID=4', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (198, N'4f08861d9a904fbea1e2a8d7df318b36', CAST(0x0000AAD600B7B4C6 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/af_AuditPost/Select', N'http://localhost:9021/admin/af_AuditPost/Select?PageIndex=1&orderField=postCode&orderWay=desc&postCode=&postName=&exeCountSql=true', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (199, N'b738c6c716714c1197b897530cb77bca', CAST(0x0000AAD600B7B925 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/af_AuditPost/Select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (200, N'8a77dc88ce6446baa058342c6de4d7ce', CAST(0x0000AAD600B7BB92 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/rbac_User/Select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (201, N'3ab2e77ac3394210a21b4fb527dad629', CAST(0x0000AAD600B89DE5 AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (202, N'0b0cf4800da34bae840f6c4ad7cd824c', CAST(0x0000AAD600B8B35D AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (203, N'033f03cf189e4839ada2bbae788def48', CAST(0x0000AAD600B8E9F3 AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (204, N'ba91bfa555714c70b5481e52b2889d0c', CAST(0x0000AAD600B8ED13 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (205, N'69cb126e828240e2a121f845ee006d66', CAST(0x0000AAD600B8ED87 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/Login/AdminLogin', N'POST      ', N'&tbxUserName=sysAdmin&tbxPassword=e10adc3949ba59abbe56e057f20f883e&orgCode=sju')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (206, N'5e5540b6f36546efb369e6ecdcc60ea0', CAST(0x0000AAD600B8EDAC AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (207, N'224ab6b4435f479c8acb7a68e3242354', CAST(0x0000AAD600B8EDB0 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (208, N'587f30d23dc64e2d8a5b8b6d49c28bcb', CAST(0x0000AAD600B8EF26 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sys_Home/desktop', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (209, N'cad03ae0ba67485dadabf80f2a903747', CAST(0x0000AAD600B8F0AE AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/af_AuditPost/Select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (210, N'9381ac689d6b42e99242d465eb0af18e', CAST(0x0000AAD600B8F47E AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/af_AuditPostUser/Select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (211, N'ddcc4b7f43944b42b1c19d3882d56c0e', CAST(0x0000AAD600B928E6 AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (212, N'8edf89d42c9b41c6bf6d1ef853388dae', CAST(0x0000AAD600B92C1A AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (213, N'732a48de712b43c49b593c59e16dd6d4', CAST(0x0000AAD600B92C2C AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/Login/AdminLogin', N'POST      ', N'&tbxUserName=sysAdmin&tbxPassword=e10adc3949ba59abbe56e057f20f883e&orgCode=sju')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (214, N'd8ee13c67cd149248f27fc8c1452a0d9', CAST(0x0000AAD600B92C5A AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (215, N'1bbd1e66305f4c498d1808255f3a0b91', CAST(0x0000AAD600B92C5D AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (216, N'11afc2f4c8ae4347a2aed98f510aa95b', CAST(0x0000AAD600B92DB8 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sys_Home/desktop', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (217, N'ee94098c16244733bfe347540a7800ef', CAST(0x0000AAD600B92F32 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/af_AuditPost/Select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (218, N'2d7616a07afb41eaa9034605d6146746', CAST(0x0000AAD600B930EA AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/af_AuditPostUser/Select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (219, N'94530347247a46b6b82fb1a0dbded196', CAST(0x0000AAD600B96C7F AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (220, N'34c0c27fe15444a58ec5f7413c5f9791', CAST(0x0000AAD600B96F95 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/Login/AdminLogin', N'POST      ', N'&tbxUserName=sysAdmin&tbxPassword=e10adc3949ba59abbe56e057f20f883e&orgCode=sju')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (221, N'9ff0413ad0ff4730ab72fe51d7eaaef7', CAST(0x0000AAD600B96F96 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (222, N'6f1c331aaba743f1bc3b510a1add597f', CAST(0x0000AAD600B96FC6 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (223, N'8bf04f74e32c4458836ce86a2df4a7ab', CAST(0x0000AAD600B96FCC AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (224, N'324793af3e0842dea99f0070b5ae13df', CAST(0x0000AAD600B9713D AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sys_Home/desktop', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (225, N'8faa2213a58a4c2b96f7e516bdb34c7b', CAST(0x0000AAD600B97299 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/af_AuditPostUser/Select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (226, N'4813a048c774490e8cfe73fc55f44464', CAST(0x0000AAD600BA3850 AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (227, N'9d2a6df373a04696af0583ffe16364be', CAST(0x0000AAD600BAAAD8 AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (228, N'40d14a34ae68487297eb64a27ea760df', CAST(0x0000AAD600BAAAD8 AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (229, N'932bfff2d4f949e6900604b03d301548', CAST(0x0000AAD600BAAD90 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (230, N'f2c4c6494b2040ada0dd428c0f39eb80', CAST(0x0000AAD600BAADA9 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/Login/AdminLogin', N'POST      ', N'&tbxUserName=sysAdmin&tbxPassword=e10adc3949ba59abbe56e057f20f883e&orgCode=sju')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (231, N'11474a6b910d407fa12d2c6611cde238', CAST(0x0000AAD600BAADD0 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (232, N'ee5a413b01b64efb81e350fb63f6033b', CAST(0x0000AAD600BAADD4 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (233, N'd1708a1d5f1343c0a10a7a168ea71e42', CAST(0x0000AAD600BAAE80 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sys_Home/desktop', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (234, N'e83868d2c70d4482ae6972394e1a9979', CAST(0x0000AAD600BAAFE8 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/af_AuditPost/Select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (235, N'b6a59ed8351b459797b629b2a261fed7', CAST(0x0000AAD600BAB39C AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/af_AuditPostUser/Select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (236, N'1d0ba7e8d2bc489db267c34251c969ad', CAST(0x0000AAD600BAB55E AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/af_AuditPost/Select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (237, N'6266c0edc6494e69ae8dd30fea5b6ea1', CAST(0x0000AAD600BAB8C6 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/rbac_User/Select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (238, N'afdc2e1f09714b90bc3ce5a5dc242fb9', CAST(0x0000AAD600BABD71 AS DateTime), N'提交', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/rbac_User/Select', N'http://localhost:9021/admin/af_AuditPostUser/userBatchPost?postCode=001', N'POST      ', N'&postCode=001&selectedkeyCodes=001702,')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (239, N'a11c88fdb4cb43fa9e0bace19377638d', CAST(0x0000AAD600BABDC0 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/rbac_User/Select', N'http://localhost:9021/admin/rbac_User/select?PageIndex=1&orderField=userCode&orderWay=asc&deptCode=&userCode=&userName=&isLogin=&exeCountSql=true', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (240, N'6066a739cacd4b11b5592528d44484c8', CAST(0x0000AAD600BAD22D AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/af_AuditPostUser/Select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (241, N'1d40eaee251849dd9b363d56424848fa', CAST(0x0000AAD600BAF7E1 AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (242, N'88b7af04a64841139695f172e874bbd6', CAST(0x0000AAD600BAFAB7 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (243, N'6b90eebcaf9d42f68255875f376097e3', CAST(0x0000AAD600BAFADC AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/Login/AdminLogin', N'POST      ', N'&tbxUserName=sysAdmin&tbxPassword=e10adc3949ba59abbe56e057f20f883e&orgCode=sju')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (244, N'90324d38ff0d44388df6f2ea99151e18', CAST(0x0000AAD600BAFB00 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (245, N'cb920a481c934c0395dfc2854cf46261', CAST(0x0000AAD600BAFB06 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (246, N'58b7e0cb4e0548c6b97d65416cbb6273', CAST(0x0000AAD600BAFC81 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sys_Home/desktop', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (247, N'e2a7ac054b0c432ab16900d29fbf4cf0', CAST(0x0000AAD600BAFE28 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/af_AuditPostUser/Select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (248, N'1c5bb53a398d404fadb38cafdaa494bd', CAST(0x0000AAD600BB2E0D AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/login/adminToLogin', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (249, N'b7188067790c4557beacfba12706c82b', CAST(0x0000AAD600BB2E14 AS DateTime), N'请求', NULL, NULL, NULL, N'http://localhost:9021/login/adminToLogin', N'http://localhost:9021/login/adminLogin', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (250, N'dd573f660d1948d5b327ea44644c6d7a', CAST(0x0000AAD600BB2E17 AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/admin/af_AuditPost/Update', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (251, N'57520ce1cf424509bf1c46f844ab28fa', CAST(0x0000AAD600BB3078 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/login/adminLogin', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (252, N'b391e3f00d4a4bde9ec110cabbb5b1c7', CAST(0x0000AAD600BB3091 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/login/adminLogin', N'http://localhost:9021/Login/AdminLogin', N'POST      ', N'&tbxUserName=sysAdmin&tbxPassword=e10adc3949ba59abbe56e057f20f883e&orgCode=sju')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (253, N'ac2a76f79c024a41b5de586bec2d8e94', CAST(0x0000AAD600BB30AE AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (254, N'bf6cd5b280ba4c30bed0d7670666511b', CAST(0x0000AAD600BB30B2 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/login/adminLogin', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (255, N'5b1ac7c4f2414e40bf296b8f6b9d313a', CAST(0x0000AAD600BB3151 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sys_Home/desktop', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (256, N'c3b1568ca10f4a638b8b438bb7ff7441', CAST(0x0000AAD600BB32D1 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/af_AuditPostUser/Select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (257, N'018c28c86e2949f4a2b77c7af3e5e5b6', CAST(0x0000AAD600BB77F0 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/af_AuditPostUser/Select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (258, N'be9fd95c6399419ead4c2095368d62cc', CAST(0x0000AAD600BB8596 AS DateTime), N'提交', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/af_AuditPostUser/Select', N'http://localhost:9021/admin/af_AuditPostUser/batchSave', N'POST      ', N'&detail.rowID=10006&detail.isDeptPost=否&detail.deptCode=B001')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (259, N'50cce7725dd3415bb0dfa7f48af8e6ce', CAST(0x0000AAD600BB892D AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/af_AuditPostUser/Select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (260, N'1b30e54adf27491e902e0e74c9db0fc0', CAST(0x0000AAD600BB9032 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/rbac_User/Select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (261, N'3543ea7dd8594d2cb365fd7de0025196', CAST(0x0000AAD600BB9A4D AS DateTime), N'提交', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/rbac_User/Select', N'http://localhost:9021/admin/af_AuditPostUser/userBatchPost?postCode=003', N'POST      ', N'&postCode=003&selectedkeyCodes=001703,sysAdmin,')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (262, N'ea2617ab32a840449c928ee04a3cd091', CAST(0x0000AAD600BB9AAA AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/rbac_User/Select', N'http://localhost:9021/admin/rbac_User/select?PageIndex=1&orderField=userCode&orderWay=asc&deptCode=&userCode=&userName=&isLogin=&exeCountSql=true', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (263, N'19670db2a9834b9e9f67545c01a17498', CAST(0x0000AAD600BB9CD4 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/af_AuditPostUser/Select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (264, N'3ee7897aa80043608c8735bb242ef385', CAST(0x0000AAD600BBAF38 AS DateTime), N'提交', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/af_AuditPostUser/Select', N'http://localhost:9021/admin/af_AuditPostUser/batchSave', N'POST      ', N'&detail.rowID=10008,10007,10006&detail.isDeptPost=是,是,否&detail.deptCode=B002,B001,')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (265, N'd17d073258b0405baed95bc3761cf0dc', CAST(0x0000AAD600BBB17A AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/af_AuditPostUser/Select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (266, N'4ee324ebe6a942b1aff41717079c576e', CAST(0x0000AAD600BBB298 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/af_AuditPostUser/Select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (267, N'ef942eda753f418f8d7876d9098f5e18', CAST(0x0000AAD600BBB5C3 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/af_AuditPostUser/Select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (268, N'a1ea28b9833c44f59ef5a4cacd75a750', CAST(0x0000AAD7015C4A4A AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (269, N'ac878a80b61c4d17ae086e749ec82ca9', CAST(0x0000AAD901069C81 AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (270, N'5a1679e676c543db935d9d6dc4f7108c', CAST(0x0000AAD90106A07D AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (271, N'7eacde564d654bac880771107265ddd3', CAST(0x0000AAD90106A091 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/Login/AdminLogin', N'POST      ', N'&tbxUserName=sysAdmin&tbxPassword=e10adc3949ba59abbe56e057f20f883e&orgCode=sju')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (272, N'9451b30d38244d069dd712657d262733', CAST(0x0000AAD90106A0BB AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (273, N'5fdbfa52df19426da83963cf62b490a8', CAST(0x0000AAD90106A0C1 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (274, N'1410bcdc86a949d3870190d4d436e535', CAST(0x0000AAD90107154B AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/admin/sys_Home/Index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (275, N'7cdb6eae56ea43028c37dad0a448432b', CAST(0x0000AAD90107154B AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/login/adminToLogin', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (276, N'3dfad5eacf61435998b6f7efba73e6b8', CAST(0x0000AAD901071555 AS DateTime), N'请求', NULL, NULL, NULL, N'http://localhost:9021/login/adminToLogin', N'http://localhost:9021/login/adminLogin', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (277, N'c8f9219257f2478ebaed82d593ef940b', CAST(0x0000AAD90107175C AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/login/adminLogin', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (278, N'c2f04f3e04f1487e94dd62bec9b7576c', CAST(0x0000AAD90107177F AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/login/adminLogin', N'http://localhost:9021/Login/AdminLogin', N'POST      ', N'&tbxUserName=sysAdmin&tbxPassword=e10adc3949ba59abbe56e057f20f883e&orgCode=sju')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (279, N'399b090277b541e3b6b8b343a899b496', CAST(0x0000AAD9010717A7 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (280, N'471efed24ce242049d862b9bb657a8f4', CAST(0x0000AAD9010717AD AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/login/adminLogin', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (281, N'43e135a16259471aab4a6b7f531d8586', CAST(0x0000AAD90107190F AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sys_Home/desktop', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (282, N'077e52ae0147426e8a6ac31ddb7e700c', CAST(0x0000AAD901071ABA AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/rbac_Role/select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (283, N'98625f753cee49d782d6a134b6ab0a4b', CAST(0x0000AAD901071DB1 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/rbac_User/Select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (284, N'3f5b67b8b9dd49578a25a51a9fc5d69f', CAST(0x0000AAD901072335 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/af_AuditPost/Select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (285, N'80bcb0e1551c420abebce3614433b8ff', CAST(0x0000AAD9010726D0 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/af_AuditPostUser/Select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (286, N'49eac2d632224b53b84250f3b404eb97', CAST(0x0000AAD9010BCA88 AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/Login/toDesktop', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (287, N'7716a453aa604510aae5cb298bb7dc13', CAST(0x0000AAD9010BDA95 AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/Login/toDesktop', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (288, N'7e9de753b2c640cdb17e1aac7dd9df5d', CAST(0x0000AAD9010BFB5E AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (289, N'fca48844f8764682b67db99e5f184c84', CAST(0x0000AAD9010BFB7F AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/login/toLogin', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (290, N'1a250b7dccee4e76931b190219606745', CAST(0x0000AAD9010BFB85 AS DateTime), N'请求', NULL, NULL, NULL, N'http://localhost:9021/login/toLogin', N'http://localhost:9021/login/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (291, N'563a3f10968e4e828713a409a80f783d', CAST(0x0000AAD9010C0031 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/login/index', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (292, N'db40835748dc4ab18c5bff929d39500c', CAST(0x0000AAD9010C33D6 AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/Login/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (293, N'1d9b681e66ce4af68733bb774f9613b8', CAST(0x0000AAD9010C3813 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/Login/index', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (294, N'959ff00b86c94140b04449fe5b188692', CAST(0x0000AAD9010C382A AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/Login/index', N'http://localhost:9021/Login/index', N'POST      ', N'&tbxUserName=sysAdmin&tbxPassword=e10adc3949ba59abbe56e057f20f883e&orgCode=sju')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (295, N'254eadf6ff41429b8db90111ba8b07c5', CAST(0x0000AAD9010C3857 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (296, N'43256ac4e31f4f7bb68ca57131421e20', CAST(0x0000AAD9010C385F AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/Login/index', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (297, N'6fd2915074b9431eb04c745ee1371950', CAST(0x0000AAD9010C39EC AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sys_Home/desktop', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (298, N'205f6deedf6d40e39b6732ed315453a5', CAST(0x0000AAD9010C3C8F AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sys_Home/exit', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (299, N'd9dbc30e6ea0414bba6af7313def5019', CAST(0x0000AAD9010C3C93 AS DateTime), N'请求', NULL, NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/Login/toLogin', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (300, N'e3ce9d22984240069a2894eeac19e9dd', CAST(0x0000AAD9010C3C99 AS DateTime), N'请求', NULL, NULL, NULL, N'http://localhost:9021/Login/toLogin', N'http://localhost:9021/login/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (301, N'7fb39ffcdf6d4695ad6906250d3e1e52', CAST(0x0000AAD9010C68D4 AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (302, N'2475d72a7ae7490d9fa45a2c65347046', CAST(0x0000AAD9010C6F9C AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (303, N'75eee5a8715742c2be0b1f5b9e1c738b', CAST(0x0000AAD9010C6FB6 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/Login/index', N'POST      ', N'&tbxUserName=sysAdmin&tbxPassword=e10adc3949ba59abbe56e057f20f883e&orgCode=sju')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (304, N'c145628ce75f4fda8e18e133a2832d2a', CAST(0x0000AAD9010C6FE1 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (305, N'023b92c694a2414eb7b92365a6a7f4a4', CAST(0x0000AAD9010C6FEA AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (306, N'1890802efb7c49278b7846fa04d150fa', CAST(0x0000AAD9010C715B AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sys_Home/desktop', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (307, N'e3bf0cb14e1c4034924b85628c3f43a9', CAST(0x0000AAD9010C73D3 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sys_Home/exit', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (308, N'688dda2cf4b645bb9cabdf543d8baba0', CAST(0x0000AAD9010C73D4 AS DateTime), N'请求', NULL, NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/Login/toLogin', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (309, N'3f87e8709ca54a7c9a89bb11695db958', CAST(0x0000AAD9010C73DB AS DateTime), N'请求', NULL, NULL, NULL, N'http://localhost:9021/Login/toLogin', N'http://localhost:9021/login/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (310, N'c081b3b5ec344f8d9d83ed161317c761', CAST(0x0000AAD9010DAD78 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/login/index', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (311, N'ef62f25146214b2dbbb9e6bdd0313bcb', CAST(0x0000AAD9010DAD92 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/login/index', N'http://localhost:9021/Login/index', N'POST      ', N'&tbxUserName=sysAdmin&tbxPassword=e10adc3949ba59abbe56e057f20f883e&orgCode=sju')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (312, N'e4e9192983114e87a67d04117b47a203', CAST(0x0000AAD9010DADA8 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (313, N'89b785c4f95445708f2102da1d9a4b84', CAST(0x0000AAD9010DADAD AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/login/index', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (314, N'a33f27cfadb54e748de35c00c89a7a6c', CAST(0x0000AAD9010DADF9 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sys_Home/desktop', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (315, N'74365001711042bbb1ea95218ece9c6b', CAST(0x0000AAD9010DB498 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/rbac_Role/select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (316, N'cdab0b8273b24b4c8b96ff5248b5f7d6', CAST(0x0000AAD9010DB9F7 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/rbac_User/Select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (317, N'e1c0c8d1f43b45bbaf24f3bcb9240c11', CAST(0x0000AAD9010DF4EB AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (318, N'a590293540404a42a165a4653fc6ba20', CAST(0x0000AAD9010DF7C7 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (319, N'e399bea04c2a457db12b17b7029c7345', CAST(0x0000AAD9010DF7DC AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/Login/index', N'POST      ', N'&tbxUserName=sysAdmin&tbxPassword=e10adc3949ba59abbe56e057f20f883e&orgCode=sju')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (320, N'54863eb0f7ec4a058794e4d92a3a9e3f', CAST(0x0000AAD9010DF804 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (321, N'1dfc279a04f341f7a665a91de9c36e07', CAST(0x0000AAD9010DF80D AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (322, N'13a55b77d51d47f9a923950f09dd94d8', CAST(0x0000AAD9010DF8BF AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sys_Home/desktop', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (323, N'17ed639fc2964f838e09764d2aa10ecc', CAST(0x0000AAD9010DFFF0 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/rbac_Role/select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (324, N'03e7cda91edc4ae0aaeeb70a1c8d5070', CAST(0x0000AAD9010E01F5 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sbs_Org/select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (325, N'45b2e7b5043c43ad8b65e8b9cc9f704b', CAST(0x0000AAD9010E1E18 AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (326, N'9d0bdef66b1b47b7a9d72d2f96804a09', CAST(0x0000AAD9010E2118 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (327, N'9d9e1ca1b4a64d7cad7eb93f7f889991', CAST(0x0000AAD9010E2133 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/Login/index', N'POST      ', N'&tbxUserName=sysAdmin&tbxPassword=e10adc3949ba59abbe56e057f20f883e&orgCode=sju')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (328, N'b8891f429e7841d5b37727493f216a61', CAST(0x0000AAD9010E215D AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (329, N'501b82b5ee734e1a98843544fdc19696', CAST(0x0000AAD9010E2160 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (330, N'f22664dc03164a239e69d846c96faa46', CAST(0x0000AAD9010E2208 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sys_Home/desktop', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (331, N'7f43658db971471c9af949477a6860ae', CAST(0x0000AAD9010E2376 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sys_Home/changePW', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (332, N'cbea1ee48f834718a2e9904b0a33a473', CAST(0x0000AAD9010E2808 AS DateTime), N'提交', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/changePW', N'http://localhost:9021/admin/sys_Home/ChangePW', N'POST      ', N'&oldPW=&newPW1=&newPW2=')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (333, N'81f6cdbe20254571ad3226b83f183fbe', CAST(0x0000AAD9010E2D19 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sys_Home/changePW', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (334, N'3c31eb23bfdb4487b108f8453fd1dbd5', CAST(0x0000AAD9010E2E1E AS DateTime), N'提交', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/changePW', N'http://localhost:9021/admin/sys_Home/ChangePW', N'POST      ', N'&oldPW=&newPW1=&newPW2=')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (335, N'ec60443112884190a0002056f40b07c1', CAST(0x0000AAD9010E31DF AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/rbac_Role/select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (336, N'4bccbeee0c374fe98608975cf084a426', CAST(0x0000AAD9010E32CF AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/rbac_User/Select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (337, N'7324ce03afb84116b12bfce9b5e47c08', CAST(0x0000AAD9016AD23C AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (338, N'f9b5b91aac5d43688d53785b48fa2894', CAST(0x0000AAD9016AD556 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (339, N'71a8d0cd57584e6290567ce8681d6df3', CAST(0x0000AAD9016B0C6C AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/Login/adminLogin', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (340, N'ad6c7e5d53b543e68211f26566876135', CAST(0x0000AAD9016B0FB2 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/Login/adminLogin', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (341, N'28b8c9c5e2eb499dbc7d49dabb72f995', CAST(0x0000AAD9016B0FC6 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/Login/adminLogin', N'http://localhost:9021/Login/adminLogin', N'POST      ', N'&tbxUserName=sysAdmin&tbxPassword=e10adc3949ba59abbe56e057f20f883e&orgCode=sju')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (342, N'60cff9dbc29f465da10f89ecf2352e6a', CAST(0x0000AAD9016B0FF9 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (343, N'4c360ab3be9a4ca08561c2a81b591ef5', CAST(0x0000AAD9016B0FFF AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/Login/adminLogin', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (344, N'd240f055b2304aa689e74d3b5b572080', CAST(0x0000AAD9016B1172 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sys_Home/desktop', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (345, N'4b61ecf0661a4b559695591499f1f4bb', CAST(0x0000AADA00B157C7 AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/admin/af_AuditPost/Select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (346, N'277a1a3a55e84953bf2677cf8d76e8c2', CAST(0x0000AADA00B157C7 AS DateTime), N'请求', NULL, NULL, NULL, N'http://localhost:9021/login/toLogin', N'http://localhost:9021/login/adminLogin', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (347, N'a1889fc57cea40d6989c90046397255c', CAST(0x0000AADA00B157CA AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/login/toLogin', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (348, N'5412fddece16434886fa4359adfba416', CAST(0x0000AADA00B15A5D AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/login/adminLogin', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (349, N'bfaf819bf84e4fb881fa4932f8e006be', CAST(0x0000AADA00B15A6B AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/login/adminLogin', N'http://localhost:9021/Login/adminLogin', N'POST      ', N'&tbxUserName=sysAdmin&tbxPassword=e10adc3949ba59abbe56e057f20f883e&orgCode=sju')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (350, N'ba026ffe27b74fd2b3b70e83c8db76b2', CAST(0x0000AADA00B15A93 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (351, N'1163bc7eb0944e05aa84f4c9ef26a80f', CAST(0x0000AADA00B15A97 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/login/adminLogin', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (352, N'75f08f93e9e645bc92e74b11a1ba1410', CAST(0x0000AADA00B15C37 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sys_Home/desktop', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (353, N'48af3ae22a1e4bc8bc4148f48ca5a9f6', CAST(0x0000AADA00B15D82 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/rbac_Role/select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (354, N'c43e80fd3abe4367b80ad76e7aaec968', CAST(0x0000AADA00B160C3 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/rbac_Role/select', N'http://localhost:9021/admin/rbac_Role/Update?rowID=1', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (355, N'c0e7db23f8e34761ac023de77e9c24e1', CAST(0x0000AADA00B1624A AS DateTime), N'提交', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/rbac_Role/Update?rowID=1', N'http://localhost:9021/admin/rbac_Role/Update?rowID=1', N'POST      ', N'&rowID=1&rowID=1&roleCode=R0001&roleName=232&remark=234')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (356, N'df9d5378ebf7438ab6dac6881e7e5dd3', CAST(0x0000AADA00B1625A AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/rbac_Role/select', N'http://localhost:9021/admin/rbac_Role/select?PageIndex=1&orderField=roleCode&orderWay=asc&roleName=&exeCountSql=true', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (357, N'aa3a32d51f9a43d88d7ef639cea19a5f', CAST(0x0000AADA00B16550 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/rbac_Role/select', N'http://localhost:9021/admin/rbac_Role/Update?rowID=1', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (358, N'dae8ac1c6d67491d90ef734385554e68', CAST(0x0000AADA00B166ED AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/rbac_Role/select', N'http://localhost:9021/admin/rbac_Role/select?PageIndex=1&orderField=roleCode&orderWay=asc&roleName=&exeCountSql=true', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (359, N'2fa231b29fef475e9f896fbf610aab30', CAST(0x0000AADA0167DF9E AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (360, N'8a31b09d57e74ef899018acf91d3f5fd', CAST(0x0000AADA01686618 AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (361, N'f2741e69d59142b4a788456a689a7165', CAST(0x0000AADA01686963 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (362, N'34cbfce2b8d7438cbc2088bd169364a9', CAST(0x0000AADA01686976 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/Login/adminLogin', N'POST      ', N'&tbxUserName=sysAdmin&tbxPassword=e10adc3949ba59abbe56e057f20f883e&orgCode=sju')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (363, N'c7913b3a45884f3f93ac431db7af0fe7', CAST(0x0000AADA0168699F AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (364, N'643b379d6013425d98286a1d27f9e855', CAST(0x0000AADA016869A8 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (365, N'348ee0f5fd56487c8e05f7efc810326a', CAST(0x0000AADA01686B16 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sys_Home/desktop', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (366, N'86e3fc288226485ea32bada1b1cf6ded', CAST(0x0000AADA01686CA6 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/rbac_Role/select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (367, N'1ea03ec722f3471d955da00b5b7cb401', CAST(0x0000AADA01686F28 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/rbac_User/Select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (368, N'ffb6ced003d54f4ea6b9ae20b910a6c0', CAST(0x0000AADA0168712C AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/af_AuditPost/Select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (369, N'ec59477838654b3c875fd64bafa36830', CAST(0x0000AADA016873B2 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/af_AuditPost/Select', N'http://localhost:9021/admin/af_AuditPost/Update?rowID=4', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (370, N'2bffafc78227466fa573158cfb8067b3', CAST(0x0000AADA016874CF AS DateTime), N'提交', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/af_AuditPost/Update?rowID=4', N'http://localhost:9021/admin/af_AuditPost/Update?rowID=4', N'POST      ', N'&rowID=4&rowID=4&postCode=004&postName=副院长&isDeptPost=是&remark=')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (371, N'4ea1fd9945db4b868eeef4b813b40745', CAST(0x0000AADA016874DC AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/af_AuditPost/Select', N'http://localhost:9021/admin/af_AuditPost/Select?PageIndex=1&orderField=postCode&orderWay=desc&postCode=&postName=&exeCountSql=true', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (372, N'fcc34a197c7242789eacaa1cb6e2dad9', CAST(0x0000AADA016A3598 AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (373, N'9c5170dc1cd849079b0eae6d446ea140', CAST(0x0000AADA016A3B28 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (374, N'f59d0949b3644ec7827ce5739153fb26', CAST(0x0000AADA016A3B36 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/Login/adminLogin', N'POST      ', N'&tbxUserName=sysAdmin&tbxPassword=e10adc3949ba59abbe56e057f20f883e&orgCode=sju')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (375, N'ac83cd8078a54a868fe5cabf3960a853', CAST(0x0000AADA016A3B64 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (376, N'b0c8b8e21bf0496c9b1d6b3a60ceed35', CAST(0x0000AADA016A3B67 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (377, N'135a688c807343dda413e8307d23a86b', CAST(0x0000AADA016A3CD4 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sys_Home/desktop', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (378, N'675f6c83f03a4627b0230145a799d766', CAST(0x0000AADA016A41D6 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/af_AuditType/select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (379, N'f94d3c8ba05e4e82ad7964719dfa904d', CAST(0x0000AADA016A43DD AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/af_AuditPostUser/Select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (380, N'fe7de9d184af4939800257d596859308', CAST(0x0000AADA016A473D AS DateTime), N'提交', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/af_AuditPostUser/Select', N'http://localhost:9021/admin/af_AuditPostUser/batchSave', N'POST      ', N'&detail.rowID=10008,10007,10006&detail.isDeptPost=是,是,否&detail.deptCode=B002,B001,')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (381, N'8354aa7b7c5d4d28ab881ab887297e6e', CAST(0x0000AADE01445034 AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (382, N'359f1f53bcd54f86b23b74cba251db21', CAST(0x0000AADE0144532F AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (383, N'8f259b73695b4ed4847dc11300af7e93', CAST(0x0000AADE01445341 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/Login/adminLogin', N'POST      ', N'&tbxUserName=sysAdmin&tbxPassword=e10adc3949ba59abbe56e057f20f883e&orgCode=sju')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (384, N'a12ee83fd25f4e5ea404b8e9296848da', CAST(0x0000AADE0144536D AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (385, N'bb075f0105154351b3949cf0ac538582', CAST(0x0000AADE01445372 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (386, N'd21f302f8d4346bc801b52ae51e7a891', CAST(0x0000AADE014454EF AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sys_Home/desktop', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (387, N'fa344fc8db2d44abaade9c30dd8eeb11', CAST(0x0000AAE301312935 AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/admin/rbac_Resource/Select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (388, N'6495724ecc964a6ca8f2b6866bcec972', CAST(0x0000AAE301312935 AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/login/toLogin', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (389, N'c0e0a50937c14b2b85ac5e7421c6635a', CAST(0x0000AAE3013129BD AS DateTime), N'请求', NULL, NULL, NULL, N'http://localhost:9021/login/toLogin', N'http://localhost:9021/login/adminLogin', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (390, N'285a92441de2425a97486be0e736ebba', CAST(0x0000AAE301312E8F AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/login/adminLogin', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (391, N'9c14230ff93040a79797e41ac75ac5eb', CAST(0x0000AAE30131330C AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/login/adminLogin', N'http://localhost:9021/Login/adminLogin', N'POST      ', N'&tbxUserName=sysAdmin&tbxPassword=e10adc3949ba59abbe56e057f20f883e&orgCode=sju')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (392, N'5a8ffe4765104cc0a662c062c6545780', CAST(0x0000AAE30131332E AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (393, N'8895d4a1a2944f50aed0af70b7207cbd', CAST(0x0000AAE301313333 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/login/adminLogin', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (394, N'206a8bc29e95484dab05a9b7be5f9a19', CAST(0x0000AAE301313624 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sys_Home/desktop', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (395, N'1bdf362195724cf38fe5a6e1de9c32ba', CAST(0x0000AAE3013139FE AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/rbac_Resource/select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (396, N'd01eb6a3d6714db0a96a057357f9bf83', CAST(0x0000AAE301314203 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/rbac_Resource/select', N'http://localhost:9021/admin/rbac_Resource/Select?PageIndex=1&exeCountSql=true&moduleCode=&resourceName=&text=', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (397, N'110bde82c9c04430837be685eb5c65c4', CAST(0x0000AAE301315B27 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (398, N'609503c44c7c4e91aa76c9778f54183d', CAST(0x0000AAE301315B8C AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sys_Home/desktop', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (399, N'5cb76ae8fb4846b696076f2791c7f77f', CAST(0x0000AAE301315F1B AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/rbac_Module/select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (400, N'506f671dc31841d284a1d11d99ef059d', CAST(0x0000AAE301316071 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/rbac_Resource/select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (401, N'dfe2a051a997415fb7bf7ccdf7f4e8ad', CAST(0x0000AAE3013165BC AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/rbac_Resource/select', N'http://localhost:9021/admin/rbac_Resource/Select?PageIndex=1&exeCountSql=true&moduleCode=&resourceName=', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (402, N'7e7e5b14d37c4e9f9709834c18a0514a', CAST(0x0000AAE3013184BB AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (403, N'cd50dd57afe149e0af77cf1f5439588a', CAST(0x0000AAE301318518 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sys_Home/desktop', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (404, N'3ec89b18386b4ed1a27f618a4a8517d4', CAST(0x0000AAE3013187ED AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/rbac_Resource/select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (405, N'462364356ffa4cf1a66e6d52e4904e9d', CAST(0x0000AAE301318DBF AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/rbac_Resource/select', N'http://localhost:9021/admin/rbac_Resource/Select?PageIndex=1&exeCountSql=true&moduleCode=&resourceName=&text=123', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (406, N'fd690b9cb2f3403bb06fe83763bece94', CAST(0x0000AAEE0125AB75 AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (407, N'a4f9504afd99447f94629616bd6655f7', CAST(0x0000AAEE0125AB82 AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/login/adminLogin', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (408, N'b9c1104c8e03452896a5d9d8ad5e9187', CAST(0x0000AAEE0125ABCF AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/login/priv', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (409, N'765fa01019034e719b9b98c63d2b2118', CAST(0x0000AAEE0125B1C8 AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/login/priv', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (410, N'c38f283ddf04479c8d83f4d5a0265dc5', CAST(0x0000AAEE0131FB4B AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (411, N'5dd893da643940d580fa37e2da853c4d', CAST(0x0000AAEE0131FB52 AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/login/priv', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (412, N'431e17f5e6d34d28a2f13783ccb2f185', CAST(0x0000AAEE013536C9 AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (413, N'c6207bd79e4a475f8baa13edf8e7fd21', CAST(0x0000AAEE013536D1 AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/login/priv', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (414, N'e9ede7b631d3451a9f603c6c4fe5eb5e', CAST(0x0000AAEF0106F177 AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (415, N'8ea3fda26c6044f3b46bd06070a91bad', CAST(0x0000AAEF0106FD8B AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (416, N'39fa63d9c2a14782bf2c42f1d561ec78', CAST(0x0000AAEF010701B1 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/Login/adminLogin', N'POST      ', N'&tbxUserName=sysAdmin&tbxPassword=67783f91a310c414d181b75ca566e38e&orgCode=sju')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (417, N'3fb6f1a2b2be4aaca9ddb45ef5eab561', CAST(0x0000AAEF01070786 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/Login/adminLogin', N'POST      ', N'&tbxUserName=sysAdmin&tbxPassword=e10adc3949ba59abbe56e057f20f883e&orgCode=sju')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (418, N'c87406b9fb7e4358ae53138d20c9c0f2', CAST(0x0000AAEF0107079A AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (419, N'bd9ac4dfa5c04b3495554e8aa02b0af3', CAST(0x0000AAEF0107079E AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (420, N'00e4655bc37f4b76bd70aed39101505d', CAST(0x0000AAEF01070940 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sys_Home/desktop', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (421, N'e942e32863754126a95a19ae8c035ccb', CAST(0x0000AAEF01070D18 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/rbac_User/Select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (422, N'b035b73b09ff483aa0f73e9318fcbc83', CAST(0x0000AAEF0107F027 AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (423, N'4128ff6d3a7b4207ac331e8a33ca0060', CAST(0x0000AAEF0107F402 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (424, N'dffaa4e0631f4b668bbea4fcb5256c40', CAST(0x0000AAEF0107F420 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/Login/adminLogin', N'POST      ', N'&tbxUserName=sysAdmin&tbxPassword=e10adc3949ba59abbe56e057f20f883e&orgCode=sju')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (425, N'e55aac84a7464e70aa1938e4ab99edaa', CAST(0x0000AAEF0107F456 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (426, N'd60a5459e0da4c32985e9f4e4fcf5da1', CAST(0x0000AAEF0107F45A AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (427, N'dff5cff33256433789d1dbe9a595bf44', CAST(0x0000AAEF0107F609 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sys_Home/desktop', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (428, N'a0dcac8c65e448169fe37b18efc42c05', CAST(0x0000AAEF0107FE40 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/rbac_Role/select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (429, N'ea886a7e58f24f709cae48845520de78', CAST(0x0000AAEF01080199 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/rbac_User/Select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (430, N'cca21869859f48f9b35b5fd48688856f', CAST(0x0000AAEF0108051F AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/af_AuditPost/Select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (431, N'85a5dbde93184145907d84b9f6d86567', CAST(0x0000AAEF010806D1 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/af_AuditPostUser/Select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (432, N'033cc9be219841299dacbe5271845abc', CAST(0x0000AAEF010808CC AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/af_AuditType/select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (433, N'58256b91e779493ab88223c98fdd8c69', CAST(0x0000AAEF01080BEF AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/rbac_Module/select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (434, N'cc6482d1046042a8b733debaf6763729', CAST(0x0000AAEF01080DB1 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/rbac_Resource/select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (435, N'51b965784cb74d1487467e3b2cdeae1a', CAST(0x0000AAEF010810E3 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sbs_Org/select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (436, N'1b5db54e3c8e41218c3d0c7cc4e0ebdf', CAST(0x0000AAEF010812A2 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sbs_Dept/select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (437, N'4afb8412e35d40629ecfb1bf6cccdde0', CAST(0x0000AAEF010813F8 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sbs_Empl/select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (438, N'dce39f610862458b8b3d5894d085f267', CAST(0x0000AAEF01081682 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/rbac_Role/select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (439, N'8890d6b9d4eb45bf9079f93b873d7843', CAST(0x0000AAEF010817B4 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/rbac_User/Select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (440, N'793ced65cbf040eba010a39e7beeffdf', CAST(0x0000AAEF0108186E AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/af_AuditPost/Select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (441, N'40d474b9f3104f669f2de41c5cda030c', CAST(0x0000AAEF01081942 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/af_AuditPostUser/Select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (442, N'2babb6fc7aee44b8a6b30be152e7a34b', CAST(0x0000AAEF010819EB AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/af_AuditType/select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (443, N'3197cccdb67845d3ac3d1acbf04adef3', CAST(0x0000AAEF01081AD9 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/af_AuditFlow/select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (444, N'050f9891de4147f3bc4cf2e5c7ec7487', CAST(0x0000AAEF01081C9E AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/af_AuditCenter/select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (445, N'03847f3bc9d44183b248466a37e1611e', CAST(0x0000AAEF01086DA7 AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (446, N'3859a837062a4c4285ce3623318f26bb', CAST(0x0000AAEF010870C2 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (447, N'59f44b08a2d54a0d8024b93130d22c33', CAST(0x0000AAEF010870DE AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/Login/adminLogin', N'POST      ', N'&tbxUserName=sysAdmin&tbxPassword=e10adc3949ba59abbe56e057f20f883e&orgCode=sju')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (448, N'249f34f0243347579a188613a89f0c58', CAST(0x0000AAEF01087118 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (449, N'c1ef6bcd91884f18979a7d92f8b5b3f7', CAST(0x0000AAEF0108711F AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (450, N'768ab566f624456390b32d3c3efcb10b', CAST(0x0000AAEF01087293 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sys_Home/desktop', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (451, N'c326b239278945fda2150c7bcba5072f', CAST(0x0000AAEF010873BA AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/rbac_Role/select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (452, N'362a65147867402d8c87ec6169c606f3', CAST(0x0000AAEF0108AD80 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/rbac_Role/select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (453, N'79f09cdde62f47948b72a55bd43ca257', CAST(0x0000AAEF0108E4C5 AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (454, N'ee0c5b6da36b47b28e9b18bf95ed75df', CAST(0x0000AAEF0108E80B AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (455, N'd83a27619fdd407c836bfb5b685f7de4', CAST(0x0000AAEF0108E825 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/Login/adminLogin', N'POST      ', N'&tbxUserName=sysAdmin&tbxPassword=e10adc3949ba59abbe56e057f20f883e&orgCode=sju')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (456, N'29567d4e7bd34ddbb7e1b1290883db5a', CAST(0x0000AAEF0108E857 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (457, N'79d1d03019a24bf9b28770bd21eb95c6', CAST(0x0000AAEF0108E85D AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (458, N'e6a3c599fc81490584f17111e5a35ecb', CAST(0x0000AAEF0108E9C7 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sys_Home/desktop', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (459, N'87c6732ebc474afe95d9e042cb4bb1eb', CAST(0x0000AAEF0108EB08 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/rbac_Role/select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (460, N'af618141fe664abfbae9bbc28b644ec6', CAST(0x0000AAEF0109437E AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (461, N'd9069d0fbb9b4aa7849601f81183a536', CAST(0x0000AAEF010947D8 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (462, N'fd609b381e5e4c1485791a0586b72f52', CAST(0x0000AAEF010947D9 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/Login/adminLogin', N'POST      ', N'&tbxUserName=sysAdmin&tbxPassword=e10adc3949ba59abbe56e057f20f883e&orgCode=sju')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (463, N'737ad9d7f00b44d18cd80d050cb50359', CAST(0x0000AAEF0109481D AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (464, N'9dec24a3f7524129a13d0638110bb281', CAST(0x0000AAEF01094827 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (465, N'114745fdc9cc4137929bd4cbd3c89a4f', CAST(0x0000AAEF010949A4 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sys_Home/desktop', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (466, N'2160527b51d943089451b2c72f21d2dd', CAST(0x0000AAEF01094AAE AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/rbac_Role/select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (467, N'9f8040233bbd44f3aa6f48eef9dc7331', CAST(0x0000AAEF01094C9D AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/rbac_User/Select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (468, N'cfe373a815244f689b5b0af062f8aafc', CAST(0x0000AAEF01094E6A AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/af_AuditPost/Select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (469, N'7cd5f54536314ce39e6f4517c592339e', CAST(0x0000AAEF01095009 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/af_AuditPostUser/Select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (470, N'e8c8c358a7724a249eea34f791ddd33b', CAST(0x0000AAEF0109C297 AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (471, N'1e8095ca460b4505a8f60169dcc31b29', CAST(0x0000AAEF010A90C4 AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (472, N'26e439086a5c490d81d09881ae27c039', CAST(0x0000AAEF010A93EF AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (473, N'46d6535055cb4623b48c9154338040e2', CAST(0x0000AAEF010A9406 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/Login/adminLogin', N'POST      ', N'&tbxUserName=sysAdmin&tbxPassword=e10adc3949ba59abbe56e057f20f883e&orgCode=sju')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (474, N'570ef4d8de0647908ae3f5064461628f', CAST(0x0000AAEF010A9439 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (475, N'dc3fb3f070c845e2a2b32fc9c100d1c0', CAST(0x0000AAEF010A943E AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (476, N'1bee1caf4d6c47429de7d2ba5dcb1d7b', CAST(0x0000AAEF010A95DB AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sys_Home/desktop', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (477, N'f46b267930c54a4ebc03adc18917632f', CAST(0x0000AAEF010A9746 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/rbac_Role/select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (478, N'87e77edc548140f89f0f08937a391065', CAST(0x0000AAEF011049EA AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (479, N'0fa2d386dc74482aaebcfa266dd5d8ab', CAST(0x0000AAEF0110A120 AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (480, N'd4d271f7670544ff952ce264e24b67bf', CAST(0x0000AAEF0110A448 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (481, N'1e8ea2819f974a3c83bf8ee6f01ff4af', CAST(0x0000AAEF0110A45E AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/Login/adminLogin', N'POST      ', N'&tbxUserName=sysAdmin&tbxPassword=e10adc3949ba59abbe56e057f20f883e&orgCode=sju')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (482, N'6f0d9497c4d849bbaba4ea01b406ca53', CAST(0x0000AAEF0110A48C AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (483, N'92b136e70bc44fd3bebd0e9a105aaca6', CAST(0x0000AAEF0110A48F AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (484, N'42acc718ad104dadb4b957da0a02dd42', CAST(0x0000AAEF0110A617 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sys_Home/desktop', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (485, N'04dd445268d9438a993daf4612ee3399', CAST(0x0000AAEF0110A73B AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/rbac_Role/select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (486, N'1292f21c31e64863a56cbd5e4dbf6ba3', CAST(0x0000AAEF0111736B AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (487, N'4b49b4d1bf334b1abdabd55d28d1253d', CAST(0x0000AAEF01117643 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (488, N'036f3ee7a43a4c418809a0a76fad4dce', CAST(0x0000AAEF01117664 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/Login/adminLogin', N'POST      ', N'&tbxUserName=sysAdmin&tbxPassword=e10adc3949ba59abbe56e057f20f883e&orgCode=sju')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (489, N'1ae893ecf9c1463593a5f0979a5ce31b', CAST(0x0000AAEF011176A7 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (490, N'f16514f50e8542f6986afd40128479a9', CAST(0x0000AAEF011176B2 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (491, N'a363d48e2fae476fbf54cceae730a79b', CAST(0x0000AAEF01117768 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sys_Home/desktop', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (492, N'b26042d0544942eab1f439536ea7a9f9', CAST(0x0000AAEF011178C8 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/rbac_Role/select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (493, N'dbca0e2186ab4a679ca0d3f969f8aaad', CAST(0x0000AAEF0113731C AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (494, N'0f308f5c1495488f86d1273dc7be6f8a', CAST(0x0000AAEF0113760C AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (495, N'895f1509e72b45a5ab2ce6933fb72ddd', CAST(0x0000AAEF01137622 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/Login/adminLogin', N'POST      ', N'&tbxUserName=sysAdmin&tbxPassword=e10adc3949ba59abbe56e057f20f883e&orgCode=sju')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (496, N'0161342ba75d40ad95ad691dc37d015c', CAST(0x0000AAEF01137651 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (497, N'58362364016140b4adf590072aac2caa', CAST(0x0000AAEF01137654 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (498, N'1290cf00d3fc47d6a974c577c5b774b2', CAST(0x0000AAEF011377F0 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sys_Home/desktop', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (499, N'a4a43d4436064d2792950aeb10bf1861', CAST(0x0000AAEF011378F4 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/rbac_Role/select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (500, N'e6592a439be34688863a7a1a5d756213', CAST(0x0000AAEF0113C8C7 AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (501, N'906bb12f99a14c1cb89b5e3c7d5f5624', CAST(0x0000AAEF0113CBE5 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (502, N'cb3e8f4cb6bd443e9d02896f982da397', CAST(0x0000AAEF0113CBFE AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/Login/adminLogin', N'POST      ', N'&tbxUserName=sysAdmin&tbxPassword=e10adc3949ba59abbe56e057f20f883e&orgCode=sju')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (503, N'9b8e44f4f7af421fb5b4ee58162a52b1', CAST(0x0000AAEF0113CC2E AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (504, N'16dd44dba1784d37a1a792b493ed1bae', CAST(0x0000AAEF0113CC36 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (505, N'34b31b1ab49c48568c1172926b0f8994', CAST(0x0000AAEF0113CDF5 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sys_Home/desktop', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (506, N'84aed658d84a4399b8f2f019073970d0', CAST(0x0000AAEF0113CF17 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/rbac_Role/select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (507, N'c9d484c2c0af46568cffa50ffc245594', CAST(0x0000AAEF01147A5B AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (508, N'eb20985390704acc94ea2603a64fd0e0', CAST(0x0000AAEF01147D72 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (509, N'f43a2242ebd047aaba9cea532a5d1b65', CAST(0x0000AAEF01147D8D AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/Login/adminLogin', N'POST      ', N'&tbxUserName=sysAdmin&tbxPassword=e10adc3949ba59abbe56e057f20f883e&orgCode=sju')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (510, N'99f85b83e0a9432bbd335a1b8bf38041', CAST(0x0000AAEF01147DC2 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (511, N'9410a7605c0842468999876eb94d8ae8', CAST(0x0000AAEF01147DC8 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (512, N'9d05d2e5652341d4b711b916adfc7691', CAST(0x0000AAEF01147F58 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sys_Home/desktop', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (513, N'7c3d7682e03541b4b8c9a4b613d71d17', CAST(0x0000AAEF011480DE AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/rbac_Role/select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (514, N'5dd0f003374641979a1fe3e8a57ae39c', CAST(0x0000AAEF01149624 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/rbac_User/Select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (515, N'c49b0623e0414d1da009259d0ed534fa', CAST(0x0000AAEF0114FCE7 AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (516, N'31159b64d33a47049f7b8e5d2a7c57f4', CAST(0x0000AAEF011502D5 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (517, N'14f9ea65b3b744eb98c2884b015acfab', CAST(0x0000AAEF011502E4 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/Login/adminLogin', N'POST      ', N'&tbxUserName=sysAdmin&tbxPassword=e10adc3949ba59abbe56e057f20f883e&orgCode=sju')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (518, N'710de5c82ee94cf9a7660df201f17dd7', CAST(0x0000AAEF01150309 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (519, N'e1914db8938a460bbd975faeb29b260b', CAST(0x0000AAEF01150311 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (520, N'a3b87570b4274e1cb5eda091d2f9c0e7', CAST(0x0000AAEF01150496 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sys_Home/desktop', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (521, N'f1b1f882612c48fe8db0bcaa9a809e01', CAST(0x0000AAEF01150648 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/rbac_Role/select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (522, N'9936ad234d9f4b07ab8acdc29401905e', CAST(0x0000AAEF01150BF0 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/rbac_User/Select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (523, N'12fd79d12039434cbd1b218561411e76', CAST(0x0000AAEF01150D4A AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (524, N'4ee37cdf7f2e4794995447fe75516ba3', CAST(0x0000AAEF01150D85 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sys_Home/desktop', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (525, N'1b7e969fa4084904a7dea0d323c350e1', CAST(0x0000AAEF0115A76A AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (526, N'2f3c52234b064400967f6d7396a92528', CAST(0x0000AAEF0115AA62 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (527, N'b50c72cb31514e038a8795a3470fde0a', CAST(0x0000AAEF0115AA74 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/Login/adminLogin', N'POST      ', N'&tbxUserName=sysAdmin&tbxPassword=e10adc3949ba59abbe56e057f20f883e&orgCode=sju')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (528, N'1362ff6d78dd470bb8b4aee74c527460', CAST(0x0000AAEF0115AAA0 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (529, N'4fd2358a87d74233aa5b941fb89717ea', CAST(0x0000AAEF0115AAA5 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (530, N'6a16a05bf4cc46b6907bed808ac7f285', CAST(0x0000AAEF0115AC16 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sys_Home/desktop', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (531, N'7f27be6cc4c54442990920cd2cb77adf', CAST(0x0000AAEF0115AE1C AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/rbac_Role/select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (532, N'5bd7c46115cf419698e2e55b34a5a3b8', CAST(0x0000AAEF0116F147 AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (533, N'3cd197ee9b434c6298fe5607091b7bc2', CAST(0x0000AAEF0116FAC7 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (534, N'd14c1148c9ee454583b6faffb7bd0dd5', CAST(0x0000AAEF0116FAD7 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/Login/adminLogin', N'POST      ', N'&tbxUserName=sysAdmin&tbxPassword=e10adc3949ba59abbe56e057f20f883e&orgCode=sju')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (535, N'928cc82c4b434054b53976299c7cd706', CAST(0x0000AAEF0116FB08 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (536, N'1d3f3f11372649be94add52d809fd986', CAST(0x0000AAEF0116FB0B AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (537, N'a9811141538d4223bc50bf48e2d21677', CAST(0x0000AAEF0116FCAD AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sys_Home/desktop', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (538, N'b343779178ab42ff9c3dbb5bcd37c060', CAST(0x0000AAEF0116FDB0 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/rbac_Role/select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (539, N'4e7329b7a79f4e8f9b443190cba150cf', CAST(0x0000AAEF011701A5 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/rbac_User/Select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (540, N'63c500741aac4ce3bb85ec0e17fec332', CAST(0x0000AAEF01170366 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/af_AuditPost/Select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (541, N'5b32c2063626451b98af6a9245416607', CAST(0x0000AAEF013C4787 AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (542, N'cf9e77af0d964141bf42998c7f842cde', CAST(0x0000AAEF013C4CE2 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (543, N'6b6babc676e1404fbb9cac019e6581a1', CAST(0x0000AAEF013C4E51 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/Login/adminLogin', N'POST      ', N'&tbxUserName=sysAdmin&tbxPassword=e10adc3949ba59abbe56e057f20f883e&orgCode=sju')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (544, N'584f54fdca854ef6b5675d835071500d', CAST(0x0000AAEF013C4E79 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (545, N'08566386c792446cb25f73a751ffb7b1', CAST(0x0000AAEF013C4E80 AS DateTime), N'请求', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (546, N'e44143797c224edb9cde82d3144a37a2', CAST(0x0000AAEF013C4EA4 AS DateTime), N'请求', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/login/toLogin', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (547, N'29c6383eb62846e98ef959ca5a4b5682', CAST(0x0000AAEF013C4EA8 AS DateTime), N'请求', NULL, NULL, NULL, N'http://localhost:9021/login/toLogin', N'http://localhost:9021/login/adminLogin', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (548, N'67e5a220c5d248888cef11a5c4297733', CAST(0x0000AAEF013C516A AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/login/adminLogin', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (549, N'd299a50ca0f545e88149ed5cc26f5ece', CAST(0x0000AAEF013C5188 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/login/adminLogin', N'http://localhost:9021/Login/adminLogin', N'POST      ', N'&tbxUserName=sysAdmin&tbxPassword=e10adc3949ba59abbe56e057f20f883e&orgCode=sju')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (550, N'b673bd038b494d5389cfa7cc33b123a3', CAST(0x0000AAEF013C5199 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (551, N'd0dd141d219b400c951fc627b09b73ef', CAST(0x0000AAEF013C519F AS DateTime), N'请求', NULL, NULL, NULL, N'http://localhost:9021/login/adminLogin', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (552, N'f992065204824b15bf13b2410279febc', CAST(0x0000AAEF013C51A1 AS DateTime), N'请求', NULL, NULL, NULL, N'http://localhost:9021/login/adminLogin', N'http://localhost:9021/login/toLogin', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (553, N'466675799caa43d880ebb7081c5738e5', CAST(0x0000AAEF013C51B0 AS DateTime), N'请求', NULL, NULL, NULL, N'http://localhost:9021/login/toLogin', N'http://localhost:9021/login/adminLogin', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (554, N'87cd647da8e14b77be8afcdec6ec5606', CAST(0x0000AAEF013C5261 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/login/adminLogin', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (555, N'd98524dc7da043f8b54fbc317f8289e1', CAST(0x0000AAEF013C5267 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/login/adminLogin', N'http://localhost:9021/Login/adminLogin', N'POST      ', N'&tbxUserName=sysAdmin&tbxPassword=e10adc3949ba59abbe56e057f20f883e&orgCode=sju')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (556, N'cfe708b12dc041c9a8f7d0f573c8a035', CAST(0x0000AAEF013C5276 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (557, N'056eb6a8a7474412acc18b4850d10bd1', CAST(0x0000AAEF013C527D AS DateTime), N'请求', NULL, NULL, NULL, N'http://localhost:9021/login/adminLogin', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (558, N'a55400b47a21470d96b0b7e86632706c', CAST(0x0000AAEF013C5281 AS DateTime), N'请求', NULL, NULL, NULL, N'http://localhost:9021/login/adminLogin', N'http://localhost:9021/login/toLogin', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (559, N'bc4df79d672f482ca63ca384c8463284', CAST(0x0000AAEF013C5286 AS DateTime), N'请求', NULL, NULL, NULL, N'http://localhost:9021/login/toLogin', N'http://localhost:9021/login/adminLogin', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (560, N'e80feac4faa64c31948c2066ed8bf924', CAST(0x0000AAEF013C536E AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/login/adminLogin', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (561, N'bd2e46cd73fc48f7a33c3985bebbe2c6', CAST(0x0000AAEF013C5383 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/login/adminLogin', N'http://localhost:9021/Login/adminLogin', N'POST      ', N'&tbxUserName=sysAdmin&tbxPassword=e10adc3949ba59abbe56e057f20f883e&orgCode=sju')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (562, N'd9c34e3cf98641eaaedbbc3cf7b6d519', CAST(0x0000AAEF013C5393 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (563, N'51ca7b2d2d284f55bc61ab3c0b075c2d', CAST(0x0000AAEF013C5399 AS DateTime), N'请求', NULL, NULL, NULL, N'http://localhost:9021/login/adminLogin', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (564, N'eeec1746789f41bd83ea3bc516a6e6bb', CAST(0x0000AAEF013C539B AS DateTime), N'请求', NULL, NULL, NULL, N'http://localhost:9021/login/adminLogin', N'http://localhost:9021/login/toLogin', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (565, N'a27416d46e6e434a8ca6030041ab150d', CAST(0x0000AAEF013C53A5 AS DateTime), N'请求', NULL, NULL, NULL, N'http://localhost:9021/login/toLogin', N'http://localhost:9021/login/adminLogin', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (566, N'a2e6f314ed66440eb6620805840c6ec3', CAST(0x0000AAEF013C5CA4 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/login/adminLogin', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (567, N'd9c532293e4f4a4ca8789a94648abb9e', CAST(0x0000AAEF013C6272 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/login/adminLogin', N'http://localhost:9021/Login/adminLogin', N'POST      ', N'&tbxUserName=sysAdmin&tbxPassword=e10adc3949ba59abbe56e057f20f883e&orgCode=sju')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (568, N'62a8279b10c346b49171cc97bb5bcf48', CAST(0x0000AAEF013C64EA AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (569, N'bcf68d6325214a0cadb8971f6e707e7c', CAST(0x0000AAEF013C64F2 AS DateTime), N'请求', NULL, NULL, NULL, N'http://localhost:9021/login/adminLogin', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (570, N'99de4d66fc914c8e8064666228bd7d06', CAST(0x0000AAEF013C64F4 AS DateTime), N'请求', NULL, NULL, NULL, N'http://localhost:9021/login/adminLogin', N'http://localhost:9021/login/toLogin', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (571, N'8fbb00bd7af9484eb4339dd00e21f7e3', CAST(0x0000AAEF013C64F9 AS DateTime), N'请求', NULL, NULL, NULL, N'http://localhost:9021/login/toLogin', N'http://localhost:9021/login/adminLogin', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (572, N'fdb25db755e44a21b06e2a708b013875', CAST(0x0000AAEF013C7424 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/login/adminLogin', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (573, N'a7b1c17004504f03a8e58634eb384dcc', CAST(0x0000AAEF013C7437 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/login/adminLogin', N'http://localhost:9021/Login/adminLogin', N'POST      ', N'&tbxUserName=sysAdmin&tbxPassword=e10adc3949ba59abbe56e057f20f883e&orgCode=sju')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (574, N'5360fb0c2a92435e80942970bde9ab9c', CAST(0x0000AAEF013C7448 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (575, N'2cb1e7b0354443a1ab5e850ecbf166e7', CAST(0x0000AAEF013C7450 AS DateTime), N'请求', NULL, NULL, NULL, N'http://localhost:9021/login/adminLogin', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (576, N'4eb7187f4b304d0d86611177aecdb27f', CAST(0x0000AAEF013C7E99 AS DateTime), N'请求', NULL, NULL, NULL, N'http://localhost:9021/login/adminLogin', N'http://localhost:9021/login/toLogin', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (577, N'4f327e7ec7e14510b4b15664bea406c9', CAST(0x0000AAEF013C7EA0 AS DateTime), N'请求', NULL, NULL, NULL, N'http://localhost:9021/login/toLogin', N'http://localhost:9021/login/adminLogin', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (578, N'a89f56c2ad2849d7a970099a0330c0c9', CAST(0x0000AAEF013C9B2E AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/login/adminLogin', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (579, N'b75a3435a7f44472a67716c1a82a74fc', CAST(0x0000AAEF013C9B4C AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/login/adminLogin', N'http://localhost:9021/Login/adminLogin', N'POST      ', N'&tbxUserName=sysAdmin&tbxPassword=e10adc3949ba59abbe56e057f20f883e&orgCode=sju')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (580, N'8452284b2dd64415acd33be617a064ae', CAST(0x0000AAEF013CE3E3 AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (581, N'ad6046e852964072a3b03647cdb0e275', CAST(0x0000AAEF013CEA20 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (582, N'63423fb6c5cb41c0a57b8abf433d9b0a', CAST(0x0000AAEF013CEA33 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/Login/adminLogin', N'POST      ', N'&tbxUserName=sysAdmin&tbxPassword=e10adc3949ba59abbe56e057f20f883e&orgCode=sju')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (583, N'b4aa8af51eb74aeb88a4f782929b5213', CAST(0x0000AAEF013CEEC7 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (584, N'5c5ddc881bd7483ba68aa98e5e97270e', CAST(0x0000AAEF013CEECE AS DateTime), N'请求', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (585, N'd90d890c6f9c4f9d9f5a686dc64d72f9', CAST(0x0000AAEF013CF000 AS DateTime), N'请求', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/login/toLogin', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (586, N'55a651642cf1420cbed79e481b705904', CAST(0x0000AAEF013CF008 AS DateTime), N'请求', NULL, NULL, NULL, N'http://localhost:9021/login/toLogin', N'http://localhost:9021/login/adminLogin', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (587, N'2c7785eb34c54ac38e4bfbeab8fe9783', CAST(0x0000AAEF013E5A56 AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (588, N'2d117a4c1d7048589e8ea867f6c7db1d', CAST(0x0000AAEF013EC1B2 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (589, N'51c9a053b13c42fe9fdef4de76d90187', CAST(0x0000AAEF013EC1BC AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/Login/adminLogin', N'POST      ', N'&tbxUserName=sysAdmin&tbxPassword=e10adc3949ba59abbe56e057f20f883e&orgCode=sju')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (590, N'556f75f791174c308672fcc6a3cf14ad', CAST(0x0000AAEF013EC94E AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (591, N'122f8abde5f5496995781aa4cb550009', CAST(0x0000AAEF013EC954 AS DateTime), N'请求', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (592, N'594d0d4987704de1b2ccd8e0847d49e4', CAST(0x0000AAEF013ED0FD AS DateTime), N'请求', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/login/toLogin', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (593, N'8106d6e46e1e4678b76b11bd210f3846', CAST(0x0000AAEF013ED11A AS DateTime), N'请求', NULL, NULL, NULL, N'http://localhost:9021/login/toLogin', N'http://localhost:9021/login/adminLogin', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (594, N'6bab7fffef09486f8596f6fc6c282d4b', CAST(0x0000AAEF013F6357 AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (595, N'5b24dfd1acf341c285ffc2b80a3ad2e3', CAST(0x0000AAEF013F827F AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (596, N'27b95a3e3b994999a0211626826db182', CAST(0x0000AAEF013F8293 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/Login/adminLogin', N'POST      ', N'&tbxUserName=sysAdmin&tbxPassword=e10adc3949ba59abbe56e057f20f883e&orgCode=sju')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (597, N'466d82b8ba2148139fa26be5c8ed9d5f', CAST(0x0000AAEF013F888F AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (598, N'ceba18790be44e11a6f94ddd0a35ace0', CAST(0x0000AAEF013F8897 AS DateTime), N'请求', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (599, N'c06ed9435a8242958d10004e006de6e3', CAST(0x0000AAEF013F8B3A AS DateTime), N'请求', NULL, NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sys_Home/desktop', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (600, N'f81e91f5da1b47dba127c5c0f45a72e5', CAST(0x0000AAEF013F99AD AS DateTime), N'请求', NULL, NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sys_Home/exit', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (601, N'4ca83fef84b446cf98368ef4ff767a04', CAST(0x0000AAEF013F9AA4 AS DateTime), N'请求', NULL, NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/Login/toLogin', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (602, N'ccc538de7b1f483eb51854d2aa52c84b', CAST(0x0000AAEF013F9AAB AS DateTime), N'请求', NULL, NULL, NULL, N'http://localhost:9021/Login/toLogin', N'http://localhost:9021/login/adminLogin', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (603, N'8a53d0c612a740e7a9f06f9e29044d2d', CAST(0x0000AAEF013F9D0A AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/login/adminLogin', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (604, N'd548c74e87b749278d867f71392feee7', CAST(0x0000AAEF013F9D24 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/login/adminLogin', N'http://localhost:9021/Login/adminLogin', N'POST      ', N'&tbxUserName=sysAdmin&tbxPassword=e10adc3949ba59abbe56e057f20f883e&orgCode=sju')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (605, N'e2551504d11e433791d7ae8bea744612', CAST(0x0000AAEF013F9F0D AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (606, N'c43d79d2d76f4e4d9f50df47408032cb', CAST(0x0000AAEF013F9F16 AS DateTime), N'请求', NULL, NULL, NULL, N'http://localhost:9021/login/adminLogin', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (607, N'f7063c7e47b541a7908a585ee2b0d7b0', CAST(0x0000AAEF013FC63A AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (608, N'719edd60f22a49f6ae12cfc50059a716', CAST(0x0000AAEF013FC92B AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (609, N'305a6c194ffe42c2b163a523e4847746', CAST(0x0000AAEF013FCC1A AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/Login/adminLogin', N'POST      ', N'&tbxUserName=sysAdmin&tbxPassword=e10adc3949ba59abbe56e057f20f883e&orgCode=sju')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (610, N'a38c01ba44ad442ebf9646fbfe7e078e', CAST(0x0000AAEF01401A18 AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (611, N'93f7c46e432044c2a36ce18bd0107657', CAST(0x0000AAEF01401FAD AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (612, N'ed4bc4f2bb5343239b98494a0c0c0c0b', CAST(0x0000AAEF01402558 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/Login/adminLogin', N'POST      ', N'&tbxUserName=sysAdmin&tbxPassword=e10adc3949ba59abbe56e057f20f883e&orgCode=sju')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (613, N'64a43523b17f4800a7f982eb413d5d22', CAST(0x0000AAEF01402752 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (614, N'7730672e00ce4cd78427c0c0d42ebf3b', CAST(0x0000AAEF0140275F AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (615, N'dedc4f6a9a0f411480cedc5484230546', CAST(0x0000AAEF01402A32 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sys_Home/desktop', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (616, N'b47a89f201114ae4a98e41f3fc2241ef', CAST(0x0000AAEF01403588 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/rbac_Role/select', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (617, N'19c9ec878d3a48b6959494bfab5ab8b3', CAST(0x0000AAEF01404826 AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (618, N'ee6fb32ebab14802bcaa656d28c10edd', CAST(0x0000AAEF01404B7A AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (619, N'bae4cbc8165d44fc95f6fa9f94b1de39', CAST(0x0000AAEF01404B8C AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/Login/adminLogin', N'POST      ', N'&tbxUserName=sysAdmin&tbxPassword=e10adc3949ba59abbe56e057f20f883e&orgCode=sju')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (620, N'2fdbb83e886f490ea13df8ccf9dc1759', CAST(0x0000AAEF01404C87 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (621, N'da429a0593d64ab6ae36344611f70361', CAST(0x0000AAEF01404C8E AS DateTime), N'请求', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (622, N'2ad72a99a0d74ea0bfda097c024380db', CAST(0x0000AAEF01404D42 AS DateTime), N'请求', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/login/toLogin', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (623, N'17a1ae1c07624ef1ba14a4421b973fe9', CAST(0x0000AAEF01404D48 AS DateTime), N'请求', NULL, NULL, NULL, N'http://localhost:9021/login/toLogin', N'http://localhost:9021/login/adminLogin', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (624, N'25e5b514655145b294e174011c39e2b6', CAST(0x0000AAEF01405076 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/login/adminLogin', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (625, N'fc352840bd604fc8b3b65fdeaa61927f', CAST(0x0000AAEF01405099 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/login/adminLogin', N'http://localhost:9021/Login/adminLogin', N'POST      ', N'&tbxUserName=sysAdmin&tbxPassword=e10adc3949ba59abbe56e057f20f883e&orgCode=sju')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (626, N'8d7f652ef06b48d5bdc162e476344a54', CAST(0x0000AAEF01405294 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (627, N'1f31d98b2802422da20adc1f316f9a98', CAST(0x0000AAEF01405298 AS DateTime), N'请求', NULL, NULL, NULL, N'http://localhost:9021/login/adminLogin', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (628, N'5494d1a0894047d095e2a7fb784972f2', CAST(0x0000AAEF01405363 AS DateTime), N'请求', NULL, NULL, NULL, N'http://localhost:9021/login/adminLogin', N'http://localhost:9021/login/toLogin', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (629, N'3635feb44dba4007b28ead5cf4c42fe0', CAST(0x0000AAEF01405377 AS DateTime), N'请求', NULL, NULL, NULL, N'http://localhost:9021/login/toLogin', N'http://localhost:9021/login/adminLogin', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (630, N'228ab29d20454eae8e7d733e5288a670', CAST(0x0000AAEF01406F69 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/login/adminLogin', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (631, N'91ed03fe22da4cd2abad890e6b50faff', CAST(0x0000AAEF01407440 AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/login/adminLogin', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (632, N'ba140360047c467d80968aa8c7a6f1b0', CAST(0x0000AAEF0140763E AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/login/adminLogin', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (633, N'962e8fe3e46a4d64bf0a59c4f66422d3', CAST(0x0000AAEF0140765C AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/login/adminLogin', N'http://localhost:9021/Login/adminLogin', N'POST      ', N'&tbxUserName=sysAdmin&tbxPassword=e10adc3949ba59abbe56e057f20f883e&orgCode=sju')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (634, N'3ef74e3e140e47ab9d3cd01c4b90d01e', CAST(0x0000AAEF0140772F AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (635, N'4014b25031f5463e92f8576e08ec0afe', CAST(0x0000AAEF0140773E AS DateTime), N'请求', NULL, NULL, NULL, N'http://localhost:9021/login/adminLogin', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (636, N'868286c0287d42a486423a07c8d554d2', CAST(0x0000AAEF014077DD AS DateTime), N'请求', NULL, NULL, NULL, N'http://localhost:9021/login/adminLogin', N'http://localhost:9021/login/toLogin', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (637, N'1e521a61845549039b7a599383d89bcf', CAST(0x0000AAEF014077E4 AS DateTime), N'请求', NULL, NULL, NULL, N'http://localhost:9021/login/toLogin', N'http://localhost:9021/login/adminLogin', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (638, N'db8a18acfdd14b7e9bab5034a0eebb98', CAST(0x0000AAEF01407B33 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/login/adminLogin', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (639, N'4d5d7edb84c0477a98493a790e179c0d', CAST(0x0000AAEF01407B54 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/login/adminLogin', N'http://localhost:9021/Login/adminLogin', N'POST      ', N'&tbxUserName=sysAdmin&tbxPassword=e10adc3949ba59abbe56e057f20f883e&orgCode=sju')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (640, N'25fc7c47328845688eae90c7b4501971', CAST(0x0000AAEF01407C03 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (641, N'158f102eea454c6681a88a990e45eb59', CAST(0x0000AAEF01407C07 AS DateTime), N'请求', NULL, NULL, NULL, N'http://localhost:9021/login/adminLogin', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (642, N'51f03e22acb741169fd2e79fcc19b10e', CAST(0x0000AAEF01407C30 AS DateTime), N'请求', NULL, NULL, NULL, N'http://localhost:9021/login/adminLogin', N'http://localhost:9021/login/toLogin', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (643, N'a2a0e3fd676c4b869fa275b823ed34f0', CAST(0x0000AAEF01407C34 AS DateTime), N'请求', NULL, NULL, NULL, N'http://localhost:9021/login/toLogin', N'http://localhost:9021/login/adminLogin', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (644, N'68da4a6ffbe44d75a6ddba37c9c8a7a2', CAST(0x0000AAEF01407E3F AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/login/adminLogin', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (645, N'ff2ab5d9f3354d928ec08487fcb13edd', CAST(0x0000AAEF01407E67 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/login/adminLogin', N'http://localhost:9021/Login/adminLogin', N'POST      ', N'&tbxUserName=sysAdmin&tbxPassword=e10adc3949ba59abbe56e057f20f883e&orgCode=sju')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (646, N'c814dccd1ee442719077e4955f8517ff', CAST(0x0000AAEF01407EF7 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (647, N'3c56dd21d7df4f75864b58e3482cf202', CAST(0x0000AAEF01407EFF AS DateTime), N'请求', NULL, NULL, NULL, N'http://localhost:9021/login/adminLogin', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (648, N'b033f1c23e7540ca8f38eb6ca8a4d04e', CAST(0x0000AAEF01407F2B AS DateTime), N'请求', NULL, NULL, NULL, N'http://localhost:9021/login/adminLogin', N'http://localhost:9021/login/toLogin', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (649, N'9812d7ef31e847f6bc3636ba96198cf9', CAST(0x0000AAEF01407F31 AS DateTime), N'请求', NULL, NULL, NULL, N'http://localhost:9021/login/toLogin', N'http://localhost:9021/login/adminLogin', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (650, N'e402e2021e224c769f8991be08e36793', CAST(0x0000AAEF01409544 AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (651, N'a5685cb9e4d94bc7916ae576a8e9309d', CAST(0x0000AAEF01409A6B AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=001702')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (652, N'd625384518ca42bfb638f4a3433692c3', CAST(0x0000AAEF01409A9E AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=001702')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (653, N'14acfcb8b10b478fa697f2c65cbeef99', CAST(0x0000AAEF01409AB3 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=001702')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (654, N'127c7dccfaee4a82b34e4175d42de860', CAST(0x0000AAEF01409EC1 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (655, N'86dd3792bd0844c9b64be05c0d6474e4', CAST(0x0000AAEF0140A1E2 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/Login/adminLogin', N'POST      ', N'&tbxUserName=sysAdmin&tbxPassword=e10adc3949ba59abbe56e057f20f883e&orgCode=sju')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (656, N'6ac961f8c4dc4c51ab2aae911434e5f9', CAST(0x0000AAEF0140A38E AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (657, N'66652ac3ab2142a09f446e8e0fdd1516', CAST(0x0000AAEF0140A394 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/admin/sys_Home/index', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (658, N'91a7e6fc018f40cb9275bc5c6b2f76a4', CAST(0x0000AAEF0140A543 AS DateTime), N'请求', N'sysAdmin', NULL, NULL, N'http://localhost:9021/admin/sys_Home/index', N'http://localhost:9021/admin/sys_Home/desktop', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (659, N'1dbb49c46a4a4ad9a0bd886ebdcc9443', CAST(0x0000AAEF014186C7 AS DateTime), N'请求', NULL, NULL, NULL, N'', N'http://localhost:9021/', N'GET       ', NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (660, N'6f7edb6cf7634a7a9536760583468cfa', CAST(0x0000AAEF01418D70 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/login/getLoginOrg', N'POST      ', N'&userCode=sysAdmin')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (661, N'1a22f1c4eada437fae1a52a5dcfa6bf1', CAST(0x0000AAEF01419522 AS DateTime), N'提交', NULL, NULL, NULL, N'http://localhost:9021/', N'http://localhost:9021/Login/adminLogin', N'POST      ', N'&tbxUserName=sysAdmin&tbxPassword=e10adc3949ba59abbe56e057f20f883e&orgCode=sju')
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (662, N'4fe3109305144dbba081c1d237bcaa8a', CAST(0x0000AAEF0142367D AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (663, N'a18dfcc56f2046e99cfb222318d4c126', CAST(0x0000AAEF014B3C29 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (664, N'7e778438cbaa4a20b5eca872671cf482', CAST(0x0000AAEF014D893C AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (665, N'07ed25e328d94dc38412b64534af4471', CAST(0x0000AAF600FC400D AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (666, N'48349316fd4e4dc79dfad1adf87fb16f', CAST(0x0000AAF6014C2440 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (667, N'925fbb05801a4283af71de6cdc68ab46', CAST(0x0000AAF80148FA99 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (668, N'267293577d2d460b82e41e6c83ed298f', CAST(0x0000AAFF01638A6A AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (669, N'06de3519c2d9405a9226c6e8be79d8f7', CAST(0x0000AAFF0167146D AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (670, N'c1d7e39b32bb4409af6931f10634017e', CAST(0x0000AAFF01755105 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (671, N'89d3bcef8a234ab98b07a16f1065020f', CAST(0x0000AAFF0176EF30 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (672, N'95d9029a3de64ecea9e86b2fe32b62f0', CAST(0x0000AB00013B7307 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (673, N'9d293fb0c8c94e97babfcbeb504f6147', CAST(0x0000AB00013DFE76 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (674, N'aeb754f7d42e4bcc8d66ea1e6f109995', CAST(0x0000AB000140C7F0 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (675, N'887bb323626f4c56baa571dcd6599fd5', CAST(0x0000AB000145B253 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (676, N'72c7060312214022a9bcf44c16938c74', CAST(0x0000AB0100A89C7A AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (677, N'e2d063e4f58b4321ab55d1dbd3b4ddf4', CAST(0x0000AB0100AEC8E5 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (678, N'09a40af14e4e458b88711d0a4f46bdad', CAST(0x0000AB0100AF021E AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (679, N'958e968c904c493287e1e7f65f62f704', CAST(0x0000AB0100AF7BD7 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (680, N'ac8dbe40df77425b8c56307e0b172238', CAST(0x0000AB0100AFAD15 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (681, N'704fd0ab8bc5452cb586bfba82f8c411', CAST(0x0000AB0100AFB1C2 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (682, N'cc5fa93815024692b15fa016465838f5', CAST(0x0000AB0100B0754C AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (683, N'b2a09c06ce50433099c79eec04c1fcdc', CAST(0x0000AB0100B2A732 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (684, N'c5aea33cd7b9423eb03a14acb7d5486f', CAST(0x0000AB020142C528 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (685, N'0353a7c5e002493d8987382d4dbef388', CAST(0x0000AB04008A011D AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (686, N'b9cef9a9e5be44138037896dadc54b21', CAST(0x0000AB0E0094E2DF AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (687, N'e4f3121ec65946d28fbfda7b200531a7', CAST(0x0000AB0F0125336D AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (688, N'7c87e881e96843b59d210fa71fa446c0', CAST(0x0000AB2000AB1C40 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (689, N'cddbcdb6538340efbe42e44787758961', CAST(0x0000AB3601398AAC AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (690, N'e99c10b095a14c8490e7532e043f5975', CAST(0x0000AB36013BA8C3 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (691, N'13a387b285e44eb5b2d2f20b0d051381', CAST(0x0000AB3A00A04CC4 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (692, N'c39ea244c7d2424299070722063e4712', CAST(0x0000AB3A00A68920 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (693, N'286d774df6994b08bd50af00a4b3845e', CAST(0x0000AB3A00A6CFF1 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (694, N'5663b2c0291a44f1bb9c7ab254484048', CAST(0x0000AB3A00A86F42 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (695, N'4d73fedeb99746359d8b0e234eb0f459', CAST(0x0000AB3A00A8F0F2 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (696, N'92578556e1df4a06a298c856297391d0', CAST(0x0000AB3A00AA34FC AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (697, N'27b7ca6802b146b7a8703093e7853014', CAST(0x0000AB3A00AAC3CC AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (698, N'1c94e71e22e5486e99ee2ecfcdd3d98a', CAST(0x0000AB3A00B6118F AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (699, N'95eacec49683429db619ae18d2a28327', CAST(0x0000AB3A00B6AAC4 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (702, N'8342ab0d23e94694b9e3fe01ffe0baae', CAST(0x0000AB3A00C4882F AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (703, N'a3bdef80ce6f43e6af27726fc0ad781b', CAST(0x0000AB3A00EF84EE AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (704, N'7e41568555d74158b175567dcd2a9ef2', CAST(0x0000AB3A01589CED AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (705, N'33f05558fb794ac5bf23fef7a81e8696', CAST(0x0000AB3A015966A2 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (706, N'baaa0f58ac9a4deb9df960853c0794f4', CAST(0x0000AB3A015B41C5 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (707, N'34dc3b61e8454b4e990467284600cf05', CAST(0x0000AB3A015D2B1E AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (708, N'6dd8a8b956d34c09b529c03ab76d5db7', CAST(0x0000AB3A015DBCF9 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (709, N'a8d8ef51bb114b7fbcb1e99b3b97d1a6', CAST(0x0000AB3A015ECDB1 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (710, N'b99a7fd8df584c07810735a34b7167e1', CAST(0x0000AB3A015F8D4B AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (711, N'5e4c6055ef6b48d89e98893e46729dd1', CAST(0x0000AB3A0160BB2F AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (712, N'69fb57bdfbf743ebbf934f05a97e25a9', CAST(0x0000AB3A01645031 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (713, N'2afcc195dede4db298170dcd3604b3c0', CAST(0x0000AB3A0164B9D7 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (714, N'b560d5c13a4d44a98fd1a7ab31c9901a', CAST(0x0000AB3A01689397 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (715, N'1f92dcb191b7493aa18b8679f7162248', CAST(0x0000AB3A0169D467 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (716, N'269c1da31e0646deab9c47f15d2d7d33', CAST(0x0000AB3A016A6273 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (717, N'3281d89adbbb42d2a373dc1ef453ce21', CAST(0x0000AB3A016ABA95 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (718, N'7f634931439b4373a1f98c332caa77ea', CAST(0x0000AB3A016B490C AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (719, N'7fc59b6ac18f447abe9c17aebd2ec07b', CAST(0x0000AB3B010BE4D4 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (720, N'028529b792aa410fb74cdc2f059b14e0', CAST(0x0000AB3B010DEE58 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (721, N'43ac363a7b214654a818ed8a0cff2580', CAST(0x0000AB3B010F7259 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (722, N'2c469036c67c4b208bc4bc79a886f86b', CAST(0x0000AB3B01107AF0 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (723, N'436956d990214b149a671811c57e2418', CAST(0x0000AB3B0110CB3D AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (724, N'a946f5f9a0f44e6b96feb164ef584872', CAST(0x0000AB3B0111182C AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (725, N'930dad91911b4529beb7a94e5d00521d', CAST(0x0000AB3B01118CD0 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (726, N'76445cc7a8f34f44b01749af8d007993', CAST(0x0000AB3B0111D298 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (727, N'ce3a5b98e7d2437ca54f0834ef77421a', CAST(0x0000AB3B0113CD30 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (728, N'ee87bbc716dd48f09f02a1ec17c131d6', CAST(0x0000AB3B01150471 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (729, N'ed24fc54853b4317bf50abfde68c1089', CAST(0x0000AB3B01168780 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (730, N'15a969e160434483b90921d91fb21720', CAST(0x0000AB3F0133A4A4 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (731, N'a2e0d81cf54e4ab8bffbb361f416f8b2', CAST(0x0000AB3F01348C36 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (732, N'afc67a90adad4909bb45d739d001f0e1', CAST(0x0000AB3F013581A9 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (733, N'0db3ff61251948b8835384afa2ec6762', CAST(0x0000AB3F0135BB72 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (734, N'e1e2eb167b69481db146db3c7da41f7f', CAST(0x0000AB3F01378167 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (735, N'585c10ee4ba14aa187d364e8590b4f2f', CAST(0x0000AB3F01387399 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (736, N'8c6ab199f8654e09a7ddee413099126f', CAST(0x0000AB4200E9E10D AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (737, NULL, CAST(0x0000AB4200FB0A6B AS DateTime), N'登录', N'sysAdmin', N'', N'', NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (738, N'69c31a4181a94c1c9dd17ae91e6777ba', CAST(0x0000AB42014F098E AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (739, N'a26233e8fd2d4dd58a25d8f4c5802acb', CAST(0x0000AB42014F97B4 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (740, N'b527cd233aca426d9394256dbf16e392', CAST(0x0000AB420150C1FB AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (741, N'799caf46cfcb4218823d2f5e760dc5db', CAST(0x0000AB4300A40518 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (742, N'5867afe91ecf41799857d69d66f6d8d4', CAST(0x0000AB4300A60E2D AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (743, N'95759993beb14f6faacd31ebc84c1f4f', CAST(0x0000AB4300A6C050 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (744, N'07827901c5394b159c77262ffcf9d40b', CAST(0x0000AB4300A72A71 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (745, N'e5becf025fd1430985a8572e116afa10', CAST(0x0000AB4300A807F6 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (746, N'2ed4d7b4626b4762895c0f3f8c32d8e3', CAST(0x0000AB4300A907EE AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (747, N'29e9dde55def4088a36332e5e2a6e68d', CAST(0x0000AB4300AB5E2C AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (748, N'5e863ccb47b2409b80d81ba8ce36a1ba', CAST(0x0000AB4300ABD041 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (749, N'9d31f29b4be046e3b76f0f33c3f4949e', CAST(0x0000AB4300AC2BC4 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (750, N'b34d356e06f44fbaa999e9a35ed7a622', CAST(0x0000AB4300AC92E4 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (751, N'8a3ba80f12924b5a950121fb4def8b01', CAST(0x0000AB4300AD4F89 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (752, N'0b6de05b1f2c45f598b65564e5d32723', CAST(0x0000AB4300AFD449 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (753, N'65af406e6cc44fa59a2720e6dbbfa4b6', CAST(0x0000AB4300B0BE8B AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (754, N'4018ea71e52144d08318613befb84777', CAST(0x0000AB4300B41F20 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (755, N'e2b0b51be7784865bf1c3675a13bad18', CAST(0x0000AB4300B47E97 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (756, N'8bdf347f9afc4859bc71200f50028032', CAST(0x0000AB4300B516F5 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (757, N'2be01ed26e864e66b08a7f2da518103d', CAST(0x0000AB4300BCED46 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (758, N'b03f3f2d5ac3427ca864618d65f873b4', CAST(0x0000AB4300BE7AB9 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (759, N'473b10e4b4ac4e3890d3cacc966e1b5a', CAST(0x0000AB4300BF7480 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (760, N'd873bb4c01db4c468078ac22571e8547', CAST(0x0000AB4300BFEBD1 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (761, N'6777ffdca485447f9d7b032826ea987f', CAST(0x0000AB4300CF684E AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (762, N'e822841fc96a4911ae498cd42c403913', CAST(0x0000AB4300D04680 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (763, N'13bb3030354340908f60255000a60d0f', CAST(0x0000AB4300D0F4B6 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (764, N'26eeac24876d4a8b860bc10c5fe5042c', CAST(0x0000AB4300D172F2 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (765, N'98281690e053418c867767b847f0bf61', CAST(0x0000AB4300D1C86A AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (766, N'cc522023bf6641e6b68dea2286876b5a', CAST(0x0000AB430158274D AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (767, N'e4eabe22e00c4f60b0e5d219ff57948f', CAST(0x0000AB430158C5BA AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (768, N'0b73b381eb7a4c6fb869551de8d4ea31', CAST(0x0000AB43015941C8 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (769, N'31b3f76e00824cd3b45de1b4fe512e3a', CAST(0x0000AB430159C8E1 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (770, N'1e189ddfa17d4e409e79e42603a1724d', CAST(0x0000AB43015A1FAC AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (771, N'a43db302b9a64b0ba824720a9f7032b6', CAST(0x0000AB43015FB57B AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (772, N'39c4062be0f942a7954316b10faacd6d', CAST(0x0000AB4301612C33 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (773, N'f5aec0c4da21447abc27192a81f21115', CAST(0x0000AB4301621D69 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (774, N'af7f7452a06a4c8486e4ceb2ec93eb70', CAST(0x0000AB430163B252 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (775, N'8111c09e5d914449b0acc06d1b65f41c', CAST(0x0000AB4301645157 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (776, N'c6b7cee4a17747c08ea7c277b2dfe44c', CAST(0x0000AB430164E785 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (777, N'8ee164a73a45469981b783f87aa43a50', CAST(0x0000AB4301656979 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (778, N'64cc5dd8756c4cb68c3d4d74fb621865', CAST(0x0000AB430165B02E AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (779, N'484ca47e06614b9e83c4b3212cbb758b', CAST(0x0000AB430168F8B7 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (780, N'f58799c8665c409886a2a594c361101c', CAST(0x0000AB44008DCF8A AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (781, N'5e4eddb9d04144cb96a045f70546657c', CAST(0x0000AB44008FA395 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (782, N'4571ccfe4049490baa178942fffa81d4', CAST(0x0000AB5D0146228A AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (783, N'370e2e86dddc4041bf0ea9e4cbe4d39c', CAST(0x0000AB6001199688 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (784, N'6a96a1f81bbf487884fc20f85d3ca2b6', CAST(0x0000AB60011F0C4A AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (785, N'a03a0b0659b34a60b2d4df249e290b03', CAST(0x0000AB60012042F6 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (786, N'3aab31d28e3b4aa09dc32b88b506820b', CAST(0x0000AB6001279BEC AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (787, N'c0db98f16ece4daa9476389353170bdd', CAST(0x0000AB6001284B43 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (788, N'882fce1ef291458abec238442a8fa7db', CAST(0x0000AB6001286834 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (789, N'a9200a2ac2f945f0a6d236f6e2f93ca2', CAST(0x0000AB60012956AE AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (790, N'facb6b63d20d40c3953ac190994df858', CAST(0x0000AB6101162C0B AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (791, N'3806544016204c0584e3323c86cb5ef6', CAST(0x0000AB61011B17F2 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (792, N'e61a697f88f24b3ca6a7f152c20e44c8', CAST(0x0000AB61011C5862 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (793, N'78c46c5b3369418294db56d3613fe0f3', CAST(0x0000AB61011F57CB AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (794, N'474c822f0630462699ae553c2d9800d1', CAST(0x0000AB61011FF5A7 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (795, N'dc909d5c9bdc42d5bd1f2d4142137a66', CAST(0x0000AB61015565B6 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (796, N'8e735eb024ec4c0c84140c6ebfddc16c', CAST(0x0000AB61015CB1EE AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (797, N'4ee120de885d4dc9b9902f93bd1c1d27', CAST(0x0000AB6200E1E23D AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (798, N'06158408c6f04777a93697541b70f5b0', CAST(0x0000AB6200E38897 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (799, N'bc234130efa7482badb7ff412d850533', CAST(0x0000AB6200E60988 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (800, N'c9d66b15a3514b548f2d3248d30fe0d8', CAST(0x0000AB6200F09902 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (801, N'528e02fe311643dc8c28f4080b5fae18', CAST(0x0000AB620101A513 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (802, N'bd3d7febd07642239084a0628c63a945', CAST(0x0000AB62010498A7 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (803, N'33c0d59722754a39900ce1205c5b2741', CAST(0x0000AB62010A7D8D AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (804, N'43d323f2b78547c9b0cae5cf92ebf582', CAST(0x0000AB620115EE6A AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (805, N'27a9fd96c2c449ddadd3e2c90809b7fb', CAST(0x0000AB62011CBF42 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (806, N'1500a8df28dd460389420e166bc0b496', CAST(0x0000AB62011D35D6 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (807, N'b6cba30dc0b049b6a12f8cf7f8e5cdd5', CAST(0x0000AB62012E934D AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (808, N'aa66bc06acb44efb94f6affcf685b0e4', CAST(0x0000AB6A00AFAB7A AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (809, N'7798e85da6aa46eb88fb1aa8919aa575', CAST(0x0000AB6B016C6FAE AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (810, N'6adc9daa6306463cbe65241773643fd4', CAST(0x0000AB6B016D8175 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (811, N'bed152c089244d079e11b337df46475b', CAST(0x0000AB6B016D84CB AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[sys_WebLog] ([rowNum], [rowID], [logDate], [logType], [userCode], [fromIP], [ipLoc], [fromLoc], [accessLoc], [requestType], [remark]) VALUES (812, N'804795ea41e54dee94578ad1abf28f64', CAST(0x0000AB6C00119349 AS DateTime), N'登录', N'sysAdmin', NULL, NULL, NULL, NULL, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[sys_WebLog] OFF
GO
ALTER TABLE [dbo].[rbac_Resource] ADD  CONSTRAINT [DF_rbac_Resource_privControl]  DEFAULT (N'是') FOR [opControl]
GO
ALTER TABLE [dbo].[sbs_Empl] ADD  CONSTRAINT [DF__bs_Empl__isQuit__2FBA0BF1]  DEFAULT ('否') FOR [status]
GO
ALTER TABLE [dbo].[sys_Column] ADD  CONSTRAINT [DF_sys_Column_isShow]  DEFAULT ((1)) FOR [isShow]
GO
ALTER TABLE [dbo].[sys_Column] ADD  CONSTRAINT [DF_sys_Column_isOrder]  DEFAULT ((0)) FOR [isOrder]
GO
ALTER TABLE [dbo].[sys_Column] ADD  CONSTRAINT [DF_sys_Column_resize]  DEFAULT ((1)) FOR [isResize]
GO
ALTER TABLE [dbo].[sys_Column] ADD  CONSTRAINT [DF_sys_Column_fixedValue]  DEFAULT (N'no') FOR [fixedValue]
GO
ALTER TABLE [dbo].[sys_Column] ADD  CONSTRAINT [DF_sys_Column_alignType]  DEFAULT (N'left') FOR [alignType]
GO
ALTER TABLE [dbo].[sys_DataSyncInterfaceDetail] ADD  CONSTRAINT [DF_DataSyncInterfaceDetail_show]  DEFAULT (N'是') FOR [show]
GO
ALTER TABLE [dbo].[sys_DataSyncInterfaceDetail] ADD  CONSTRAINT [DF_DataSyncInterfaceDetail_import]  DEFAULT (N'是') FOR [import]
GO
ALTER TABLE [dbo].[sys_DataSyncInterfaceDetail] ADD  CONSTRAINT [DF_DataSyncInterfaceDetail_filter]  DEFAULT (N'否') FOR [filter]
GO
ALTER TABLE [dbo].[sys_UCColumn] ADD  CONSTRAINT [DF_sys_UCColumn_isShow]  DEFAULT ((1)) FOR [isShow]
GO
ALTER TABLE [dbo].[sys_UCColumn] ADD  CONSTRAINT [DF_sys_UCColumn_isOrder]  DEFAULT ((0)) FOR [isOrder]
GO
ALTER TABLE [dbo].[sys_UCColumn] ADD  CONSTRAINT [DF_sys_UCColumn_resize]  DEFAULT ((1)) FOR [isResize]
GO
ALTER TABLE [dbo].[sys_UCColumn] ADD  CONSTRAINT [DF_sys_UCColumn_alignType]  DEFAULT (N'left') FOR [alignType]
GO
ALTER TABLE [dbo].[sys_UCPager] ADD  CONSTRAINT [DF__sys_UCPag__pageS__4CA06362]  DEFAULT ((20)) FOR [pageSize]
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
         Begin Table = "af_AuditLog"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 240
               Right = 227
            End
            DisplayFlags = 280
            TopColumn = 11
         End
         Begin Table = "sbs_Dept"
            Begin Extent = 
               Top = 6
               Left = 265
               Bottom = 145
               Right = 428
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "sendUser"
            Begin Extent = 
               Top = 64
               Left = 562
               Bottom = 203
               Right = 723
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "auditUser"
            Begin Extent = 
               Top = 150
               Left = 237
               Bottom = 289
               Right = 398
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "af_AuditType"
            Begin Extent = 
               Top = 294
               Left = 38
               Bottom = 433
               Right = 219
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
    ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'sv_af_AuditCenter'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'     Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'sv_af_AuditCenter'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'sv_af_AuditCenter'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[31] 4[30] 2[20] 3) )"
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
         Begin Table = "af_AuditFlow"
            Begin Extent = 
               Top = 0
               Left = 38
               Bottom = 188
               Right = 188
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "af_AuditType"
            Begin Extent = 
               Top = 2
               Left = 621
               Bottom = 121
               Right = 785
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "sbs_Org"
            Begin Extent = 
               Top = 6
               Left = 230
               Bottom = 145
               Right = 404
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
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 3900
         Alias = 900
         Table = 1740
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'sv_af_AuditFlow'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'sv_af_AuditFlow'
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
         Begin Table = "af_AuditPostUser"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 253
               Right = 196
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "rbac_User"
            Begin Extent = 
               Top = 6
               Left = 234
               Bottom = 145
               Right = 395
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "af_AuditPost"
            Begin Extent = 
               Top = 62
               Left = 519
               Bottom = 201
               Right = 677
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "sbs_Dept"
            Begin Extent = 
               Top = 150
               Left = 234
               Bottom = 289
               Right = 397
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'sv_af_AuditPostUser'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'sv_af_AuditPostUser'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[49] 4[15] 2[20] 3) )"
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
         Begin Table = "rbac_Resource"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 313
               Right = 204
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "rbac_Module"
            Begin Extent = 
               Top = 6
               Left = 242
               Bottom = 125
               Right = 392
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
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 3405
         Alias = 2865
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'sv_rbac_Resource'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'sv_rbac_Resource'
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
         Begin Table = "rbac_UserOrg"
            Begin Extent = 
               Top = 20
               Left = 23
               Bottom = 276
               Right = 170
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "sbs_Dept"
            Begin Extent = 
               Top = 6
               Left = 223
               Bottom = 145
               Right = 386
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "sbs_Org"
            Begin Extent = 
               Top = 83
               Left = 450
               Bottom = 222
               Right = 624
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'sv_rbac_UserOrg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'sv_rbac_UserOrg'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[54] 4[15] 2[30] 3) )"
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
         Begin Table = "sbs_Dept"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 316
               Right = 201
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "sbs_Org"
            Begin Extent = 
               Top = 6
               Left = 239
               Bottom = 145
               Right = 413
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "dept2"
            Begin Extent = 
               Top = 5
               Left = 361
               Bottom = 125
               Right = 510
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
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 2175
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'sv_sbs_Dept'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'sv_sbs_Dept'
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
         Begin Table = "sys_BillAttach"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 229
               Right = 253
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "rbac_User"
            Begin Extent = 
               Top = 6
               Left = 291
               Bottom = 237
               Right = 452
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
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'sv_sys_BillAttach'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'sv_sys_BillAttach'
GO
