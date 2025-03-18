package big.census.big_smallville_census_api.controllers;

import java.math.BigDecimal;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import big.census.big_smallville_census_api.responses.AvgIncomeResponse;
import big.census.big_smallville_census_api.responses.BusinessRecordResponse;
import big.census.big_smallville_census_api.responses.ListEmployeesResponse;
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

  /**
   * @author David Phillips
   * @description returns a list of business record DTO from a given business name
   * @param businessName
   * @return BusinessRecordResponse: a wrapper class which holds a list of
   *         business object DTO
   * @testOn http://localhost:8080/api/v1/businesses/listBusRecords?businessName=Serious%20Business
   */
  @GetMapping("/listBusRecords")
  ResponseEntity<BusinessRecordResponse> listBusinessRecords(@RequestParam String businessName) {
    BusinessRecordResponse result = new BusinessRecordResponse(businessService.listRecordsOfABusiness(businessName));
    return ResponseEntity.ok(result);
  }

  /**
   * @author David Phillips
   * @description updates all employee wages of a company below a threshold to be
   *              at that threshold
   * @param businessName, newWage:
   * @return WageUpdateResponse: A count of the employees updated
   * @testOn http://localhost:8080/api/v1/businesses/updateMinWage?businessName=Serious%20Business&newWage=70000
   */
  @PutMapping("/updateMinWage")
  ResponseEntity<WageUpdateResponse> updateMinWage(@RequestParam String businessName, @RequestParam Integer newWage) {
    WageUpdateResponse result = new WageUpdateResponse(businessService.updateMinWage(businessName, newWage));
    return ResponseEntity.ok(result);
  }

  /**
   * Show first name, last name, and income of employees earning less than a
   * limit given based on a given business name.
   * 
   * Test on
   * http://localhost:8080/api/v1/businesses/listEmployees?businessName=Serious%20Business&incomeLimit=100000
   * The given business name is 'Serious Business' and given income limit is
   * 100000
   * 
   * @author Ting Gao
   */
  @GetMapping("/listEmployees")
  ResponseEntity<ListEmployeesResponse> listEmployees(@RequestParam String businessName,
      @RequestParam BigDecimal incomeLimit) {
    ListEmployeesResponse result = new ListEmployeesResponse(
        businessService.listEmployeesInABusiness(businessName, incomeLimit));
    return ResponseEntity.ok(result);
  }
}