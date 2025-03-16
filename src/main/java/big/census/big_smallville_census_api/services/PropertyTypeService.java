package big.census.big_smallville_census_api.services;

import java.math.BigDecimal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import big.census.big_smallville_census_api.repositories.PropertyTypeRepository;

@Service
public class PropertyTypeService {
    @Autowired
    private PropertyTypeRepository propertyTypeRepository;

    //false if the type doesn't exist, percentage already set, or new percentage negative
    @Transactional
    public Integer updateTaxPercentageForASpecificPropertyType(BigDecimal newTaxPercentage, String propertyTypeName){
        if (!propertyTypeRepository.isTypeValid(propertyTypeName) || (newTaxPercentage.compareTo(BigDecimal.ZERO) < 0)) {
            return 0;
        }

        propertyTypeRepository.setTaxPercentageForASpecificPropertyType(newTaxPercentage, propertyTypeName);
        return 1;
    }
}