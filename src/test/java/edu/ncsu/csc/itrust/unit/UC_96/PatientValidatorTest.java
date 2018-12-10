package edu.ncsu.csc.itrust.unit.UC_96;

import edu.ncsu.csc.itrust.exception.FormValidationException;
import edu.ncsu.csc.itrust.model.old.beans.PatientBean;
import edu.ncsu.csc.itrust.model.old.validate.PatientValidator;
import junit.framework.TestCase;

public class PatientValidatorTest extends TestCase {
    private PatientValidator validator = new PatientValidator();

    public void testInvalidPatientEmail() {
    	PatientBean bean = new PatientBean();
        bean.setFirstName("test");
        bean.setLastName("one");
        bean.setEmail("not_a_email");
        try {
            validator.validate(bean);
            fail("Validator should throw the FormValidationException");
        } catch (FormValidationException e) {
            assertEquals("Email: Up to 30 alphanumeric characters and symbols . and _ @", e.getErrorList().get(0));
        }
    }

    public void testInvalidName() {
        PatientBean bean = new PatientBean();
        bean.setFirstName("test");
        bean.setLastName("");
        bean.setEmail("real_email@gmail.com");
        try {
            validator.validate(bean);
            fail("Validator should throw the FormValidationException");
        } catch (FormValidationException e) {
            assertEquals("Last name: Up to 20 Letters, space, ' and -", e.getErrorList().get(0));
        }
    }

    public void testValidTravelHistory() {
    	PatientBean bean = new PatientBean();
        bean.setFirstName("test");
        bean.setLastName("one");
        bean.setEmail("real_email@gmail.com");
        try {
            validator.validate(bean);
        } catch (FormValidationException e) {
            fail("Validator should not throw the FormValidationException");
        }
    }
}
