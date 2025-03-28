USE [MotoVibeDB]
GO
/****** Object:  Table [dbo].[appointments]    Script Date: 3/10/2025 2:56:43 AM ******/
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
/****** Object:  Table [dbo].[brands]    Script Date: 3/10/2025 2:56:43 AM ******/
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
/****** Object:  Table [dbo].[customers]    Script Date: 3/10/2025 2:56:43 AM ******/
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
/****** Object:  Table [dbo].[employees]    Script Date: 3/10/2025 2:56:43 AM ******/
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
/****** Object:  Table [dbo].[events]    Script Date: 3/10/2025 2:56:43 AM ******/
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
/****** Object:  Table [dbo].[feedbacks]    Script Date: 3/10/2025 2:56:43 AM ******/
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
/****** Object:  Table [dbo].[fuels]    Script Date: 3/10/2025 2:56:43 AM ******/
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
/****** Object:  Table [dbo].[inventory_log]    Script Date: 3/10/2025 2:56:43 AM ******/
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
/****** Object:  Table [dbo].[models]    Script Date: 3/10/2025 2:56:43 AM ******/
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
/****** Object:  Table [dbo].[motors]    Script Date: 3/10/2025 2:56:43 AM ******/
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
/****** Object:  Table [dbo].[orders]    Script Date: 3/10/2025 2:56:43 AM ******/
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
/****** Object:  Table [dbo].[reviews]    Script Date: 3/10/2025 2:56:43 AM ******/
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
/****** Object:  Table [dbo].[user_account]    Script Date: 3/10/2025 2:56:43 AM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[warranty]    Script Date: 3/10/2025 2:56:43 AM ******/
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
/****** Object:  Table [dbo].[wishlist]    Script Date: 3/10/2025 2:56:43 AM ******/
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
SET IDENTITY_INSERT [dbo].[appointments] ON 

INSERT [dbo].[appointments] ([appointment_id], [customer_id], [employee_id], [date_start], [date_end], [note], [appointment_status]) VALUES (1, 1, 1, CAST(N'2025-01-21' AS Date), CAST(N'2025-01-21' AS Date), N'Initial consultation for Honda CBR500R', 1)
INSERT [dbo].[appointments] ([appointment_id], [customer_id], [employee_id], [date_start], [date_end], [note], [appointment_status]) VALUES (2, 2, 1, CAST(N'2025-02-13' AS Date), CAST(N'2025-02-13' AS Date), N'Test ride and financing discussion for Yamaha R3', 1)
INSERT [dbo].[appointments] ([appointment_id], [customer_id], [employee_id], [date_start], [date_end], [note], [appointment_status]) VALUES (4, 1, 1, CAST(N'2025-02-28' AS Date), CAST(N'2025-03-02' AS Date), N'cadascxzc', 0)
INSERT [dbo].[appointments] ([appointment_id], [customer_id], [employee_id], [date_start], [date_end], [note], [appointment_status]) VALUES (5, 1, 1, CAST(N'2025-02-28' AS Date), CAST(N'2025-03-02' AS Date), N'1casdwd', 1)
SET IDENTITY_INSERT [dbo].[appointments] OFF
GO
SET IDENTITY_INSERT [dbo].[brands] ON 

INSERT [dbo].[brands] ([brand_id], [brand_name], [country_of_origin], [description]) VALUES (1, N'Honda', N'Japan', N'Renowned for reliability and fuel efficiency.')
INSERT [dbo].[brands] ([brand_id], [brand_name], [country_of_origin], [description]) VALUES (2, N'Yamaha', N'Japan', N'Known for performance and sporty designs.')
INSERT [dbo].[brands] ([brand_id], [brand_name], [country_of_origin], [description]) VALUES (3, N'Harley-Davidson', N'USA', N'Iconic American motorcycles, known for their V-twin engines.')
SET IDENTITY_INSERT [dbo].[brands] OFF
GO
SET IDENTITY_INSERT [dbo].[customers] ON 

INSERT [dbo].[customers] ([customer_id], [user_id], [name], [phone_number], [address]) VALUES (1, 2, N'John Doe', N'555-123-4567', N'123 Main St, Anytown, USA')
INSERT [dbo].[customers] ([customer_id], [user_id], [name], [phone_number], [address]) VALUES (2, 3, N'Jane Smith', N'555-987-6543', N'456 Oak Ave, Anytown, USA')
INSERT [dbo].[customers] ([customer_id], [user_id], [name], [phone_number], [address]) VALUES (3, 6, N'Hung Truong', N'0817771184', N'An Giang')
SET IDENTITY_INSERT [dbo].[customers] OFF
GO
SET IDENTITY_INSERT [dbo].[employees] ON 

