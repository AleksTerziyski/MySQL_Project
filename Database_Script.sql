
DROP DATABASE computertechs;
Create Database ComputerTechs;

USE ComputerTechs;


CREATE TABLE Products(
ProductId INT,
Type VARCHAR(30),
Warranty INT CHECK(Warranty >= 0),
Price DECIMAL(10,2) CHECK(Price > 0),
Quantity INT CHECK(Quantity >= 0),
CONSTRAINT PK_Products PRIMARY KEY (ProductId)
);

CREATE TABLE Customers(
Username VARCHAR(255),
Email VARCHAR(255) NOT NULL UNIQUE,
PhoneNumber VARCHAR(50) NOT NULL,
Password VARCHAR(255) NOT NULL,
ActiveStatus BIT NOT NULL DEFAULT 1,
CONSTRAINT PK_Customers PRIMARY KEY (Username)
);

CREATE TABLE Orders(
Customer VARCHAR(255) NOT NULL,
OrderId INT AUTO_INCREMENT,
TotalPrice DECIMAL(18,2) DEFAULT 0 NOT NULL,
CreatedAt DATETIME DEFAULT NOW(),
Finished BIT NOT NULL DEFAULT 0,
CONSTRAINT PK_Orders PRIMARY KEY (OrderId)
);
-- След смяна на потребителското си име, клиента запазва поръчките си
ALTER TABLE Orders ADD CONSTRAINT FK_Orders_Customers FOREIGN KEY (Customer) REFERENCES Customers(Username) ON UPDATE CASCADE;

CREATE TABLE OrdersProducts(
OrderId INT,
ProductId INT,
Quantity INT CHECK(Quantity >=0),
ProductPrice DECIMAL(18,2) DEFAULT 0 NOT NULL,
CONSTRAINT PK_OrdersProducts PRIMARY KEY (OrderId,ProductId)
);
ALTER TABLE OrdersProducts ADD CONSTRAINT FK_OrdersProducts_Orders FOREIGN KEY (OrderId) REFERENCES Orders(OrderId) ON DELETE CASCADE;
ALTER TABLE OrdersProducts ADD CONSTRAINT FK_OrdersProducts_Products FOREIGN KEY(ProductId) REFERENCES Products(ProductId);


CREATE TABLE Processors(
ProcessorId INT,
Manufacturer VARCHAR(50) NOT NULL,
Model VARCHAR(50) NOT NULL UNIQUE,
Cores INT NOT NULL CHECK(Cores > 0),
Threads INT NOT NULL CHECK(Threads>0),
BaseFrequency DECIMAL(6,2) NOT NULL CHECK(BaseFrequency > 0),
TurboFrequency DECIMAL(6,2) NOT NULL CHECK(TurboFrequency > 0),
Socket VARCHAR(50) NOT NULL,
MaximumTemperature INT NOT NULL CHECK(MaximumTemperature > 0),
CONSTRAINT PK_Processors PRIMARY KEY(ProcessorId)
);

ALTER TABLE Processors ADD CONSTRAINT FK_Processors_Products FOREIGN KEY (ProcessorId) REFERENCES Products(ProductId);

-- отделен чек, ако евентуално след време освободим Id-та (след 100 000) примерно за ползване
-- ще се направи отделна таблица за интервалите от допустими стойности
ALTER TABLE Processors
ADD CONSTRAINT CHK_Processors_ProcessorId
CHECK(ProcessorId BETWEEN 3001 AND 4000);

CREATE TABLE Mouses(
MouseId INT,
Manufacturer VARCHAR(50) NOT NULL,
Model VARCHAR(50) NOT NULL UNIQUE,
DPI INT NOT NULL CHECK(DPI > 0),
Buttons INT NOT NULL CHECK(Buttons > 0),
Port VARCHAR(20) NOT NULL,
Battery INT,
Wireless BIT NOT NULL,
Weight INT NOT NULL CHECK(Weight > 0),
Color VARCHAR(30) NOT NULL,
CableLength DECIMAL(8,2),
CONSTRAINT PK_Mouses PRIMARY KEY (MouseId)
);

ALTER TABLE Mouses ADD CONSTRAINT FK_Mouses_Products FOREIGN KEY (MouseId) REFERENCES Products(ProductId);

ALTER TABLE Mouses
ADD CONSTRAINT CHK_Mouses_MouseId
CHECK(MouseId BETWEEN 8001 AND 9000);

CREATE TABLE Keyboards(
KeyboardId INT,
Manufacturer VARCHAR(50) NOT NULL,
Model VARCHAR(50) NOT NULL UNIQUE,
Port VARCHAR(30) NOT NULL,
Backlight BIT NOT NULL,
Wireless BIT NOT NULL,
Color VARCHAR(20) NOT NULL,
CableLength DECIMAL(8,2),
CONSTRAINT PK_Keyboards PRIMARY KEY (KeyboardId)
);

ALTER TABLE Keyboards ADD CONSTRAINT FK_Keyboards_Products FOREIGN KEY (KeyboardId) REFERENCES Products(ProductId);

ALTER TABLE Keyboards
ADD CONSTRAINT CHK_Keyboards_KeyboardId
CHECK(KeyboardId BETWEEN 9001 AND 10000);

CREATE TABLE Monitors(
MonitorId INT,
Manufacturer VARCHAR(50) NOT NULL,
Model VARCHAR(50) NOT NULL UNIQUE,
Size DECIMAL(6,1) NOT NULL CHECK(Size> 0), 
Resolution VARCHAR(20) NOT NULL,
AspectRatio VARCHAR(10) NOT NULL,
RefreshRate INT NOT NULL CHECK(RefreshRate > 0),
Type VARCHAR(20) NOT NULL,
Brightness INT NOT NULL CHECK(Brightness > 0),
Contrast VARCHAR(50) NOT NULL,
Colors DECIMAL(18,1) NOT NULL CHECK(Colors> 0),
CONSTRAINT PK_Monitors PRIMARY KEY (MonitorId)
);

ALTER TABLE Monitors ADD CONSTRAINT FK_Monitors_Products FOREIGN KEY (MonitorId) REFERENCES Products(ProductId);

ALTER TABLE Monitors
ADD CONSTRAINT CHK_Monitors_MonitorId
CHECK(MonitorId BETWEEN 7001 AND 8000);

CREATE TABLE Ports(
PortId INT,
Type VARCHAR(50) NOT NULL UNIQUE,
CONSTRAINT PK_Ports PRIMARY KEY (PortId)
);

ALTER TABLE Ports
ADD CONSTRAINT CHK_Ports_PortId
CHECK(PortId BETWEEN 10001 AND 11000);

CREATE TABLE RAMs(
RAMId INT,
Manufacturer VARCHAR(50) NOT NULL,
Model VARCHAR(50) NOT NULL UNIQUE,
Capacity DECIMAL(10,3) NOT NULL CHECK(Capacity > 0),
Type VARCHAR(20) NOT NULL,
Frequency INT NOT NULL CHECK(Frequency > 0),
CONSTRAINT PK_RAMs PRIMARY KEY (RAMId)
);

ALTER TABLE RAMs ADD CONSTRAINT FK_RAMs_Products FOREIGN KEY (RAMId) REFERENCES Products(ProductId);

ALTER TABLE RAMs
ADD CONSTRAINT CHK_RAMs_RAMId
CHECK(RAMId BETWEEN 4001 AND 5000);

CREATE TABLE SSDs(
SSDId INT,
Manufacturer VARCHAR(50) NOT NULL,
Model VARCHAR(50) NOT NULL UNIQUE,
FormFactor VARCHAR(20) NOT NULL,
Capacity INT NOT NULL CHECK(Capacity > 0),
ReadSpeed INT NOT NULL CHECK(ReadSpeed > 0),
WriteSpeed INT NOT NULL CHECK(WriteSpeed > 0),
CONSTRAINT PK_SSDs PRIMARY KEY (SSDId)
);
ALTER TABLE SSDs ADD CONSTRAINT FK_SSDs_Products FOREIGN KEY (SSDId) REFERENCES Products(ProductId);

ALTER TABLE SSDs
ADD CONSTRAINT CHK_SSDs_SSDId
CHECK(SSDId BETWEEN 6001 AND 7000);

CREATE TABLE HDDs(
HDDId INT,
Manufacturer VARCHAR(50) NOT NULL,
Model VARCHAR(50) NOT NULL UNIQUE,
FormFactor VARCHAR(20) NOT NULL,
Capacity INT NOT NULL CHECK(Capacity > 0),
RPM INT NOT NULL CHECK (RPM > 0),
CONSTRAINT PK_HDDs PRIMARY KEY (HDDId)
);

ALTER TABLE HDDs ADD CONSTRAINT FK_HDDs_Products FOREIGN KEY (HDDId) REFERENCES Products(ProductId);

ALTER TABLE HDDs
ADD CONSTRAINT CHK_HDDs_HDDId
CHECK(HDDId BETWEEN 5001 AND 6000);

CREATE TABLE GraphicsCards(
GraphicsCardId INT,
Manufacturer VARCHAR(50) NOT NULL,
Model VARCHAR(100) NOT NULL UNIQUE,
Capacity INT NOT NULL CHECK(Capacity > 0),
Type VARCHAR(20) NOT NULL,
MemorySpeed INT NOT NULL CHECK(MemorySpeed>0),
DirectX DECIMAL(8,1),
Slot VARCHAR(30) NOT NULL,
MaximumTemperature INT NOT NULL CHECK(MaximumTemperature > 0),
CoreSpeed INT NOT NULL CHECK(CoreSpeed > 0),
CONSTRAINT PK_GraphicsCards PRIMARY KEY (GraphicsCardId)
);

ALTER TABLE GraphicsCards ADD CONSTRAINT FK_GraphicsCards_Products FOREIGN KEY (GraphicsCardId) REFERENCES Products(ProductId);

ALTER TABLE GraphicsCards
ADD CONSTRAINT CHK_GraphicsCards_GraphicsCardId
CHECK(GraphicsCardId BETWEEN 2001 AND 3000);

CREATE TABLE Laptops(
LaptopId INT,
Manufacturer VARCHAR(50) NOT NULL,
Model VARCHAR(100) NOT NULL UNIQUE,
Inches DECIMAL(6,1) NOT NULL CHECK(Inches > 0),
Resolution VARCHAR(20) NOT NULL,
ProcessorId INT NOT NULL,
HDDId INT,
SSDId INT,
BatteryType VARCHAR(20) NOT NULL,
BatteryCapacity DECIMAL(4,1) NOT NULL,
CameraMegapixels DECIMAL(6,2) NOT NULL CHECK(CameraMegapixels > 0),
Weight DECIMAL(4,2) NOT NULL CHECK(Weight > 0),
Color VARCHAR(20) NOT NULL,
OperationSystem VARCHAR(50),
CONSTRAINT PK_Laptop PRIMARY KEY (LaptopId)
);

ALTER TABLE Laptops ADD CONSTRAINT FK_Laptops_Products FOREIGN KEY (LaptopId) REFERENCES Products(ProductId);
ALTER TABLE Laptops ADD CONSTRAINT FK_Laptops_Processors FOREIGN KEY (ProcessorId) REFERENCES Processors(ProcessorId);
ALTER TABLE Laptops ADD CONSTRAINT FK_Laptops_HDDs FOREIGN KEY (HDDId) REFERENCES HDDs(HDDId);
ALTER TABLE Laptops ADD CONSTRAINT FK_Laptops_SSDs FOREIGN KEY (SSDId) REFERENCES SSDs(SSDId);
ALTER TABLE Laptops
ADD CONSTRAINT CHK_Laptops_LaptopId
CHECK(LaptopId BETWEEN 1 AND 1000);



CREATE TABLE PCs(
PCId INT,
Manufacturer VARCHAR(50) NOT NULL,
Model VARCHAR(50) NOT NULL UNIQUE,
Box VARCHAR(100) NOT NULL,
Motherboard VARCHAR(100) NOT NULL,
ProcessorId INT NOT NULL,
Chipset VARCHAR(50) NOT NULL,
HDDId INT,
SSDId INT,
PowerSupply INT NOT NULL CHECK (PowerSupply > 0),
OperationSystem VARCHAR(100),
CONSTRAINT PK_PCs PRIMARY KEY (PCId)
);

ALTER TABLE PCs ADD CONSTRAINT FK_PCs_Products FOREIGN KEY (PCId) REFERENCES Products(ProductId);
ALTER TABLE PCs ADD CONSTRAINT FK_PCs_Processors FOREIGN KEY (ProcessorId) REFERENCES Processors(ProcessorId);
ALTER TABLE PCs ADD CONSTRAINT FK_PCs_HDDs FOREIGN KEY (HDDId) REFERENCES HDDs(HDDId);
ALTER TABLE PCs ADD CONSTRAINT FK_PCs_SSDs FOREIGN KEY (SSDId) REFERENCES SSDs(SSDId);
ALTER TABLE PCs
ADD CONSTRAINT CHK_PCs_PCId
CHECK(PCId BETWEEN 1001 AND 2000);

