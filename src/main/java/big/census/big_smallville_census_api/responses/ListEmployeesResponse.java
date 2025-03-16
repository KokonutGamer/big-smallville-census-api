/**
 * Response when trying to retrieve a list of employees' first names, last names,
 * and incomes based on a given business name.
 * 
 * @author Ting Gao
 */
package big.census.big_smallville_census_api.responses;

import java.util.List;

import big.census.big_smallville_census_api.dtos.EmployeeNameDto;
import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class ListEmployeesResponse {
  private List<EmployeeNameDto> employees;
}
