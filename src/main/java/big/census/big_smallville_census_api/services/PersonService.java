package big.census.big_smallville_census_api.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import big.census.big_smallville_census_api.repositories.PersonRepository;

import big.census.big_smallville_census_api.entities.MaritalStatus;
import big.census.big_smallville_census_api.entities.Person;

import java.util.Date;
import java.util.List;

@Service
public class PersonService {
    @Autowired
    private PersonRepository personRepository;

    /**
     * Fetches household members for the given lot number.
     * 
     * @param lotNumber An integer representing the household’s lot number.
     * @return          True if a person was created. Otherwise, false.
     * @author  Kent Mayoya
     */
    public boolean addPerson(
        String ssn,
        MaritalStatus maritalStatus, 
        String lotNumber, 
        String firstName, 
        String lastName, 
        Date birthDate, 
        String email, 
        String phone) {
        return personRepository.addPerson(ssn, maritalStatus.getId(), lotNumber, firstName, lastName, birthDate, email, phone) > 0;
    }

    /**
     * Checks if a person with a specific social security number exists.
     * 
     * @param ssn   A person's social security number.
     * @return      True if a person with the ssn exists. Otherwise, false.
     * @author Kent Mayoya
     */
    public boolean ssnExists(String ssn) {
        return personRepository.ssnExists(ssn) > 0;
    }

    public List<Person> getNeedyParents() {
        return personRepository.getNeedyParents();
    }
}