CREATE TABLE MonitorsPorts(
PortId INT,
MonitorId INT,
PortQuantity INT NOT NULL CHECK(PortQuantity >= 0),
CONSTRAINT PK_Monitors_Ports PRIMARY KEY (PortId,MonitorId) 
);

ALTER TABLE MonitorsPorts ADD CONSTRAINT FK_MonitorsPorts_Monitors FOREIGN KEY (MonitorId) REFERENCES Monitors (MonitorId);
ALTER TABLE MonitorsPorts ADD CONSTRAINT FK_MonitorsPorts_Ports FOREIGN KEY (PortId) REFERENCES Ports (PortId);


CREATE TABLE LaptopsPorts(
PortId INT,
LaptopId INT,
PortQuantity INT NOT NULL CHECK(PortQuantity >= 0),
CONSTRAINT PK_LaptopsPorts PRIMARY KEY (PortId,LaptopId) 
);

ALTER TABLE LaptopsPorts ADD CONSTRAINT FK_LaptopsPorts_Laptops FOREIGN KEY (LaptopId) REFERENCES Laptops (LaptopId);
ALTER TABLE LaptopsPorts ADD CONSTRAINT FK_LaptopsPorts_Ports FOREIGN KEY (PortId) REFERENCES Ports (PortId);


CREATE TABLE PCsPorts(
PortId INT,
PCId INT,
PortQuantity INT NOT NULL CHECK(PortQuantity >= 0),
CONSTRAINT PK_PCsPorts PRIMARY KEY (PortId,PCId) 
);

ALTER TABLE PCsPorts ADD CONSTRAINT FK_PCsPorts_PCs FOREIGN KEY (PCId) REFERENCES PCs (PCId);
ALTER TABLE PCsPorts ADD CONSTRAINT FK_PCsPorts_Ports FOREIGN KEY (PortId) REFERENCES Ports (PortId);

CREATE TABLE LaptopsGraphicsCards(
GraphicsCardId INT,
LaptopId INT,
CardQuantity INT NOT NULL CHECK(CardQuantity >= 0),
CONSTRAINT PK_LaptopsGraphics PRIMARY KEY (GraphicsCardId,LaptopId) 
);

ALTER TABLE LaptopsGraphicsCards ADD CONSTRAINT FK_LaptopsGraphicsCards_Laptops FOREIGN KEY (LaptopId) REFERENCES Laptops (LaptopId);
ALTER TABLE LaptopsGraphicsCards ADD CONSTRAINT FK_LaptopsGraphicsCards_Graphics FOREIGN KEY (GraphicsCardId) REFERENCES GraphicsCards (GraphicsCardId);

CREATE TABLE PCsGraphicsCards(
GraphicsCardId INT,
PCId INT,
CardQuantity INT NOT NULL CHECK(CardQuantity >= 0),
CONSTRAINT PK_PCsGraphicsCards PRIMARY KEY (GraphicsCardId,PCId) 
);

ALTER TABLE PCsGraphicsCards ADD CONSTRAINT FK_PCsGraphicsCards_PCs FOREIGN KEY (PCId) REFERENCES PCs (PCId);
ALTER TABLE PCsGraphicsCards ADD CONSTRAINT FK_PCsGraphicsCards_Graphics FOREIGN KEY (GraphicsCardId) REFERENCES GraphicsCards (GraphicsCardId);

CREATE TABLE PCsRAMs(
RAMId INT,
PCId INT,
RAMQuantity INT NOT NULL CHECK(RAMQuantity >= 0),
CONSTRAINT PK_PCsRAMs PRIMARY KEY (RAMId,PCId) 
);

ALTER TABLE PCsRAMs ADD CONSTRAINT FK_PCsRAMs_PCs FOREIGN KEY (PCId) REFERENCES PCs (PCId);
ALTER TABLE PCsRAMs ADD CONSTRAINT FK_PCsRAMs_RAMs FOREIGN KEY (RAMId) REFERENCES RAMs (RAMId);

CREATE TABLE LaptopsRAMs(
RAMId INT,
LaptopId INT,
RAMQuantity INT NOT NULL CHECK(RAMQuantity >= 0),
CONSTRAINT PK_LaptopsRAMs PRIMARY KEY (RAMId,LaptopId) 
);

ALTER TABLE LaptopsRAMs ADD CONSTRAINT FK_LaptopsRAMs_Laptops FOREIGN KEY (LaptopId) REFERENCES Laptops (LaptopId);
ALTER TABLE LaptopsRAMs ADD CONSTRAINT FK_LaptopsRAMs_RAMs FOREIGN KEY (RAMId) REFERENCES RAMs (RAMId);

DELIMITER $$

CREATE TRIGGER TR_Customers_Prevent_Delete
BEFORE DELETE
ON Customers
FOR EACH ROW
BEGIN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Table Customers does not support deletion';
END$$

CREATE TRIGGER TR_Orders_Prevent_Delete_When_Order_Is_Finished
BEFORE DELETE
ON Orders
FOR EACH ROW
BEGIN
IF OLD.Finished = 1 THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Cannot delete an order that has already finished';
END IF;
END$$

CREATE TRIGGER TR_Orders_Prevent_Update_When_Order_Is_Finished
BEFORE UPDATE
ON Orders
FOR EACH ROW
BEGIN
IF OLD.Finished = 1 THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Cannot update an order that has already finished';
END IF;
END$$

CREATE TRIGGER TR_OrdersProducts_Prevent_Delete
BEFORE DELETE
ON OrdersProducts
FOR EACH ROW
BEGIN
SET @orderStatus = (SELECT Finished FROM Orders WHERE OrderId = OLD.OrderId);
IF @orderStatus = 1 THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Cannot delete from finished orders';
END IF;
END$$


CREATE TRIGGER TR_LaptopsGraphicsCards_Prevent_Delete
BEFORE DELETE
ON LaptopsGraphicsCards
FOR EACH ROW
BEGIN
IF OLD.CardQuantity != 0 THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Cannot perform deletion when CardQuantity is not equal to 0';
END IF;
END$$


CREATE TRIGGER TR_PCsGraphicsCards_Prevent_Delete
BEFORE DELETE
ON PCsGraphicsCards
FOR EACH ROW
BEGIN
IF OLD.CardQuantity != 0 THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Cannot perform deletion when CardQuantity is not equal to 0';
END IF;
END$$


CREATE TRIGGER TR_LaptopsRAMs_Prevent_Delete
BEFORE DELETE
ON LaptopsRAMs
FOR EACH ROW
BEGIN
IF OLD.RAMQuantity != 0 THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Cannot perform deletion when RAMQuantity is not equal to 0';
END IF;
END$$


CREATE TRIGGER TR_PCsRAMs_Prevent_Delete
BEFORE DELETE
ON PCsRAMs
FOR EACH ROW
BEGIN
IF OLD.RAMQuantity != 0 THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Cannot perform deletion when RAMQuantity is not equal to 0';
END IF;
END$$


CREATE TRIGGER TR_MonitorsPorts_Prevent_Delete
BEFORE DELETE
ON MonitorsPorts
FOR EACH ROW
BEGIN
IF OLD.PortQuantity != 0 THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Cannot perform deletion when PortQuantity is not equal to 0';
END IF;
END$$


CREATE TRIGGER TR_PCsPorts_Prevent_Delete
BEFORE DELETE
ON PCsPorts
FOR EACH ROW
BEGIN
IF OLD.PortQuantity != 0 THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Cannot perform deletion when PortQuantity is not equal to 0';
END IF;
END$$


CREATE TRIGGER TR_LaptopsPorts_Prevent_Delete
BEFORE DELETE
ON LaptopsPorts
FOR EACH ROW
BEGIN
IF OLD.PortQuantity != 0 THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Cannot perform deletion when PortQuantity is not equal to 0';
END IF;
END$$


CREATE TRIGGER TR_GraphicsCards_Prevent_Delete
BEFORE DELETE
ON GraphicsCards
FOR EACH ROW
BEGIN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Table GraphicsCards does not support deletion';
END$$

CREATE TRIGGER TR_HDDs_Prevent_Delete
BEFORE DELETE
ON HDDs
FOR EACH ROW
BEGIN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Table HDDs does not support deletion';
END$$

CREATE TRIGGER TR_Keyboards_Prevent_Delete
BEFORE DELETE
ON Keyboards
FOR EACH ROW
BEGIN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Table Keyboards does not support deletion';
END$$

CREATE TRIGGER TR_Monitors_Prevent_Delete
BEFORE DELETE
ON Monitors
FOR EACH ROW
BEGIN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Table Monitors does not support deletion';
END$$

CREATE TRIGGER TR_Mouses_Prevent_Delete
BEFORE DELETE
ON Mouses
FOR EACH ROW
BEGIN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Table Mouses does not support deletion';
END$$


CREATE TRIGGER TR_Processors_Prevent_Delete
BEFORE DELETE
ON Processors
FOR EACH ROW
BEGIN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Table Processors does not support deletion';
END$$

CREATE TRIGGER TR_RAMs_Prevent_Delete
BEFORE DELETE
ON RAMs
FOR EACH ROW
BEGIN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Table RAMs does not support deletion';
END$$

CREATE TRIGGER TR_SSDs_Prevent_Delete
BEFORE DELETE
ON SSDs
FOR EACH ROW
BEGIN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Table SSDs does not support deletion';
END$$


CREATE TRIGGER TR_OrdersProducts_BeforeInsert 
BEFORE INSERT
ON OrdersProducts
FOR EACH ROW
BEGIN
SET @productQuantity = (SELECT Quantity FROM Products WHERE ProductId=NEW.ProductId);
IF (@productQuantity < NEW.Quantity) THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Not enough Quantity available';
ELSE
SET NEW.ProductPrice = (SELECT Price FROM Products WHERE NEW.ProductId = ProductId);
END IF;
END$$

CREATE TRIGGER TR_OrdersProducts_AfterInsert 
AFTER INSERT
ON OrdersProducts
FOR EACH ROW
BEGIN
UPDATE Products SET Quantity = Quantity - NEW.Quantity WHERE ProductId = NEW.ProductId;
UPDATE Orders SET TotalPrice = (SELECT SUM(Quantity*ProductPrice) as OrderPrice FROM OrdersProducts WHERE OrderId=NEW.OrderId) WHERE OrderId=NEW.OrderId;
END$$


CREATE TRIGGER TR_OrdersProducts_BeforeUpdate
BEFORE UPDATE
ON OrdersProducts
FOR EACH ROW
BEGIN
SET @productQuantity = (SELECT Quantity FROM Products WHERE ProductId=NEW.ProductId);
SET @addedQuantity = NEW.Quantity - OLD.Quantity;
SET @isOrderFinished = (SELECT Finished FROM Orders WHERE OrderId = NEW.OrderId) = 1;

IF (@productQuantity < @addedQuantity) THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Not enough Quantity available';
ELSEIF @isOrderFinished THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'The order had already finished';
END IF;
END$$

CREATE TRIGGER TR_OrdersProducts_AfterUpdate 
AFTER UPDATE
ON OrdersProducts
FOR EACH ROW
BEGIN

SET @addedQuantity = NEW.Quantity - OLD.Quantity;
UPDATE Products SET Quantity = Quantity - @addedQuantity WHERE ProductId = NEW.ProductId;
UPDATE Orders SET TotalPrice = (SELECT SUM(Quantity*ProductPrice) as OrderPrice FROM OrdersProducts WHERE OrderId=NEW.OrderId) WHERE OrderId=NEW.OrderId;
END$$

CREATE PROCEDURE `GetProductInfo2`(
IN ProductId INT
)
BEGIN
IF ProductId BETWEEN 1 AND 1000 THEN
SELECT * FROM Laptops WHERE LaptopId = ProductId;
ELSEIF ProductId BETWEEN 1001 AND 2000 THEN
SELECT * FROM PCs WHERE PCId = ProductId;
ELSEIF ProductId BETWEEN 2001 AND 3000 THEN
SELECT * FROM GraphicsCards WHERE GraphicsCardId = ProductId;
ELSEIF ProductId BETWEEN 3001 AND 4000 THEN
SELECT * FROM Processors WHERE ProcessorId = ProductId;
ELSEIF ProductId BETWEEN 4001 AND 5000 THEN
SELECT * FROM RAMs WHERE RAMId = ProductId;
ELSEIF ProductId BETWEEN 5001 AND 6000 THEN
SELECT * FROM HDDs WHERE HDDId = ProductId;
ELSEIF ProductId BETWEEN 6001 AND 7000 THEN
SELECT * FROM SSDs WHERE SSDId = ProductId;
ELSEIF ProductId BETWEEN 7001 AND 8000 THEN
SELECT * FROM Monitors WHERE MonitorId = ProductId;
ELSEIF ProductId BETWEEN 8001 AND 9000 THEN
SELECT * FROM Mouses WHERE MouseId = ProductId;
ELSEIF ProductId BETWEEN 9001 AND 10000 THEN
SELECT * FROM Keyboards WHERE KeyboardId = ProductId;
END IF;
END$$

