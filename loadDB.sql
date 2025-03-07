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

INSERT INTO Household (LotNumber, Street, ZipCode, HouseNumber, 
	ApartmentNumber, DistrictID)
VALUES
	('00001', 'Crescent View', '10001', '101', '1', 'AA'),
	('00002', 'Silverbrook Ln', '10002', '202', '2', 'BB'),
	('00003', 'Sunset Blvd', '10003', '303', '1', 'CC'),
	('00004', 'Riverside Dr', '10004', '404', '3', 'DH'),
	('00005', 'Lakeshore Ave', '10005', '505', '4', 'EP'),
	('00006', 'Granite Hill Rd', '10006', '606', '1', 'FR'),
	('00007', 'Wildflower Ln', '10007', '707', NULL, 'GS'),
	('00008', 'Brookstone Rd', '10008', '808', '2', 'HH'),
	('00009', 'Redwood St', '10009', '909', NULL, 'IC'),
	('00010', 'Chestnut Hill', '10010', '1010', '2', 'JP'),
	('00011', 'Riverbend Dr', '10011', '1111', '1', 'KE'),
	('00012', 'Pinehurst Ln', '10012', '1212', NULL, 'LS'),
	('00013', 'Westfield Dr', '10013', '1313', '3', 'MV'),
	('00014', 'Seabreeze Cir', '10014', '1414', '1', 'NG'),
	('00015', 'Whispering Oaks', '10015', '1515', NULL, 'OH'),
	('00016', 'Sapphire Way', '10016', '1616', '3', 'PD'),
	('00017', 'Meadowbrook Cir', '10017', '1717', '2', 'QR'),
	('00018', 'Lakeside Blvd', '10018', '1818', '4', 'RV'),
	('00019', 'Highland Crest', '10019', '1919', '1', 'SP'),
	('00020', 'Cedarwood Ter', '10020', '2020', NULL, 'TE'),
	('00021', 'Hilltop Ave', '10021', '2121', NULL, 'UT'),
	('00022', 'Maplewood Dr', '10022', '2222', NULL, 'VP'),
	('00023', 'Oak Hollow Way', '10023', '2323', NULL, 'WD'),
	('00024', 'Golden Gate Pkwy', '10024', '2424', '1', 'XA'),
	('00025', 'Cedar Ridge Loop', '10025', '2525', NULL, 'YT'),
	('00026', 'Birchwood Park', '10026', '2626', NULL, 'ZP'),
	('00027', 'Holly Ridge Rd', '10027', '2727', '1', 'AA'),
	('00028', 'Stonegate Rd', '10028', '2828', '2', 'BB'),
	('00029', 'Riverstone Rd', '10029', '2929', NULL, 'CC'),
	('00030', 'Meadowdale Dr', '10030', '3030', '1', 'DH'),
	('00031', 'Ashwood Ln', '10031', '3131', NULL, 'EP'),
	('00032', 'Willowbrook Rd', '10032', '3232', NULL, 'FR'),
	('00033', 'Fox Hollow Rd', '10033', '3333', '2', 'GS'),
	('00034', 'Sunridge Ave', '10034', '3434', NULL, 'HH'),
	('00035', 'Creekside Ln', '10035', '3535', NULL, 'IC'),
	('00036', 'Sequoia Rd', '10036', '3636', NULL, 'JP'),
	('00037', 'Violet Dr', '10037', '3737', '3', 'KE'),
	('00038', 'Goldenwood Ln', '10038', '3838', NULL, 'LS'),
	('00039', 'Pinehill Rd', '10039', '3939', NULL, 'MV'),
	('00040', 'Falcon Ridge Rd', '10040', '4040', '1', 'NG'),
	('00041', 'Timberline Dr', '10041', '4141', NULL, 'OH'),
	('00042', 'Riverbend Ave', '10042', '4242', '2', 'PD'),
	('00043', 'Morningstar Ln', '10043', '4343', NULL, 'QR'),
	('00044', 'Echo Valley Rd', '10044', '4444', '1', 'RV'),
	('00045', 'Sunset Ridge', '10045', '4545', NULL, 'SP'),
	('00046', 'Whispering Pines', '10046', '4646', '2', 'TE'),
	('00047', 'Silverstone Rd', '10047', '4747', NULL, 'UT'),
	('00048', 'Bluebird Ln', '10048', '4848', '1', 'VP'),
	('00049', 'Oakridge Ave', '10049', '4949', NULL, 'WD'),
	('00050', 'Maple Ridge Rd', '10050', '5050', NULL, 'XA'),
	('00051', 'Red Rock Cir', '10051', '5151', '1', 'YT'),
	('00052', 'Clearwater Dr', '10052', '5252', NULL, 'ZP'),
	('00053', 'Canyon View Rd', '10053', '5353', NULL, 'AA'),
	('00054', 'Sunnybrook Rd', '10054', '5454', NULL, 'BB'),
	('00055', 'Brookside Dr', '10055', '5555', '2', 'CC'),
	('00056', 'Cottonwood Dr', '10056', '5656', NULL, 'DH'),
	('00057', 'Briarwood Ln', '10057', '5757', '1', 'EP'),
	('00058', 'Windmill Rd', '10058', '5858', NULL, 'FR'),
	('00059', 'Autumn Ridge Rd', '10059', '5959', NULL, 'GS'),
	('00060', 'Silver Creek Rd', '10060', '6060', '3', 'HH'),
	('00061', 'Lynnwood Ave', '10061', '6161', NULL, 'IC'),
	('00062', 'Hawthorn St', '10062', '6262', '1', 'JP'),
	('00063', 'Sunflower Ln', '10063', '6363', '2', 'KE'),
	('00064', 'Cedar Valley Rd', '10064', '6464', NULL, 'LS'),
	('00065', 'Blue Ridge Rd', '10065', '6565', NULL, 'MV'),
	('00066', 'Pinebrook Dr', '10066', '6666', NULL, 'NG'),
	('00067', 'Mountain View Rd', '10067', '6767', '1', 'OH'),
	('00068', 'Valleywood Rd', '10068', '6868', '2', 'PD'),
	('00069', 'Wildwood Dr', '10069', '6969', '1', 'QR'),
	('00070', 'Springhill Dr', '10070', '7070', NULL, 'RV'),
	('00071', 'Redwood Grove Rd', '10071', '7171', NULL, 'SP'),
	('00072', 'Lakeshore Pkwy', '10072', '7272', '3', 'TE'),
	('00073', 'Cedar Springs Rd', '10073', '7373', NULL, 'UT'),
	('00074', 'Evergreen Rd', '10074', '7474', NULL, 'VP'),
	('00075', 'Shady Brook Ln', '10075', '7575', NULL, 'WD'),
	('00076', 'Shadow Ridge Rd', '10076', '7676', '2', 'XA'),
	('00077', 'Hummingbird Ln', '10077', '7777', NULL, 'YT'),
	('00078', 'Silver Maple Rd', '10078', '7878', '1', 'ZP'),
	('00079', 'Kingfisher Rd', '10079', '7979', NULL, 'AA'),
	('00080', 'Sunshine Blvd', '10080', '8080', '2', 'BB'),
	('00081', 'Meadowview Rd', '10081', '8181', NULL, 'CC'),
	('00082', 'Turtle Creek Rd', '10082', '8282', NULL, 'DH'),
	('00083', 'Mountain Brook Ln', '10083', '8383', '1', 'EP'),
	('00084', 'Birch Hill Rd', '10084', '8484', '2', 'FR'),
	('00085', 'Cloud Ridge Rd', '10085', '8585', NULL, 'GS');

