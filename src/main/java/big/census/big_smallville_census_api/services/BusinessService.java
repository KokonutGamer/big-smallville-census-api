package big.census.big_smallville_census_api.services;

import org.springframework.beans.factory.annotation.Autowired;
import java.util.List;

import org.springframework.stereotype.Service;
import big.census.big_smallville_census_api.entities.Employee;
import big.census.big_smallville_census_api.entities.BusinessRecord;

import big.census.big_smallville_census_api.repositories.BusinessRepository;

@Service
public class BusinessService {
    @Autowired
    private BusinessRepository businessRepository;

    public double getAverageIncome(String businessName) {
        return businessRepository.avgEmployeeIncome(businessName);
    }

    public List<Employee> listEmployeesInABusiness(String businessName) {
        return businessRepository.getEmployeesInABusiness(businessName);
    }

    public List<BusinessRecord> listRecordsOfABusiness(String businessName) {
        return businessRepository.getRecordsOfABusiness(businessName);
    }

    public int updateMinWage(String businessName, Integer newWage) {
        return businessRepository.updateMinWage(businessName, newWage);
    }
}