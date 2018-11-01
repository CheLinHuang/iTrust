package edu.ncsu.csc.itrust.unit.bean;

import edu.ncsu.csc.itrust.model.old.beans.FetusRecordBean;
import junit.framework.TestCase;

public class FetusRecordBeanTest extends TestCase {

    public void testBean() {
        FetusRecordBean frb = new FetusRecordBean();

        assertEquals(frb.getAppointments().length(), 0);
    }
}
