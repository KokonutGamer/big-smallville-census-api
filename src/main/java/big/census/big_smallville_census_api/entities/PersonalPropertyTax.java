package big.census.big_smallville_census_api.entities;

import big.census.big_smallville_census_api.composites.PersonalPropertyTaxId;
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
@Table(name = "personalpropertytax")
public class PersonalPropertyTax {
    @EmbeddedId
    private PersonalPropertyTaxId id;

    @NonNull
    @ManyToOne
    @MapsId("propertyId")
    @JoinColumn(name = "propertyid")
    private PersonalProperty property;

    @NonNull
    @ManyToOne
    @MapsId("ownerId")
    @JoinColumn(name = "ownerid")
    private Person owner;
}