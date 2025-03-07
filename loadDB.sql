CREATE DATABASE smallVilleDB;
\c smallvilledb

CREATE TABLE MaritalStatus (
    ID              char(1)        NOT NULL,
    Name			varchar(8)     NOT NULL UNIQUE,

  	PRIMARY KEY 	(ID)
);

CREATE TABLE District (
 	ID 				char(2)		    NOT NULL,
 	Name 			varchar(20) 	NOT NULL UNIQUE,

  	PRIMARY KEY 	(ID)
);

CREATE TABLE Household (
	ID 				Serial			NOT NULL,
	LotNumber		varchar(5)		NOT NULL UNIQUE,
  	Street 			varchar(20)		NOT NULL,
  	ZipCode 		char(5)			NOT NULL,
	HouseNumber 	varchar(5)		NOT NULL,
  	ApartmentNumber varchar(4),
 	DistrictID		char(2)			NOT NULL,

  	PRIMARY KEY 	(ID),
    FOREIGN KEY 	(DistrictID) REFERENCES District(ID)
		Deferrable Initially Deferred
);

CREATE TABLE Person (
  	ID 				Serial			NOT NULL,
	SSN				char(9)			NOT NULL UNIQUE,
  	MaritalStatusID char(1)			NOT NULL,
  	HouseholdID 	Serial			NOT NULL,
  	FirstName 		varchar(20)		NOT NULL,
  	LastName 		varchar(20)		NOT NULL,
  	Birthdate 		date			NOT NULL,
  	Email 			varchar(80),
  	Phone 			varchar(10),

  	PRIMARY KEY 	(ID),
    FOREIGN KEY 	(MaritalStatusID) REFERENCES MaritalStatus(ID)
		Deferrable Initially Deferred,
    FOREIGN KEY 	(HouseholdID) REFERENCES Household(ID)
		Deferrable Initially Deferred
);

CREATE TABLE TaxRecord (
  	ID 				Serial			NOT NULL,
  	PersonID 		Serial			NOT NULL,
  	Year 			Integer			NOT NULL,
  	NumOfDependents Integer			NOT NULL,
 	TaxesPaid 		Decimal(15,2)	NOT NULL,

  	PRIMARY KEY 	(ID),
    FOREIGN KEY 	(PersonID) REFERENCES Person(ID)
		Deferrable Initially Deferred
);

CREATE TABLE PropertyType (
  	ID 				char(1)			NOT NULL,
  	Name 			varchar(20)		NOT NULL UNIQUE,
	TaxPercentage	Decimal(4,2)	NOT NULL,

  	PRIMARY KEY (ID)
);

CREATE TABLE PersonalProperty (
  	ID 				Serial			NOT NULL,
  	PropertyTypeID 	char(1)			NOT NULL,
 	Description 	varchar(50)		NOT NULL,
 	PropertyValue 	Decimal(15,2)	NOT NULL,

  	PRIMARY KEY 	(ID),
    FOREIGN KEY 	(PropertyTypeID) REFERENCES PropertyType(ID)
		Deferrable Initially Deferred
);

CREATE TABLE Business (
  	ID				Serial			NOT NULL,
  	Name 			varchar(80) 	NOT NULL UNIQUE,
  	Email 			varchar(80),
  	Phone 			char(10),
 	Street 			varchar(20)		NOT NULL,
 	ZipCode			char(5)			NOT NULL,
  	BuildingNumber 	varchar(5)		NOT NULL,

  	PRIMARY KEY 	(ID)
);

CREATE TABLE Quarter (
  	ID 				char(2)			NOT NULL,

  	PRIMARY KEY 	(ID)
);

CREATE TABLE BusinessRecord (
  	BusinessID 		Serial			NOT NULL,
  	Revenue 		Decimal(15,2)	NOT NULL,
  	Expenses 		Decimal(15,2)	NOT NULL,
  	Profit 			Decimal(15,2)	NOT NULL,
  	TaxesPaid 		Decimal(15,2)	NOT NULL,
  	PropertyTaxes	Decimal(15,2)	NOT NULL,
  	Year 			Integer			NOT NULL,
  	QuarterID 		Char(2)			NOT NULL,

  	PRIMARY KEY 	(BusinessID, QuarterID, Year),
    FOREIGN KEY		(BusinessID) REFERENCES Business(ID)
		Deferrable Initially Deferred,
    FOREIGN KEY 	(QuarterID) REFERENCES Quarter(ID)
		Deferrable Initially Deferred
);

CREATE TABLE PersonalPropertyTax (
  	PropertyID 		Serial			NOT NULL,
  	OwnerID 		Serial			NOT NULL,

	PRIMARY KEY		(PropertyID, OwnerID),
    FOREIGN KEY 	(OwnerID) REFERENCES Person(ID)
		Deferrable Initially Deferred,
    FOREIGN KEY 	(PropertyID) REFERENCES PersonalProperty(ID)
		Deferrable Initially Deferred
);

