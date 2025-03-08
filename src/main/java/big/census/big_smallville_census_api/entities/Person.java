package big.census.big_smallville_census_api.entities;

import java.sql.Date;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.ManyToOne;
import lombok.Data;
import lombok.NonNull;

@Entity
@Data
public class Person {
    private @Id @GeneratedValue(strategy = GenerationType.IDENTITY) Integer id;
    private @NonNull String SSN;
    private @NonNull String maritalstatusid;
    
    // TODO implement Household entity with @ManyToOne mapping

    private @NonNull String firstname;
    private @NonNull String lastname;
    private @NonNull Date birthdate;
    private String email;
    private String phone;
}