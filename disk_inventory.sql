/********************************************************************
* Date		Programmer		Description
*---------- --------------- -----------------------------------------
*2/28/2022  CPalmer		Initial implementation of disk db.
 3/2/2022	CPalmer		Added insert statements to populate db.
 3/11/2022	CPalmer		Inserted Data
*
********************************************************************/

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
-- grant read-all to new user alter db_datareader & add your user

DROP USER IF EXISTS diskUsercp;
CREATE USER diskUsercp;
ALTER ROLE db_datareader
	ADD MEMBER diskUsercp;
go

--create lookup tables
CREATE TABLE artist_type
	(
	artist_type_id			INT NOT NULL PRIMARY KEY IDENTITY,
	description				VARCHAR(40) NOT NULL
	);
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
CREATE TABLE artist
	(
	artist_id			INT NOT NULL PRIMARY KEY IDENTITY,
	fname				NVARCHAR(60) NOT NULL,
	lname				NVARCHAR(60) NULL,
	artist_type_id		INT NOT NULL REFERENCES artist_type(artist_type_id)
	);
	-- table relationships
CREATE TABLE disk_has_borrower (
	disk_has_borrower_id	INT NOT NULL IDENTITY PRIMARY KEY,
	borrower_id			INT NOT NULL REFERENCES borrower(borrower_id),
	disk_id			INT NOT NULL REFERENCES disk(disk_id),
	borrowed_date		DATETIME2 NOT NULL,
	returned_date		DATETIME2 NULL
);

CREATE TABLE disk_has_artist
	(
	disk_has_artist_id	INT NOT NULL PRIMARY KEY IDENTITY,
	disk_id				INT NOT NULL REFERENCES disk(disk_id),
	artist_id			INT NOT NULL REFERENCES artist(artist_id)
	UNIQUE (disk_id, artist_id)
	);

INSERT INTO artist_type (description)
VALUES
	('Solo'),
	('Group'),
	('Fake');

INSERT INTO disk_type (description)
VALUES
	('Floppy'),
	('USB'),
	('SD'),
	('Mico-SD'),
	('MP3'),
	('.WAV');

INSERT INTO genre (description) 
VALUES
	('Wave'),
	('Funk'),
	('Techno'),
	('West Coast Bass'),
	('Freeform'),
	('House'),
	('Drum n Bass');
	
INSERT INTO status (description) 
VALUES
	('Available'),
	('On loan'),
	('Damaged'),
	('Missing'),
	('Who Knows');


INSERT INTO Disk
	(disk_name, release_date, genre_id, status_id, disk_type_id)
VALUES
	('Happy Train', '1/1/1995', 1, 1, 1)
	,('Rainbow Brain', '10/1/2021', 2, 2, 5)
	,('Meticulous', '11/12/2021', 3, 3, 3)
	,('Vibrant', '12/18/1990', 7, 4, 1)
	,('Rudabegga', '12/11/1921', 2, 2, 2)
	,('Cool Beans', '5/12/2001', 3, 1, 3)
	,('Lame Beans', '6/18/1990', 7, 2, 6)
	,('Information-OverLoad', '7/1/2021', 2, 2, 6)
	,('Brain Fart', '8/12/2021', 3, 3, 3)
	,('IDK what I am DOING', '9/18/1990', 7, 4, 6)
	,('I love coding', '10/1/2021', 2, 2, 6)
	,('Have fun with a real job', '11/12/1989', 1, 3, 3)
	,('So much', '12/18/1996', 7, 4, 4)
	,('Dont forget the ....', '1/1/2007', 2, 2, 6)
	,('What happened?', '2/12/2009', 3, 3, 3)
	,('Who are you', '3/27/1990', 7, 4, 6)
	,('Why does it matter', '3/25/2021', 2, 2, 4)
	,('Creepy', '4/30/2021', 3, 3, 3)
	,('Mok w erryday', '12/18/1990', 7, 4, 1)
	,('Your BFF Jill', '12/18/1990', 1, 3, 1)
	,('Safety First', '12/18/1990', 1, 2, 1);


INSERT INTO borrower
(fname, lname, phone_num)
VALUES
('johnny', 'johnskins', '208-555-7891')
,('Shinjo', 'Left-hand', '265-547-222')
,('Crimchi', 'Forehead', '555-456-111')
,('Cracky', 'Lo Mein', '564-545-4454')
,('Trippy', 'Larry', '896-456-4421')
,('Funny', 'Smalls', '707-112-2255')
,('Pedro', 'TheFirst', '407-111-7891')
,('Jim', 'Kerry', '208-456-2252')
,('Uncle', 'Mike', '404-456-3333')
,('Yummys', 'FoodTruck', '808-456-1234')
,('Lazy', 'Toothache', '889-456-5265')
,('WhodemBe', 'Rafael', '123-456-4578')
,('Crikey', 'Mate', '556-456-4567')
,('Whistlin', 'Dixie', '665-456-8965')
,('Freddy', 'Fredrickson', '123-555-4444')
,('Betsy', 'Jo', '445-556-4125')
,('Jaimei', 'Rappaport', '123-456-5587')
,('Piper', 'Emory', '444-456-7896')
,('Kailey', 'Teirney', '555-456-4568')
,('J-rod', 'Ackerwack', '458-888-3215')
,('Cord', 'Palmer', '208-965-4389');

DELETE borrower
WHERE borrower_id = 20;

INSERT INTO Artist
	(fname, lname, artist_type_id)
