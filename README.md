## Smallville Census API
The Smallville Census API (SCAPI) provides tools and utilities through HTTP requests for the local government at Smallville to assist in their efforts to rebuild the economy.

## Running the API
> [!NOTE]
> This is the backend service for the project. To run the full project, redirect to the repository of the [frontend application](https://github.com/KokonutGamer/big-smallville-census-web).

### Requirements
- Java 21 or higher
- PostgreSQL 14.17 or higher
- IDE or text editor with Apache Maven support

### Available Functionalities
- [X] List the lot number of a household
- [X] Calculate incentives for an individual person
- [X] List all of the records for a business
- [X] Update the minimum wage at a business
- [X] Find the average income of employees at a business
- [X] List married parents and guardians who have at least a number of children and do not own a house
- [X] List all members of in a household
- [X] Add a new person
- [X] List employees in a business
- [X] Update the tax percentage for a specific property type

## About BIG Information Group
BIG is the world's leading data analytics organization (*source: trust me*). At the forefront of data technology, BIG manages to surpass expectations consistently. Despite all of this, our GROuP (**G**enerous **R**eliable **Ou**tstanding **P**eople) always finds ways to contribute to society whatever we can.

### Meet the team members
- Gabe Lapingcao
- David Phillips
- Alan Cordova
- Kent Mayoya
- Ting Gao

## Demo HTTP Requests

### Persons
- Calculate incentives
  - HTTP method: `GET`
  - http://localhost:8080/api/v1/persons/incentive?ssn=000000156
- Add a new person
  - HTTP method: `PUT`
  - `curl -X PUT -H "Content-Type: application/json" "http://localhost:8080/api/v1/persons/add?ssn=000000146&maritalStatusID=S&lotNumber=00001&firstName=Joe&lastName=Mama&birthDate=01-01-1945&email=joe.mama@example.com&phone=5550100151"`
- List married parents/guardians who have at least a number of children and do not own a house
  - HTTP method: `GET`
  - http://localhost:8080/api/v1/persons/needyParents

### Households
- Get the lot number of a household
  - HTTP method: `GET`
  - http://localhost:8080/api/v1/households/lot-number?street=struggle%20street&zipcode=10087&house-number=8787&district=brookfield%20bay&apartment-number=2B
- List the members of a household
  - HTTP method: `GET`
  - http://localhost:8080/api/v1/households/members?lotNumber=00085&limit=5

### Businesses
- Average income of employees at a business
  - HTTP method: `GET`
  - http://localhost:8080/api/v1/businesses/avgincome?businessName=Business%201
- List all business records
  - HTTP method: `GET`
  - http://localhost:8080/api/v1/businesses/listBusRecords?businessName=Serious%20Business
- Update minimum wages
  - HTTP method: `PUT`, no body needed
  - `curl -X PUT -H "Content-Type: application/json" "http://localhost:8080/api/v1/businesses/updateMinWage?businessName=Serious%20Business&newWage=99999994"`
- List employees in a business
  - HTTP method: `GET`
  - http://localhost:8080/api/v1/businesses/listEmployees?businessName=Serious%20Business&incomeLimit=100000

### Properties
- List property types
  - HTTP method: `GET`
  - http://localhost:8080/api/v1/properties/displayPropertyTypeTable
- Update tax percentage of a property type
  - HTTP method: `PUT`
  - `curl -X PUT -H "Content-Type: application/json" -d "0.8" http://localhost:8080/api/v1/properties/Vehicle/taxPercentage`
