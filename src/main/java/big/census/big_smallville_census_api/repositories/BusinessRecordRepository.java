package big.census.big_smallville_census_api.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import big.census.big_smallville_census_api.composites.BusinessRecordId;
import big.census.big_smallville_census_api.entities.BusinessRecord;

public interface BusinessRecordRepository extends JpaRepository<BusinessRecord, BusinessRecordId> {
}