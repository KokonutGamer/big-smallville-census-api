package big.census.big_smallville_census_api.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import big.census.big_smallville_census_api.repositories.BusinessRepository;

@Service
public class BusinessService {
    @Autowired
    private BusinessRepository businessRepository;

    public double getAverageIncome(String businessName){
        return businessRepository.avgEmployeeIncome(businessName);
    }
}