CREATE TABLE Employee (
  	PersonID 		Serial			NOT NULL,
  	BusinessID 		Serial			NOT NULL,
 	Income 			Decimal(15,2)	NOT NULL,

  	PRIMARY KEY 	(PersonID, BusinessID),
    FOREIGN KEY 	(PersonID) REFERENCES Person(ID)
		Deferrable Initially Deferred,
    FOREIGN KEY 	(BusinessID)REFERENCES Business(ID)
		Deferrable Initially Deferred
);

ALTER SEQUENCE Household_id_seq RESTART WITH 1;
ALTER SEQUENCE Person_id_seq RESTART WITH 1;

BEGIN;

INSERT INTO MaritalStatus (ID, Name)
VALUES
	('S', 'Single'),
	('M', 'Married'),
	('D', 'Divorced'),
	('W', 'Widowed');

INSERT INTO District (ID, Name)
VALUES
	('AA', 'Ashford Acres'),
	('BB', 'Brookfield Bay'),
	('CC', 'Cedar Creek'),
	('DH', 'Dover Heights'),
	('EP', 'Elmwood Park'),
	('FR', 'Fairview Ridge'),
	('GS', 'Greenwood South'),
	('HH', 'Harrison Hill'),
	('IC', 'Ironwood Crossing'),
	('JP', 'Jefferson Park'),
	('KE', 'Kingsbrook Estate'),
	('LS', 'Lakewood Shores'),
	('MV', 'Maple Valley'),
	('NG', 'Northfield Glen'),
	('OH', 'Oakridge Hills'),
	('PD', 'Pineview District'),
	('QR', 'Quarry Ridge'),
	('RV', 'Riverstone Valley'),
	('SP', 'Summit Park'),
	('TE', 'Timberline Edge'),
	('UT', 'Upper Town'),
	('VP', 'Viewcrest Port'),
	('WD', 'Waterwood District'),
	('XA', 'Xenon Acres'),
	('YT', 'Yorkwood Corner'),
	('ZP', 'Zalem Park');

INSERT INTO Household (Street, ZipCode, HouseNumber, 
    ApartmentNumber, DistrictID)
