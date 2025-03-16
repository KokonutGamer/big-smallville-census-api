package big.census.big_smallville_census_api.dtos;

import java.math.BigDecimal;

import lombok.Data;

@Data
public class EmployeeNameDto {
  private final String firstName;
  private final String lastName;
  private final BigDecimal income;

  public EmployeeNameDto(String firstName, String lastName, BigDecimal income) {
    this.firstName = firstName;
    this.lastName = lastName;
    this.income = income;
  }
}