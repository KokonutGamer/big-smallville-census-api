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
    @Column(name = "lotnumber")
    private String lotNumber;

    @NonNull
    private String street;

    @NonNull
    @Column(name = "zipcode", columnDefinition = "BPCHAR(5)")
    private String zipCode;

    @NonNull
    @Column(name = "housenumber")
    private String houseNumber;

    @Column(name = "apartmentnumber")
    private String apartmentNumber;

    @NonNull
    @ManyToOne
    @JoinColumn(name = "districtid")
    private District district;
}