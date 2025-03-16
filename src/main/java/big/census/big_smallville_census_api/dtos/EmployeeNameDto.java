package big.census.big_smallville_census_api.dtos;

import java.math.BigDecimal;

public interface EmployeeNameDto {
  String getFirstName();

  String getLastName();

  BigDecimal getIncome();
}