DELIMITER ;

CREATE VIEW VW_Laptops_Processor_HDD_SSD_Info
AS
SELECT l_p_h.Manufacturer, l_p_h.Model,l_p_h.Inches,l_p_h.Resolution,l_p_h.BatteryType,l_p_h.BatteryCapacity,l_p_h.CameraMegapixels,l_p_h.Weight,l_p_h.Color,l_p_h.OperationSystem,
l_p_h.ProcessorManufacturer,l_p_h.ProcessorModel,l_p_h.ProcessorCores
,l_p_h.ProcessorThreads,l_p_h.ProcessorBaseFrequency,l_p_h.ProcessorTurboFrequency
,l_p_h.ProcessorSocket,l_p_h.ProcessorMaximumTemperature,l_p_h.HDDManufacturer,l_p_h.HDDModel,
l_p_h.HDDFormFactor,l_p_h.HDDCapacity,l_p_h.HDDRMP,s.Manufacturer AS SSDManufacturer,s.Model AS SSDModel,
s.FormFactor AS SSDFormFactor , s.Capacity AS SSDCapacity ,s.ReadSpeed AS SSDReadSpeed , s.WriteSpeed AS SSDWriteSpeed,l_p_h.LaptopId
FROM
(SELECT l_p.Manufacturer, l_p.Model,l_p.Inches,l_p.Resolution,l_p.BatteryType,l_p.BatteryCapacity,l_p.CameraMegapixels,l_p.Weight,l_p.Color,l_p.OperationSystem,
l_p.ProcessorManufacturer,l_p.ProcessorModel,l_p.ProcessorCores
,l_p.ProcessorThreads,l_p.ProcessorBaseFrequency,l_p.ProcessorTurboFrequency
,l_p.ProcessorSocket,l_p.ProcessorMaximumTemperature,h.Manufacturer AS HDDManufacturer,h.Model AS HDDModel,
h.FormFactor AS HDDFormFactor,h.Capacity AS HDDCapacity,h.RPM AS HDDRMP,l_p.SSDId ,l_p.LaptopId
FROM
(SELECT l.Manufacturer, l.Model,l.Inches,l.Resolution,l.BatteryType,l.BatteryCapacity,l.CameraMegapixels,l.Weight,l.Color,l.OperationSystem,
p.Manufacturer AS ProcessorManufacturer,p.Model AS ProcessorModel,p.Cores AS ProcessorCores
,p.Threads AS ProcessorThreads,p.BaseFrequency AS ProcessorBaseFrequency,p.TurboFrequency AS ProcessorTurboFrequency
,p.Socket AS ProcessorSocket,p.MaximumTemperature AS ProcessorMaximumTemperature,l.HDDId,l.SSDId,l.LaptopId
FROM Laptops AS l LEFT JOIN Processors AS p
ON l.ProcessorId=p.ProcessorId) AS l_p LEFT JOIN HDDs AS h
ON l_p.HDDId=h.HDDId) AS l_p_h LEFT JOIN SSDs AS s
ON l_p_h.SSDId=s.SSDId;

CREATE VIEW VW_Laptops_Processor_HDD_SSD_Warranty_Price_Info
AS
SELECT l_p_h.Manufacturer, l_p_h.Model,l_p_h.Inches,l_p_h.Resolution,l_p_h.BatteryType,l_p_h.BatteryCapacity,l_p_h.CameraMegapixels,l_p_h.Weight,l_p_h.Color,l_p_h.OperationSystem,
l_p_h.ProcessorManufacturer,l_p_h.ProcessorModel,l_p_h.ProcessorCores
,l_p_h.ProcessorThreads,l_p_h.ProcessorBaseFrequency,l_p_h.ProcessorTurboFrequency
,l_p_h.ProcessorSocket,l_p_h.ProcessorMaximumTemperature,l_p_h.HDDManufacturer,l_p_h.HDDModel,
l_p_h.HDDFormFactor,l_p_h.HDDCapacity,l_p_h.HDDRMP,l_p_h.SSDManufacturer,l_p_h.SSDModel,
l_p_h.SSDFormFactor , l_p_h.SSDCapacity ,l_p_h.SSDReadSpeed , l_p_h.SSDWriteSpeed,p.Warranty,p.Price,l_p_h.LaptopId
FROM VW_Laptops_Processor_HDD_SSD_Info AS l_p_h LEFT JOIN Products AS p
ON l_p_h.LaptopId=p.ProductId;

CREATE VIEW VW_Laptops_Compact_Info
AS
SELECT
CONCAT(Manufacturer,' ',Model)AS Laptops,CONCAT(ProcessorManufacturer,' ',ProcessorModel)AS Processor
,CONCAT(HDDCapacity,' GB ',HDDRMP,'rpm') AS HDD
,CONCAT(SSDCapacity,' GB ',SSDFormFactor)	AS SSD,Warranty,Price
FROM VW_Laptops_Processor_HDD_SSD_Warranty_Price_Info;

CREATE VIEW VW_PCs_Processor_HDD_SSD_Info
AS
SELECT pc_p_h.Manufacturer, pc_p_h.Model,pc_p_h.Box,pc_p_h.Motherboard,pc_p_h.Chipset,pc_p_h.PowerSupply,pc_p_h.OperationSystem,
pc_p_h.ProcessorManufacturer,pc_p_h.ProcessorModel,pc_p_h.ProcessorCores
,pc_p_h.ProcessorThreads,pc_p_h.ProcessorBaseFrequency,pc_p_h.ProcessorTurboFrequency
,pc_p_h.ProcessorSocket,pc_p_h.ProcessorMaximumTemperature,pc_p_h.HDDManufacturer,pc_p_h.HDDModel,
pc_p_h.HDDFormFactor,pc_p_h.HDDCapacity,pc_p_h.HDDRMP,s.Manufacturer AS SSDManufacturer,s.Model AS SSDModel,
s.FormFactor AS SSDFormFactor , s.Capacity AS SSDCapacity ,s.ReadSpeed AS SSDReadSpeed , s.WriteSpeed AS SSDWriteSpeed,pc_p_h.PCid
FROM
(SELECT pc_p.Manufacturer, pc_p.Model,pc_p.Box,pc_p.Motherboard,pc_p.Chipset,pc_p.PowerSupply,pc_p.OperationSystem,
pc_p.ProcessorManufacturer,pc_p.ProcessorModel,pc_p.ProcessorCores
,pc_p.ProcessorThreads,pc_p.ProcessorBaseFrequency,pc_p.ProcessorTurboFrequency
,pc_p.ProcessorSocket,pc_p.ProcessorMaximumTemperature,h.Manufacturer AS HDDManufacturer,h.Model AS HDDModel,
h.FormFactor AS HDDFormFactor,h.Capacity AS HDDCapacity,h.RPM AS HDDRMP,pc_p.SSDId,pc_p.PCId
FROM
(SELECT pc.Manufacturer, pc.Model,pc.Box,pc.Motherboard,pc.Chipset,pc.PowerSupply,pc.OperationSystem,
p.Manufacturer AS ProcessorManufacturer,p.Model AS ProcessorModel,p.Cores AS ProcessorCores
,p.Threads AS ProcessorThreads,p.BaseFrequency AS ProcessorBaseFrequency,p.TurboFrequency AS ProcessorTurboFrequency
,p.Socket AS ProcessorSocket,p.MaximumTemperature AS ProcessorMaximumTemperature,pc.HDDId,pc.SSDId,pc.PCId
FROM PCs AS pc LEFT JOIN Processors AS p
ON pc.ProcessorId=p.ProcessorId) AS pc_p LEFT JOIN HDDs AS h
ON pc_p.HDDId=h.HDDId) AS pc_p_h LEFT JOIN SSDs AS s
ON pc_p_h.SSDId=s.SSDId;

CREATE VIEW VW_PCs_Processor_HDD_SSD_Warranty_Price_Info
AS
SELECT pc_p_h.Manufacturer, pc_p_h.Model,pc_p_h.Box,pc_p_h.Motherboard,pc_p_h.Chipset,pc_p_h.PowerSupply,pc_p_h.OperationSystem,
pc_p_h.ProcessorManufacturer,pc_p_h.ProcessorModel,pc_p_h.ProcessorCores
,pc_p_h.ProcessorThreads,pc_p_h.ProcessorBaseFrequency,pc_p_h.ProcessorTurboFrequency
,pc_p_h.ProcessorSocket,pc_p_h.ProcessorMaximumTemperature,pc_p_h.HDDManufacturer,pc_p_h.HDDModel,
pc_p_h.HDDFormFactor,pc_p_h.HDDCapacity,pc_p_h.HDDRMP,pc_p_h.SSDManufacturer,pc_p_h.SSDModel,
pc_p_h.SSDFormFactor , pc_p_h.SSDCapacity ,pc_p_h.SSDReadSpeed , pc_p_h.SSDWriteSpeed,p.Warranty,p.Price,pc_p_h.PCId
FROM VW_PCs_Processor_HDD_SSD_Info AS pc_p_h LEFT JOIN Products AS p
ON pc_p_h.PCId=p.ProductId;

CREATE VIEW VW_PCs_Compact_Info
AS
SELECT CONCAT(Manufacturer,' ',Model)AS Laptops,CONCAT(ProcessorManufacturer,' ',ProcessorModel)AS Processor
,CONCAT(HDDCapacity,' GB ',HDDRMP,'rpm') AS HDD
,CONCAT(SSDCapacity,' GB ',SSDFormFactor)	AS SSD,Warranty,Price
FROM VW_PCs_Processor_HDD_SSD_Warranty_Price_Info;

CREATE VIEW VW_Processor
AS
SELECT p.Manufacturer,p.Model,p.BaseFrequency,p.TurboFrequency,p.Socket,p.Threads,pr.Warranty,pr.Price
FROM Processors p JOIN Products pr
ON p.ProcessorId=pr.ProductId;

CREATE VIEW VW_GraphicsCard
AS
SELECT gc.Manufacturer,gc.Model,gc.Capacity,gc.Type,gc.MemorySpeed,gc.DirectX,p.Warranty,p.Price
FROM GraphicsCards gc JOIN Products p
ON gc.GraphicsCardId=p.ProductId;

CREATE VIEW VW_SSDs
AS
SELECT s.Manufacturer,s.Model,s.FormFactor,s.Capacity,s.ReadSpeed,s.WriteSpeed,p.Warranty,p.Price
FROM SSDs s JOIN Products p
ON s.SSDId=p.ProductId;

CREATE VIEW VW_HDDs
AS
SELECT h.Manufacturer,h.Model,h.FormFactor,h.Capacity,h.RPM,p.Warranty,p.Price
FROM HDDs h JOIN Products p
ON h.HDDId=p.ProductId;

CREATE VIEW VW_Monitors
AS
SELECT m.Manufacturer,m.Model,m.Size,m.Resolution,m.AspectRatio,m.RefreshRate,m.Type,m.Contrast,m.Colors,p.Warranty,p.Price
FROM Monitors m JOIN Products p
ON m.MonitorId=p.ProductId;

CREATE VIEW VW_Mouse
AS
SELECT m.Manufacturer,m.Model,m.DPI,m.Wireless,m.Color,p.Warranty,p.Price
FROM Mouses m JOIN Products p
ON m.MouseId = p.ProductId;

CREATE VIEW VW_Keyboard
AS
SELECT k.Manufacturer,k.Model,k.Backlight,k.Wireless,k.Color,p.Warranty,p.Price
FROM Keyboards k JOIN Products p
ON k.KeyboardId=p.ProductId;

CREATE VIEW VW_RAM
AS
SELECT r.Manufacturer,r.Model,r.Capacity,r.Type,r.Frequency,p.Warranty,p.Price
FROM RAMs r JOIN Products p
ON r.RAMId=p.ProductId;

CREATE INDEX IDX_Product
ON Products (Price);

CREATE INDEX IDX_PC
ON PCs (Manufacturer);

CREATE INDEX IDX_Laptop
ON Laptops (Manufacturer);

CREATE INDEX IDX_HDD
ON HDDs (Capacity);

CREATE INDEX IDX_SSD
ON SSDs (Capacity);

CREATE INDEX IDX_Monitor
ON Monitors (Size);





INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(1, 'laptop', 24, 1599, 5);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(2, 'laptop', 36, 3149, 4);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(3, 'laptop', 36, 2249, 6);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(4, 'laptop', 24, 2199, 2);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(5, 'laptop', 24, 2269, 3);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(6, 'laptop', 36, 1549, 1);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(7, 'laptop', 36, 4049, 0);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(8, 'laptop', 24, 1338, 0);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(9, 'laptop', 24, 999, 2);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(10, 'laptop', 24, 799, 1);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(1001, 'pc', 36, 3319, 0);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(1002, 'pc', 36, 983, 1);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(1003, 'pc', 36, 703, 5);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(1004, 'pc', 36, 2999, 4);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(1005, 'pc', 24, 4199, 3);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(1006, 'pc', 36, 1399, 2);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(1007, 'pc', 36, 999, 5);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(1008, 'pc', 36, 1629, 0);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(1009, 'pc', 36, 5819, 1);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(1010, 'pc', 24, 2659, 4);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(2001, 'gc', 36, 352, 2);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(2002, 'gc', 36, 308, 1);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(2003, 'gc', 36, 135, 5);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(2004, 'gc', 36, 719, 5);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(2005, 'gc', 12, 939, 2);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(2006, 'gc', 36, 1239, 3);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(2007, 'gc', 24, 280, 2);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(2008, 'gc', 36, 1136, 4);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(2009, 'gc', 36, 349, 1);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(2010, 'gc', 36, 1685, 5);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(3001, 'processor', 24, 541, 1);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(3002, 'processor', 36, 818, 1);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(3003, 'processor', 36, 740, 1);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(3004, 'processor', 24, 450, 5);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(3005, 'processor', 24, 713, 4);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(3006, 'processor', 36, 713, 2);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(3007, 'processor', 24, 507, 3);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(3008, 'processor', 24, 596, 5);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(3009, 'processor', 24, 328, 1);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(3010, 'processor', 12, 260, 2);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(3011, 'processor', 12, 115, 6);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(3012, 'processor', 60, 700, 3);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(3013, 'processor', 24, 361, 4);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(3014, 'processor', 24, 326, 0);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(3015, 'processor', 12, 179, 1);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(3016, 'processor', 36, 376, 4);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(3017, 'processor', 12, 197, 3);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(4001, 'ram', 60, 50, 5);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(4002, 'ram', 36, 65, 2);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(4003, 'ram', 60, 82, 2);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(4004, 'ram', 36, 79, 5);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(4005, 'ram', 60, 199, 5);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(4006, 'ram', 36, 149, 4);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(4007, 'ram', 60, 165, 3);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(4008, 'ram', 60, 175, 4);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(4009, 'ram', 36, 184, 2);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(4010, 'ram', 60, 326, 4);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(4011, 'ram', 36, 90, 1);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(4012, 'ram', 60, 48, 4);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(5001, 'hdd', 24, 254.44, 1);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(5002, 'hdd', 24, 89, 3);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(5003, 'hdd', 12, 205, 3);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(5004, 'hdd', 24, 211, 3);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(5005, 'hdd', 60, 270, 4);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(5006, 'hdd', 24, 162, 2);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(5007, 'hdd', 36, 570, 5);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(5008, 'hdd', 36, 452, 4);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(5009, 'hdd', 24, 325, 5);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(5010, 'hdd', 60, 325, 2);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(6001, 'ssd', 36, 80, 1);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(6002, 'ssd', 36, 152, 3);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(6003, 'ssd', 36, 125, 2);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(6004, 'ssd', 60, 145, 3);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(6005, 'ssd', 60, 250, 3);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(6006, 'ssd', 60, 230, 1);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(6007, 'ssd', 60, 300, 4);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(6008, 'ssd', 36, 325, 5);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(6009, 'ssd', 60, 719, 1);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(6010, 'ssd', 60, 619, 3);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(7001, 'monitor', 24, 219, 5);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(7002, 'monitor', 36, 549, 5);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(7003, 'monitor', 36, 1557.00, 4);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(7004, 'monitor', 12, 245, 3);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(7005, 'monitor', 24, 545.00, 1);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(7006, 'monitor', 36, 813, 3);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(7007, 'monitor', 36, 137, 2);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(7008, 'monitor', 24, 249, 5);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(7009, 'monitor', 36, 2715, 4);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(7010, 'monitor', 60, 723, 1);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(8001, 'mouse', 24, 123, 3);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(8002, 'mouse', 12, 139, 4);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(8003, 'mouse', 24, 13, 5);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(8004, 'mouse', 24, 49, 3);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(8005, 'mouse', 24, 31, 1);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(8006, 'mouse', 12, 39, 5);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(8007, 'mouse', 12, 72, 4);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(8008, 'mouse', 24, 169, 1);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(8009, 'mouse', 24, 59, 4);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(8010, 'mouse', 24, 12, 2);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(8011, 'mouse', 12, 65, 3);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(8012, 'mouse', 12, 47, 4);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(8013, 'mouse', 24, 11, 1);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(8014, 'mouse', 24, 79, 5);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(9001, 'keyboard', 24, 419, 2);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(9002, 'keyboard', 24, 149, 3);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(9003, 'keyboard', 24, 98, 1);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(9004, 'keyboard', 24, 45, 5);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(9005, 'keyboard', 24, 29, 4);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(9006, 'keyboard', 12, 139, 5);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(9007, 'keyboard', 24, 69, 4);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(9008, 'keyboard', 24, 459, 3);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(9009, 'keyboard', 24, 127, 1);
INSERT INTO Products(ProductId, Type, Warranty, Price, Quantity) VALUES(9010, 'keyboard', 36, 319, 4);

INSERT INTO Keyboards(KeyboardId, Manufacturer, Model, Port, Backlight, Wireless, Color, CableLength)
VALUES(9001, 'Corsair', 'RGB K70 RAPIDFIRЕ', 'USB', 1, 0, 'black', 1.6);
INSERT INTO Keyboards VALUES(9002, 'Razer', 'Ornata', 'USB', 1, 0, 'red', 1.8);
INSERT INTO Keyboards VALUES(9003, 'Logitech', 'K400 Plus', 'USB', 0, 1, 'white', null);
INSERT INTO Keyboards VALUES(9004, 'Rapoo', '8000M', 'Bluetooth', 0, 1, 'white', null);
INSERT INTO Keyboards VALUES(9005, 'Canyon', 'CNS-HKBW2-US', 'USB', 0, 1, 'black', null);
INSERT INTO Keyboards VALUES(9006, 'A4TECH', 'Bloody B820R', 'USB', 1, 0, 'carbon', 1.8);
INSERT INTO Keyboards VALUES(9007, 'Canyon', 'Leonof - CND-SGS01-US', 'USB', 1, 0, 'black', 1.6);
INSERT INTO Keyboards VALUES(9008, 'ASUS', 'ROG Claymore RGB', 'USB', 1, 0, 'black', 1.8);
INSERT INTO Keyboards VALUES(9009, 'Redragon', 'Mahoraga K590', 'USB', 1, 1, 'black', null);
INSERT INTO Keyboards VALUES(9010, 'Dell', 'Alienware 510K RGB', 'USB', 1, 0, 'white', 1.6);

INSERT INTO Mouses(MouseId, Manufacturer, Model, DPI, Buttons, Port, Battery, Wireless, Weight, Color, CableLength)
VALUES(8001,'Kingston', 'HyperX Pulsefire Surge', 16000, 6, 'USB', null, 0, 130, 'black',1.8);
INSERT INTO Mouses VALUES(8002, 'Alienware', '510M', 16000, 10, 'USB', null,	0, 160, 'black', 2);
INSERT INTO Mouses VALUES(8003, 'Fury', 'Warrior', 3200, 3, 'USB', null, 0, 95, 'gray', 1.5);
INSERT INTO Mouses VALUES(8004, 'Logitech', 'M220 Silent', 1000, 3, 'USB', null, 1, 75, 'black/gray', null);
INSERT INTO Mouses VALUES(8005, 'Redragon', 'Pegasus M705', 7200, 6, 'USB', null, 0, 240, 'black/red', 1.8);
INSERT INTO Mouses VALUES(8006, 'A4Tech', 'Bloody P85', 5000, 8, 'USB', null, 0, 150, 'black', 1.8);
INSERT INTO Mouses VALUES(8007, 'HP', 'Spectre 500', 1600, 3, 'Bluetooth', null, 1, 100, 'gray', null);
INSERT INTO Mouses VALUES(8008, 'MSI', 'Clutch GM 70', 18000, 10, 'USB', null, 1, 180, 'black', 2);
INSERT INTO Mouses VALUES(8009, 'Cougar', 'MINOS X3', 3200, 6, 'USB', null, 0, 94, 'black', 1.8);
INSERT INTO Mouses VALUES(8010, 'Fury', 'Brawler', 1600, 4, 'USB', null, 0, 82, 'black', 1.8);
INSERT INTO Mouses VALUES(8011, 'HP', 'Omen 600', 12000, 6, 'USB', null, 0, 130, 'black', 1.8);
INSERT INTO Mouses VALUES(8012, 'A4Tech', 'Bloody J95 2-FIRE', 5000, 9, 'USB', null, 0, 160, 'black', 1.8);
INSERT INTO Mouses VALUES(8013, 'Delux', 'M107GX+G07UF', 1000, 3, 'USB', null, 1, 120, 'black', null);
INSERT INTO Mouses VALUES(8014, 'Razer', 'Basilisk Essential', 6400, 7, 'USB', null, 0, 95, 'black', 2);



INSERT INTO Monitors(MonitorId,Manufacturer,Model,Size,Resolution,AspectRatio,RefreshRate,Type,Brightness,Contrast,Colors) VALUES(7001,'Acer','KA242Ybi',23.8,'1920x1080','16:9',75,'LED',250,'100 000 000 : 1',16.7 );
INSERT INTO Monitors(MonitorId,Manufacturer,Model,Size,Resolution,AspectRatio,RefreshRate,Type,Brightness,Contrast,Colors) VALUES(7002,'ASUS','TUF Gaming VG249Q',23.8,'1920x1080','16:9',144,'WLED',250,'1000 : 1',16.7);
INSERT INTO Monitors(MonitorId,Manufacturer,Model,Size,Resolution,AspectRatio,RefreshRate,Type,Brightness,Contrast,Colors) VALUES(7003,'LG','34UC89G-B',34,'2560x1080','21:9',144,'LED',300,'1000 : 1',16.7);
INSERT INTO Monitors(MonitorId,Manufacturer,Model,Size,Resolution,AspectRatio,RefreshRate,Type,Brightness,Contrast,Colors) VALUES(7004,'Dell','SE2416H',23.8,'1920x1080','16:9',76,'LED',250,'8 000 000 : 1',16.7);
INSERT INTO Monitors(MonitorId,Manufacturer,Model,Size,Resolution,AspectRatio,RefreshRate,Type,Brightness,Contrast,Colors) VALUES(7005,'Samsung','LS27R750QEUXEN',27,'2560x1440','16:9',144,'LED',250,'3000 : 1',1070);
INSERT INTO Monitors(MonitorId,Manufacturer,Model,Size,Resolution,AspectRatio,RefreshRate,Type,Brightness,Contrast,Colors) VALUES(7006,'BenQ','EW3270UE',31.5,'3840x2160','16:9',60,'LED',300,'20 000 000 : 1',512);
INSERT INTO Monitors(MonitorId,Manufacturer,Model,Size,Resolution,AspectRatio,RefreshRate,Type,Brightness,Contrast,Colors) VALUES(7007,'AOC','e2270SWN',21.5,'1920x1080','16:9',75,'WLED',200,'20 000 000 : 1',16.8);
INSERT INTO Monitors(MonitorId,Manufacturer,Model,Size,Resolution,AspectRatio,RefreshRate,Type,Brightness,Contrast,Colors) VALUES(7008,'Acer','Nitro QG241Ybii',23.8,'1920x1080','16:9',75,'LED',250,'100 000 000 : 1',16.7);
INSERT INTO Monitors(MonitorId,Manufacturer,Model,Size,Resolution,AspectRatio,RefreshRate,Type,Brightness,Contrast,Colors) VALUES(7009,'ASUS','ROG Swift PG349Q',34,'3440x1440','21:9',120 ,'WLED',300,'1000 : 1',16.7);
INSERT INTO Monitors(MonitorId,Manufacturer,Model,Size,Resolution,AspectRatio,RefreshRate,Type,Brightness,Contrast,Colors) VALUES(7010,'EIZO','FlexScan EV2451',23.8,'1920x1080','16:9',76,'LED',250,'1000 : 1',16.8);

