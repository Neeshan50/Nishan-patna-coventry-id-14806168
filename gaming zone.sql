CREATE TABLE Customers (
  CustomerID INT PRIMARY KEY,
  FirstName VARCHAR(50),
  LastName VARCHAR(50),
  Address VARCHAR(100),
  MemberType VARCHAR(20),
  MembershipFee DECIMAL(10, 2),
  JoinDate DATE,
  DateOfBirth DATE
);

CREATE TABLE Sessions (
  SessionID INT PRIMARY KEY,
  SessionDay VARCHAR(20),
  StartTime TIME,
  EndTime TIME,
  SessionType VARCHAR(50),
  Floor INT,
  Price DECIMAL(10, 2)
);

CREATE TABLE Staff (
  StaffID INT PRIMARY KEY,
  FirstName VARCHAR(50),
  LastName VARCHAR(50),  -- Fixed data type name
  Role VARCHAR(50)       -- Added the Role column based on usage in the query below
);

CREATE TABLE Bookings (
  BookingID INT PRIMARY KEY,
  SessionID INT,
  CustomerID INT,
  Date DATE,
  Member BOOLEAN,
  Fee DECIMAL(10, 2),
  PrePaid BOOLEAN,
  FOREIGN KEY (SessionID) REFERENCES Sessions(SessionID),
  FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Machines (
  MachineID INT PRIMARY KEY,
  Game VARCHAR(50),
  Year INT,
  Floor INT
);

CREATE TABLE Consoles (
  ConsoleID INT PRIMARY KEY,
  Name VARCHAR(50),
  PEGI VARCHAR(10),
  Quantity INT
);

CREATE TABLE Games (
  GameID INT PRIMARY KEY,
  Name VARCHAR(50),
  PEGI VARCHAR(10),
  Console VARCHAR(20)
);

-- Inserting data into Customers
INSERT INTO Customers VALUES
(1, 'Saroj', 'Upadhyay', 'Dillibazar, Kathmandu', 'Standard', 1000.00, '2023-09-01', '1998-02-01'),
(2, 'Neha', 'Kakkar', 'Putalisadak, Kathmandu', 'Premium', 14000.00, '2023-06-05', '2000-10-15');

-- Inserting data into Sessions
INSERT INTO Sessions VALUES
(1, 'Sunday', '11:00:00', '19:00:00', 'Free', 1, 1000.00),
(2, 'Sunday', '11:00:00', '19:00:00', 'Free', 2, 500.00);

-- Inserting data into Staff
INSERT INTO Staff VALUES
(1, 'Sujal', 'Bohara', 'Cafe'),
(2, 'Rajesh', 'Hamal', 'Maintenance');

-- Inserting data into Bookings
INSERT INTO Bookings VALUES
(1, 1, 1, '2023-10-21', TRUE, NULL, FALSE),
(2, 1, 2, '2023-10-21', FALSE, 1000.00, FALSE);

-- Inserting data into Machines
INSERT INTO Machines VALUES
(12, 'Pokemon', 2016, 2),
(45, 'PUBG Battlegrounds', 2004, 1);

-- Inserting data into Consoles
INSERT INTO Consoles VALUES
(1, 'PS1', 'PG', 3),
(2, 'PS2', 'PG', 2);

-- Inserting data into Games
INSERT INTO Games VALUES
(1, 'FIFA 18', 'PG', 'PS1'),
(2, 'FIFA 18', 'PG', 'PS2');

-- Querying Customers with unpaid bookings in a specific session
SELECT c.FirstName, c.LastName
FROM Customers c
JOIN Bookings b ON c.CustomerID = b.CustomerID
WHERE b.SessionID = 1 AND b.PrePaid = FALSE;

-- Counting games for a specific console
SELECT COUNT(*)
FROM Games
WHERE Console = 'PS2';

-- Selecting staff for a session with a specific role
SELECT s.FirstName, s.LastName
FROM Staff s
JOIN Sessions se ON s.StaffID = se.SessionID
WHERE se.SessionID = 1 AND s.Role = 'Counter';

-- Updating machine information
UPDATE Machines
SET Floor = 2
WHERE Game = 'Grand Theft Auto';

-- Deleting a specific machine entry 
DELETE FROM Machines
WHERE Game = 'Mario';