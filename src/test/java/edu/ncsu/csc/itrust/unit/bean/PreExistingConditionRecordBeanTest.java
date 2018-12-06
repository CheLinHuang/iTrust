package edu.ncsu.csc.itrust.unit.bean;

import edu.ncsu.csc.itrust.model.old.beans.PreExistingConditionRecordBean;
import junit.framework.TestCase;

public class PreExistingConditionRecordBeanTest extends TestCase {

    PreExistingConditionRecordBean testBean;

    /**
     * setUp
     */
    @Override
    public void setUp() {
        testBean = new PreExistingConditionRecordBean();
    }

    /**
     * testPatientMID
     */
    public void testPatientMID() {
        testBean.setPatientMID(10L);
        assertEquals(testBean.getPatientMID(), 10L);
    }

    /**
     * testIcdInfo
     */
    public void testIcdInfo() {
        String icd = "024011, Pre-existing type 1 diabetes mellitus, in pregnancy, first trimester, 0";
        testBean.setIcdInfo(icd);
        assertEquals(testBean.getIcdInfo(), icd);
    }
}
