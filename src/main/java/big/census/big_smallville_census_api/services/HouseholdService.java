package big.census.big_smallville_census_api.services;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import big.census.big_smallville_census_api.repositories.HouseholdRepository;
import big.census.big_smallville_census_api.repositories.PersonRepository;
import big.census.big_smallville_census_api.dtos.PersonDto;

@Service
public class HouseholdService {
    @Autowired
    private HouseholdRepository householdRepository;

    @Autowired
    private PersonRepository personRepository;

    private final BigDecimal incentiveRatio = new BigDecimal(0.02);

    /**
     * <p>
     * Calculate the incentive given the number of dependents to consider.
     * </p>
     * 
     * @author Gabe Lapingcao
     * @param numberOfDependents the number of dependents within the household
     * @return the tax percentage amount for incentive
     * @see {@link big.census.big_smallville_census_api.services.HouseholdService.getNumberOfDependentsOfPerson}
     */
    public BigDecimal incentiveAmountCalculation(Integer numberOfDependents) {
        if (numberOfDependents <= 0) {
            return new BigDecimal(0);
        }
        return new BigDecimal(numberOfDependents).multiply(incentiveRatio);
    }

    /**
     * <p>
     * Count the number of dependents associated with the person of the given Social
     * Security Number. If this person happens to also be a dependent, return 0.
     * </p>
     * 
     * @author Gabe Lapingcao
     * @param ssn the given person's Social Security Number
     * @return the number of dependents associated with the person of the given
     *         Social Security Number
     * @see
     */
    public Integer getNumberOfDependentsOfPerson(String ssn) {
        if (personRepository.isDependent(ssn)) {
            return 0;
        }
        String lotNumber = personRepository.getLotNumberOfPerson(ssn);
        return householdRepository.numberOfDependents(lotNumber);
    }

    /**
     * <p>
     * Retrieve the lot number associated with the specified address.
     * </p>
     * 
     * @author Gabe Lapingcao
     * @param street          the street component of the address
     * @param zipcode         the zipcode component of the address
     * @param houseNumber     the house number component of the address
     * @param district        the district the address is located within
     * @param apartmentNumber the apartment number of the house (nullable)
     * @return the lot number associated with the specified address
     */
    public String getLotNumber(String street, String zipcode, String houseNumber, String district,
            String apartmentNumber) {
        return householdRepository.getLotNumber(street, zipcode, houseNumber, district, apartmentNumber);
    }

    /**
     * Fetches household members for the given lot number.
     * 
     * @param lotNumber An integer representing the household’s lot number.
     * @param limit     An integer representing the maximum number of rows to
     *                  return.
     * @return A list of person objects within the requested household.
     * @author Kent Mayoya
     */
    public List<PersonDto> getHouseholdMembers(Integer lotNumber, Integer limit) {
        return householdRepository.getHouseholdMembers(lotNumber, limit);
    }

    /**
     * Checks if a household with a specific lot number exists within the database.
     * 
     * @param lotNumber A household's lot number.
     * @return True if it exists. Otherwise, false.
     * @author Kent Mayoya
     */
    public boolean lotNumberExists(String lotNumber) {
        return householdRepository.lotNumberExists(lotNumber) > 0;
    }

}