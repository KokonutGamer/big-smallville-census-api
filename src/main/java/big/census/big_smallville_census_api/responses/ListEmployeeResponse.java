package big.census.big_smallville_census_api.responses;

import java.util.List;

import big.census.big_smallville_census_api.entities.Employee;
import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class ListEmployeeResponse {
  private List<Employee> employees;
}