VALUES
	('Apple', 'Johnstone', 1)
	,('Shooby', 'Trinkee', 2)
	,('Bimjy', 'GoGo', 1)
	,('Zip', 'Torn', 3)
	,('Eek', 'Fleek', 3)
	,('Momma', 'Jo', 2)
	,('Susy', 'Q', 1)
	,('Pipperoni', 'Queenboss', 2)
	,('Katu', 'KittyKat', 3)
	,('Slushi', 'TheCat', 1)
	,('Haze', 'Dog', 1)
	,('Vella', 'GLady', 3)
	,('Trixy', 'TheotherDog', 2)
	,('Mustard', 'Potato', 1)
	,('Kimchi', 'Breath', 2)
	,('Paella', 'Seafood', 3)
	,('Me', 'NotYou', 2)
	,('Youyou', 'NotMe', 1)
	,('lala', 'geronimo', 1)
	,('SWIM', 'Also', 1);

	SELECT * FROM DISK

INSERT INTO disk_has_borrower
	(borrower_id, disk_id, borrowed_date, returned_date)
VALUES
	(1, 1, '1-2-2021', '1-3-2021')
	,(2, 5, '2-16-2021', '2-17-2021')
	,(3, 6, '12-22-2021', '12-25-2021')
	,(4, 7, '1-2-2021', '1-3-2021')
	,(4, 4, '3-4-2021', '3-5-2021')
	,(5, 5, '7-7-2021', '7-15-2021')
	,(5, 6, '8-2-2021', '8-15-2021')
	,(6, 7, '8-16-2021', '8-17-2021')
	,(7, 8, '8-23-2021', '8-27-2021')
	,(8, 2, '9-1-2021', '9-2-2021')
	,(9, 3, '9-24-2021', '9-25-2021')
	,(10, 14, '9-8-2021', '9-9-2021')
	,(11, 13, '10-2-2021', NULL)
	,(12, 15, '4-5-2021', '5-5-2021')
	,(13, 15, '5-2-2021', '10-9-2021')
	,(14, 5, '1-2-2021', '2-15-2021')
	,(15, 1, '1-2-2021', '2-15-2021')
	,(16, 7, '1-2-2021', NULL)
	,(16, 9, '10-26-2021', NULL)
	,(3, 5, '12-26-2021', '12-27-2021');


	SELECT borrower_id as Borrower_id, disk_id as Disk_id, CAST (borrowed_date as date) as Borrowed_date, returned_date as Return_date
	FROM disk_has_borrower
	WHERE returned_date IS NULL

	-- Start P4
--1. Show all disks in your database, the type, & status. 
SELECT 'Disk Name' = disk_name, 'Release Date' = CONVERT(varchar, release_date, 101), 
	'Type' = disk_type.description, 'Genre' = genre.description,
	'Status' = status.description
FROM Disk
JOIN disk_type
	ON disk.disk_type_id = disk_type.disk_type_id 
JOIN genre
	ON disk.genre_id =  genre.genre_id
JOIN status
	ON disk.status_id = status.status_id
ORDER BY disk_name;

-- 2. Show all borrowed disks and who borrowed them.
SELECT 'Last' = lname, 'First' = fname, 'Disk Name' = disk_name, 
	'Borrowed Date' = CAST(borrowed_date AS date), 'Returned Date' = CAST(returned_date AS date)
FROM disk_has_borrower
JOIN borrower 
	ON disk_has_borrower.borrower_id = borrower.borrower_id
JOIN disk
	ON disk_has_borrower.disk_id = disk.disk_id
ORDER BY lname;

-- 3. Show the disks that have been borrowed more than once.
SELECT 'Disk Name' = disk_name, 'Times Borrowed' = COUNT(*)
FROM disk_has_borrower
JOIN disk
	ON disk_has_borrower.disk_id = disk.disk_id
GROUP BY disk_name
HAVING COUNT (*) > 1
ORDER BY disk_name

-- 4. Show the disks outstanding or on-loan and who took each disk.
SELECT 'Disk Name' = disk_name, 'Borrowed' = CAST(borrowed_date AS date), 
	'Returned' = returned_date, 'Last Name' = lname, 'First Name' = fname
FROM disk
JOIN disk_has_borrower
	ON disk.disk_id = disk_has_borrower.disk_id
JOIN borrower
	ON borrower.borrower_id = disk_has_borrower.borrower_id
WHERE returned_date IS NULL
ORDER BY disk_name

GO

-- 5. Create a view called View_Borrower_No_Loans that shows the borrowers who have not borrowed a disk. Include the borrower id in the view definition but do not display the id in your output.
CREATE VIEW View_Borrower_No_Loans
AS
SELECT borrower_id, lname, fname
FROM borrower
WHERE borrower_id NOT IN
	(SELECT DISTINCT borrower_id
	FROM disk_has_borrower);
GO
SELECT 'Last Name' = lname, 'First Name' = fname
FROM View_Borrower_No_Loans
ORDER BY lname, fname;

-- 6. Show the borrowers who have borrowed more than 1 disk. Sample Output:
SELECT 'Last Name' = lname, 'First Name' = fname, 'Disks Borrowed' = COUNT(DISTINCT disk_id) 
FROM disk_has_borrower
JOIN borrower
	ON borrower.borrower_id = disk_has_borrower.borrower_id
GROUP BY lname, fname
HAVING COUNT(*) > 1
ORDER BY lname, fname








