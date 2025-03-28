USE [MotoVibeDB]
GO
/****** Object:  Table [dbo].[appointments]    Script Date: 3/28/2025 5:40:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[appointments](
	[appointment_id] [int] IDENTITY(1,1) NOT NULL,
	[customer_id] [int] NOT NULL,
	[employee_id] [int] NULL,
	[date_start] [date] NOT NULL,
	[date_end] [date] NULL,
	[note] [nvarchar](max) NULL,
	[appointment_status] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[appointment_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[brands]    Script Date: 3/28/2025 5:40:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[brands](
	[brand_id] [int] IDENTITY(1,1) NOT NULL,
	[brand_name] [varchar](255) NOT NULL,
	[country_of_origin] [varchar](255) NULL,
	[description] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[brand_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[customers]    Script Date: 3/28/2025 5:40:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[customers](
	[customer_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[name] [varchar](255) NOT NULL,
	[phone_number] [varchar](20) NULL,
	[address] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[customer_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[employees]    Script Date: 3/28/2025 5:40:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[employees](
	[employee_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[name] [varchar](255) NOT NULL,
	[phone_number] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[employee_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[events]    Script Date: 3/28/2025 5:40:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[events](
	[event_id] [int] IDENTITY(1,1) NOT NULL,
	[event_name] [varchar](255) NOT NULL,
	[event_details] [nvarchar](max) NULL,
	[image] [varbinary](max) NULL,
	[date_start] [date] NULL,
	[date_end] [date] NULL,
	[event_status] [bit] NOT NULL,
	[user_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[event_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[feedbacks]    Script Date: 3/28/2025 5:40:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[feedbacks](
	[feedback_id] [int] IDENTITY(1,1) NOT NULL,
	[order_id] [int] NOT NULL,
	[customer_id] [int] NOT NULL,
	[feedback_content] [nvarchar](max) NULL,
	[feedback_status] [bit] NOT NULL,
	[date_create] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[feedback_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[fuels]    Script Date: 3/28/2025 5:40:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[fuels](
	[fuel_id] [int] IDENTITY(1,1) NOT NULL,
	[fuel_name] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[fuel_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[inventory_log]    Script Date: 3/28/2025 5:40:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[inventory_log](
	[log_id] [int] IDENTITY(1,1) NOT NULL,
	[motor_id] [int] NOT NULL,
	[previous_quantity] [int] NOT NULL,
	[change_amount] [int] NOT NULL,
	[action_type] [varchar](50) NOT NULL,
	[user_id_modified_by] [int] NOT NULL,
	[modified_at] [datetime] NULL,
	[note] [text] NULL,
PRIMARY KEY CLUSTERED 
(
	[log_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[models]    Script Date: 3/28/2025 5:40:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[models](
	[model_id] [int] IDENTITY(1,1) NOT NULL,
	[model_name] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[model_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[motors]    Script Date: 3/28/2025 5:40:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[motors](
	[motor_id] [int] IDENTITY(1,1) NOT NULL,
	[brand_id] [int] NOT NULL,
	[model_id] [int] NOT NULL,
	[motor_name] [varchar](255) NOT NULL,
	[date_start] [date] NULL,
	[color] [varchar](100) NULL,
	[price] [decimal](12, 2) NOT NULL,
	[fuel_id] [int] NOT NULL,
	[present] [bit] NOT NULL,
	[description] [nvarchar](max) NULL,
	[quantity] [int] NULL,
	[picture] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[motor_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[orders]    Script Date: 3/28/2025 5:40:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[orders](
	[order_id] [int] IDENTITY(1,1) NOT NULL,
	[customer_id] [int] NOT NULL,
	[employee_id] [int] NULL,
	[motor_id] [int] NOT NULL,
	[create_date] [datetime] NULL,
	[payment_method] [varchar](50) NULL,
	[total_amount] [decimal](12, 2) NOT NULL,
	[deposit_status] [bit] NOT NULL,
	[order_status] [varchar](50) NULL,
	[date_start] [date] NULL,
	[date_end] [date] NULL,
	[has_warranty] [bit] NOT NULL,
	[warranty_id] [int] NULL,
	[order_code] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[order_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[reviews]    Script Date: 3/28/2025 5:40:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[reviews](
	[review_id] [int] IDENTITY(1,1) NOT NULL,
	[customer_id] [int] NOT NULL,
	[motor_id] [int] NOT NULL,
	[rating] [int] NOT NULL,
	[review_text] [nvarchar](max) NULL,
	[review_date] [date] NULL,
	[review_status] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[review_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[user_account]    Script Date: 3/28/2025 5:40:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user_account](
	[user_id] [int] IDENTITY(1,1) NOT NULL,
	[email] [varchar](255) NOT NULL,
	[password] [varchar](255) NULL,
	[role] [varchar](50) NOT NULL,
	[date_created] [date] NULL,
	[status] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[warranty]    Script Date: 3/28/2025 5:40:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[warranty](
	[warranty_id] [int] IDENTITY(1,1) NOT NULL,
	[order_id] [int] NOT NULL,
	[warranty_details] [nvarchar](max) NULL,
	[warranty_expiry] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[warranty_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[wishlist]    Script Date: 3/28/2025 5:40:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[wishlist](
	[wishlist_id] [int] IDENTITY(1,1) NOT NULL,
	[customer_id] [int] NOT NULL,
	[motor_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[wishlist_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[inventory_log] ADD  DEFAULT (getdate()) FOR [modified_at]
GO
ALTER TABLE [dbo].[orders] ADD  DEFAULT ((0)) FOR [has_warranty]
GO
ALTER TABLE [dbo].[appointments]  WITH NOCHECK ADD FOREIGN KEY([customer_id])
REFERENCES [dbo].[customers] ([customer_id])
GO
ALTER TABLE [dbo].[appointments]  WITH NOCHECK ADD FOREIGN KEY([employee_id])
REFERENCES [dbo].[employees] ([employee_id])
GO
ALTER TABLE [dbo].[customers]  WITH NOCHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[user_account] ([user_id])
GO
ALTER TABLE [dbo].[employees]  WITH NOCHECK ADD FOREIGN KEY([user_id])
REFERENCES [dbo].[user_account] ([user_id])
GO
ALTER TABLE [dbo].[events]  WITH NOCHECK ADD  CONSTRAINT [FK_Events_UserAccount] FOREIGN KEY([user_id])
REFERENCES [dbo].[user_account] ([user_id])
GO
ALTER TABLE [dbo].[events] CHECK CONSTRAINT [FK_Events_UserAccount]
GO
ALTER TABLE [dbo].[feedbacks]  WITH NOCHECK ADD  CONSTRAINT [FK_Feedbacks_Orders] FOREIGN KEY([order_id])
REFERENCES [dbo].[orders] ([order_id])
GO
ALTER TABLE [dbo].[feedbacks] CHECK CONSTRAINT [FK_Feedbacks_Orders]
GO
ALTER TABLE [dbo].[inventory_log]  WITH NOCHECK ADD FOREIGN KEY([motor_id])
REFERENCES [dbo].[motors] ([motor_id])
GO
ALTER TABLE [dbo].[inventory_log]  WITH NOCHECK ADD FOREIGN KEY([user_id_modified_by])
REFERENCES [dbo].[user_account] ([user_id])
GO
ALTER TABLE [dbo].[motors]  WITH NOCHECK ADD FOREIGN KEY([brand_id])
REFERENCES [dbo].[brands] ([brand_id])
GO
ALTER TABLE [dbo].[motors]  WITH NOCHECK ADD FOREIGN KEY([fuel_id])
REFERENCES [dbo].[fuels] ([fuel_id])
GO
ALTER TABLE [dbo].[motors]  WITH NOCHECK ADD FOREIGN KEY([model_id])
REFERENCES [dbo].[models] ([model_id])
GO
ALTER TABLE [dbo].[orders]  WITH NOCHECK ADD FOREIGN KEY([customer_id])
REFERENCES [dbo].[customers] ([customer_id])
GO
ALTER TABLE [dbo].[orders]  WITH NOCHECK ADD FOREIGN KEY([employee_id])
REFERENCES [dbo].[employees] ([employee_id])
GO
ALTER TABLE [dbo].[orders]  WITH NOCHECK ADD FOREIGN KEY([motor_id])
REFERENCES [dbo].[motors] ([motor_id])
GO
ALTER TABLE [dbo].[reviews]  WITH NOCHECK ADD FOREIGN KEY([customer_id])
REFERENCES [dbo].[customers] ([customer_id])
GO
ALTER TABLE [dbo].[reviews]  WITH NOCHECK ADD FOREIGN KEY([motor_id])
REFERENCES [dbo].[motors] ([motor_id])
GO
ALTER TABLE [dbo].[warranty]  WITH NOCHECK ADD FOREIGN KEY([order_id])
REFERENCES [dbo].[orders] ([order_id])
GO
ALTER TABLE [dbo].[wishlist]  WITH NOCHECK ADD FOREIGN KEY([customer_id])
REFERENCES [dbo].[customers] ([customer_id])
GO
ALTER TABLE [dbo].[wishlist]  WITH NOCHECK ADD FOREIGN KEY([motor_id])
REFERENCES [dbo].[motors] ([motor_id])
GO
ALTER TABLE [dbo].[inventory_log]  WITH NOCHECK ADD CHECK  (([action_type]='Decrease' OR [action_type]='Increase'))
GO
ALTER TABLE [dbo].[inventory_log]  WITH NOCHECK ADD CHECK  (([previous_quantity]>=(0)))
GO
