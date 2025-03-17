package big.census.big_smallville_census_api.services;

import org.springframework.beans.factory.annotation.Autowired;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.stereotype.Service;
import big.census.big_smallville_census_api.entities.BusinessRecord;
import big.census.big_smallville_census_api.dtos.EmployeeDto;

import big.census.big_smallville_census_api.repositories.BusinessRepository;

@Service
public class BusinessService {
    @Autowired
    private BusinessRepository businessRepository;

    public BigDecimal getAverageIncome(String businessName) {
        return businessRepository.avgEmployeeIncome(businessName);
    }

    /**
     * Show first name, last name, and income of all employees based on a given
     * business name.
     * 
     * @param businessName the given business name
     * @return a list of employees' first names, last names, and incomes
     * 
     * @author Ting Gao
     */
    public List<EmployeeDto> listEmployeesInABusiness(String businessName) {
        return businessRepository.getEmployeesInABusiness(businessName);
    }

    /**
     * @author David Phillips
     * @description returns a list of business records form a given business name
     * @param businessName
     * @return BusinessRecordResponse: a wrapper class which holds a list of
     *         business
     *         objects
     */
    public List<BusinessRecord> listRecordsOfABusiness(String businessName) {
        return businessRepository.getRecordsOfABusiness(businessName);
    }

    /**
     * @author David Phillips
     * @description updates all employee wages of a company below a threshold to be
     *              at that threshold
     * @param businessName, newWage:
     * @return WageUpdateResponse: A count of the employees updated
     */
    public int updateMinWage(String businessName, Integer newWage) {
        return businessRepository.updateMinWage(businessName, newWage);
    }
}