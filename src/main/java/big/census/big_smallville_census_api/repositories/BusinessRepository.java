package big.census.big_smallville_census_api.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import big.census.big_smallville_census_api.entities.Business;
import big.census.big_smallville_census_api.entities.Employee;

public interface BusinessRepository extends JpaRepository<Business, Integer> {
  @Query(nativeQuery = true, value =
  """
  SELECT P.firstName, P.lastName, E.income
  FROM Person AS P
    JOIN Employee AS E ON (P.ID = E.personID)
    JOIN Business AS B ON (B.ID = E.businessID)
  WHERE B.name = :businessName;      
  """
  )
  List<Employee> getEmployeesInABusiness(@Param("businessName") String businessName);  
}