package big.census.big_smallville_census_api.entities;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Data
@Table(name = "quarter")
public class Quarter {
    @Id
    @Column(columnDefinition = "BPCHAR(2)")
    private String id;
}