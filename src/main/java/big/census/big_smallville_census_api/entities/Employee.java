package big.census.big_smallville_census_api.entities;

import java.math.BigDecimal;

import big.census.big_smallville_census_api.composites.EmployeeId;
import jakarta.persistence.EmbeddedId;
import jakarta.persistence.Entity;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.MapsId;
import jakarta.persistence.Table;
import lombok.Data;
import lombok.NonNull;

@Entity
@Data
@Table(name = "employee")
public class Employee {
    @EmbeddedId
    private EmployeeId id;

    @NonNull
    @ManyToOne
    @MapsId("personId")
    @JoinColumn(name = "personid")
    private Person person;

    @NonNull
    @ManyToOne
    @MapsId("businessId")
    @JoinColumn(name = "businessid")
    private Business business;

    @NonNull
    private BigDecimal income;
}