/**
 * Property Type Data Transfer Object (DTO) to only display name and taxPercentage
 * queried from the PropertyType database, excluding ID.
 * 
 * @author Ting Gao
 */
package big.census.big_smallville_census_api.dtos;

import java.math.BigDecimal;

public interface PropertyTypeDto {
  String getName();

  BigDecimal getTaxPercentage();
}
