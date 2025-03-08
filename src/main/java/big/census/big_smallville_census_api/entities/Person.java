package big.census.big_smallville_census_api.entities;

import java.sql.Date;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Data;
import lombok.NonNull;

@Entity
@Data
@Table(name = "person")
public class Person {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @NonNull
    @Column(columnDefinition = "BPCHAR(9)")
    private String SSN;

    @NonNull
    private Character maritalstatusid;
    
    // TODO implement Household entity with @ManyToOne mapping

    @NonNull
    private String firstname;

    @NonNull
    private String lastname;

    @NonNull
    private Date birthdate;

    private String email;
    private String phone;
}