VALUES
    ('Crescent View', '10001', 101, 1, 'AA'),
    ('Silverbrook Ln', '10002', 202, 2, 'BB'),
    ('Sunset Blvd', '10003', 303, 1, 'CC'),
    ('Riverside Dr', '10004', 404, 3, 'DH'),
    ('Lakeshore Ave', '10005', 505, 4, 'EP'),
    ('Granite Hill Rd', '10006', 606, 1, 'FR'),
    ('Wildflower Ln', '10007', 707, NULL, 'GS'),
    ('Brookstone Rd', '10008', 808, 2, 'HH'),
    ('Redwood St', '10009', 909, NULL, 'IC'),
    ('Chestnut Hill', '10010', 1010, 2, 'JP'),
    ('Riverbend Dr', '10011', 1111, 1, 'KE'),
    ('Pinehurst Ln', '10012', 1212, NULL, 'LS'),
    ('Westfield Dr', '10013', 1313, 3, 'MV'),
    ('Seabreeze Cir', '10014', 1414, 1, 'NG'),
    ('Whispering Oaks', '10015', 1515, NULL, 'OH'),
    ('Sapphire Way', '10016', 1616, 3, 'PD'),
    ('Meadowbrook Cir', '10017', 1717, 2, 'QR'),
    ('Lakeside Blvd', '10018', 1818, 4, 'RV'),
    ('Highland Crest', '10019', 1919, 1, 'SP'),
    ('Cedarwood Ter', '10020', 2020, NULL, 'TE'),
    ('Hilltop Ave', '10021', 2121, NULL, 'UT'),
    ('Maplewood Dr', '10022', 2222, NULL, 'VP'),
    ('Oak Hollow Way', '10023', 2323, NULL, 'WD'),
    ('Golden Gate Pkwy', '10024', 2424, 1, 'XA'),
    ('Cedar Ridge Loop', '10025', 2525, NULL, 'YT'),
    ('Birchwood Park', '10026', 2626, NULL, 'ZP'),
    ('Holly Ridge Rd', '10027', 2727, 1, 'AA'),
    ('Stonegate Rd', '10028', 2828, 2, 'BB'),
    ('Riverstone Rd', '10029', 2929, NULL, 'CC'),
    ('Meadowdale Dr', '10030', 3030, 1, 'DH'),
    ('Ashwood Ln', '10031', 3131, NULL, 'EP'),
    ('Willowbrook Rd', '10032', 3232, NULL, 'FR'),
    ('Fox Hollow Rd', '10033', 3333, 2, 'GS'),
    ('Sunridge Ave', '10034', 3434, NULL, 'HH'),
    ('Creekside Ln', '10035', 3535, NULL, 'IC'),
    ('Sequoia Rd', '10036', 3636, NULL, 'JP'),
    ('Violet Dr', '10037', 3737, 3, 'KE'),
    ('Goldenwood Ln', '10038', 3838, NULL, 'LS'),
    ('Pinehill Rd', '10039', 3939, NULL, 'MV'),
    ('Falcon Ridge Rd', '10040', 4040, 1, 'NG'),
    ('Timberline Dr', '10041', 4141, NULL, 'OH'),
    ('Riverbend Ave', '10042', 4242, 2, 'PD'),
    ('Morningstar Ln', '10043', 4343, NULL, 'QR'),
    ('Echo Valley Rd', '10044', 4444, 1, 'RV'),
    ('Sunset Ridge', '10045', 4545, NULL, 'SP'),
    ('Whispering Pines', '10046', 4646, 2, 'TE'),
    ('Silverstone Rd', '10047', 4747, NULL, 'UT'),
    ('Bluebird Ln', '10048', 4848, 1, 'VP'),
    ('Oakridge Ave', '10049', 4949, NULL, 'WD'),
    ('Maple Ridge Rd', '10050', 5050, NULL, 'XA'),
    ('Red Rock Cir', '10051', 5151, 1, 'YT'),
    ('Clearwater Dr', '10052', 5252, NULL, 'ZP'),
    ('Canyon View Rd', '10053', 5353, NULL, 'AA'),
    ('Sunnybrook Rd', '10054', 5454, NULL, 'BB'),
    ('Brookside Dr', '10055', 5555, 2, 'CC'),
    ('Cottonwood Dr', '10056', 5656, NULL, 'DH'),
    ('Briarwood Ln', '10057', 5757, 1, 'EP'),
    ('Windmill Rd', '10058', 5858, NULL, 'FR'),
    ('Autumn Ridge Rd', '10059', 5959, NULL, 'GS'),
    ('Silver Creek Rd', '10060', 6060, 3, 'HH'),
    ('Lynnwood Ave', '10061', 6161, NULL, 'IC'),
    ('Hawthorn St', '10062', 6262, 1, 'JP'),
    ('Sunflower Ln', '10063', 6363, 2, 'KE'),
    ('Cedar Valley Rd', '10064', 6464, NULL, 'LS'),
    ('Blue Ridge Rd', '10065', 6565, NULL, 'MV'),
    ('Pinebrook Dr', '10066', 6666, NULL, 'NG'),
    ('Mountain View Rd', '10067', 6767, 1, 'OH'),
    ('Valleywood Rd', '10068', 6868, 2, 'PD'),
    ('Wildwood Dr', '10069', 6969, 1, 'QR'),
    ('Springhill Dr', '10070', 7070, NULL, 'RV'),
    ('Redwood Grove Rd', '10071', 7171, NULL, 'SP'),
    ('Lakeshore Pkwy', '10072', 7272, 3, 'TE'),
    ('Cedar Springs Rd', '10073', 7373, NULL, 'UT'),
    ('Evergreen Rd', '10074', 7474, NULL, 'VP'),
    ('Shady Brook Ln', '10075', 7575, NULL, 'WD'),
    ('Shadow Ridge Rd', '10076', 7676, 2, 'XA'),
    ('Hummingbird Ln', '10077', 7777, NULL, 'YT'),
    ('Silver Maple Rd', '10078', 7878, 1, 'ZP'),
    ('Kingfisher Rd', '10079', 7979, NULL, 'AA'),
    ('Sunshine Blvd', '10080', 8080, 2, 'BB'),
    ('Meadowview Rd', '10081', 8181, NULL, 'CC'),
    ('Turtle Creek Rd', '10082', 8282, NULL, 'DH'),
    ('Mountain Brook Ln', '10083', 8383, 1, 'EP'),
    ('Birch Hill Rd', '10084', 8484, 2, 'FR'),
    ('Cloud Ridge Rd', '10085', 8585, NULL, 'GS');

