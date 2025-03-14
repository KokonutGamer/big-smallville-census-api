/**
 * Response when a person is added to the database.
 * 
 * @author Kent Mayoya
 */
package big.census.big_smallville_census_api.responses;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class AddPersonResponse {
    private boolean success;
    private boolean uniqueSSN;
    private boolean lotNumberExists;
}