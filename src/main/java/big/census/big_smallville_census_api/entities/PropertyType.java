package big.census.big_smallville_census_api.entities;

import java.math.BigDecimal;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;
import lombok.NonNull;

@Entity
@Data
@Table(name = "propertytype")
public class PropertyType {
    @Id
    private Character id;

    @NonNull
    private String name;

    @NonNull
    @Column(name = "taxpercentage")
    private BigDecimal taxPercentage;
}