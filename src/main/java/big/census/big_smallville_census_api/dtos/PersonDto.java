/**
 * Person Data Transfer Object (DTO) to limit the number of fields queried from the Person database.
 * 
 * @author Kent Mayoya
 */
package big.census.big_smallville_census_api.dtos;

import lombok.Data;
import java.util.Date;

@Data
public class PersonDto
{
  private final String ssn;
  private final String firstName;
  private final String lastName;
  private final String maritalStatus;
  private final Date birthDate;
  private final String email;
  private final String phone;

  public PersonDto(String ssn, String firstName, String lastName, String maritalStatus,
    Date birthDate, String email, String phone) {
    this.ssn = ssn;
    this.firstName = firstName;
    this.lastName = lastName;
    this.maritalStatus = maritalStatus;
    this.birthDate = birthDate;
    this.email = email;
    this.phone = phone;
  }
}