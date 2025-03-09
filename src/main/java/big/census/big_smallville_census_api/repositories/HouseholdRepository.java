package big.census.big_smallville_census_api.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import big.census.big_smallville_census_api.entities.Household;

public interface HouseholdRepository extends JpaRepository<Household, Integer> {
    @Query(nativeQuery = true, value = "SELECT COUNT(Person.ID) FROM Household LEFT JOIN Person ON Person.householdID = Household.ID AND Person.birthDate + INTERVAL '18 years' > CURRENT_DATE WHERE Household.lotNumber =:lotNumber GROUP BY Household.lotNumber;")
    Integer numberOfDependents(@Param("lotNumber") String lotNumber);
}