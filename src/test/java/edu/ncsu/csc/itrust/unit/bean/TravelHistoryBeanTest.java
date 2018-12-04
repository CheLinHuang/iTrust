package edu.ncsu.csc.itrust.unit.bean;

import edu.ncsu.csc.itrust.model.old.beans.TravelHistoryBean;
import junit.framework.TestCase;

public class TravelHistoryBeanTest extends TestCase {
    TravelHistoryBean testBean;

    /**
     * setUp
     */
    @Override
    public void setUp() {
        testBean = new TravelHistoryBean();
    }

    /**
     * testPatientMID
     */
    public void testPatientMID() {
        testBean.setPatientMID(10L);
        assertEquals(testBean.getPatientMID(), 10L);
    }

    /**
     * testStartDate
     */
    public void testStartDate() {
        java.sql.Date date = new java.sql.Date(System.currentTimeMillis() - 10000000000L);
        testBean.setStartDate(date);
        assertEquals(testBean.getStartDate(), date);
    }

    /**
     * testEndDate
     */
    public void testEndDate() {
        java.sql.Date date = new java.sql.Date(System.currentTimeMillis() - 10000000000L);
        testBean.setEndDate(date);
        assertEquals(testBean.getEndDate(), date);
    }
}