INSERT [dbo].[employees] ([employee_id], [user_id], [name], [phone_number]) VALUES (1, 4, N'Alice Jones', N'555-111-2222')
INSERT [dbo].[employees] ([employee_id], [user_id], [name], [phone_number]) VALUES (2, 5, N'Bob Williams', N'555-333-4444')
SET IDENTITY_INSERT [dbo].[employees] OFF
GO
SET IDENTITY_INSERT [dbo].[events] ON 

INSERT [dbo].[events] ([event_id], [event_name], [event_details], [image], [date_start], [date_end], [event_status], [user_id]) VALUES (1, N'Spring Motorcycle Show', N'Local motorcycle show featuring new models and custom bikes.', NULL, CAST(N'2025-04-15' AS Date), CAST(N'2025-04-17' AS Date), 1, 1)
SET IDENTITY_INSERT [dbo].[events] OFF
GO
SET IDENTITY_INSERT [dbo].[feedbacks] ON 

INSERT [dbo].[feedbacks] ([feedback_id], [order_id], [customer_id], [feedback_content], [feedback_status], [date_create]) VALUES (1, 1, 1, N'The sales process was smooth and the staff was very helpful.', 1, CAST(N'2025-01-31' AS Date))
SET IDENTITY_INSERT [dbo].[feedbacks] OFF
GO
SET IDENTITY_INSERT [dbo].[fuels] ON 

INSERT [dbo].[fuels] ([fuel_id], [fuel_name]) VALUES (1, N'Gasoline')
INSERT [dbo].[fuels] ([fuel_id], [fuel_name]) VALUES (2, N'Electric')
SET IDENTITY_INSERT [dbo].[fuels] OFF
GO
SET IDENTITY_INSERT [dbo].[models] ON 

INSERT [dbo].[models] ([model_id], [model_name]) VALUES (1, N'CBR')
INSERT [dbo].[models] ([model_id], [model_name]) VALUES (2, N'YZF-R')
INSERT [dbo].[models] ([model_id], [model_name]) VALUES (3, N'Softail')
INSERT [dbo].[models] ([model_id], [model_name]) VALUES (4, N'CB')
SET IDENTITY_INSERT [dbo].[models] OFF
GO
SET IDENTITY_INSERT [dbo].[motors] ON 

INSERT [dbo].[motors] ([motor_id], [brand_id], [model_id], [motor_name], [date_start], [color], [price], [fuel_id], [present], [description], [quantity], [picture]) VALUES (1, 1, 1, N'Honda CBR500R', CAST(N'2023-05-15' AS Date), N'Red', CAST(6999.00 AS Decimal(12, 2)), 1, 1, N'Sporty and versatile middleweight motorcycle.222', 5, N'motor_pictures/motor_1_1740742585058.jpg')
INSERT [dbo].[motors] ([motor_id], [brand_id], [model_id], [motor_name], [date_start], [color], [price], [fuel_id], [present], [description], [quantity], [picture]) VALUES (2, 2, 2, N'Yamaha R3', CAST(N'2024-01-20' AS Date), N'Blue', CAST(5299.00 AS Decimal(12, 2)), 1, 1, N'Lightweight and agile sportbike.', 8, N'motor_pictures/motor_2_1740740061421.jpg')
INSERT [dbo].[motors] ([motor_id], [brand_id], [model_id], [motor_name], [date_start], [color], [price], [fuel_id], [present], [description], [quantity], [picture]) VALUES (3, 3, 3, N'Harley-Davidson Softail Standard', CAST(N'2023-08-01' AS Date), N'Black', CAST(13599.00 AS Decimal(12, 2)), 1, 1, N'Classic cruiser with a modern edge.', 2, N'motor_pictures/motor_3_1740740070504.jpg')
INSERT [dbo].[motors] ([motor_id], [brand_id], [model_id], [motor_name], [date_start], [color], [price], [fuel_id], [present], [description], [quantity], [picture]) VALUES (4, 1, 4, N'Honda CB500X', CAST(N'2024-03-10' AS Date), N'White', CAST(7299.00 AS Decimal(12, 2)), 1, 1, N'Adventure-ready motorcycle.', 3, N'motor_pictures/motor_4_1740740078347.jpg')
SET IDENTITY_INSERT [dbo].[motors] OFF
GO
SET IDENTITY_INSERT [dbo].[orders] ON 

