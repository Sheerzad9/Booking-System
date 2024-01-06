 /*
	This script creates schema and the initial tables and relationships between them.
	You can run this script with the MySQL workbench, or directly from terminal with the MySQL server with the following command,
	mysql -u your_username -p your_password < create_tables.sql
	
	NOTE, you may want to update application.properties file for the user and password. If you don't want to change them, please
	run the following two queries manually aswell
	
	CREATE USER 'demouser'@'localhost' IDENTIFIED BY 'demouser';

	GRANT ALL PRIVILEGES ON * . * TO 'demouser'@'localhost';
 */


-- Create the bookingdb schema if it doesn't exist
CREATE DATABASE IF NOT EXISTS bookingdb;

-- Use the bookingdb schema
USE bookingdb;

-- Create the Instructor table
CREATE TABLE Instructor (
    InstructorID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(15),
    Specialization VARCHAR(50)
);

-- Create the DancingCategory table
CREATE TABLE DancingCategory (
    CategoryID INT PRIMARY KEY AUTO_INCREMENT,
    CategoryName VARCHAR(50) NOT NULL,
    InstructorID INT,
    FOREIGN KEY (InstructorID) REFERENCES Instructor(InstructorID)
);

-- Create the Customer table
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(15),
    Password VARCHAR(250) NOT NULL
);

-- Create the DanceClass table
CREATE TABLE DanceClass (
    ClassID INT PRIMARY KEY AUTO_INCREMENT,
    ClassName VARCHAR(50) NOT NULL,
    Schedule DATETIME NOT NULL,
    Duration INT NOT NULL,
    InstructorID INT,
    Location VARCHAR(100),
    FOREIGN KEY (InstructorID) REFERENCES Instructor(InstructorID)
);

-- Create the Booking table
CREATE TABLE Booking (
    BookingID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    ClassID INT,
    BookingDate DATETIME,
    Status VARCHAR(20),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (ClassID) REFERENCES DanceClass(ClassID)
);

