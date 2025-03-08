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
@Table(name = "taxrecord")
public class TaxRecord {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @NonNull
    @ManyToOne
    @JoinColumn(name = "personid")
    private Person person;

    @NonNull
    private Integer year;

    @NonNull
    @Column(name = "numofdependents")
    private Integer numberOfDependents;

    @NonNull
    @Column(name = "taxespaid")
    private BigDecimal taxesPaid;
}