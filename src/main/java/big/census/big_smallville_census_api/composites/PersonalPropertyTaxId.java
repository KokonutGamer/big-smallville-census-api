package big.census.big_smallville_census_api.composites;

import java.io.Serializable;
import java.util.Objects;

import jakarta.persistence.Embeddable;

@Embeddable
public class PersonalPropertyTaxId implements Serializable {
    private Integer propertyId;
    private Integer ownerId;

    public PersonalPropertyTaxId(Integer propertyId, Integer ownerId) {
        this.propertyId = propertyId;
        this.ownerId = ownerId;
    }

    @Override
    public int hashCode() {
        return Objects.hash(propertyId, ownerId);
    }

    @Override
    public boolean equals(Object obj) {
        if(obj == null || !(obj instanceof PersonalPropertyTaxId)) {
            return false;
        }
        PersonalPropertyTaxId other = (PersonalPropertyTaxId) obj;
        return this.propertyId == other.propertyId && this.ownerId == other.ownerId;
    }

}