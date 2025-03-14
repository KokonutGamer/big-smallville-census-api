package big.census.big_smallville_census_api.entities;

import java.sql.Date;

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
@Table(name = "person")
public class Person {
    public Person() {
    }

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @NonNull
    @Column(columnDefinition = "BPCHAR(9)")
    private String SSN;

    @NonNull
    @ManyToOne
    @JoinColumn(name = "maritalstatusid")
    private MaritalStatus maritalStatus;

    @NonNull
    @ManyToOne
    @JoinColumn(name = "householdid")
    private Household household;

    @NonNull
    @Column(name = "firstname")
    private String firstName;

    @NonNull
    @Column(name = "lastname")
    private String lastName;

    @NonNull
    @Column(name = "birthdate")
    private Date birthDate;

    private String email;
    private String phone;
}