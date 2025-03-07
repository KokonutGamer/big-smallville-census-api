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