INSERT INTO Person (SSN, MaritalStatusID, HouseholdID, FirstName, 
	LastName, Birthdate, Email, Phone)
VALUES
-- Households with one person each
	('000000001', 'S', 1, 'John',      'Doe',         '1980-03-15', 'john.doe@example.com',        '5550100001'),
	('000000002', 'S', 2, 'Mary',      'Smith',       '1975-07-22', 'mary.smith@example.com',      '5550100002'),
	('000000003', 'S', 3, 'Robert',    'Johnson',     '1990-11-05', 'robert.johnson@example.com',  '5550100003'),
	('000000004', 'S', 4, 'Patricia',  'Brown',       '1985-01-10', 'patricia.brown@example.com',  '5550100004'),
	('000000005', 'S', 5, 'Michael',   'Davis',       '1965-09-30', 'michael.davis@example.com',   '5550100005'),
	('000000006', 'D', 6, 'Linda',     'Miller',      '1978-12-17', 'linda.miller@example.com',    '5550100006'),
	('000000007', 'D', 7, 'William',   'Wilson',      '1982-06-03', 'william.wilson@example.com',  '5550100007'),
	('000000008', 'D', 8, 'Elizabeth', 'Moore',       '1995-04-12', 'elizabeth.moore@example.com', '5550100008'),
	('000000009', 'D', 9, 'David',     'Taylor',      '1972-08-25', 'david.taylor@example.com',    '5550100009'),
	('000000010', 'D', 10, 'Barbara',   'Anderson',    '1988-02-14', 'barbara.anderson@example.com','5550100010'),
	('000000011', 'D', 11, 'Richard',   'Thomas',      '1968-10-01', 'richard.thomas@example.com',  '5550100011'),
	('000000012', 'D', 12, 'Jennifer',  'Jackson',     '1992-05-07', 'jennifer.jackson@example.com','5550100012'),
	('000000013', 'D', 13, 'Charles',   'White',       '1979-03-30', 'charles.white@example.com',   '5550100013'),
	('000000014', 'D', 14, 'Susan',     'Harris',      '1983-11-19', 'susan.harris@example.com',    '5550100014'),
	('000000015', 'D', 15, 'Joseph',    'Martin',      '1980-08-08', 'joseph.martin@example.com',   '5550100015'),
	('000000016', 'W', 16, 'Christopher','Thompson',   '1976-04-10', 'christopher.thompson@example.com','5550100016'),
	('000000017', 'W', 17, 'Karen',     'Garcia',      '1981-07-20', 'karen.garcia@example.com',    '5550100017'),
	('000000018', 'W', 18, 'Steven',    'Martinez',    '1977-05-12', 'steven.martinez@example.com',  '5550100018'),
	('000000019', 'W', 19, 'Donna',     'Robinson',    '1982-09-09', 'donna.robinson@example.com',  '5550100019'),
	('000000020', 'W', 20, 'Paul',      'Clark',       '1979-12-25', 'paul.clark@example.com',      '5550100020'),

