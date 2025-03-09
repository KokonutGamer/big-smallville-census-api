package big.census.big_smallville_census_api.controllers;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import big.census.big_smallville_census_api.responses.IncentiveResponse;
import big.census.big_smallville_census_api.services.HouseholdService;

@RestController
@RequestMapping("/api/v1/persons")
public class PersonController {

    private final HouseholdService householdService;

    public PersonController(HouseholdService householdService) {
        this.householdService = householdService;
    }

    // test on http://localhost:8080/api/v1/persons/incentive?ssn=000000145
    @GetMapping("/incentive")
    ResponseEntity<IncentiveResponse> calculateIncentives(@RequestParam String ssn) {
        IncentiveResponse result = new IncentiveResponse(
                householdService.incentiveAmountCalculation(householdService.getNumberOfDependentsOfPerson(ssn)));
        return ResponseEntity.ok(result);
    }
}