INSERT INTO RAMs(RAMId,Manufacturer,Model,Capacity,Type,Frequency) VALUES(4001,'Kingston','HyperX Fury1',4,'DDR4',2666);
INSERT INTO RAMs(RAMId,Manufacturer,Model,Capacity,Type,Frequency) VALUES(4002,'Corsair','Value',8,'DDR4',2133);
INSERT INTO RAMs(RAMId,Manufacturer,Model,Capacity,Type,Frequency) VALUES(4003,'Kingston','ValueRAM',8,'DDR4',2400);
INSERT INTO RAMs(RAMId,Manufacturer,Model,Capacity,Type,Frequency) VALUES(4004,'Team Group','T1 GAMING',8,'DDR4',2666);
INSERT INTO RAMs(RAMId,Manufacturer,Model,Capacity,Type,Frequency) VALUES(4005,'ADATA','XPG Z1 Bulk',8,'DDR4',3600);
INSERT INTO RAMs(RAMId,Manufacturer,Model,Capacity,Type,Frequency) VALUES(4006,'Trascend','2133',16,'DDR4',2133);
INSERT INTO RAMs(RAMId,Manufacturer,Model,Capacity,Type,Frequency) VALUES(4007,'Kingston','HyperX Fury2',16,'DDR4',2400);
INSERT INTO RAMs(RAMId,Manufacturer,Model,Capacity,Type,Frequency) VALUES(4008,'Team Group','Dark Z',16,'DDR4',2666);
INSERT INTO RAMs(RAMId,Manufacturer,Model,Capacity,Type,Frequency) VALUES(4009,'Kingston','HyperX Predator1',16,'DDR4',3000);
INSERT INTO RAMs(RAMId,Manufacturer,Model,Capacity,Type,Frequency) VALUES(4010,'Kingston','HyperX Predator2',32,'DDR4',2133);
INSERT INTO RAMs(RAMId,Manufacturer,Model,Capacity,Type,Frequency) VALUES(4011,'Apacer','DND',8,'DDR3',1600);
INSERT INTO RAMs(RAMId,Manufacturer,Model,Capacity,Type,Frequency) VALUES(4012,'Corsair','Vengeance',4,'DDR3',1600);

INSERT INTO Processors(ProcessorId,Manufacturer,Model,Cores,Threads,BaseFrequency,TurboFrequency,Socket,MaximumTemperature) VALUES(3001,'Intel','Core i5-1035G1',4,8,1.00,3.60,'FCBGA1526',100);
INSERT INTO Processors(ProcessorId,Manufacturer,Model,Cores,Threads,BaseFrequency,TurboFrequency,Socket,MaximumTemperature) VALUES(3002,'Intel','Core i7-8565U',4,8,1.80,4.60,'FCBGA1528',100);
INSERT INTO Processors(ProcessorId,Manufacturer,Model,Cores,Threads,BaseFrequency,TurboFrequency,Socket,MaximumTemperature) VALUES(3003,'Intel','Core i7-10510U',4,8,1.80,4.90,'FCBGA1528',100);
INSERT INTO Processors(ProcessorId,Manufacturer,Model,Cores,Threads,BaseFrequency,TurboFrequency,Socket,MaximumTemperature) VALUES(3004,'Intel','Core i5-9300HF',4,8,2.40,4.10,'FCBGA1440',100);
INSERT INTO Processors(ProcessorId,Manufacturer,Model,Cores,Threads,BaseFrequency,TurboFrequency,Socket,MaximumTemperature) VALUES(3005,'Intel','Core i7-9750H',6,12,2.60,4.50,'FCBGA1440',100);
INSERT INTO Processors(ProcessorId,Manufacturer,Model,Cores,Threads,BaseFrequency,TurboFrequency,Socket,MaximumTemperature) VALUES(3006,'Intel','Core i7-8750H',6,12,2.20,4.10,'FCBGA1440',100);
INSERT INTO Processors(ProcessorId,Manufacturer,Model,Cores,Threads,BaseFrequency,TurboFrequency,Socket,MaximumTemperature) VALUES(3007,'Intel','Core i3-8130U',2,4,2.20,3.40,'FCBGA1356',100);
INSERT INTO Processors(ProcessorId,Manufacturer,Model,Cores,Threads,BaseFrequency,TurboFrequency,Socket,MaximumTemperature) VALUES(3008,'Intel','Core i7-9700',8,8,3.00,4.70,'FCLGA1151',100);
INSERT INTO Processors(ProcessorId,Manufacturer,Model,Cores,Threads,BaseFrequency,TurboFrequency,Socket,MaximumTemperature) VALUES(3009,'Intel','Core i5-9400',6,6,2.90,4.10,'FCLGA1151',100);
INSERT INTO Processors(ProcessorId,Manufacturer,Model,Cores,Threads,BaseFrequency,TurboFrequency,Socket,MaximumTemperature) VALUES(3010,'Intel','Core i3-9300',4,4,3.70,4.30,'FCLGA1151',100);
INSERT INTO Processors(ProcessorId,Manufacturer,Model,Cores,Threads,BaseFrequency,TurboFrequency,Socket,MaximumTemperature) VALUES(3011,'Intel','Pentium Gold G5400',2,4,3.70,3.70,'FCLGA1151',100);
INSERT INTO Processors(ProcessorId,Manufacturer,Model,Cores,Threads,BaseFrequency,TurboFrequency,Socket,MaximumTemperature) VALUES(3012,'Intel','Core i7-9700K',8,8,3.60,4.90,'FCLGA1151',100);
INSERT INTO Processors(ProcessorId,Manufacturer,Model,Cores,Threads,BaseFrequency,TurboFrequency,Socket,MaximumTemperature) VALUES(3013,'Intel','Core i5-8500',6,6,3.00,4.10,'FCLGA1151',100);
INSERT INTO Processors(ProcessorId,Manufacturer,Model,Cores,Threads,BaseFrequency,TurboFrequency,Socket,MaximumTemperature) VALUES(3014,'AMD','Ryzen 5 3500U',4,8,2.1,3.7,'AM4',105);
INSERT INTO Processors(ProcessorId,Manufacturer,Model,Cores,Threads,BaseFrequency,TurboFrequency,Socket,MaximumTemperature) VALUES(3015,'AMD','Ryzen 3 3200G',4,4,3.6,4,'AM4',95);
INSERT INTO Processors(ProcessorId,Manufacturer,Model,Cores,Threads,BaseFrequency,TurboFrequency,Socket,MaximumTemperature) VALUES(3016,'AMD','Ryzen 7 2700X',8,16,3.7,4.3,'AM4',85);
INSERT INTO Processors(ProcessorId,Manufacturer,Model,Cores,Threads,BaseFrequency,TurboFrequency,Socket,MaximumTemperature) VALUES(3017,'AMD','Ryzen 5 1600',6,12,3.2,3.6,'AM4',95);

INSERT INTO GraphicsCards(GraphicsCardId,Manufacturer,Model,Capacity,Type,MemorySpeed,DirectX,Slot,MaximumTemperature,CoreSpeed) VALUES(2001,'Nvidia','GeForce GTX 1650 4GB',4,'GDDR5',8000,12.0,'PCI Express 3.0',88,1719);
INSERT INTO GraphicsCards(GraphicsCardId,Manufacturer,Model,Capacity,Type,MemorySpeed,DirectX,Slot,MaximumTemperature,CoreSpeed) VALUES(2002,'Nvidia','GeForce GTX 1050 3GB',3,'GDDR5',7008,12.0,'PCI Express 3.0',97,1417);
INSERT INTO GraphicsCards(GraphicsCardId,Manufacturer,Model,Capacity,Type,MemorySpeed,DirectX,Slot,MaximumTemperature,CoreSpeed) VALUES(2003,'AMD','Radeon 610 2 GB GDDR5',2,'GDDR5',2250,12.0,'PCI Express 2.0',102,1030);
INSERT INTO GraphicsCards(GraphicsCardId,Manufacturer,Model,Capacity,Type,MemorySpeed,DirectX,Slot,MaximumTemperature,CoreSpeed) VALUES(2004,'Nvidia','GeForce RTX 2060 6 GB GDDR6',4,'GDDR6',14000,12.0,'PCI Express x16 3.0',88,1710);
INSERT INTO GraphicsCards(GraphicsCardId,Manufacturer,Model,Capacity,Type,MemorySpeed,DirectX,Slot,MaximumTemperature,CoreSpeed) VALUES(2005,'Nvidia','Quadro P2200 5GB',4,'GDDR5X',5000,12.0,'PCI Express 3.0',75,1280);
INSERT INTO GraphicsCards(GraphicsCardId,Manufacturer,Model,Capacity,Type,MemorySpeed,DirectX,Slot,MaximumTemperature,CoreSpeed) VALUES(2006,'Nvidia','GeForce RTX 2070 Super 8 GB',8,'GDDR6',14000,12.0,'PCI Express 3.0',88,1770);
INSERT INTO GraphicsCards(GraphicsCardId,Manufacturer,Model,Capacity,Type,MemorySpeed,DirectX,Slot,MaximumTemperature,CoreSpeed) VALUES(2007,'Nvidia','GeForce GTX 1050 2GB',2,'GDDR5',7000,12.0,'PCI Express 3.0',75,1379);
INSERT INTO GraphicsCards(GraphicsCardId,Manufacturer,Model,Capacity,Type,MemorySpeed,DirectX,Slot,MaximumTemperature,CoreSpeed) VALUES(2008,'Nvidia','GeForce GTX 1080 8GB GDDR5X',8,'GDDR5X',10010,12.0,'PCI Express 3.0',94,1607);
INSERT INTO GraphicsCards(GraphicsCardId,Manufacturer,Model,Capacity,Type,MemorySpeed,DirectX,Slot,MaximumTemperature,CoreSpeed) VALUES(2009,'Nvidia','GeForce GTX 1060 6GB',6,'GDDR5X',10000,12.0,'PCI Express 3.0',94,1771);
INSERT INTO GraphicsCards(GraphicsCardId,Manufacturer,Model,Capacity,Type,MemorySpeed,DirectX,Slot,MaximumTemperature,CoreSpeed) VALUES(2010,'Nvidia','GeForce RTX 2080 Super 8GB',8,'GDDR6',15500,12.0,'PCI Express 3.0',250,1845);

INSERT INTO HDDs(HDDId,Manufacturer,Model,FormFactor,Capacity,RPM) VALUES(5001,'Western','Digital','2.5"',1000,5400);
INSERT INTO HDDs(HDDId,Manufacturer,Model,FormFactor,Capacity,RPM) VALUES(5002,'Seagate','Barracuda ST1000LM036','3.5"',1000,7200);
INSERT INTO HDDs(HDDId,Manufacturer,Model,FormFactor,Capacity,RPM) VALUES(5003,'Fujitsu','S26361','3.5"',2000,7200);
INSERT INTO HDDs(HDDId,Manufacturer,Model,FormFactor,Capacity,RPM) VALUES(5004,'Seagate','Maxtor','2.5"',4000,5400);
INSERT INTO HDDs(HDDId,Manufacturer,Model,FormFactor,Capacity,RPM) VALUES(5005,'Toshiba','MG04ACA200E','3.5"',2000,7200);
INSERT INTO HDDs(HDDId,Manufacturer,Model,FormFactor,Capacity,RPM) VALUES(5006,'Toshiba','DT01ACA300','3,5"',3000,7200);
INSERT INTO HDDs(HDDId,Manufacturer,Model,FormFactor,Capacity,RPM) VALUES(5007,'Dell','400-AJPH','2,5"',600,10000);
INSERT INTO HDDs(HDDId,Manufacturer,Model,FormFactor,Capacity,RPM) VALUES(5008,'HP','SAS-J9F46A','2,5"',600,10000);
INSERT INTO HDDs(HDDId,Manufacturer,Model,FormFactor,Capacity,RPM) VALUES(5009,'Seagate','Barracuda ST4000LM024','2.5"',4000,5400);
INSERT INTO HDDs(HDDId,Manufacturer,Model,FormFactor,Capacity,RPM) VALUES(5010,'ADATA','SX8100','M.2 2280',1000,7200);