-- Households with 2 people each
	('000000021', 'S', 21, 'Matthew', 'Brown',   '1970-05-15', 'matthew.brown@example.com', '5550100021'),
	('000000022', 'S', 21, 'Emily',   'Brown',   '1972-06-20', 'emily.brown@example.com',   '5550100022'),
	('000000023', 'S', 22, 'Daniel',  'Miller',  '1969-03-22', 'daniel.miller@example.com', '5550100023'),
	('000000024', 'S', 22, 'Olivia',  'Brown',   '1971-07-11', 'olivia.miller@example.com', '5550100024'),
	('000000025', 'S', 23, 'Andrew',  'Wilson',  '1975-08-30', 'andrew.wilson@example.com', '5550100025'),
	('000000026', 'S', 23, 'Sophia',  'Payne',   '1977-09-10', 'sophia.wilson@example.com', '5550100026'),
	('000000027', 'S', 24, 'Anthony', 'Moore',   '1974-04-12', 'anthony.moore@example.com', '5550100027'),
	('000000028', 'S', 24, 'Laura',   'Swift',   '1976-05-13', 'laura.moore@example.com',   '5550100028'),
	('000000029', 'S', 25, 'Mark',    'Taylor',  '1978-03-03', 'mark.taylor@example.com',   '5550100029'),
	('000000030', 'S', 25, 'Deborah', 'Smith',   '1980-04-04', 'deborah.taylor@example.com','5550100030'),
	('000000031', 'S', 26, 'Paul',    'Anderson','1972-06-06', 'paul.anderson@example.com', '5550100031'),
	('000000032', 'S', 26, 'Cynthia', 'James',   '1974-07-07', 'cynthia.anderson@example.com','5550100032'),
	('000000033', 'S', 27, 'Steven',  'Thomas',  '1973-07-08', 'steven.thomas@example.com', '5550100033'),
	('000000034', 'S', 27, 'Angela',  'Culveski','1975-08-09', 'angela.thomas@example.com', '5550100034'),
	('000000035', 'S', 28, 'Kevin',   'Jackson', '1976-09-10', 'kevin.jackson@example.com', '5550100035'),
	('000000036', 'S', 28, 'Melissa', 'Miles',   '1978-10-11', 'melissa.jackson@example.com','5550100036'),
	('000000037', 'S', 29, 'Brian',   'White',   '1970-11-12', 'brian.white@example.com',   '5550100037'),
	('000000038', 'S', 29, 'Patricia','Coleman', '1972-12-13', 'patricia.white@example.com','5550100038'),
	('000000039', 'M', 30, 'George',  'Harris',  '1975-01-14', 'george.harris@example.com', '5550100039'),
	('000000040', 'M', 30, 'Sharon',  'Harris',  '1977-02-15', 'sharon.harris@example.com', '5550100040'),

