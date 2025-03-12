package big.census.big_smallville_census_api.controllers;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import big.census.big_smallville_census_api.responses.AvgIncomeResponse;
import big.census.big_smallville_census_api.services.BusinessService;

@RestController
@RequestMapping("/api/v1/businesses")
public class BusinessController{
  private final BusinessService businessService;

  public BusinessController(BusinessService businessService){
    this.businessService = businessService;
  }

  // test on http://localhost:8080/api/v1/businesses/avgincome?businessName=Business%201
  @GetMapping("/avgincome")
    ResponseEntity<AvgIncomeResponse> averageIncome(@RequestParam String businessName) {
      AvgIncomeResponse result = new AvgIncomeResponse(
            businessService.getAverageIncome(businessName));
        return ResponseEntity.ok(result);
    }
}