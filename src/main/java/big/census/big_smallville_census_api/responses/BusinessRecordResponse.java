package big.census.big_smallville_census_api.responses;

import lombok.AllArgsConstructor;
import lombok.Data;
import java.util.List;

import big.census.big_smallville_census_api.dtos.BusinessRecordDto;

@Data
@AllArgsConstructor
public class BusinessRecordResponse {
    private List<BusinessRecordDto> busRecords;
}