-- Households with 3 people each
	('000000041', 'M', 51, 'Henry',   'Carter',  '1980-04-12', 'henry.carter@example.com',  '5550100081'),
	('000000042', 'M', 51, 'Laura',   'Carter',  '1982-05-16', 'laura.carter@example.com',  '5550100082'),
	('000000043', 'S', 51, 'Sophia',  'Carter',  '2018-07-20', NULL,                        NULL),
	('000000044', 'M', 52, 'Patrick', 'Roberts', '1979-03-22', 'patrick.roberts@example.com','5550100083'),
	('000000045', 'M', 52, 'Diana',   'Roberts', '1981-06-30', 'diana.roberts@example.com', '5550100084'),
	('000000046', 'S', 52, 'Ethan',   'Roberts', '2017-11-05', NULL,                        NULL),
	('000000047', 'M', 53, 'Stephen', 'Turner',  '1980-08-14', 'stephen.turner@example.com','5550100085'),
	('000000048', 'M', 53, 'Rachel',  'Turner',  '1982-09-18', 'rachel.turner@example.com', '5550100086'),
	('000000049', 'S', 53, 'Oliver',  'Turner',  '2018-10-20', NULL,                        NULL),
	('000000050', 'M', 54, 'Mark',    'Parker',  '1978-12-25', 'mark.parker@example.com',   '5550100087'),
	('000000051', 'M', 54, 'Linda',   'Parker',  '1980-03-03', 'linda.parker@example.com',  '5550100088'),
	('000000052', 'S', 54, 'Chloe',   'Parker',  '2017-04-04', NULL,                        NULL),
	('000000053', 'M', 55, 'George',  'Evans',   '1977-05-05', 'george.evans@example.com',  '5550100089'),
	('000000054', 'M', 55, 'Karen',   'Evans',   '1979-06-06', 'karen.evans@example.com',   '5550100090'),
	('000000055', 'S', 55, 'Mia',     'Evans',   '2016-07-07', NULL,                        NULL),
	('000000056', 'M', 56, 'Brian',   'Collins', '1981-07-07', 'brian.collins@example.com', '5550100091'),
	('000000057', 'M', 56, 'Angela',  'Collins', '1983-08-08', 'angela.collins@example.com','5550100092'),
	('000000058', 'S', 56, 'Isabella','Collins', '2015-09-09', NULL,                        NULL),
	('000000059', 'M', 57, 'Frank',   'Stewart', '1982-01-20', 'frank.stewart@example.com', '5550100093'),
	('000000060', 'M', 57, 'Laura',   'Stewart', '1984-02-21', 'laura.stewart@example.com', '5550100094'),
	('000000061', 'S', 57, 'Ava',     'Stewart', '2017-03-22', NULL,                        NULL),
	('000000062', 'M', 58, 'Kevin',   'Morris',  '1979-11-11', 'kevin.morris@example.com',  '5550100095'),
	('000000063', 'M', 58, 'Susan',   'Morris',  '1981-12-12', 'susan.morris@example.com',  '5550100096'),
	('000000064', 'S', 58, 'Ella',    'Morris',  '2015-01-13', NULL,                        NULL),
	('000000065', 'M', 59, 'Ronald',  'Reed',    '1980-02-14', 'ronald.reed@example.com',   '5550100097'),
	('000000066', 'M', 59, 'Patricia','Reed',    '1982-03-15', 'patricia.reed@example.com', '5550100098'),
	('000000067', 'S', 59, 'Charlotte','Reed',   '2016-04-16', NULL,                        NULL),
	('000000068', 'M', 60, 'Jeffrey', 'Cook',    '1981-04-17', 'jeffrey.cook@example.com',  '5550100099'),
	('000000069', 'M', 60, 'Deborah', 'Cook',    '1983-05-18', 'deborah.cook@example.com',  '5550100100'),
	('000000070', 'S', 60, 'Amelia',  'Cook',    '2017-06-19', NULL,                        NULL),
	('000000071', 'M', 61, 'Samuel',  'Morgan',  '1982-07-20', 'samuel.morgan@example.com', '5550100101'),
	('000000072', 'M', 61, 'Laura',   'Morgan',  '1984-08-21', 'laura.morgan@example.com',  '5550100102'),
	('000000073', 'S', 61, 'Harper',  'Morgan',  '2016-09-22', NULL,                        NULL),
	('000000074', 'M', 62, 'Patrick', 'Bell',    '1979-10-23', 'patrick.bell@example.com',  '5550100103'),
	('000000075', 'M', 62, 'Megan',   'Bell',    '1981-11-24', 'megan.bell@example.com',    '5550100104'),
	('000000076', 'S', 62, 'Abigail', 'Bell',    '2017-12-25', NULL,                        NULL),
	('000000077', 'M', 63, 'Douglas', 'Murphy',  '1980-01-02', 'douglas.murphy@example.com','5550100105'),
	('000000078', 'M', 63, 'Angela',  'Murphy',  '1982-02-03', 'angela.murphy@example.com', '5550100106'),
	('000000079', 'S', 63, 'Samantha','Murphy',  '2014-03-04', NULL,                        NULL),
	('000000080', 'M', 64, 'Robert',  'Bailey',  '1978-03-05', 'robert.bailey@example.com', '5550100107'),
	('000000081', 'M', 64, 'Catherine','Bailey', '1980-04-06', 'catherine.bailey@example.com','5550100108'),
	('000000082', 'S', 64, 'Victoria','Bailey',  '2015-05-07', NULL,                        NULL),
	('000000083', 'M', 65, 'Mark',    'Rivera',  '1981-05-08', 'mark.rivera@example.com',   '5550100109'),
	('000000084', 'M', 65, 'Susan',   'Rivera',  '1983-06-09', 'susan.rivera@example.com',   '5550100110'),
	('000000085', 'S', 65, 'Lily',    'Rivera',  '2017-07-10', NULL,                        NULL),
	('000000086', 'M', 66, 'Edward',  'Cooper',  '1980-06-11', 'edward.cooper@example.com', '5550100111'),
	('000000087', 'M', 66, 'Patricia','Cooper',  '1982-07-12', 'patricia.cooper@example.com','5550100112'),
	('000000088', 'S', 66, 'Zoe',     'Cooper',  '2013-08-13', NULL,                        NULL),
	('000000089', 'M', 67, 'Walter',  'Richardson','1979-07-14','walter.richardson@example.com','5550100113'),
	('000000090', 'M', 67, 'Nancy',   'Richardson','1981-08-15','nancy.richardson@example.com','5550100114'),
	('000000091', 'S', 67, 'Chloe',   'Richardson','2014-09-16', NULL,                        NULL),
	('000000092', 'M', 68, 'Dennis',  'Cox',     '1982-08-17', 'dennis.cox@example.com',     '5550100115'),
	('000000093', 'M', 68, 'Laura',   'Cox',     '1984-09-18', 'laura.cox@example.com',      '5550100116'),
	('000000094', 'S', 68, 'Avery',   'Cox',     '2015-10-19', NULL,                        NULL),
	('000000095', 'M', 69, 'Frank',   'Howard',  '1980-10-20', 'frank.howard@example.com',   '5550100117'),
	('000000096', 'M', 69, 'Sandra',  'Howard',  '1982-11-21', 'sandra.howard@example.com',   '5550100118'),
	('000000097', 'S', 69, 'Evelyn',  'Howard',  '2014-12-22', NULL,                        NULL),
	('000000098', 'M', 70, 'Larry',   'Ward',    '1979-12-23', 'larry.ward@example.com',     '5550100119'),
	('000000099', 'M', 70, 'Deborah', 'Ward',    '1981-01-24', 'deborah.ward@example.com',   '5550100120'),
	('000000100', 'S', 70, 'Grace',   'Ward',    '2017-02-25', NULL,                        NULL),

