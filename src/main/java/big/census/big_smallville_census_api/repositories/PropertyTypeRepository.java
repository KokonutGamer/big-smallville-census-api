package big.census.big_smallville_census_api.repositories;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import big.census.big_smallville_census_api.dtos.PropertyTypeDto;
import big.census.big_smallville_census_api.entities.PropertyType;

public interface PropertyTypeRepository extends JpaRepository<PropertyType, String> {
  /**
   * Update Tax Percentage For A Specific Property Type
   * Update the tax percentage based on a given property type name.
   * Lowering tax for a property type may incentivize civilians to purchase them
   * more, and raising tax for a property type may push them away from
   * purchasing those types of property. 
   * 
   * @param newTaxPercentage the new tax percentage desired
   * @param propertyTypeName the property type name for which we want to update
   * the tax percentage 
   * @return Integer, 1 if updated, 0 if the given name is invalid or the new
   * percentage is negative
   * 
   * @author Ting Gao
   */
  @Modifying
  @Query(nativeQuery = true, value =
    """
    BEGIN;
    UPDATE PropertyType
    SET taxPercentage = :newTaxPercentage
    WHERE id = (SELECT id FROM PropertyType WHERE name = :propertyTypeName);
    COMMIT;
    """
    )
  Integer setTaxPercentageForASpecificPropertyType(@Param("newTaxPercentage") BigDecimal newTaxPercentage, @Param("propertyTypeName") String propertyTypeName);

  /**
   * Check if the give property type name is valid
   * 
   * @param typeName the the property type name for which we want to update
   * the tax percentage
   * @return true if valid, false if not
   * 
   * @author Ting Gao
   */
  @Query(nativeQuery = true, value =
    """
    SELECT COUNT(*) = 1
    FROM propertytype
    WHERE name = :typeName;
    """
    )
  boolean isTypeValid(@Param("typeName") String typeName);

  /**
   * Display name and taxPercentage attributes of PropertyType Table, hiding ID
   * 
   * @return the PropertyType Table
   * 
   * @author Ting Gao
   */
  @Query(nativeQuery = true, value =
    """
    SELECT PT.name, PT.taxPercentage
    FROM PropertyType AS PT
    ORDER BY PT.name;
    """
    )
  List<PropertyTypeDto> displayPropertyTypeTable();
}