package big.census.big_smallville_census_api.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import big.census.big_smallville_census_api.entities.Employee;
import big.census.big_smallville_census_api.repositories.BusinessRepository;

@Service
public class BusinessService {
    /* TODO implement service */
    @Autowired
    private BusinessRepository businessRepository;

    List<Employee> listEmployeesInABusiness(String businessName){
        return businessRepository.getEmployeesInABusiness(businessName);
    }
}