-- Households with 4 people each
	('000000101', 'M', 71, 'Douglas', 'King',    '1975-03-15', 'douglas.king@example.com',  '5550100121'),
	('000000102', 'M', 71, 'Patricia','King',    '1977-04-16', 'patricia.king@example.com', '5550100122'),
	('000000103', 'S', 71, 'Emily',   'King',    '2009-05-17', 'emily.king@example.com',    NULL),
	('000000104', 'S', 71, 'Oliver',  'King',    '2018-06-18', NULL,                        NULL),
	('000000105', 'M', 72, 'Edward',  'Scott',   '1976-07-19', 'edward.scott@example.com',  '5550100123'),
	('000000106', 'M', 72, 'Cynthia', 'Scott',   '1978-08-20', 'cynthia.scott@example.com', '5550100124'),
	('000000107', 'S', 72, 'Megan',   'Scott',   '2008-09-21', 'megan.scott@example.com',   NULL),
	('000000108', 'S', 72, 'Liam',    'Scott',   '2017-10-22', NULL,                        NULL),
	('000000109', 'M', 73, 'Donald',  'Hernandez','1977-12-20','donald.hernandez@example.com','5550100125'),
	('000000110', 'M', 73, 'Shirley', 'Hernandez','1979-01-21','shirley.hernandez@example.com','5550100126'),
	('000000111', 'S', 73, 'Grace',   'Hernandez','2009-02-22','grace.hernandez@example.com', NULL),
	('000000112', 'S', 73, 'Lily',    'Hernandez','2018-03-23', NULL,                        NULL),
	('000000113', 'M', 74, 'Anthony', 'Murphy',  '1978-03-05', 'anthony.murphy@example.com', '5550100127'),
	('000000114', 'M', 74, 'Patricia','Murphy',  '1980-04-06', 'patricia.murphy@example.com', '5550100128'),
	('000000115', 'S', 74, 'Brian',   'Murphy',  '2008-05-07', 'brian.murphy@example.com',    NULL),
	('000000116', 'S', 74, 'Rebecca', 'Murphy',  '2017-06-08', NULL,                        NULL),
	('000000117', 'M', 75, 'Patrick', 'Adams',   '1977-07-10', 'patrick.adams@example.com', '5550100129'),
	('000000118', 'M', 75, 'Donna',   'Adams',   '1979-08-11', 'donna.adams@example.com',   '5550100130'),
	('000000119', 'S', 75, 'Samuel',  'Adams',   '2008-09-12', 'samuel.adams@example.com',  NULL),
	('000000120', 'S', 75, 'Emily',   'Adams',   '2017-10-13', NULL,                        NULL),