INSERT INTO Person (MaritalStatusID, HouseholdID, FirstName, LastName, Birthdate, Email, Phone)
VALUES
-- Single‑occupant households
	('S',  1, 'John',      'Doe',         '1980-03-15', 'john.doe@example.com',       '555-010-0001'),
	('S',  2, 'Mary',      'Smith',       '1975-07-22', 'mary.smith@example.com',     '555-010-0002'),
	('S',  3, 'Robert',    'Johnson',     '1990-11-05', 'robert.johnson@example.com', '555-010-0003'),
	('S',  4, 'Patricia',  'Brown',       '1985-01-10', 'patricia.brown@example.com', '555-010-0004'),
	('S',  5, 'Michael',   'Davis',       '1965-09-30', 'michael.davis@example.com',  '555-010-0005'),
	('D',  6, 'Linda',     'Miller',      '1978-12-17', 'linda.miller@example.com',   '555-010-0006'),
	('D',  7, 'William',   'Wilson',      '1982-06-03', 'william.wilson@example.com', '555-010-0007'),
	('D',  8, 'Elizabeth', 'Moore',       '1995-04-12', 'elizabeth.moore@example.com','555-010-0008'),
	('D',  9, 'David',     'Taylor',      '1972-08-25', 'david.taylor@example.com',   '555-010-0009'),
	('D', 10, 'Barbara',   'Anderson',    '1988-02-14', 'barbara.anderson@example.com','555-010-0010'),
	('D', 11, 'Richard',   'Thomas',      '1968-10-01', 'richard.thomas@example.com', '555-010-0011'),
	('D', 12, 'Jennifer',  'Jackson',     '1992-05-07', 'jennifer.jackson@example.com','555-010-0012'),
	('D', 13, 'Charles',   'White',       '1979-03-30', 'charles.white@example.com',  '555-010-0013'),
	('D', 14, 'Susan',     'Harris',      '1983-11-19', 'susan.harris@example.com',   '555-010-0014'),
	('D', 15, 'Joseph',    'Martin',      '1980-08-08', 'joseph.martin@example.com',  '555-010-0015'),
	('W', 16, 'Christopher','Thompson',   '1976-04-10', 'christopher.thompson@example.com','555-010-0016'),
	('W', 17, 'Karen',     'Garcia',      '1981-07-20', 'karen.garcia@example.com',   '555-010-0017'),
	('W', 18, 'Steven',    'Martinez',    '1977-05-12', 'steven.martinez@example.com', '555-010-0018'),
	('W', 19, 'Donna',     'Robinson',    '1982-09-09', 'donna.robinson@example.com', '555-010-0019'),
	('W', 20, 'Paul',      'Clark',       '1979-12-25', 'paul.clark@example.com',     '555-010-0020'),

