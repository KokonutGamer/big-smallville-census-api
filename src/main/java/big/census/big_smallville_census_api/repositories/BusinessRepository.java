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

  /**
   * List Employees In A Business 
   * Show first name, last name, and income of all employees based on a given business name.
   * This help analyze the condition of the business selected.
   * 
   * DTO projections implemented to display only information we want to see.
   * https://www.javaguides.net/2023/08/spring-data-jpa-specific-columns.html
   * used as reference.
   * DTO turned into an interface to use native query.
   * 
   * @param businessName the given business name
   * @return a list of employees' first names, last names, and incomes
   * @author Ting Gao & Gabe Lapingcao
   */
  @Query(nativeQuery = true, value = """
      SELECT P.firstName, P.lastName, E.income
      FROM Employee AS E
        JOIN Person AS P ON P.ID = E.personID
        JOIN Business AS B ON B.ID = E.businessID
      WHERE B.name = :businessName;
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