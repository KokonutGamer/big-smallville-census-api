package big.census.big_smallville_census_api.controllers;

import java.math.BigDecimal;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import big.census.big_smallville_census_api.responses.TaxPercentageUpdateResponse;
import big.census.big_smallville_census_api.services.PropertyTypeService;

@RestController
@CrossOrigin(origins = "http://localhost:4200")
@RequestMapping("/api/v1/propertyType")
public class PropertyTypeController{
  private final PropertyTypeService propertyTypeService;

  public PropertyTypeController(PropertyTypeService propertyTypeService) {
    this.propertyTypeService = propertyTypeService;
  }

  // http://localhost:8080/api/v1/propertyType/updateTaxPercentage?propertyTypeName=Vehicle&newTaxPercentage=1
  @GetMapping("/updateTaxPercentage")
  ResponseEntity<TaxPercentageUpdateResponse> updateTaxPercentage(@RequestParam BigDecimal newTaxPercentage, @RequestParam String propertyTypeName) {
    TaxPercentageUpdateResponse result = new TaxPercentageUpdateResponse(propertyTypeService.updateTaxPercentageForASpecificPropertyType(newTaxPercentage, propertyTypeName));
    return ResponseEntity.ok(result);
  }
}
