package big.census.big_smallville_census_api.entities;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;
import lombok.NonNull;
import lombok.NoArgsConstructor;

@Entity
@NoArgsConstructor
@Data
@Table(name = "maritalstatus")
public class MaritalStatus {

    @Id
    private Character id;

    @NonNull
    private String name;
}