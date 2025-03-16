/**
 * Employee Data Transfer Object (DTO) to only display first names, last names, 
 * and incomes queried from the Employee database.
 * 
 * @author Ting Gao & Gabe Lapingcao
 */
package big.census.big_smallville_census_api.dtos;

import java.math.BigDecimal;

public interface EmployeeDto {
  String getFirstName();

  String getLastName();

  BigDecimal getIncome();
}