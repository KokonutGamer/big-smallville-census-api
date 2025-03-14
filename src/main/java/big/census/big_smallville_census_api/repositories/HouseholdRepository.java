package big.census.big_smallville_census_api.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import big.census.big_smallville_census_api.entities.Household;
import big.census.big_smallville_census_api.entities.Person;


public interface HouseholdRepository extends JpaRepository<Household, Integer> {
    @Query(nativeQuery = true, value = """
            SELECT COUNT(Person.ID)
            FROM Household
                LEFT JOIN Person ON Person.householdID = Household.ID AND Person.birthDate + INTERVAL '18 years' > CURRENT_DATE
            WHERE Household.lotNumber =:lotNumber
            GROUP BY Household.lotNumber;
            """)
    Integer numberOfDependents(@Param("lotNumber") String lotNumber);

    @Query(nativeQuery = true, value = """
            SELECT lotNumber
            FROM Household
            WHERE (street ILIKE :street
                AND zipcode =:zipcode
                AND houseNumber =:houseNumber
                AND districtID = (
                    SELECT id
                    FROM District
                    WHERE name ILIKE :district
                )
                AND (:apartmentNumber IS NULL OR apartmentNumber =:apartmentNumber));
            """)
    String getLotNumber(@Param("street") String street, @Param("zipcode") String zipcode,
            @Param("houseNumber") String houseNumber, @Param("district") String district,
            @Param("apartmentNumber") String apartmentNumber);

    /**
     * Detail API - 50 points
     * This API retrieves detailed information for each household.
     * From this API, we could calculate the average size, age, and other relevant
     * statistics for each household in Smallville. This information is useful to
     * track Smallville’s population and demographics over time.
     * 
     * To remain consistent with Person class defined in Person.java, all fields are
     * queried. Unnecessary fields will be filtered out in the front-end.
     * 
     * @param lotNumber An integer representing the household’s lot number.
     * @return          A list of person objects within the requested household. 
     * @author Kent Mayoya
     */
    @Query(nativeQuery = true, value = """
        SELECT Person.*
        FROM Person
            JOIN Household ON (Person.HouseholdID = Household.ID)
            JOIN MaritalStatus ON (Person.MaritalStatusID = MaritalStatus.ID)
        WHERE Person.HouseholdID = :lotNumber
        ORDER BY Person.SSN
        """)
    public List<Person> getHouseholdMembers(@Param("lotNumber") Integer lotNumber);

    /**
     * Queries the database to get the number of Households with a specific lot number.
     * 
     * @param lotNumber A household's lot number. Limited to 5 characters.
     * @return          1 if the household exists, otherwise 0.
     * @author Kent Mayoya
     */
    @Query(nativeQuery = true, value = """
        SELECT COUNT(*)
        FROM Household
        WHERE lotNumber = :lotNumber
    """)
    public int lotNumberExists(@Param("lotNumber") String lotNumber);
}