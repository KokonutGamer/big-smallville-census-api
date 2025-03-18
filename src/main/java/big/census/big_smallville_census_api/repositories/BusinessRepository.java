package big.census.big_smallville_census_api.repositories;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import big.census.big_smallville_census_api.entities.Business;
import big.census.big_smallville_census_api.dtos.BusinessRecordDto;
import big.census.big_smallville_census_api.dtos.EmployeeDto;

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
   * Show first name, last name, and income of employees earning less than a
   * limit given based on a given business name.
   * This help analyze the condition of the business selected.
   * 
   * DTO projections implemented to display only information we want to see.
   * https://www.javaguides.net/2023/08/spring-data-jpa-specific-columns.html
   * used as reference.
   * DTO turned into an interface to use native query.
   * 
   * @param businessName the given business name
   * @param incomeLimit  the given income limit
   * @return a list of employees' first names, last names, and incomes
   * @author Ting Gao & Gabe Lapingcao
   */
  @Query(nativeQuery = true, value = """
      SELECT P.firstName, P.lastName, E.income
      FROM Employee AS E
        JOIN Person AS P ON P.ID = E.personID
        JOIN Business AS B ON B.ID = E.businessID
      WHERE B.name = :businessName AND E.income < :incomeLimit;
      """)
  List<EmployeeDto> getEmployeesInABusiness(@Param("businessName") String businessName,
      @Param("incomeLimit") BigDecimal incomeLimit);

  /**
   * @author David Phillips
   * @description queries a list of business records form a given business name:
   *              each record contains revenue, expenses, profit,
   *              taxespaid, propertytaxes, year, quarterid
   * @param businessName
   * @return the query response: list of business record DTOs
   */
  @Query(nativeQuery = true, value = """
      SELECT BR.revenue, BR.expenses, BR.profit, BR.taxespaid, BR.propertytaxes, BR.year, BR.quarterid
      FROM businessrecord AS BR
        JOIN business AS B ON (BR.businessID = B.ID)
      WHERE B.name = :businessName;
      """)
  List<BusinessRecordDto> getRecordsOfABusiness(@Param("businessName") String businessName);

  /**
   * @author David Phillips
   * @description updates all employee wages of a company below a threshold to be
   *              at that threshold, runs UPDATE within a with statement to allow
   *              the amount of updates to be counted and returned
   * @param businessName, newWage:
   * @return WageUpdateResponse: A count of the employees updated
   */
  @Query(nativeQuery = true, value = """
      WITH updated_rows AS (
          UPDATE employee
          SET income = :newWage
          WHERE income < :newWage
          AND businessID = (SELECT ID FROM business WHERE name = :businessName FOR UPDATE)
          RETURNING 1
      )
      SELECT COUNT(*) FROM updated_rows;
      """)
  Integer updateMinWage(@Param("businessName") String businessName, @Param("newWage") Integer newWage);
}