/**
 * Response when trying to update the tax percentage for a specific property
 * type.
 * 
 * @author Ting Gao
 */
package big.census.big_smallville_census_api.responses;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class TaxPercentageUpdateResponse {
  private Integer updateSuccessInt;
}
