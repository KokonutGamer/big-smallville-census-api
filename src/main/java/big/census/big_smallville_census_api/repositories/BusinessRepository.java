package big.census.big_smallville_census_api.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import big.census.big_smallville_census_api.entities.Business;

public interface BusinessRepository extends JpaRepository<Business, Integer> {
  @Query(nativeQuery = true, value = "SELECT AVG(e.income) as “Income Average” FROM	Person p JOIN Employee e ON p.id = e.personid JOIN Business b ON e.businessID = b.id WHERE b.name = :businessName;")
  Integer avgEmployeeIncome(@Param("businessName") String businessName);
}