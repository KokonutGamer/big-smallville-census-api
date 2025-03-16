package big.census.big_smallville_census_api.services;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import big.census.big_smallville_census_api.dtos.PropertyTypeDto;
import big.census.big_smallville_census_api.repositories.PropertyTypeRepository;

@Service
public class PropertyTypeService {
    @Autowired
    private PropertyTypeRepository propertyTypeRepository;

    /**
     * Update the tax percentage based on a given property type name.
     * 
     * @param newTaxPercentage the new tax percentage desired
     * @param propertyTypeName the property type name for which we want to update
     * the tax percentage 
     * @return Integer, 1 if updated, 0 if the given name is invalid or the new
     * percentage is negative
     * 
     * @author Ting Gao
     */
    @Transactional
    public Integer updateTaxPercentageForASpecificPropertyType(BigDecimal newTaxPercentage, String propertyTypeName){
        // return 0 if the given name is invalid or the new percentage is negative 
        if (!propertyTypeRepository.isTypeValid(propertyTypeName) || (newTaxPercentage.compareTo(BigDecimal.ZERO) < 0)) {
            return 0;
        }

        propertyTypeRepository.setTaxPercentageForASpecificPropertyType(newTaxPercentage, propertyTypeName);
        return 1;
    }

    /**
     * Display PropertyType Table to verify updateTaxPercentageForASpecificPropertyType
     * 
     * @return PropertyType Table
     * 
     * @author Ting Gao
     */
    public List<PropertyTypeDto> displayPropertyTypeTable() {
        return propertyTypeRepository.displayPropertyTypeTable();
    }
}