INSERT [dbo].[orders] ([order_id], [customer_id], [employee_id], [motor_id], [create_date], [payment_method], [total_amount], [deposit_status], [order_status], [date_start], [date_end], [has_warranty], [warranty_id], [order_code]) VALUES (1, 1, 1, 1, CAST(N'2025-01-26T01:02:28.910' AS DateTime), N'Credit Card', CAST(6999.00 AS Decimal(12, 2)), 1, N'Completed', CAST(N'2025-01-31' AS Date), CAST(N'2025-02-20' AS Date), 1, NULL, N'MV-1')
INSERT [dbo].[orders] ([order_id], [customer_id], [employee_id], [motor_id], [create_date], [payment_method], [total_amount], [deposit_status], [order_status], [date_start], [date_end], [has_warranty], [warranty_id], [order_code]) VALUES (2, 2, 1, 2, CAST(N'2025-02-15T01:02:28.910' AS DateTime), N'Finance', CAST(5299.00 AS Decimal(12, 2)), 1, N'Processing', CAST(N'2025-02-20' AS Date), NULL, 0, NULL, N'MV-2')
INSERT [dbo].[orders] ([order_id], [customer_id], [employee_id], [motor_id], [create_date], [payment_method], [total_amount], [deposit_status], [order_status], [date_start], [date_end], [has_warranty], [warranty_id], [order_code]) VALUES (3, 3, 2, 1, CAST(N'2025-03-10T02:45:32.977' AS DateTime), N'Credit Card', CAST(6999.00 AS Decimal(12, 2)), 0, N'Pending', CAST(N'2025-03-10' AS Date), CAST(N'2025-03-12' AS Date), 1, 1, NULL)
SET IDENTITY_INSERT [dbo].[orders] OFF
GO
SET IDENTITY_INSERT [dbo].[reviews] ON 

INSERT [dbo].[reviews] ([review_id], [customer_id], [motor_id], [rating], [review_text], [review_date], [review_status]) VALUES (1, 1, 1, 5, N'Excellent bike, very happy with the purchase!', CAST(N'2025-02-05' AS Date), 1)
INSERT [dbo].[reviews] ([review_id], [customer_id], [motor_id], [rating], [review_text], [review_date], [review_status]) VALUES (2, 2, 2, 4, N'Great handling, but the seat could be more comfortable.', CAST(N'2025-02-17' AS Date), 1)
SET IDENTITY_INSERT [dbo].[reviews] OFF
GO
SET IDENTITY_INSERT [dbo].[user_account] ON 

INSERT [dbo].[user_account] ([user_id], [email], [password], [role], [date_created], [status]) VALUES (1, N'admin@motovibe.com', N'admin123', N'admin', CAST(N'2025-02-25' AS Date), 1)
INSERT [dbo].[user_account] ([user_id], [email], [password], [role], [date_created], [status]) VALUES (2, N'john.doe@example.com', N'customer1', N'customer', CAST(N'2025-02-25' AS Date), 1)
INSERT [dbo].[user_account] ([user_id], [email], [password], [role], [date_created], [status]) VALUES (3, N'jane.smith@example.com', N'customer2', N'customer', CAST(N'2025-02-25' AS Date), 1)
INSERT [dbo].[user_account] ([user_id], [email], [password], [role], [date_created], [status]) VALUES (4, N'alice.jones@example.com', N'employee1', N'employee', CAST(N'2025-02-25' AS Date), 1)
INSERT [dbo].[user_account] ([user_id], [email], [password], [role], [date_created], [status]) VALUES (5, N'bob.williams@example.com', N'employee2', N'employee', CAST(N'2025-02-25' AS Date), 1)
INSERT [dbo].[user_account] ([user_id], [email], [password], [role], [date_created], [status]) VALUES (6, N'truongquochungag@gmail.com', N'123', N'customer', CAST(N'2025-03-10' AS Date), 1)
SET IDENTITY_INSERT [dbo].[user_account] OFF
GO
SET IDENTITY_INSERT [dbo].[warranty] ON 

INSERT [dbo].[warranty] ([warranty_id], [order_id], [warranty_details], [warranty_expiry]) VALUES (1, 3, N'Standard 2-year manufacturer warranty covering parts and service.', CAST(N'2027-03-10' AS Date))
SET IDENTITY_INSERT [dbo].[warranty] OFF
GO
SET IDENTITY_INSERT [dbo].[wishlist] ON 

INSERT [dbo].[wishlist] ([wishlist_id], [customer_id], [motor_id]) VALUES (1, 1, 3)
INSERT [dbo].[wishlist] ([wishlist_id], [customer_id], [motor_id]) VALUES (2, 2, 1)
SET IDENTITY_INSERT [dbo].[wishlist] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__user_acc__AB6E61640D333E6A]    Script Date: 3/10/2025 2:56:43 AM ******/
ALTER TABLE [dbo].[user_account] ADD UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
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