INSERT INTO SSDs(SSDId,Manufacturer,Model,FormFactor,Capacity,ReadSpeed,WriteSpeed) VALUES(6001,'Gigabyte','GP-GSM2NE8128GNTD','M.2 2280',128,1100,500);
INSERT INTO SSDs(SSDId,Manufacturer,Model,FormFactor,Capacity,ReadSpeed,WriteSpeed) VALUES(6002,'Kingston','A2000','M.2 2280',250,2200,2000);
INSERT INTO SSDs(SSDId,Manufacturer,Model,FormFactor,Capacity,ReadSpeed,WriteSpeed) VALUES(6003,'Gigabyte','GP-GSM2NE8256GNTD','M.2 2280',256,1200,800);
INSERT INTO SSDs(SSDId,Manufacturer,Model,FormFactor,Capacity,ReadSpeed,WriteSpeed) VALUES(6004,'HP','EX920','M.2 2280',256,3200,1800);
INSERT INTO SSDs(SSDId,Manufacturer,Model,FormFactor,Capacity,ReadSpeed,WriteSpeed) VALUES(6005,'Samsung','970 EVO Plus','M.2 2280',500,3500,3200);
INSERT INTO SSDs(SSDId,Manufacturer,Model,FormFactor,Capacity,ReadSpeed,WriteSpeed) VALUES(6006,'Samsung','960 PRO','M.2 2280',512,3500,2700);
INSERT INTO SSDs(SSDId,Manufacturer,Model,FormFactor,Capacity,ReadSpeed,WriteSpeed) VALUES(6007,'Samsung','970 PRO','M.2 2280',1024,3500,2700);
INSERT INTO SSDs(SSDId,Manufacturer,Model,FormFactor,Capacity,ReadSpeed,WriteSpeed) VALUES(6008,'ADATA','SX8100','2.5"',1000,3500,3000);
INSERT INTO SSDs(SSDId,Manufacturer,Model,FormFactor,Capacity,ReadSpeed,WriteSpeed) VALUES(6009,'Samsung','860 EVO','2.5"',2000,550,520);
INSERT INTO SSDs(SSDId,Manufacturer,Model,FormFactor,Capacity,ReadSpeed,WriteSpeed) VALUES(6010,'Intel','660p','M.2 2280',2000,1800,1800);

INSERT INTO Ports(PortId, Type) VALUES(10001, 'USB 2.0');
INSERT INTO Ports(PortId, Type) VALUES(10002, 'USB 3.0');
INSERT INTO Ports(PortId, Type) VALUES(10003, 'USB 3.1');
INSERT INTO Ports(PortId, Type) VALUES(10004, 'USB 3.1 Type C');
INSERT INTO Ports(PortId, Type) VALUES(10005, 'M.2 2242/2280 SSD');
INSERT INTO Ports(PortId, Type) VALUES(10006, 'M.2 SSD Combo');
INSERT INTO Ports(PortId, Type) VALUES(10007, 'M.2 2280 NVMe');
INSERT INTO Ports(PortId, Type) VALUES(10008, 'HDMI');
INSERT INTO Ports(PortId, Type) VALUES(10009, 'RJ-45');
INSERT INTO Ports(PortId, Type) VALUES(10010, 'Mini DisplayPort');
INSERT INTO Ports(PortId, Type) VALUES(10011, 'VGA');
INSERT INTO Ports(PortId, Type) VALUES(10012, 'DisplayPort');
INSERT INTO Ports(PortId, Type) VALUES(10013, 'DVI-D');

INSERT INTO Laptops(LaptopId,Manufacturer,Model,Inches,Resolution,ProcessorId,HDDId,SSDId,BatteryType,BatteryCapacity,CameraMegapixels,Weight,Color,OperationSystem)
VALUES(1,'Lenovo','ThinkBook 15-IIL',15.6,'1920x1080',3001,null,6003,'LiOh',45,2.1,1.80,'gray','Windows 10');
INSERT INTO Laptops(LaptopId,Manufacturer,Model,Inches,Resolution,ProcessorId,HDDId,SSDId,BatteryType,BatteryCapacity,CameraMegapixels,Weight,Color,OperationSystem)
VALUES(2,'HP','EliteBook 850 G6',15.6,'3840x2160',3002,null,6007,'LiOH',56,2.1,3.30,'silver','Windows 10 Proffesional');
INSERT INTO Laptops(LaptopId,Manufacturer,Model,Inches,Resolution,ProcessorId,HDDId,SSDId,BatteryType,BatteryCapacity,CameraMegapixels,Weight,Color,OperationSystem)
VALUES(3,'Lenovo','ThinkPad E14',14,'1920x1080',3003,5004,6006,'LiOH',45,2.1,1.73,'black','Windows 10 Home 64-bit');
INSERT INTO Laptops(LaptopId,Manufacturer,Model,Inches,Resolution,ProcessorId,HDDId,SSDId,BatteryType,BatteryCapacity,CameraMegapixels,Weight,Color,OperationSystem)
VALUES(4,'Lenovo','Y540',15.6,'1920x1080',3004,null,6006,'LiOH',52.5,1,2.30,'black','Windows 10 Home');
INSERT INTO Laptops(LaptopId,Manufacturer,Model,Inches,Resolution,ProcessorId,HDDId,SSDId,BatteryType,BatteryCapacity,CameraMegapixels,Weight,Color,OperationSystem)
VALUES(5,'Acer','Aspire 7',15.6,'1920x1080',3005,5002,6003,'LiOH',55,2.35,2.35,'black','Windows 10 Home 64 - bit');
INSERT INTO Laptops(LaptopId,Manufacturer,Model,Inches,Resolution,ProcessorId,HDDId,SSDId,BatteryType,BatteryCapacity,CameraMegapixels,Weight,Color,OperationSystem)
VALUES(6,'Dell','Vostro 3590',15.6,'1920x1080',3003,null,6004,'LiOH',42,0.9,1.99,'black','Windows 10 Home 64 - bit');
INSERT INTO Laptops(LaptopId,Manufacturer,Model,Inches,Resolution,ProcessorId,HDDId,SSDId,BatteryType,BatteryCapacity,CameraMegapixels,Weight,Color,OperationSystem)
VALUES(7,'Dell','G7 7790',17.3,'1920x1080',3006,5003,6007,'LiOH',60,2.1,3.30,'black','Windows 10 Home 62-bit');
INSERT INTO Laptops(LaptopId,Manufacturer,Model,Inches,Resolution,ProcessorId,HDDId,SSDId,BatteryType,BatteryCapacity,CameraMegapixels,Weight,Color,OperationSystem)
VALUES(8,'Acer','Aspire 3',15.6,'1920x1080',3014,5005,6002,'LiOH',36.7,0.3,1.90,'black','Windows 10 Home 64-bit');
INSERT INTO Laptops(LaptopId,Manufacturer,Model,Inches,Resolution,ProcessorId,HDDId,SSDId,BatteryType,BatteryCapacity,CameraMegapixels,Weight,Color,OperationSystem)
VALUES(9,'ASUS','M509DA',15.6,'1920x1080',3014,null,6005,'LiOH',32,0.3,1.8,'gray',null);
INSERT INTO Laptops(LaptopId,Manufacturer,Model,Inches,Resolution,ProcessorId,HDDId,SSDId,BatteryType,BatteryCapacity,CameraMegapixels,Weight,Color,OperationSystem)
VALUES(10,'HP','250G7',15.6,'1920x1080',3007,null,6003,'LiOH',41,0.3,1.8,'gray','Linux');

INSERT INTO LaptopsRAMS(RAMId,LaptopId,RAMQuantity) VALUES(4004,1,1);
INSERT INTO LaptopsRAMS(RAMId,LaptopId,RAMQuantity) VALUES(4007,2,1);
INSERT INTO LaptopsRAMS(RAMId,LaptopId,RAMQuantity) VALUES(4008,3,1);
INSERT INTO LaptopsRAMS(RAMId,LaptopId,RAMQuantity) VALUES(4006,4,2);
INSERT INTO LaptopsRAMS(RAMId,LaptopId,RAMQuantity) VALUES(4006,5,1);
INSERT INTO LaptopsRAMS(RAMId,LaptopId,RAMQuantity) VALUES(4006,6,2);
INSERT INTO LaptopsRAMS(RAMId,LaptopId,RAMQuantity) VALUES(4010,7,1);
INSERT INTO LaptopsRAMS(RAMId,LaptopId,RAMQuantity) VALUES(4002,8,3);
INSERT INTO LaptopsRAMS(RAMId,LaptopId,RAMQuantity) VALUES(4003,9,1);
INSERT INTO LaptopsRAMS(RAMId,LaptopId,RAMQuantity) VALUES(4003,10,1);

INSERT INTO LaptopsGraphicsCards(GraphicsCardId,LaptopId,CardQuantity) VALUES(2009,1,1);
INSERT INTO LaptopsGraphicsCards(GraphicsCardId,LaptopId,CardQuantity) VALUES(2002,2,2);
INSERT INTO LaptopsGraphicsCards(GraphicsCardId,LaptopId,CardQuantity) VALUES(2008,3,1);
INSERT INTO LaptopsGraphicsCards(GraphicsCardId,LaptopId,CardQuantity) VALUES(2001,4,1);
INSERT INTO LaptopsGraphicsCards(GraphicsCardId,LaptopId,CardQuantity) VALUES(2002,5,1);
INSERT INTO LaptopsGraphicsCards(GraphicsCardId,LaptopId,CardQuantity) VALUES(2001,6,1);
INSERT INTO LaptopsGraphicsCards(GraphicsCardId,LaptopId,CardQuantity) VALUES(2004,7,1);
INSERT INTO LaptopsGraphicsCards(GraphicsCardId,LaptopId,CardQuantity) VALUES(2007,8,1);
INSERT INTO LaptopsGraphicsCards(GraphicsCardId,LaptopId,CardQuantity) VALUES(2008,9,1);
INSERT INTO LaptopsGraphicsCards(GraphicsCardId,LaptopId,CardQuantity) VALUES(2007,10,1);

INSERT INTO LaptopsPorts(LaptopId,PortId,PortQuantity) VALUES(1,10003,2);
INSERT INTO LaptopsPorts(LaptopId,PortId,PortQuantity) VALUES(1,10005,1);
INSERT INTO LaptopsPorts(LaptopId,PortId,PortQuantity) VALUES(1,10008,1);
INSERT INTO LaptopsPorts(LaptopId,PortId,PortQuantity) VALUES(1,10009,1);
INSERT INTO LaptopsPorts(LaptopId,PortId,PortQuantity) VALUES(1,10001,1);
INSERT INTO LaptopsPorts(LaptopId,PortId,PortQuantity) VALUES(1,10004,1);
INSERT INTO LaptopsPorts(LaptopId,PortId,PortQuantity) VALUES(2,10006,1);
INSERT INTO LaptopsPorts(LaptopId,PortId,PortQuantity) VALUES(2,10004,1);
INSERT INTO LaptopsPorts(LaptopId,PortId,PortQuantity) VALUES(2,10003,2);
INSERT INTO LaptopsPorts(LaptopId,PortId,PortQuantity) VALUES(2,10008,1);
INSERT INTO LaptopsPorts(LaptopId,PortId,PortQuantity) VALUES(2,10009,1);
INSERT INTO LaptopsPorts(LaptopId,PortId,PortQuantity) VALUES(3,10006,1);
INSERT INTO LaptopsPorts(LaptopId,PortId,PortQuantity) VALUES(3,10003,2);
INSERT INTO LaptopsPorts(LaptopId,PortId,PortQuantity) VALUES(3,10008,1);
INSERT INTO LaptopsPorts(LaptopId,PortId,PortQuantity) VALUES(3,10009,1);
INSERT INTO LaptopsPorts(LaptopId,PortId,PortQuantity) VALUES(3,10001,1);
INSERT INTO LaptopsPorts(LaptopId,PortId,PortQuantity) VALUES(3,10004,1);
INSERT INTO LaptopsPorts(LaptopId,PortId,PortQuantity) VALUES(4,10008,1);
INSERT INTO LaptopsPorts(LaptopId,PortId,PortQuantity) VALUES(4,10003,3);
INSERT INTO LaptopsPorts(LaptopId,PortId,PortQuantity) VALUES(4,10010,1);
INSERT INTO LaptopsPorts(LaptopId,PortId,PortQuantity) VALUES(4,10009,1);
INSERT INTO LaptopsPorts(LaptopId,PortId,PortQuantity) VALUES(4,10004,1);
INSERT INTO LaptopsPorts(LaptopId,PortId,PortQuantity) VALUES(4,10007,1);
INSERT INTO LaptopsPorts(LaptopId,PortId,PortQuantity) VALUES(5,10003,2);
INSERT INTO LaptopsPorts(LaptopId,PortId,PortQuantity) VALUES(5,10007,2);
INSERT INTO LaptopsPorts(LaptopId,PortId,PortQuantity) VALUES(5,10008,1);
INSERT INTO LaptopsPorts(LaptopId,PortId,PortQuantity) VALUES(5,10009,1);
INSERT INTO LaptopsPorts(LaptopId,PortId,PortQuantity) VALUES(5,10001,1);
INSERT INTO LaptopsPorts(LaptopId,PortId,PortQuantity) VALUES(5,10004,1);
INSERT INTO LaptopsPorts(LaptopId,PortId,PortQuantity) VALUES(6,10003,2);
INSERT INTO LaptopsPorts(LaptopId,PortId,PortQuantity) VALUES(6,10005,1);
INSERT INTO LaptopsPorts(LaptopId,PortId,PortQuantity) VALUES(6,10008,1);
INSERT INTO LaptopsPorts(LaptopId,PortId,PortQuantity) VALUES(6,10009,1);
INSERT INTO LaptopsPorts(LaptopId,PortId,PortQuantity) VALUES(6,10001,1);
INSERT INTO LaptopsPorts(LaptopId,PortId,PortQuantity) VALUES(7,10008,1);
INSERT INTO LaptopsPorts(LaptopId,PortId,PortQuantity) VALUES(7,10003,4);
INSERT INTO LaptopsPorts(LaptopId,PortId,PortQuantity) VALUES(7,10007,1);
INSERT INTO LaptopsPorts(LaptopId,PortId,PortQuantity) VALUES(7,10010,1);
INSERT INTO LaptopsPorts(LaptopId,PortId,PortQuantity) VALUES(7,10009,1);
INSERT INTO LaptopsPorts(LaptopId,PortId,PortQuantity) VALUES(8,10007,1);
INSERT INTO LaptopsPorts(LaptopId,PortId,PortQuantity) VALUES(8,10003,1);
INSERT INTO LaptopsPorts(LaptopId,PortId,PortQuantity) VALUES(8,10008,1);
INSERT INTO LaptopsPorts(LaptopId,PortId,PortQuantity) VALUES(8,10009,1);
INSERT INTO LaptopsPorts(LaptopId,PortId,PortQuantity) VALUES(8,10001,2);
INSERT INTO LaptopsPorts(LaptopId,PortId,PortQuantity) VALUES(9,10006,1);
INSERT INTO LaptopsPorts(LaptopId,PortId,PortQuantity) VALUES(9,10003,1);
INSERT INTO LaptopsPorts(LaptopId,PortId,PortQuantity) VALUES(9,10008,1);
INSERT INTO LaptopsPorts(LaptopId,PortId,PortQuantity) VALUES(9,10001,2);
INSERT INTO LaptopsPorts(LaptopId,PortId,PortQuantity) VALUES(9,10004,1);
INSERT INTO LaptopsPorts(LaptopId,PortId,PortQuantity) VALUES(9,10007,1);
INSERT INTO LaptopsPorts(LaptopId,PortId,PortQuantity) VALUES(10,10006,1);
INSERT INTO LaptopsPorts(LaptopId,PortId,PortQuantity) VALUES(10,10008,1);
INSERT INTO LaptopsPorts(LaptopId,PortId,PortQuantity) VALUES(10,10009,1);
INSERT INTO LaptopsPorts(LaptopId,PortId,PortQuantity) VALUES(10,10001,1);
INSERT INTO LaptopsPorts(LaptopId,PortId,PortQuantity) VALUES(10,10003,2);

