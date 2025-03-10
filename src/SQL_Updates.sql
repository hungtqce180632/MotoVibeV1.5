-- Add order_code column to orders table
ALTER TABLE [dbo].[orders]
ADD [order_code] VARCHAR(50) NULL;

-- Update existing orders with a default code
UPDATE [dbo].[orders]
SET [order_code] = 'MV-' + CAST([order_id] AS VARCHAR(10))
WHERE [order_code] IS NULL;
