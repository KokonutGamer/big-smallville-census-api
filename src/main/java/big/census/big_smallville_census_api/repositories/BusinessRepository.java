package big.census.big_smallville_census_api.repositories;

import org.springframework.data.jpa.repository.JpaRepository;

import big.census.big_smallville_census_api.entities.Business;

public interface BusinessRepository extends JpaRepository<Business, Integer> {
}