package big.census.big_smallville_census_api.repositories;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import big.census.big_smallville_census_api.entities.Business;
import big.census.big_smallville_census_api.entities.BusinessRecord;
import big.census.big_smallville_census_api.dtos.EmployeeNameDto;

public interface BusinessRepository extends JpaRepository<Business, Integer> {
  @Query(nativeQuery = true, value = """
      SELECT AVG(e.income) as \"Income Average\"
      FROM	Person p
        JOIN Employee e ON p.id = e.personid
        JOIN Business b ON e.businessID = b.id
      WHERE b.name = :businessName;
      """)
  BigDecimal avgEmployeeIncome(@Param("businessName") String businessName);

  @Query("""
      SELECT new big.census.big_smallville_census_api.dtos.EmployeeNameDto(p.firstName, p.lastName, e.income)
      FROM Employee e
        JOIN e.person p
        JOIN e.business b
      WHERE b.name = :businessName
      """)
List<EmployeeNameDto> getEmployeesInABusiness(@Param("businessName") String businessName);


  @Query(nativeQuery = true, value = """
      SELECT businessid, revenue, expenses, profit, taxespaid, propertytaxes, year, quarterid
      FROM businessrecord
        JOIN business ON (businessrecord.businessID = business.ID)
      WHERE name = :businessName;
      """)
  List<BusinessRecord> getRecordsOfABusiness(@Param("businessName") String businessName);

  @Query(nativeQuery = true, value = """
      WITH updated_rows AS (
          UPDATE employee
          SET income = :newWage
          WHERE income < :newWage
          AND businessID = (SELECT ID FROM business WHERE name = :businessName)
          RETURNING 1
      )
      SELECT COUNT(*) FROM updated_rows;
      """)
  Integer updateMinWage(@Param("businessName") String businessName, @Param("newWage") Integer newWage);
}