-- Households with 2 persons each
	('S', 21, 'Matthew', 'Brown',   '1970-05-15', 'matthew.brown@example.com', '555-010-0021'),
	('S', 21, 'Emily',   'Brown',   '1972-06-20', 'emily.brown@example.com',   '555-010-0022'),
	('S', 22, 'Daniel',  'Miller',  '1969-03-22', 'daniel.miller@example.com', '555-010-0023'),
	('S', 22, 'Olivia',  'Brown',  '1971-07-11', 'olivia.miller@example.com', '555-010-0024'),
	('S', 23, 'Andrew',  'Wilson',  '1975-08-30', 'andrew.wilson@example.com', '555-010-0025'),
	('S', 23, 'Sophia',  'Payne',  '1977-09-10', 'sophia.wilson@example.com', '555-010-0026'),
	('S', 24, 'Anthony', 'Moore',   '1974-04-12', 'anthony.moore@example.com', '555-010-0027'),
	('S', 24, 'Laura',   'Swift',   '1976-05-13', 'laura.moore@example.com',   '555-010-0028'),
	('S', 25, 'Mark',    'Taylor',  '1978-03-03', 'mark.taylor@example.com',   '555-010-0029'),
	('S', 25, 'Deborah', 'Smith',  '1980-04-04', 'deborah.taylor@example.com','555-010-0030'),
	('S', 26, 'Paul',    'Anderson','1972-06-06', 'paul.anderson@example.com', '555-010-0031'),
	('S', 26, 'Cynthia', 'James','1974-07-07', 'cynthia.anderson@example.com','555-010-0032'),
	('S', 27, 'Steven',  'Thomas',  '1973-07-08', 'steven.thomas@example.com', '555-010-0033'),
	('S', 27, 'Angela',  'Culveski',  '1975-08-09', 'angela.thomas@example.com', '555-010-0034'),
	('S', 28, 'Kevin',   'Jackson','1976-09-10', 'kevin.jackson@example.com', '555-010-0035'),
	('S', 28, 'Melissa', 'Miles','1978-10-11', 'melissa.jackson@example.com','555-010-0036'),
	('S', 29, 'Brian',   'White',  '1970-11-12', 'brian.white@example.com',   '555-010-0037'),
	('S', 29, 'Patricia','Coleman',  '1972-12-13', 'patricia.white@example.com','555-010-0038'),
	('M', 30, 'George',  'Harris', '1975-01-14', 'george.harris@example.com', '555-010-0039'),
	('M', 30, 'Sharon',  'Harris', '1977-02-15', 'sharon.harris@example.com', '555-010-0040'),
	('M', 31, 'Frank',   'Martin', '1978-03-16', 'frank.martin@example.com',  '555-010-0041'),
	('M', 31, 'Diana',   'Martin', '1980-04-17', 'diana.martin@example.com',  '555-010-0042'),
	('M', 32, 'Patrick', 'Thompson','1972-05-18','patrick.thompson@example.com','555-010-0043'),
	('M', 32, 'Nancy',   'Thompson','1974-06-19','nancy.thompson@example.com',  '555-010-0044'),
	('M', 33, 'Scott',   'Garcia', '1971-07-20', 'scott.garcia@example.com',    '555-010-0045'),
	('M', 33, 'Kimberly','Garcia', '1973-08-21', 'kimberly.garcia@example.com', '555-010-0046'),
	('M', 34, 'Eric',    'Martinez','1979-09-22', 'eric.martinez@example.com',   '555-010-0047'),
	('M', 34, 'Laura',   'Martinez','1981-10-23', 'laura.martinez@example.com',  '555-010-0048'),
	('M', 35, 'Larry',   'Robinson','1976-11-24', 'larry.robinson@example.com',  '555-010-0049'),
	('M', 35, 'Betty',   'Robinson','1978-12-25', 'betty.robinson@example.com',  '555-010-0050'),
	('M', 36, 'Raymond', 'Clark',  '1975-02-26', 'raymond.clark@example.com',   '555-010-0051'),
	('M', 36, 'Gloria',  'Clark',  '1977-03-27', 'gloria.clark@example.com',    '555-010-0052'),
	('M', 37, 'Jerry',   'Lewis',  '1974-04-28', 'jerry.lewis@example.com',     '555-010-0053'),
	('M', 37, 'Carol',   'Lewis',  '1976-05-29', 'carol.lewis@example.com',     '555-010-0054'),
	('M', 38, 'Walter',  'Lee',    '1973-07-30', 'walter.lee@example.com',      '555-010-0055'),
	('M', 38, 'Susan',   'Lee',    '1975-08-31', 'susan.lee@example.com',       '555-010-0056'),
	('M', 39, 'Patrick', 'Walker', '1972-10-01', 'patrick.walker@example.com',  '555-010-0057'),
	('M', 39, 'Linda',   'Walker', '1974-11-02', 'linda.walker@example.com',    '555-010-0058'),
	('M', 40, 'Dennis',  'Hall',   '1970-12-03', 'dennis.hall@example.com',     '555-010-0059'),
	('M', 40, 'Catherine','Hall',  '1972-01-04', 'catherine.hall@example.com',  '555-010-0060'),
	('M', 41, 'Douglas', 'Allen',  '1978-02-05', 'douglas.allen@example.com',   '555-010-0061'),
	('M', 41, 'Angela',  'Allen',  '1980-03-06', 'angela.allen@example.com',    '555-010-0062'),
	('M', 42, 'Arthur',  'Young',  '1975-04-07', 'arthur.young@example.com',    '555-010-0063'),
	('M', 42, 'Brenda',  'Young',  '1977-05-08', 'brenda.young@example.com',    '555-010-0064'),
	('M', 43, 'Henry',   'Hernandez','1976-06-09','henry.hernandez@example.com', '555-010-0065'),
	('M', 43, 'Sandra',  'Hernandez','1978-07-10','sandra.hernandez@example.com', '555-010-0066'),
	('M', 44, 'Carl',    'King',   '1977-08-11', 'carl.king@example.com',       '555-010-0067'),
	('M', 44, 'Donna',   'King',   '1979-09-12', 'donna.king@example.com',      '555-010-0068'),
	('M', 45, 'Roger',   'Wright', '1978-10-13', 'roger.wright@example.com',    '555-010-0069'),
	('M', 45, 'Pamela',  'Wright', '1980-11-14', 'pamela.wright@example.com',   '555-010-0070'),
	('M', 46, 'Joe',     'Lopez',  '1974-12-15', 'joe.lopez@example.com',       '555-010-0071'),
	('M', 46, 'Debbie',  'Lopez',  '1976-01-16', 'debbie.lopez@example.com',    '555-010-0072'),
	('M', 47, 'Tony',    'Hill',   '1973-03-17', 'tony.hill@example.com',       '555-010-0073'),
	('M', 47, 'Alice',   'Hill',   '1975-04-18', 'alice.hill@example.com',      '555-010-0074'),
	('M', 48, 'Alan',    'Scott',  '1972-05-19', 'alan.scott@example.com',      '555-010-0075'),
	('M', 48, 'Brenda',  'Scott',  '1974-06-20', 'brenda.scott@example.com',    '555-010-0076'),
	('M', 49, 'Carl',    'Green',  '1971-07-21', 'carl.green@example.com',      '555-010-0077'),
	('M', 49, 'Martha',  'Green',  '1973-08-22', 'martha.green@example.com',    '555-010-0078'),
	('M', 50, 'Victor',  'Adams',  '1970-09-23', 'victor.adams@example.com',    '555-010-0079'),
	('M', 50, 'Stephanie','Adams', '1972-10-24', 'stephanie.adams@example.com', '555-010-0080'),

