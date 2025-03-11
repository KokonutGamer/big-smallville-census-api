package big.census.big_smallville_census_api.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import big.census.big_smallville_census_api.entities.Business;
import big.census.big_smallville_census_api.entities.Employee;

public interface BusinessRepository extends JpaRepository<Business, Integer> {
  @Query(nativeQuery = true, value = "SELECT AVG(e.income) as “Income Average” FROM	Person p JOIN Employee e ON p.id = e.personid JOIN Business b ON e.businessID = b.id WHERE b.name = :businessName;")
  Integer avgEmployeeIncome(@Param("businessName") String businessName);
  
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