INSERT INTO PCs(PCId, Manufacturer, Model, Box, Motherboard, ProcessorId, Chipset, HDDId, SSDId, PowerSupply, OperationSystem)
VALUES(1001, 'Asus', 'Game Master V5.0', 'Cooler Master MasterBox MB500 RGB TUF Gaming', 'ASUS TUF B360-PLUS Gaming', 3008, 'Intel B360', 5002, 6006, 500, null);
INSERT INTO PCs(PCId, Manufacturer, Model, Box, Motherboard, ProcessorId, Chipset, HDDId, SSDId, PowerSupply, OperationSystem)
VALUES(1002, 'Dell', 'Vostro 3671 MT', 'Middle Tower', 'Optiplex GX60', 3009, 'Intel B365', 5002, null, 290, 'Linux');
INSERT INTO PCs(PCId, Manufacturer, Model, Box, Motherboard, ProcessorId, Chipset, HDDId, SSDId, PowerSupply, OperationSystem)
VALUES(1003, 'Cougar', 'Game Master V2.0', 'Middle Tower', 'ASRock A320M-HDV R4.0', 3015, 'AMD A320', 5002, null, 500, null);
INSERT INTO PCs(PCId, Manufacturer, Model, Box, Motherboard, ProcessorId, Chipset, HDDId, SSDId, PowerSupply, OperationSystem)
VALUES(1004, 'Fujitsu', 'Esprimo P958 Tower', 'Tower', 'Intel Q370', 3008, 'Intel Q370', null, 6007, 400, null);
INSERT INTO PCs(PCId, Manufacturer, Model, Box, Motherboard, ProcessorId, Chipset, HDDId, SSDId, PowerSupply, OperationSystem)
VALUES(1005, 'Ardes', 'Tharios Mark R7', 'COUGAR PANZER EVO', 'ASRock Fatal1ty X470 Gaming K4', 3016, 'AMD X470', 5003, 6002, 750, 'Windows 10 Home');
INSERT INTO PCs(PCId, Manufacturer, Model, Box, Motherboard, ProcessorId, Chipset, HDDId, SSDId, PowerSupply, OperationSystem)
VALUES(1006, 'HP', 'ProDesk 600 G5 MT', 'Compact', 'Intel Q370', 3010, 'Intel Q370', 5006, 6003, 650, null);
INSERT INTO PCs(PCId, Manufacturer, Model, Box, Motherboard, ProcessorId, Chipset, HDDId, SSDId, PowerSupply, OperationSystem)
VALUES(1007, 'Ardes', 'Game Wave', 'DeepCool Wave V2', 'GIGABYTE Z370M DS3H', 3011, 'Intel Z370', null, 6001, 450, null);
INSERT INTO PCs(PCId, Manufacturer, Model, Box, Motherboard, ProcessorId, Chipset, HDDId, SSDId, PowerSupply, OperationSystem)
VALUES(1008, 'Cougar', 'Game Master V3.0', 'COUGAR MX340', 'ASRock A320M-HDV R4.0', 3017, 'AMD A320', 5005, 6004, 500, 'Windows 10 Home 64bit');
INSERT INTO PCs(PCId, Manufacturer, Model, Box, Motherboard, ProcessorId, Chipset, HDDId, SSDId, PowerSupply, OperationSystem)
VALUES(1009, 'Ardes', 'Game Dark Force', 'XIGMATEK Aquarius Plus', 'ASUS ROG MAXIMUS XI CODE', 3012, 'Intel Z390', 5009, 6002, 1050, 'Windows 10 Home 64bit');
INSERT INTO PCs(PCId, Manufacturer, Model, Box, Motherboard, ProcessorId, Chipset, HDDId, SSDId, PowerSupply, OperationSystem)
VALUES(1010, 'Ultimate Gear', 'Meshify Gaming', 'Fractal Design Meshify C', 'ASUS Prime H310-Plus', 3013, 'Intel H310', 5003, 6003, 600, 'Windows 10 Home 64bit');

INSERT INTO PCsRAMs(RAMId,PCId,RAMQuantity) VALUES(4009,1001,1);
INSERT INTO PCsRAMs(RAMId,PCId,RAMQuantity) VALUES(4001,1002,1);
INSERT INTO PCsRAMs(RAMId,PCId,RAMQuantity) VALUES(4004,1003,1);
INSERT INTO PCsRAMs(RAMId,PCId,RAMQuantity) VALUES(4004,1004,2);
INSERT INTO PCsRAMs(RAMId,PCId,RAMQuantity) VALUES(4005,1005,2);
INSERT INTO PCsRAMs(RAMId,PCId,RAMQuantity) VALUES(4001,1006,2);
INSERT INTO PCsRAMs(RAMId,PCId,RAMQuantity) VALUES(4001,1007,2);
INSERT INTO PCsRAMs(RAMId,PCId,RAMQuantity) VALUES(4008,1008,1);
INSERT INTO PCsRAMs(RAMId,PCId,RAMQuantity) VALUES(4009,1009,2);
INSERT INTO PCsRAMs(RAMId,PCId,RAMQuantity) VALUES(4008,1010,1);

INSERT INTO PCsGraphicsCards(GraphicsCardId,PCId,CardQuantity) VALUES(2006,1001,2);
INSERT INTO PCsGraphicsCards(GraphicsCardId,PCId,CardQuantity) VALUES(2002,1002,1);
INSERT INTO PCsGraphicsCards(GraphicsCardId,PCId,CardQuantity) VALUES(2002,1003,1);
INSERT INTO PCsGraphicsCards(GraphicsCardId,PCId,CardQuantity) VALUES(2004,1004,1);
INSERT INTO PCsGraphicsCards(GraphicsCardId,PCId,CardQuantity) VALUES(2008,1005,2);
INSERT INTO PCsGraphicsCards(GraphicsCardId,PCId,CardQuantity) VALUES(2007,1006,1);
INSERT INTO PCsGraphicsCards(GraphicsCardId,PCId,CardQuantity) VALUES(2007,1007,1);
INSERT INTO PCsGraphicsCards(GraphicsCardId,PCId,CardQuantity) VALUES(2009,1008,1);
INSERT INTO PCsGraphicsCards(GraphicsCardId,PCId,CardQuantity) VALUES(2010,1009,1);
INSERT INTO PCsGraphicsCards(GraphicsCardId,PCId,CardQuantity) VALUES(2009,1010,1);

INSERT INTO PCsPorts(PCId,PortId,PortQuantity) VALUES(1001,10009,1);
INSERT INTO PCsPorts(PCId,PortId,PortQuantity) VALUES(1001,10001,4);
INSERT INTO PCsPorts(PCId,PortId,PortQuantity) VALUES(1001,10002,2);
INSERT INTO PCsPorts(PCId,PortId,PortQuantity) VALUES(1001,10012,2);
INSERT INTO PCsPorts(PCId,PortId,PortQuantity) VALUES(1001,10011,1);
INSERT INTO PCsPorts(PCId,PortId,PortQuantity) VALUES(1001,10008,3);
INSERT INTO PCsPorts(PCId,PortId,PortQuantity) VALUES(1001,10003,4);
INSERT INTO PCsPorts(PCId,PortId,PortQuantity) VALUES(1002,10009,1);
INSERT INTO PCsPorts(PCId,PortId,PortQuantity) VALUES(1002,10001,4);
INSERT INTO PCsPorts(PCId,PortId,PortQuantity) VALUES(1002,10011,1);
INSERT INTO PCsPorts(PCId,PortId,PortQuantity) VALUES(1002,10003,2);
INSERT INTO PCsPorts(PCId,PortId,PortQuantity) VALUES(1002,10008,1);
INSERT INTO PCsPorts(PCId,PortId,PortQuantity) VALUES(1002,10006,1);
INSERT INTO PCsPorts(PCId,PortId,PortQuantity) VALUES(1003,10009,1);
INSERT INTO PCsPorts(PCId,PortId,PortQuantity) VALUES(1003,10001,4);
INSERT INTO PCsPorts(PCId,PortId,PortQuantity) VALUES(1003,10013,1);
INSERT INTO PCsPorts(PCId,PortId,PortQuantity) VALUES(1003,10011,1);
INSERT INTO PCsPorts(PCId,PortId,PortQuantity) VALUES(1003,10002,1);
INSERT INTO PCsPorts(PCId,PortId,PortQuantity) VALUES(1003,10008,1);
INSERT INTO PCsPorts(PCId,PortId,PortQuantity) VALUES(1003,10003,4);
INSERT INTO PCsPorts(PCId,PortId,PortQuantity) VALUES(1004,10009,1);
INSERT INTO PCsPorts(PCId,PortId,PortQuantity) VALUES(1004,10001,5);
INSERT INTO PCsPorts(PCId,PortId,PortQuantity) VALUES(1004,10012,2);
INSERT INTO PCsPorts(PCId,PortId,PortQuantity) VALUES(1004,10013,1);
INSERT INTO PCsPorts(PCId,PortId,PortQuantity) VALUES(1004,10004,1);
INSERT INTO PCsPorts(PCId,PortId,PortQuantity) VALUES(1004,10003,5);
INSERT INTO PCsPorts(PCId,PortId,PortQuantity) VALUES(1005,10009,1);
INSERT INTO PCsPorts(PCId,PortId,PortQuantity) VALUES(1005,10002,2);
INSERT INTO PCsPorts(PCId,PortId,PortQuantity) VALUES(1005,10001,2);
INSERT INTO PCsPorts(PCId,PortId,PortQuantity) VALUES(1005,10013,1);
INSERT INTO PCsPorts(PCId,PortId,PortQuantity) VALUES(1005,10012,3);
INSERT INTO PCsPorts(PCId,PortId,PortQuantity) VALUES(1005,10008,2);
INSERT INTO PCsPorts(PCId,PortId,PortQuantity) VALUES(1005,10003,7);
INSERT INTO PCsPorts(PCId,PortId,PortQuantity) VALUES(1005,10004,1);
INSERT INTO PCsPorts(PCId,PortId,PortQuantity) VALUES(1006,10001,4);
INSERT INTO PCsPorts(PCId,PortId,PortQuantity) VALUES(1006,10002,6);
INSERT INTO PCsPorts(PCId,PortId,PortQuantity) VALUES(1006,10009,1);
INSERT INTO PCsPorts(PCId,PortId,PortQuantity) VALUES(1006,10012,2);
INSERT INTO PCsPorts(PCId,PortId,PortQuantity) VALUES(1006,10008,1);
INSERT INTO PCsPorts(PCId,PortId,PortQuantity) VALUES(1006,10004,2);
INSERT INTO PCsPorts(PCId,PortId,PortQuantity) VALUES(1006,10011,1);
INSERT INTO PCsPorts(PCId,PortId,PortQuantity) VALUES(1007,10009,1);
INSERT INTO PCsPorts(PCId,PortId,PortQuantity) VALUES(1007,10001,4);
INSERT INTO PCsPorts(PCId,PortId,PortQuantity) VALUES(1007,10012,1);
INSERT INTO PCsPorts(PCId,PortId,PortQuantity) VALUES(1007,10002,1);
INSERT INTO PCsPorts(PCId,PortId,PortQuantity) VALUES(1007,10013,1);
INSERT INTO PCsPorts(PCId,PortId,PortQuantity) VALUES(1007,10008,2);
INSERT INTO PCsPorts(PCId,PortId,PortQuantity) VALUES(1007,10003,4);
INSERT INTO PCsPorts(PCId,PortId,PortQuantity) VALUES(1008,10009,1);
INSERT INTO PCsPorts(PCId,PortId,PortQuantity) VALUES(1008,10001,4);
INSERT INTO PCsPorts(PCId,PortId,PortQuantity) VALUES(1008,10013,1);
INSERT INTO PCsPorts(PCId,PortId,PortQuantity) VALUES(1008,10011,1);
INSERT INTO PCsPorts(PCId,PortId,PortQuantity) VALUES(1008,10002,1);
INSERT INTO PCsPorts(PCId,PortId,PortQuantity) VALUES(1008,10012,3);
INSERT INTO PCsPorts(PCId,PortId,PortQuantity) VALUES(1008,10008,3);
INSERT INTO PCsPorts(PCId,PortId,PortQuantity) VALUES(1008,10003,4);
INSERT INTO PCsPorts(PCId,PortId,PortQuantity) VALUES(1009,10009,1);
INSERT INTO PCsPorts(PCId,PortId,PortQuantity) VALUES(1009,10002,1);
INSERT INTO PCsPorts(PCId,PortId,PortQuantity) VALUES(1009,10008,2);
INSERT INTO PCsPorts(PCId,PortId,PortQuantity) VALUES(1009,10001,1);
INSERT INTO PCsPorts(PCId,PortId,PortQuantity) VALUES(1009,10004,1);
INSERT INTO PCsPorts(PCId,PortId,PortQuantity) VALUES(1009,10003,9);
INSERT INTO PCsPorts(PCId,PortId,PortQuantity) VALUES(1009,10012,3);
INSERT INTO PCsPorts(PCId,PortId,PortQuantity) VALUES(1010,10009,1);
INSERT INTO PCsPorts(PCId,PortId,PortQuantity) VALUES(1010,10002,2);
INSERT INTO PCsPorts(PCId,PortId,PortQuantity) VALUES(1010,10001,2);
INSERT INTO PCsPorts(PCId,PortId,PortQuantity) VALUES(1010,10012,2);
INSERT INTO PCsPorts(PCId,PortId,PortQuantity) VALUES(1010,10013,1);
INSERT INTO PCsPorts(PCId,PortId,PortQuantity) VALUES(1010,10011,1);
INSERT INTO PCsPorts(PCId,PortId,PortQuantity) VALUES(1010,10003,2);
INSERT INTO PCsPorts(PCId,PortId,PortQuantity) VALUES(1010,10008,3);

