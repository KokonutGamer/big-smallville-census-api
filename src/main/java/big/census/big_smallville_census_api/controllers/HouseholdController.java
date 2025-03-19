package big.census.big_smallville_census_api.controllers;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import big.census.big_smallville_census_api.responses.LotNumberResponse;
import big.census.big_smallville_census_api.responses.HouseholdResponse;
import big.census.big_smallville_census_api.services.HouseholdService;

@RestController
@CrossOrigin(origins = "http://localhost:4200")
@RequestMapping("/api/v1/households")
public class HouseholdController {
    @Autowired
    private HouseholdService householdService;

    // test on
    // http://localhost:8080/api/v1/households/lot-number?street=wildflower%20ln&zipcode=10007&house-number=707&district=greenwood%20south
    @GetMapping("/lot-number")
    ResponseEntity<LotNumberResponse> getLotNumber(@RequestParam String street, @RequestParam String zipcode,
            @RequestParam("house-number") String houseNumber, @RequestParam String district,
            @RequestParam("apartment-number") Optional<String> apartmentNumber) {
        LotNumberResponse result = new LotNumberResponse(
                householdService.getLotNumber(street, zipcode, houseNumber, district, apartmentNumber.orElse(null)));
        return ResponseEntity.ok(result);
    }

    /**
     * Retrieves household members based on the given lot number.
     * 
     * test on
     * http://localhost:8080/api/v1/households/members?lotNumber=00085&limit=5
     * 
     * @author Kent Mayoya
     */
    @GetMapping("/members")
    ResponseEntity<HouseholdResponse> getHouseholdMembers(@RequestParam Integer lotNumber,
            @RequestParam Integer limit) {
        HouseholdResponse result = new HouseholdResponse(householdService.getHouseholdMembers(lotNumber, limit));
        return ResponseEntity.ok(result);
    }
}