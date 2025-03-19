/**
 * BusinessRecord Data Transfer Object (DTO) to only display revenue, expenses, profit, taxes paid, property taxes, quarter and year.
 * Omits unnecessary information for this API
 * 
 * Implemented using https://www.javaguides.net/2023/08/spring-data-jpa-specific-columns.html#google_vignette
 * 
 * @author David Phillips
 */
package big.census.big_smallville_census_api.dtos;

import java.math.BigDecimal;

import lombok.Data;

@Data
public class BusinessRecordDto {
    private final BigDecimal revenue;
    private final BigDecimal expenses;
    private final BigDecimal profit;
    private final BigDecimal taxesPaid;
    private final BigDecimal propertyTaxes;
    private final String quarter;
    private final Integer year;

    public BusinessRecordDto(BigDecimal revenue, BigDecimal expenses, BigDecimal profit, BigDecimal taxesPaid,
            BigDecimal propertyTaxes, Integer year, String quarter) {
        this.revenue = revenue;
        this.expenses = expenses;
        this.profit = profit;
        this.taxesPaid = taxesPaid;
        this.propertyTaxes = propertyTaxes;
        this.quarter = quarter;
        this.year = year;
    }
}
