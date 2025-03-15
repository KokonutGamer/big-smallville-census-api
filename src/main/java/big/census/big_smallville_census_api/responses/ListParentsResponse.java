package big.census.big_smallville_census_api.responses;

import java.util.List;

import big.census.big_smallville_census_api.entities.Person;
import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class ListParentsResponse {
    private List<Person> parents;
};