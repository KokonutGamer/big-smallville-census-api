package big.census.big_smallville_census_api.services;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import big.census.big_smallville_census_api.repositories.HouseholdRepository;
import big.census.big_smallville_census_api.repositories.PersonRepository;
import big.census.big_smallville_census_api.entities.Person;

@Service
public class HouseholdService {
    @Autowired
    private HouseholdRepository householdRepository;

    @Autowired
    private PersonRepository personRepository;

    private final BigDecimal incentiveRatio = new BigDecimal(0.02);

    // Calculate incentives as a linear multiplier (for now)
    public BigDecimal incentiveAmountCalculation(Integer numberOfDependents) {
        if (numberOfDependents <= 0) {
            return new BigDecimal(0);
        }
        return new BigDecimal(numberOfDependents).multiply(incentiveRatio);
    }

    public Integer getNumberOfDependentsOfPerson(String ssn) {
        String lotNumber = personRepository.getLotNumberOfPerson(ssn);
        return householdRepository.numberOfDependents(lotNumber);
    }

    public String getLotNumber(String street, String zipcode, String houseNumber, String district,
            String apartmentNumber) {
        return householdRepository.getLotNumber(street, zipcode, houseNumber, district, apartmentNumber);
    }

    /**
     * Fetches household members for the given lot number.
     * 
     * @param lotNumber An integer representing the household’s lot number.
     * @return A list of person objects within the requested household.
     * @author Kent Mayoya
     */
    public List<Person> getHouseholdMembers(Integer lotNumber) {
        return householdRepository.getHouseholdMembers(lotNumber);
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