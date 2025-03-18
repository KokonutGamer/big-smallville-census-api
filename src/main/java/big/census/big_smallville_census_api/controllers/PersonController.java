package big.census.big_smallville_census_api.controllers;

import org.springframework.http.ResponseEntity;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.dao.DataIntegrityViolationException;

import big.census.big_smallville_census_api.responses.IncentiveResponse;
import big.census.big_smallville_census_api.responses.ListParentsResponse;
import big.census.big_smallville_census_api.responses.AddPersonResponse;
import big.census.big_smallville_census_api.services.HouseholdService;
import big.census.big_smallville_census_api.services.PersonService;

import big.census.big_smallville_census_api.entities.MaritalStatus;

import java.util.Date;

@RestController
@CrossOrigin(origins = "http://localhost:4200")
@RequestMapping("/api/v1/persons")
public class PersonController {

    private final HouseholdService householdService;

    private final PersonService personService;

    public PersonController(HouseholdService householdService, PersonService personService) {
        this.householdService = householdService;
        this.personService = personService;
    }

    // test on http://localhost:8080/api/v1/persons/incentive?ssn=000000145
    @GetMapping("/incentive")
    ResponseEntity<IncentiveResponse> calculateIncentives(@RequestParam String ssn) {
        IncentiveResponse result = new IncentiveResponse(
                householdService.incentiveAmountCalculation(householdService.getNumberOfDependentsOfPerson(ssn)));
        return ResponseEntity.ok(result);
    }

    /**
     * Adds a person to the database.
     * 
     * test on
     * http://localhost:8080/api/v1/persons/add?ssn=000000146&maritalStatusID=S&lotNumber=00001&firstName=Joe&lastName=Mama&birthDate=01-01-1945&email=joe.mama@example.com&phone=5550100151
     * 
     * @author Kent Mayoya
     */
    @PutMapping("/add")
    ResponseEntity<AddPersonResponse> addPerson(
            @RequestParam String ssn,
            @RequestParam MaritalStatus maritalStatusID,
            @RequestParam String lotNumber,
            @RequestParam String firstName,
            @RequestParam String lastName,
            @RequestParam @DateTimeFormat(pattern = "MM-dd-yyyy") Date birthDate,
            @RequestParam String email,
            @RequestParam String phone) {
        boolean lotNumberExists = householdService.lotNumberExists(lotNumber);
        boolean uniqueSSN = !personService.ssnExists(ssn);
        if (!lotNumberExists || !uniqueSSN) {
            // slight optimization -- avoids try catch
            return ResponseEntity.ok(new AddPersonResponse(false, uniqueSSN, lotNumberExists));
        }
        boolean success;
        try {
            success = personService.addPerson(ssn, maritalStatusID, lotNumber, firstName, lastName, birthDate, email,
                    phone);
        } catch (DataIntegrityViolationException ex) {
            success = false;
        }
        AddPersonResponse result = new AddPersonResponse(success, uniqueSSN, lotNumberExists);
        return ResponseEntity.ok(result);
    }

    @GetMapping("/needyParents")
    ResponseEntity<ListParentsResponse> needyParents() {
        ListParentsResponse result = new ListParentsResponse(personService.getNeedyParents());
        return ResponseEntity.ok(result);
    }
}