-- Households with 3 persons each
	('M', 51, 'Henry',   'Carter',  '1980-04-12', 'henry.carter@example.com',  '555-010-0081'),
	('M', 51, 'Laura',   'Carter',  '1982-05-16', 'laura.carter@example.com',  '555-010-0082'),
	('S', 51, 'Sophia',  'Carter',  '2018-07-20', NULL,                        NULL),
	('M', 52, 'Patrick', 'Roberts', '1979-03-22', 'patrick.roberts@example.com','555-010-0083'),
	('M', 52, 'Diana',   'Roberts', '1981-06-30', 'diana.roberts@example.com', '555-010-0084'),
	('S', 52, 'Ethan',   'Roberts', '2017-11-05', NULL,                        NULL),
	('M', 53, 'Stephen', 'Turner',  '1980-08-14', 'stephen.turner@example.com','555-010-0085'),
	('M', 53, 'Rachel',  'Turner',  '1982-09-18', 'rachel.turner@example.com', '555-010-0086'),
	('S', 53, 'Oliver',  'Turner',  '2018-10-20', NULL,                        NULL),
	('M', 54, 'Mark',    'Parker',  '1978-12-25', 'mark.parker@example.com',   '555-010-0087'),
	('M', 54, 'Linda',   'Parker',  '1980-03-03', 'linda.parker@example.com',  '555-010-0088'),
	('S', 54, 'Chloe',   'Parker',  '2017-04-04', NULL,                        NULL),
	('M', 55, 'George',  'Evans',   '1977-05-05', 'george.evans@example.com',  '555-010-0089'),
	('M', 55, 'Karen',   'Evans',   '1979-06-06', 'karen.evans@example.com',   '555-010-0090'),
	('S', 55, 'Mia',     'Evans',   '2016-07-07', NULL,                        NULL),
	('M', 56, 'Brian',   'Collins', '1981-07-07', 'brian.collins@example.com', '555-010-0091'),
	('M', 56, 'Angela',  'Collins', '1983-08-08', 'angela.collins@example.com','555-010-0092'),
	('S', 56, 'Isabella','Collins', '2015-09-09', NULL,                        NULL),
	('M', 57, 'Frank',   'Stewart', '1982-01-20', 'frank.stewart@example.com', '555-010-0093'),
	('M', 57, 'Laura',   'Stewart', '1984-02-21', 'laura.stewart@example.com', '555-010-0094'),
	('S', 57, 'Ava',     'Stewart', '2017-03-22', NULL,                        NULL),
	('M', 58, 'Kevin',   'Morris',  '1979-11-11', 'kevin.morris@example.com',  '555-010-0095'),
	('M', 58, 'Susan',   'Morris',  '1981-12-12', 'susan.morris@example.com',  '555-010-0096'),
	('S', 58, 'Ella',    'Morris',  '2015-01-13', NULL,                        NULL),
	('M', 59, 'Ronald',  'Reed',    '1980-02-14', 'ronald.reed@example.com',   '555-010-0097'),
	('M', 59, 'Patricia','Reed',    '1982-03-15', 'patricia.reed@example.com', '555-010-0098'),
	('S', 59, 'Charlotte','Reed',   '2016-04-16', NULL,                        NULL),
	('M', 60, 'Jeffrey', 'Cook',    '1981-04-17', 'jeffrey.cook@example.com',  '555-010-0099'),
	('M', 60, 'Deborah', 'Cook',    '1983-05-18', 'deborah.cook@example.com',  '555-010-0100'),
	('S', 60, 'Amelia',  'Cook',    '2017-06-19', NULL,                        NULL),
	('M', 61, 'Samuel',  'Morgan',  '1982-07-20', 'samuel.morgan@example.com', '555-010-0101'),
	('M', 61, 'Laura',   'Morgan',  '1984-08-21', 'laura.morgan@example.com',  '555-010-0102'),
	('S', 61, 'Harper',  'Morgan',  '2016-09-22', NULL,                        NULL),
	('M', 62, 'Patrick', 'Bell',    '1979-10-23', 'patrick.bell@example.com',  '555-010-0103'),
	('M', 62, 'Megan',   'Bell',    '1981-11-24', 'megan.bell@example.com',    '555-010-0104'),
	('S', 62, 'Abigail', 'Bell',    '2017-12-25', NULL,                        NULL),
	('M', 63, 'Douglas', 'Murphy',  '1980-01-02', 'douglas.murphy@example.com','555-010-0105'),
	('M', 63, 'Angela',  'Murphy',  '1982-02-03', 'angela.murphy@example.com', '555-010-0106'),
	('S', 63, 'Samantha','Murphy',  '2014-03-04', NULL,                        NULL),
	('M', 64, 'Robert',  'Bailey',  '1978-03-05', 'robert.bailey@example.com', '555-010-0107'),
	('M', 64, 'Catherine','Bailey', '1980-04-06', 'catherine.bailey@example.com','555-010-0108'),
	('S', 64, 'Victoria','Bailey',  '2015-05-07', NULL,                        NULL),
	('M', 65, 'Mark',    'Rivera',  '1981-05-08', 'mark.rivera@example.com',   '555-010-0109'),
	('M', 65, 'Susan',   'Rivera',  '1983-06-09', 'susan.rivera@example.com',   '555-010-0110'),
	('S', 65, 'Lily',    'Rivera',  '2017-07-10', NULL,                        NULL),
	('M', 66, 'Edward',  'Cooper',  '1980-06-11', 'edward.cooper@example.com', '555-010-0111'),
	('M', 66, 'Patricia','Cooper',  '1982-07-12', 'patricia.cooper@example.com','555-010-0112'),
	('S', 66, 'Zoe',     'Cooper',  '2013-08-13', NULL,                        NULL),
	('M', 67, 'Walter',  'Richardson','1979-07-14','walter.richardson@example.com','555-010-0113'),
	('M', 67, 'Nancy',   'Richardson','1981-08-15','nancy.richardson@example.com','555-010-0114'),
	('S', 67, 'Chloe',   'Richardson','2014-09-16', NULL,                        NULL),
	('M', 68, 'Dennis',  'Cox',     '1982-08-17', 'dennis.cox@example.com',    '555-010-0115'),
	('M', 68, 'Laura',   'Cox',     '1984-09-18', 'laura.cox@example.com',     '555-010-0116'),
	('S', 68, 'Avery',   'Cox',     '2015-10-19', NULL,                        NULL),
	('M', 69, 'Frank',   'Howard',  '1980-10-20', 'frank.howard@example.com',  '555-010-0117'),
	('M', 69, 'Sandra',  'Howard',  '1982-11-21', 'sandra.howard@example.com',  '555-010-0118'),
	('S', 69, 'Evelyn',  'Howard',  '2014-12-22', NULL,                        NULL),
	('M', 70, 'Larry',   'Ward',    '1979-12-23', 'larry.ward@example.com',    '555-010-0119'),
	('M', 70, 'Deborah', 'Ward',    '1981-01-24', 'deborah.ward@example.com',  '555-010-0120'),
	('S', 70, 'Grace',   'Ward',    '2017-02-25', NULL,                        NULL),

