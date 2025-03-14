package big.census.big_smallville_census_api.entities;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;
import lombok.NonNull;
import lombok.NoArgsConstructor;

@Entity
@Data
@NoArgsConstructor
@Table(name = "district")
public class District {
    @Id
    @Column(columnDefinition = "BPCHAR(2)")
    private String id;

    @NonNull
    private String name;
}