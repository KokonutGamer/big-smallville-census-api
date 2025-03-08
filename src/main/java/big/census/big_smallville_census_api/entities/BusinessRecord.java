package big.census.big_smallville_census_api.entities;

import java.math.BigDecimal;

import big.census.big_smallville_census_api.composites.BusinessRecordId;
import jakarta.persistence.Column;
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
@Table(name = "businessrecord")
public class BusinessRecord {
    @EmbeddedId
    private BusinessRecordId id;

    @ManyToOne
    @MapsId("businessId")
    @JoinColumn(name = "businessid")
    private Business business;

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

    @ManyToOne
    @MapsId("quarterId")
    @JoinColumn(name = "quarterid", columnDefinition = "BPCHAR(2)")
    private Quarter quarter;
}