-- Households with 4 persons each
	('M', 71, 'Douglas', 'King',    '1975-03-15', 'douglas.king@example.com',  '555-010-0121'),
	('M', 71, 'Patricia','King',    '1977-04-16', 'patricia.king@example.com', '555-010-0122'),
	('S', 71, 'Emily',   'King',    '2009-05-17', 'emily.king@example.com',    NULL),
	('S', 71, 'Oliver',  'King',    '2018-06-18', NULL,                        NULL),
	('M', 72, 'Edward',  'Scott',   '1976-07-19', 'edward.scott@example.com',  '555-010-0123'),
	('M', 72, 'Cynthia', 'Scott',   '1978-08-20', 'cynthia.scott@example.com', '555-010-0124'),
	('S', 72, 'Megan',   'Scott',   '2008-09-21', 'megan.scott@example.com',   NULL),
	('S', 72, 'Liam',    'Scott',   '2017-10-22', NULL,                        NULL),
	('M', 73, 'Donald',  'Hernandez','1977-12-20','donald.hernandez@example.com','555-010-0125'),
	('M', 73, 'Shirley', 'Hernandez','1979-01-21','shirley.hernandez@example.com','555-010-0126'),
	('S', 73, 'Grace',   'Hernandez','2009-02-22','grace.hernandez@example.com', NULL),
	('S', 73, 'Lily',    'Hernandez','2018-03-23', NULL,                        NULL),
	('M', 74, 'Anthony', 'Murphy',  '1978-03-05', 'anthony.murphy@example.com', '555-010-0127'),
	('M', 74, 'Patricia','Murphy',  '1980-04-06', 'patricia.murphy@example.com', '555-010-0128'),
	('S', 74, 'Brian',   'Murphy',  '2008-05-07', 'brian.murphy@example.com',    NULL),
	('S', 74, 'Rebecca', 'Murphy',  '2017-06-08', NULL,                        NULL),
	('M', 75, 'Patrick', 'Adams',   '1977-07-10', 'patrick.adams@example.com', '555-010-0129'),
	('M', 75, 'Donna',   'Adams',   '1979-08-11', 'donna.adams@example.com',   '555-010-0130'),
	('S', 75, 'Samuel',  'Adams',   '2008-09-12', 'samuel.adams@example.com',  NULL),
	('S', 75, 'Emily',   'Adams',   '2017-10-13', NULL,                        NULL),
	('M', 76, 'Steven',  'Evans',   '1978-01-25', 'steven.evans@example.com',  '555-010-0131'),
	('M', 76, 'Rebecca', 'Evans',   '1980-02-26', 'rebecca.evans@example.com', '555-010-0132'),
	('S', 76, 'Ryan',    'Evans',   '2008-03-27', 'ryan.evans@example.com',    NULL),
	('S', 76, 'Nicole',  'Evans',   '2017-04-28', NULL,                        NULL),
	('M', 77, 'Gregory', 'Collins', '1978-03-29', 'gregory.collins@example.com', '555-010-0133'),
	('M', 77, 'Teresa',  'Collins', '1980-04-30', 'teresa.collins@example.com', '555-010-0134'),
	('S', 77, 'Carol',   'Collins', '2009-05-31', 'carol.collins@example.com',  NULL),
	('S', 77, 'Megan',   'Collins', '2018-06-01', NULL,                        NULL),
	('M', 78, 'Bruce',   'Scott',   '1977-05-02', 'bruce.scott@example.com',   '555-010-0135'),
	('M', 78, 'Linda',   'Scott',   '1979-06-03', 'linda.scott@example.com',   '555-010-0136'),
	('S', 78, 'Daniel',  'Scott',   '2008-07-04', 'daniel.scott@example.com',  NULL),
	('S', 78, 'Alice',   'Scott',   '2018-08-05', NULL,                        NULL),
	('M', 79, 'Mark',    'Roberts', '1978-07-06', 'mark.roberts@example.com',  '555-010-0137'),
	('M', 79, 'Susan',   'Roberts', '1980-08-07', 'susan.roberts@example.com',  '555-010-0138'),
	('S', 79, 'Victor',  'Roberts', '2008-09-08', 'victor.roberts@example.com',NULL),
	('S', 79, 'Stephanie','Roberts','2017-10-09', NULL,                        NULL),
	('M', 80, 'Joseph',  'Young',   '1977-09-10', 'joseph.young@example.com',  '555-010-0139'),
	('M', 80, 'Laura',   'Young',   '1979-10-11', 'laura.young@example.com',   '555-010-0140'),
	('S', 80, 'Daniel',  'Young',   '2008-11-12', 'daniel.young@example.com',  NULL),
	('S', 80, 'Emma',    'Young',   '2018-12-13', NULL,                        NULL),

