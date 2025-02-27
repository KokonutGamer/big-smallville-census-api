CREATE DATABASE smallVilleDB;
\c smallvilledb

CREATE TABLE MaritalStatus (
    ID      		varchar(1)      NOT NULL,
    Name			varchar(20)     NOT NULL UNIQUE,

  	PRIMARY KEY 	(ID)
);

CREATE TABLE District (
 	ID 				varchar(2)		NOT NULL,
 	Name 			varchar(20) 	NOT NULL UNIQUE,

  	PRIMARY KEY 	(ID)
);

CREATE TABLE Household (
	ID 				Serial			NOT NULL,
  	Street 			varchar(20)		NOT NULL,
  	ZipCode 		varchar(5)		NOT NULL,
	HouseNumber 	Integer			NOT NULL,
  	ApartmentNumber Integer,
 	DistrictID		varchar(2)		NOT NULL,

  	PRIMARY KEY 	(ID),
    FOREIGN KEY 	(DistrictID) REFERENCES District(ID)
		Deferrable Initially Deferred,

	UNIQUE(Street, ZipCode, HouseNumber, ApartmentNumber)
);

CREATE TABLE Person (
  	ID 				Serial			NOT NULL,
  	MaritalStatusID varchar(1)		NOT NULL,
  	HouseholdID 	Integer			NOT NULL,
  	FirstName 		varchar(20)		NOT NULL,
  	LastName 		varchar(20)		NOT NULL,
  	Birthdate 		date			NOT NULL,
  	Email 			varchar(80),
  	Phone 			varchar(20),

  	PRIMARY KEY 	(ID),
    FOREIGN KEY 	(MaritalStatusID) REFERENCES MaritalStatus(ID)
		Deferrable Initially Deferred,
    FOREIGN KEY 	(HouseholdID) REFERENCES Household(ID)
		Deferrable Initially Deferred,

	UNIQUE(HouseholdID, FirstName, LastName, Birthdate)
);

CREATE TABLE TaxRecord (
  	ID 				Serial			NOT NULL,
  	PersonID 		Integer			NOT NULL,
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
  	Email 			varchar(20),
  	Phone 			varchar(10),
 	Street 			varchar(10)		NOT NULL,
 	ZipCode			varchar(5)		NOT NULL,
  	BuildingNumber 	Integer			NOT NULL,

  	PRIMARY KEY 	(ID)
);

CREATE TABLE Quarter (
  	ID 				Char(2)			NOT NULL,

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
  	PropertyID 		Integer			NOT NULL,
  	OwnerID 		Integer			NOT NULL,
  	TaxPercentage	Decimal(4,2)	NOT NULL,
  	PercentOwnership Decimal(4,2)	NOT NULL,
  	Year 			Integer			NOT NULL,

	PRIMARY KEY		(PropertyID, OwnerID),
    FOREIGN KEY 	(OwnerID) REFERENCES Person(ID)
		Deferrable Initially Deferred,
    FOREIGN KEY 	(PropertyID) REFERENCES PersonalProperty(ID)
		Deferrable Initially Deferred
);

CREATE TABLE Employee (
  	ID				Serial			NOT NULL,
  	PersonID 		Integer			NOT NULL,
  	BusinessID 		Integer			NOT NULL,
 	Income 			Decimal(15,2)	NOT NULL,

  	PRIMARY KEY 	(ID),
    FOREIGN KEY 	(PersonID) REFERENCES Person(ID)
		Deferrable Initially Deferred,
    FOREIGN KEY 	(BusinessID)REFERENCES Business(ID)
		Deferrable Initially Deferred
);