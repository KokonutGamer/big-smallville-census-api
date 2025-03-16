package big.census.big_smallville_census_api.services;

import org.springframework.beans.factory.annotation.Autowired;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.stereotype.Service;
import big.census.big_smallville_census_api.entities.BusinessRecord;
import big.census.big_smallville_census_api.dtos.EmployeeNameDto;

import big.census.big_smallville_census_api.repositories.BusinessRepository;

@Service
public class BusinessService {
    @Autowired
    private BusinessRepository businessRepository;

    public BigDecimal getAverageIncome(String businessName) {
        return businessRepository.avgEmployeeIncome(businessName);
    }

    /**
     * Show first name, last name, and income of all employees based on a given business name.
     * 
     * @param businessName the given business name
     * @return a list of employees' first names, last names, and incomes
     * 
     * @author Ting Gao
     */
    public List<EmployeeNameDto> listEmployeesInABusiness(String businessName) {
        return businessRepository.getEmployeesInABusiness(businessName);
    }

    public List<BusinessRecord> listRecordsOfABusiness(String businessName) {
        return businessRepository.getRecordsOfABusiness(businessName);
    }

    public int updateMinWage(String businessName, Integer newWage) {
        return businessRepository.updateMinWage(businessName, newWage);
    }
}