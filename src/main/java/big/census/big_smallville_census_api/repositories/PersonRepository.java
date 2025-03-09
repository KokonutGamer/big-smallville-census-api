package big.census.big_smallville_census_api.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import big.census.big_smallville_census_api.entities.Person;

public interface PersonRepository extends JpaRepository<Person, Integer> {
    @Query(nativeQuery = true, value = "SELECT Household.lotNumber FROM Household JOIN Person ON Person.householdID = Household.ID WHERE Person.ssn =:ssn")
    public String getLotNumberOfPerson(@Param("ssn") String ssn);
}