-- Households with 5 people each
	('000000121', 'M', 81, 'Anthony', 'Scott',   '1978-03-05', 'anthony.scott@example.com', '5550100141'),
	('000000122', 'M', 81, 'Patricia','Scott',   '1980-04-06', 'patricia.scott@example.com', '5550100142'),
	('000000123', 'S', 81, 'Brian',   'Scott',   '2008-05-07', 'brian.scott@example.com',   NULL),
	('000000124', 'S', 81, 'Rebecca', 'Scott',   '2012-06-08', 'rebecca.scott@example.com', NULL),
	('000000125', 'S', 81, 'Oliver',  'Scott',   '2017-07-09', NULL,                        NULL),
	('000000126', 'M', 82, 'Patrick', 'Murphy',  '1977-07-10', 'patrick.murphy@example.com', '5550100143'),
	('000000127', 'M', 82, 'Donna',   'Murphy',  '1979-08-11', 'donna.murphy@example.com',   '5550100144'),
	('000000128', 'S', 82, 'Samuel',  'Murphy',  '2008-09-12', 'samuel.murphy@example.com',  NULL),
	('000000129', 'S', 82, 'Emily',   'Murphy',  '2012-10-13', 'emily.murphy@example.com',   NULL),
	('000000130', 'S', 82, 'Chloe',   'Murphy',  '2017-11-14', NULL,                        NULL),
	('000000131', 'M', 83, 'Steven',  'Adams',   '1978-01-25', 'steven.adams@example.com',  '5550100145'),
	('000000132', 'M', 83, 'Rebecca', 'Adams',   '1980-02-26', 'rebecca.adams@example.com', '5550100146'),
	('000000133', 'S', 83, 'Ryan',    'Adams',   '2008-03-27', 'ryan.adams@example.com',    NULL),
	('000000134', 'S', 83, 'Nicole',  'Adams',   '2012-04-28', 'nicole.adams@example.com',  NULL),
	('000000135', 'S', 83, 'Sophie',  'Adams',   '2017-05-29', NULL,                        NULL),
	('000000136', 'M', 84, 'Michael', 'Brown',   '1977-11-30', 'michael.brown@example.com', '5550100147'),
	('000000137', 'M', 84, 'Laura',   'Brown',   '1979-12-31', 'laura.brown@example.com',   '5550100148'),
	('000000138', 'S', 84, 'David',   'Brown',   '2008-01-15', 'david.brown@example.com',   NULL),
	('000000139', 'S', 84, 'Sarah',   'Brown',   '2012-02-16', 'sarah.brown@example.com',   NULL),
	('000000140', 'S', 84, 'Emma',    'Brown',   '2017-03-17', NULL,                        NULL),
	('000000141', 'M', 85, 'Joseph',  'Davis',   '1978-06-20', 'joseph.davis@example.com',  '5550100149'),
	('000000142', 'M', 85, 'Patricia','Davis',   '1980-07-21', 'patricia.davis@example.com','5550100150'),
	('000000143', 'S', 85, 'Robert',  'Davis',   '2008-08-22', 'robert.davis@example.com',  NULL),
	('000000144', 'S', 85, 'Linda',   'Davis',   '2012-09-23', 'linda.davis@example.com',   NULL),
	('000000145', 'S', 85, 'Karen',   'Davis',   '2017-10-24', NULL,                        NULL);

COMMIT;