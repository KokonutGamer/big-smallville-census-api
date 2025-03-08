package big.census.big_smallville_census_api.composites;

import java.io.Serializable;
import java.util.Objects;

import jakarta.persistence.Embeddable;

@Embeddable
public class EmployeeId implements Serializable {
    private Integer personId;
    private Integer businessId;
    
    public EmployeeId(Integer personId, Integer businessId) {
        this.personId = personId;
        this.businessId = businessId;
    }

    @Override
    public int hashCode() {
        return Objects.hash(personId, businessId);
    }

    @Override
    public boolean equals(Object obj) {
        if(obj == null || !(obj instanceof EmployeeId)) {
            return false;
        }
        EmployeeId other = (EmployeeId) obj;
        return this.personId == other.personId && this.businessId == other.businessId;
    }
}