package big.census.big_smallville_census_api.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.data.jpa.repository.Modifying;

import big.census.big_smallville_census_api.dtos.PersonDto;
import big.census.big_smallville_census_api.entities.Person;
import java.util.List;
import java.util.Date;
import java.util.Optional;

public interface PersonRepository extends JpaRepository<Person, Integer> {
    @Query(nativeQuery = true, value = "SELECT Household.lotNumber FROM Household JOIN Person ON Person.householdID = Household.ID WHERE Person.ssn =:ssn")
    public String getLotNumberOfPerson(@Param("ssn") String ssn);

    /**
     * Crupdate Single API - 50 points
     * Inserts a person into the database.
     * 
     * @param ssn             A person's social security number, 9 characters long.
     * @param maritalStatusID A person's marital status, e.g. 'S', 'M', etc. The
     *                        argument Values are restricted on the front-end.
     * @param lotNumber       A household's lot number. The person is assigned to
     *                        this household if it exists.
     * @param firstName       A person's first name. Limited to 20 characters.
     * @param lastName        A person's last name. Limited to 20 characters.
     * @param birthDate       A person's birth date in mm-dd-yyyy format.
     * @param email           A person's email (optional). Limited to 80 characters.
     * @param phone           A person's phone (optional). Limited to 10 characters.
     * @return An integer representing the number of rows created.
     * @author Kent Mayoya
     */
    @Transactional
    @Modifying
    @Query(nativeQuery = true, value = """
                INSERT INTO Person (SSN, MaritalStatusID, HouseholdID, firstName, lastName, birthDate, email, phone)
                VALUES (:ssn, :maritalstatusid, (SELECT ID FROM Household WHERE lotNumber = :lotNumber),
                    :firstName, :lastName, :birthdate, :email, :phone)
            """)
    public int addPerson(
            @Param("ssn") String ssn,
            @Param("maritalstatusid") Character MaritalStatusID,
            @Param("lotNumber") String lotNumber,
            @Param("firstName") String firstName,
            @Param("lastName") String lastName,
            @Param("birthdate") Date birthDate,
            @Param("email") Optional<String> email,
            @Param("phone") Optional<String> phone);

    /**
     * Supporting Query -- DO NOT GRADE
     * Queries the database to get the number of People with a specific ssn.
     * 
     * @param ssn A person's social security number, 9 characters long.
     * @return 1 if the ssn exists, otherwise 0.
     * @author Kent Mayoya
     */
    @Query(nativeQuery = true, value = """
                SELECT COUNT(*)
                FROM Person
                WHERE ssn = :ssn
            """)
    public int ssnExists(@Param("ssn") String ssn);

    /**
     * find all struggling parents (parents that have at least 3 dependents,
     * people under 18 years old in the household, and that don't have a property tax 
     * record with type of 'House')
     * 
     * @return a list of people entities
     * @author Alan Talavera-Cordova
     */
    @Query(nativeQuery = true, value = """
                SELECT
                    p.ssn, p.firstname, p.lastname, ms.name,
                    p.birthdate, p.email, p.phone
                FROM
                    Person p
                JOIN
                    MaritalStatus ms
                    ON p.MaritalStatusID = ms.ID
                JOIN
                    Person c
                    ON c.HouseholdID = p.HouseholdID
                    AND c.ID != p.ID
                WHERE
                    ms.name = 'Married'
                    AND age(current_date, c.Birthdate) < interval '18 years'
                    AND NOT EXISTS (
                        SELECT *
                        FROM PersonalPropertyTax ppt
                        JOIN PersonalProperty pp ON ppt.PropertyID = pp.ID
                        JOIN PropertyType pt ON pp.PropertyTypeID = pt.ID
                        WHERE ppt.OwnerID = p.ID
                        AND pt.Name = 'House'
                    )
                GROUP BY
                    p.ssn, p.firstname, p.lastname, ms.name,
                    p.birthdate, p.email, p.phone
                HAVING
                    COUNT(c.ID) >= 3
            """)
    public List<PersonDto> getNeedyParents();

    @Query(nativeQuery = true, value = """
            SELECT AGE(Person.birthdate) < INTERVAL '18 years'
            FROM Person
            WHERE Person.ssn = :ssn
            """)
    public Boolean isDependent(@Param("ssn") String ssn);
}