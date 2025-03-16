/**
 * Response when trying to retrieve PropertyType Table (excluding ID).
 * 
 * @author Ting Gao
 */
package big.census.big_smallville_census_api.responses;

import java.util.List;

import big.census.big_smallville_census_api.dtos.PropertyTypeDto;
import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class DisplayPropertyTypeTableResponse {
  private List<PropertyTypeDto> propertyTypes;
}
