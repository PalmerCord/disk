

use master;
go
DROP DATABASE IF EXISTS disk_inventorycp;
go
CREATE DATABASE disk_inventorycp;
go

--Add server user
IF SUSER_ID('diskUsercp') IS NULL
	CREATE LOGIN diskUsercp
	WITH PASSWORD = 'Pa$$w0rd', DEFAULT_DATABASE = disk_inventorycp;
use disk_inventorycp;
go

--Add db user
CREATE USER diskUsercp;
ALTER ROLE db_datareader
	ADD MEMBER diskUsercp;
go

--create lookup tables
CREATE TABLE disk_type (
	disk_type_id	INT NOT NULL IDENTITY PRIMARY KEY,
	description		VARCHAR(20) NOT NULL
);
CREATE TABLE genre (
	genre_id		INT NOT NULL IDENTITY PRIMARY KEY,
	description		VARCHAR(20) NOT NULL

);
CREATE TABLE status (
	status_id		INT NOT NULL IDENTITY PRIMARY KEY,
	description		VARCHAR(20) NOT NULL

);
CREATE TABLE borrower (
	borrower_id		INT NOT NULL IDENTITY PRIMARY KEY,
	fname			NVARCHAR(60) NOT NULL,
	lname			NVARCHAR(60) NOT NULL,
	phone_num		VARCHAR(15)  NOT NULL
);
CREATE TABLE disk (
	disk_id		INT NOT NULL IDENTITY PRIMARY KEY,
	disk_name		NVARCHAR(60) NOT NULL,
	release_date	DATE NOT NULL,
	genre_id		INT NOT NULL REFERENCES genre(genre_id),
	status_id		INT NOT NULL REFERENCES status(status_id),
	disk_type_id	INT NOT NULL REFERENCES disk_type(disk_type_id)
	
);
CREATE TABLE disk_has_borrower (
	disk_has_borrower_id	INT NOT NULL IDENTITY PRIMARY KEY,
	borrower_id			INT NOT NULL REFERENCES borrower(borrower_id),
	disk_id			INT NOT NULL REFERENCES disk(disk_id),
	borrowed_date		DATETIME2 NOT NULL,
	returned_date		DATETIME2 NULL
);
