INSERT INTO MonitorsPorts(MonitorId,PortId,PortQuantity) VALUES(7001,10008,1);
INSERT INTO MonitorsPorts(MonitorId,PortId,PortQuantity) VALUES(7001,10011,1);
INSERT INTO MonitorsPorts(MonitorId,PortId,PortQuantity) VALUES(7002,10008,1);
INSERT INTO MonitorsPorts(MonitorId,PortId,PortQuantity) VALUES(7002,10011,1);
INSERT INTO MonitorsPorts(MonitorId,PortId,PortQuantity) VALUES(7002,10012,1);
INSERT INTO MonitorsPorts(MonitorId,PortId,PortQuantity) VALUES(7003,10002,3);
INSERT INTO MonitorsPorts(MonitorId,PortId,PortQuantity) VALUES(7003,10008,1);
INSERT INTO MonitorsPorts(MonitorId,PortId,PortQuantity) VALUES(7004,10008,1);
INSERT INTO MonitorsPorts(MonitorId,PortId,PortQuantity) VALUES(7004,10011,1);
INSERT INTO MonitorsPorts(MonitorId,PortId,PortQuantity) VALUES(7005,10008,1);
INSERT INTO MonitorsPorts(MonitorId,PortId,PortQuantity) VALUES(7005,10012,1);
INSERT INTO MonitorsPorts(MonitorId,PortId,PortQuantity) VALUES(7006,10004,1);
INSERT INTO MonitorsPorts(MonitorId,PortId,PortQuantity) VALUES(7006,10008,1);
INSERT INTO MonitorsPorts(MonitorId,PortId,PortQuantity) VALUES(7006,10012,1);
INSERT INTO MonitorsPorts(MonitorId,PortId,PortQuantity) VALUES(7007,10011,1);
INSERT INTO MonitorsPorts(MonitorId,PortId,PortQuantity) VALUES(7008,10008,2);
INSERT INTO MonitorsPorts(MonitorId,PortId,PortQuantity) VALUES(7008,10011,1);
INSERT INTO MonitorsPorts(MonitorId,PortId,PortQuantity) VALUES(7009,10002,3);
INSERT INTO MonitorsPorts(MonitorId,PortId,PortQuantity) VALUES(7009,10008,1);
INSERT INTO MonitorsPorts(MonitorId,PortId,PortQuantity) VALUES(7009,10012,1);
INSERT INTO MonitorsPorts(MonitorId,PortId,PortQuantity) VALUES(7010,10002,3);
INSERT INTO MonitorsPorts(MonitorId,PortId,PortQuantity) VALUES(7010,10008,1);
INSERT INTO MonitorsPorts(MonitorId,PortId,PortQuantity) VALUES(7010,10011,1);
INSERT INTO MonitorsPorts(MonitorId,PortId,PortQuantity) VALUES(7010,10012,1);

INSERT INTO Customers(Username,Email,PhoneNumber,Password) VALUES('BoB','bobi89@abv.bg','359888888888','7a82023fe5f20e128b525c085af976cb53725fa0f08b799cd3d344c7f7fc647d');
INSERT INTO Customers(Username,Email,PhoneNumber,Password) VALUES('Vankata','csmanqka@abv.bg','359886588888','8c3c10fa443a72383d3b9279c0a0fdc52e286767c9ba07ec2e64299ae2b01822');
INSERT INTO Customers(Username,Email,PhoneNumber,Password) VALUES('Viking','alzar@abv.bg','359886584888','280e49c0399f892b50a8e3b16877726768f22c114a3cabea922265e55c72347f');
INSERT INTO Customers(Username,Email,PhoneNumber,Password) VALUES('Darkness','dark33@abv.bg','359882228888','98019eab81df5d6fd8c7326b86bbf8d570643d0adf0409f1ccd9bfdadd4cf8ba');
INSERT INTO Customers(Username,Email,PhoneNumber,Password) VALUES('Thebloody','pcgamer@abv.bg','359886588869','ce3aae3df13383ea4292084b1fac092dfe1cbe891017c268e4f557ecaecf6b90');
INSERT INTO Customers(Username,Email,PhoneNumber,Password) VALUES('Magiosnika','harrypotter@abv.bg','359833584888','355b11e64a6839551034db4c244b8bf803607f65a26eef252a42c814d40c3d6d');
INSERT INTO Customers(Username,Email,PhoneNumber,Password) VALUES('ValioMishkata','valckata@abv.bg','359882244888','7fc19588301848a57575415527108e4f202cc3020d7c2fb15d407f3ba3b9eceb');
INSERT INTO Customers(Username,Email,PhoneNumber,Password) VALUES('Faker','ezmid@abv.bg','359886585569','2a5ef50867a36f843238f0f1ca0e0889d8270f18362889826b560b10c4e1dab5');
INSERT INTO Customers(Username,Email,PhoneNumber,Password) VALUES('BradPitt','armpit@abv.bg','359881584828','012a99dc999a87120a1bb4daffc444fbeb5c882b04ed9c305bdb33e1acb08edb');
INSERT INTO Customers(Username,Email,PhoneNumber,Password) VALUES('BoykoBorisoff','boykoshefa@abv.bg','359882225788','86707ca576a4e1bb618aae15d952f17f87757e8d601fc84402923b8bb59457c4');

INSERT INTO Orders(Customer) VALUES ('BoB');
INSERT INTO Orders(Customer) VALUES ('BoB');
INSERT INTO Orders(Customer) VALUES ('BoykoBorisoff');
INSERT INTO Orders(Customer) VALUES ('BoykoBorisoff');
INSERT INTO Orders(Customer) VALUES ('BradPitt');
INSERT INTO Orders(Customer) VALUES ('ValioMishkata');

INSERT INTO OrdersProducts(OrderId,ProductId,Quantity) VALUES(1,1,2);
INSERT INTO OrdersProducts(OrderId,ProductId,Quantity) VALUES(2,3,1);
INSERT INTO OrdersProducts(OrderId,ProductId,Quantity) VALUES(4,5,3);



-- Препоръчително е да се прочете документацията за тригерите
-- преди продължаване към примерите, въпреки описанието им.
-- Примери за действията на тригерите, описани в презентацията в документацията.

SELECT * FROM Products;
SELECT * FROM OrdersProducts;
-- Преди добавяне на продукт към дадена поръчка се проверява дали се съдържа в желаното количество за добавяне към поръчката.
-- При недостатъчно количество се връща подходящото съобщение за грешка.
-- продуктът с ProductId = 1 има Quantity = 3
-- следващата заявка ще върне съобщение за грешка
UPDATE OrdersProducts SET Quantity = 5 WHERE OrderId = 2 AND ProductId = 3;

-- Продуктът с ProductId=4 има цена = 2199.00
-- при добавяне на този продукт към поръчка, която не го съдържа
-- Поръчка с OrderId=5 не е завършена и има TotalPrice = 0
-- след следната операция, Общата цена за поръчка номер 5 ще стане 4398.00
-- ProductPrice за OrdersProducts с OrderId = 6 и ProductId = 4 ще стане 2199.00
INSERT INTO OrdersProducts(OrderId,ProductId,Quantity) VALUES(6,4,2);

SELECT * FROM OrdersProducts;
SELECT * FROM Orders;

--
-- този ред ще мине, понеже статуса на поръчка с OrderId=1 е Finished = 0, т.е тя е незавършена и
-- клиента има правото да се откаже от нея
DELETE FROM Orders WHERE OrderId=1;

-- ако променим статуса на поръчката преди да я изтрием, ще получим съобщение за грешка
UPDATE Orders SET Finished = 1 WHERE OrderId = 2;
DELETE FROM Orders WHERE OrderId=2;
-- също така не можем да променим статуса на поръчка след нейното завършване
UPDATE Orders SET Finished = 0 WHERE OrderId = 2;

SELECT * FROM OrdersProducts;
-- не можем да трием продукти от поръчки след тяхното приключване
DELETE FROM OrdersProducts WHERE OrderId=2;

-- следващите 2 примера важат за множествата: 
-- LaptopsGraphicsCards, LaptopsPorts, LaptopsRAMs, MonitorsPorts, PCsGraphicsCards, PCsPorts, PCsRAMs
SELECT * FROM LaptopsGraphicsCards;
-- този ред ще хвърли грешка, понеже CardQuantity != 0
DELETE FROM LaptopsGraphicsCards WHERE LaptopId = 4 AND GraphicsCardId = 2001;
-- но тези 2 последователни реда ще минат
UPDATE LaptopsGraphicsCards SET CardQuantity = 0 WHERE LaptopId = 4 AND GraphicsCardId = 2001;
DELETE FROM LaptopsGraphicsCards WHERE LaptopId = 4 AND GraphicsCardId = 2001;

-- следващите примери важат за множествата:
-- Customers, GraphicsCards, HDDs, Keyboards, Monitors, Processors, Mouses, PCs, RAMs, SSDs
-- Тоест всички множества, които имат връзка с Products (водят се продукти)
-- Множествата Laptops и PCs нямат тригери, забраняващи изтриването от таблиците, но за тях не е необходимо,
-- понеже ограниченията от тип FOREIGN KEY (например към Processors) вече забраняват това.
DELETE FROM PCs;
DELETE FROM Laptops;
-- ..... заявките за всички от изброените таблици ще изведат подходящото съобщение за грешка

