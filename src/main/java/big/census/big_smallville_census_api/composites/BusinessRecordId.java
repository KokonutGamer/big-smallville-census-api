package big.census.big_smallville_census_api.composites;

import java.io.Serializable;
import java.util.Objects;

import jakarta.persistence.Column;
import jakarta.persistence.Embeddable;
import lombok.NonNull;

@Embeddable
public class BusinessRecordId implements Serializable {
    @NonNull
    @Column(name = "businessid")
    private Integer businessId;

    @NonNull
    @Column(name = "quarterid")
    private String quarterId;

    @NonNull
    private Integer year;

    public BusinessRecordId(@NonNull Integer businessId, @NonNull String quarterId, @NonNull Integer year) {
        this.businessId = businessId;
        this.quarterId = quarterId;
        this.year = year;
    }

    @Override
    public int hashCode() {
        return Objects.hash(businessId, quarterId, year);
    }

    @Override
    public boolean equals(Object obj) {
        if(obj == null || !(obj instanceof BusinessRecordId)) {
            return false;
        }
        BusinessRecordId other = (BusinessRecordId) obj;
        return this.businessId == other.businessId && this.quarterId == other.quarterId && this.year == other.year;
    }

}