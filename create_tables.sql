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
    instructor_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    specialization VARCHAR(50)
);

-- Create the DancingCategory table
CREATE TABLE DancingCategory (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(50) NOT NULL,
    instructor_id INT,
    FOREIGN KEY (instructor_id) REFERENCES Instructor(instructor_id)
);

-- Create the Users table
CREATE TABLE Users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    password VARCHAR(250) NOT NULL
);

-- Create the DanceClass table
CREATE TABLE DanceClass (
    class_id INT PRIMARY KEY AUTO_INCREMENT,
    class_name VARCHAR(50) NOT NULL,
    schedule DATETIME NOT NULL,
    duration INT NOT NULL,
    instructor_id INT,
    location VARCHAR(100),
    FOREIGN KEY (instructor_id) REFERENCES Instructor(instructor_id)
);

-- Create the Booking table
CREATE TABLE Booking (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    class_id INT,
    bookingdate DATETIME,
    status VARCHAR(20),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (class_id) REFERENCES DanceClass(class_id)
);

-- Create the Roles table
CREATE TABLE Roles (
    role_id INT PRIMARY KEY AUTO_INCREMENT,
    role_description VARCHAR(50) NOT NULL,
    Role VARCHAR(20) NOT NULL
);

CREATE TABLE user_roles (
    user_id INT NOT NULL,
    role_id INT NOT NULL,
    PRIMARY KEY (user_id, role_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (role_id) REFERENCES Roles(role_id)
);

INSERT INTO bookingdb.Roles (role_id, role_description, Role) VALUES (1, 'Admin role', 'ADMIN');
INSERT INTO bookingdb.Roles (role_id, role_description, Role) VALUES (2, 'Employee role', 'EMPLOYEE');
INSERT INTO bookingdb.Roles (role_id, role_description, Role) VALUES (3, 'Customer role', 'CUSTOMER');


