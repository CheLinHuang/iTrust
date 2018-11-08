package edu.ncsu.csc.itrust.unit.bean;

import edu.ncsu.csc.itrust.model.old.beans.TravelHistoryBean;
import junit.framework.TestCase;

public class TravelHistoryBeanTest extends TestCase {
    TravelHistoryBean testBean;
    TravelHistoryBean testBean2;
    TravelHistoryBean testBean3;

    /**
     * setUp
     */
    @Override
    public void setUp() {
        testBean = new TravelHistoryBean();
        testBean2 = new TravelHistoryBean();
        testBean3 = new TravelHistoryBean();
    }

    /**
     * testPatientMID
     */
    public void testPatientMID() {
        testBean.setPatientMID(1L);
        assertEquals(testBean.getPatientMID(), 1L);
    }

    /**
     * testStartDate
     */
    public void testStartDate() {
        testBean.setStartDate(null);

        assertEquals(testBean.getStartDate(), null);
    }

    /**
     * testEndDate
     */
    public void testEndDate() {
        testBean.setEndDate(null);

        assertEquals(testBean.getEndDate(), null);
    }

    /**
     * testEquals
     */
    public void testEquals() {
        assertTrue(testBean2.equals(testBean3));
    }
}
