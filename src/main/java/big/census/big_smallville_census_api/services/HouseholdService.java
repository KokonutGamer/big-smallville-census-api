package big.census.big_smallville_census_api.services;

import java.math.BigDecimal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import big.census.big_smallville_census_api.repositories.HouseholdRepository;
import big.census.big_smallville_census_api.repositories.PersonRepository;

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

    public String getLotNumber(String street, String zipcode, String houseNumber, String district, String apartmentNumber) {
        return householdRepository.getLotNumber(street, zipcode, houseNumber, district, apartmentNumber);
    }
}