package big.census.big_smallville_census_api.entities;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;

@Entity
@NoArgsConstructor
@Data
@Table(name = "business")
public class Business {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @NonNull
    private String name;

    private String email;

    @Column(columnDefinition = "BPCHAR(10)")
    private String phone;

    @NonNull
    private String street;

    @NonNull
    @Column(name = "zipcode", columnDefinition = "BPCHAR(5)")
    private String zipCode;

    @NonNull
    @Column(name = "buildingnumber")
    private String buildingNumber;
}