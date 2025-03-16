package big.census.big_smallville_census_api.repositories;

import java.math.BigDecimal;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import big.census.big_smallville_census_api.entities.PropertyType;

public interface PropertyTypeRepository extends JpaRepository<PropertyType, String> {
  @Query(nativeQuery = true, value = """
      UPDATE PropertyType
      SET taxPercentage = :newTaxPercentage
      WHERE name = :propertyTypeName;
      """)
  void setTaxPercentageForASpecificPropertyType(@Param("newTaxPercentage") BigDecimal newTaxPercentage,
      @Param("propertyTypeName") String propertyTypeName);

  @Query(nativeQuery = true, value = """
      SELECT COUNT(*) = 1
      FROM propertytype
      WHERE name = :typeName;
      """)
  boolean isTypeValid(@Param("typeName") String typeName);
}