-- Households with 5 persons each
	('M', 81, 'Anthony', 'Scott',   '1978-03-05', 'anthony.scott@example.com', '555-010-0141'),
	('M', 81, 'Patricia','Scott',   '1980-04-06', 'patricia.scott@example.com', '555-010-0142'),
	('S', 81, 'Brian',   'Scott',   '2008-05-07', 'brian.scott@example.com',   NULL),
	('S', 81, 'Rebecca', 'Scott',   '2012-06-08', 'rebecca.scott@example.com', NULL),
	('S', 81, 'Oliver',  'Scott',   '2017-07-09', NULL,                        NULL),
	('M', 82, 'Patrick', 'Murphy',  '1977-07-10', 'patrick.murphy@example.com', '555-010-0143'),
	('M', 82, 'Donna',   'Murphy',  '1979-08-11', 'donna.murphy@example.com',   '555-010-0144'),
	('S', 82, 'Samuel',  'Murphy',  '2008-09-12', 'samuel.murphy@example.com',  NULL),
	('S', 82, 'Emily',   'Murphy',  '2012-10-13', 'emily.murphy@example.com',   NULL),
	('S', 82, 'Chloe',   'Murphy',  '2017-11-14', NULL,                        NULL),
	('M', 83, 'Steven',  'Adams',   '1978-01-25', 'steven.adams@example.com',  '555-010-0145'),
	('M', 83, 'Rebecca', 'Adams',   '1980-02-26', 'rebecca.adams@example.com', '555-010-0146'),
	('S', 83, 'Ryan',    'Adams',   '2008-03-27', 'ryan.adams@example.com',    NULL),
	('S', 83, 'Nicole',  'Adams',   '2012-04-28', 'nicole.adams@example.com',  NULL),
	('S', 83, 'Sophie',  'Adams',   '2017-05-29', NULL,                        NULL),
	('M', 84, 'Michael', 'Brown',   '1977-11-30', 'michael.brown@example.com', '555-010-0147'),
	('M', 84, 'Laura',   'Brown',   '1979-12-31', 'laura.brown@example.com',   '555-010-0148'),
	('S', 84, 'David',   'Brown',   '2008-01-15', 'david.brown@example.com',   NULL),
	('S', 84, 'Sarah',   'Brown',   '2012-02-16', 'sarah.brown@example.com',   NULL),
	('S', 84, 'Emma',    'Brown',   '2017-03-17', NULL,                        NULL),
	('M', 85, 'Joseph',  'Davis',   '1978-06-20', 'joseph.davis@example.com',  '555-010-0149'),
	('M', 85, 'Patricia','Davis',   '1980-07-21', 'patricia.davis@example.com','555-010-0150'),
	('S', 85, 'Robert',  'Davis',   '2008-08-22', 'robert.davis@example.com',  NULL),
	('S', 85, 'Linda',   'Davis',   '2012-09-23', 'linda.davis@example.com',   NULL),
	('S', 85, 'Karen',   'Davis',   '2017-10-24', NULL,                        NULL);

COMMIT;