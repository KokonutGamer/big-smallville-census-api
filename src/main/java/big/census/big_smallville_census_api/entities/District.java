package big.census.big_smallville_census_api.entities;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;
import lombok.NonNull;

@Entity
@Data
@Table(name = "district")
public class District {
    District() {}

    @Id
    @Column(columnDefinition = "BPCHAR(2)")
    private String id;

    @NonNull
    private String name;
}