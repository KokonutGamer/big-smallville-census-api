package big.census.big_smallville_census_api.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import big.census.big_smallville_census_api.composites.EmployeeId;
import big.census.big_smallville_census_api.entities.Employee;

public interface EmployeeRepository extends JpaRepository<Employee, EmployeeId> {
}