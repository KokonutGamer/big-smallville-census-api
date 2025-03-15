package big.census.big_smallville_census_api.controllers;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import big.census.big_smallville_census_api.responses.AvgIncomeResponse;
import big.census.big_smallville_census_api.responses.BusinessRecordResponse;
import big.census.big_smallville_census_api.responses.ListEmployeeResponse;
import big.census.big_smallville_census_api.responses.WageUpdateResponse;
import big.census.big_smallville_census_api.services.BusinessService;

@RestController
@CrossOrigin(origins = "http://localhost:4200")
@RequestMapping("/api/v1/businesses")
public class BusinessController {
  private final BusinessService businessService;

  public BusinessController(BusinessService businessService) {
    this.businessService = businessService;
  }

  // test on
  // http://localhost:8080/api/v1/businesses/avgincome?businessName=Business%201
  @GetMapping("/avgincome")
  ResponseEntity<AvgIncomeResponse> averageIncome(@RequestParam String businessName) {
    AvgIncomeResponse result = new AvgIncomeResponse(
        businessService.getAverageIncome(businessName));
    return ResponseEntity.ok(result);
  }

  // test on
  // http://localhost:8080/api/v1/businesses/listBusRecords?businessName=Serious%20Business
  @GetMapping("/listBusRecords")
  ResponseEntity<BusinessRecordResponse> listBusinessRecords(@RequestParam String businessName) {
    BusinessRecordResponse result = new BusinessRecordResponse(businessService.listRecordsOfABusiness(businessName));
    return ResponseEntity.ok(result);
  }

  @GetMapping("/updateMinWage")
  // http://localhost:8080/api/v1/businesses/updateMinWage?businessName=Serious%20Business&newWage=70000
  ResponseEntity<WageUpdateResponse> updateMinWage(@RequestParam String businessName, @RequestParam Integer newWage) {
    WageUpdateResponse result = new WageUpdateResponse(businessService.updateMinWage(businessName, newWage));
    return ResponseEntity.ok(result);
  }

  @GetMapping("/listEmployee")
  ResponseEntity<ListEmployeeResponse> listEmployee(@RequestParam String businessName) {
    ListEmployeeResponse result = new ListEmployeeResponse(businessService.listEmployeesInABusiness(businessName));
    return ResponseEntity.ok(result);
  }
}