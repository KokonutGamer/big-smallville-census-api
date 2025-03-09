package big.census.big_smallville_census_api.controllers;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import big.census.big_smallville_census_api.responses.IncentiveResponse;

@RestController
@RequestMapping("/api/v1/persons")
public class PersonController {

    @GetMapping("/incentive")
    ResponseEntity<IncentiveResponse> calculateIncentives(@RequestParam String ssn) {
        /* TODO implement incentives calculations */
        return ResponseEntity.status(HttpStatus.OK).body(null);
    }
}