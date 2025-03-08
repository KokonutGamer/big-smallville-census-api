package big.census.big_smallville_census_api.entities;

import java.math.BigDecimal;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Data;
import lombok.NonNull;

@Entity
@Data
@Table(name = "businessrecord")
public class BusinessRecord {
    @Id
    private Integer id;

    @NonNull
    private BigDecimal revenue;

    @NonNull
    private BigDecimal expenses;

    @NonNull
    private BigDecimal profit;

    @NonNull
    @Column(name = "taxespaid")
    private BigDecimal taxesPaid;

    @NonNull
    @Column(name = "propertytaxes")
    private BigDecimal propertyTaxes;

    @NonNull
    private Integer year;

}