package big.census.big_smallville_census_api.services;

import java.math.BigDecimal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import big.census.big_smallville_census_api.repositories.PropertyTypeRepository;

@Service
public class PropertyTypeService {
    @Autowired
    private PropertyTypeRepository propertyTypeRepository;

    // false if the type doesn't exist, percentage already set, or new percentage
    // negative
    public boolean updateTaxPercentageForASpecificPropertyType(BigDecimal newTaxPercentage, String propertyTypeName) {
        if (!propertyTypeRepository.isTypeValid(propertyTypeName)
                || (newTaxPercentage.compareTo(BigDecimal.ZERO) < 0)) {
            return false;
        }

        propertyTypeRepository.setTaxPercentageForASpecificPropertyType(newTaxPercentage, propertyTypeName);
        return true;
    }
}