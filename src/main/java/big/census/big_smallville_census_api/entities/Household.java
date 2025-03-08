package big.census.big_smallville_census_api.entities;

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
@Table(name = "household")
public class Household {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @NonNull
    private String lotnumber;

    @NonNull
    private String street;

    @NonNull
    @Column(columnDefinition = "BPCHAR(5)")
    private String zipcode;

    @NonNull
    private String housenumber;

    private String apartmentnumber;

    @NonNull
    @ManyToOne
    @JoinColumn(name = "districtid")
    private District district;
}