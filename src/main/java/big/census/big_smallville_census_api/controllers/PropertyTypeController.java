package big.census.big_smallville_census_api.controllers;

import java.math.BigDecimal;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import big.census.big_smallville_census_api.responses.DisplayPropertyTypeTableResponse;
import big.census.big_smallville_census_api.responses.TaxPercentageUpdateResponse;
import big.census.big_smallville_census_api.services.PropertyTypeService;

@RestController
@CrossOrigin(origins = "http://localhost:4200")
@RequestMapping("/api/v1/properties")
public class PropertyTypeController{
  private final PropertyTypeService propertyTypeService;

  public PropertyTypeController(PropertyTypeService propertyTypeService) {
    this.propertyTypeService = propertyTypeService;
  }

  /**
   * Update the tax percentage based on a given property type name
   * 
   * Test by running the following code in bash
   * curl -X PUT -H "Content-Type: application/json" -d "0.8" http://localhost:8080/api/v1/properties/Vehicle/taxPercentage
   * The given property type name is 'Vehicle' and new tax percentage is 0.8
   * This should return 1
   * 
   * curl -X PUT -H "Content-Type: application/json" -d "0.8" http://localhost:8080/api/v1/properties/Air/taxPercentage
   * The given property type name is 'Air'
   * This should return 0
   * 
   * curl -X PUT -H "Content-Type: application/json" -d "-1" http://localhost:8080/api/v1/properties/Vehicle/taxPercentage
   * The new percentage is -1
   * This should return 0
   * 
   * @return Integer, 1 if updated, 0 if the given name is invalid or the new percentage is negative
   * 
   * @author Ting Gao
   */
  @PutMapping("/{propertyTypeName}/taxPercentage")
  public ResponseEntity<TaxPercentageUpdateResponse> updateTaxPercentage(@PathVariable String propertyTypeName, @RequestBody BigDecimal newTaxPercentage) {
      TaxPercentageUpdateResponse result = new TaxPercentageUpdateResponse(propertyTypeService.updateTaxPercentageForASpecificPropertyType(newTaxPercentage, propertyTypeName));
      return ResponseEntity.ok(result);
  }

  /**
   * Display PropertyType Table (excluding ID) to verify updateTaxPercentageForASpecificPropertyType
   * 
   * View the table on
   * http://localhost:8080/api/v1/properties/displayPropertyTypeTable
   * 
   * @return all property types' names and tax percentages
   * 
   * @author Ting Gao
   */
  @GetMapping("/displayPropertyTypeTable")
  ResponseEntity<DisplayPropertyTypeTableResponse> displayPropertyTypeTable() {
    DisplayPropertyTypeTableResponse result = new DisplayPropertyTypeTableResponse(propertyTypeService.displayPropertyTypeTable());
    return ResponseEntity.ok(result);
  }
}
