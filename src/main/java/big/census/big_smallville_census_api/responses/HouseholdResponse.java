package big.census.big_smallville_census_api.responses;

import java.math.BigDecimal;
import java.util.List;
import big.census.big_smallville_census_api.entities.Person;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class HouseholdResponse {
    private List<Person> householdMembers;
}