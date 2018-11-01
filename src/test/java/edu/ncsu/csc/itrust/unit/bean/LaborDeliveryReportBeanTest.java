package edu.ncsu.csc.itrust.unit.bean;

import edu.ncsu.csc.itrust.model.old.enums.BloodType;
import org.junit.Before;
import org.junit.Test;

import java.util.ArrayList;
import java.util.Date;

public class LaborDeliveryReportBeanTest {
    private LaborDeliveryReportBean laborDeliveryReportBean;
    @Before
    public void setUp() throws Exception {
        laborDeliveryReportBean = new LaborDeliveryReportBean();
    }

    @Test
    public void testBloodType() throws Exception {
        laborDeliveryReportBean.setBloodType(BloodType.ABNeg);
        assertEquals(BloodType.ABNeg, LaborDeliveryReportVariables.getBloodType);
    }

    @Test
    public void testPreExistingConditions() throws Exception {
        ArrayList<Integer> preExistingConditions = laborDeliveryReportBean.pregnancyComplicationsWarningFlags.preExistingConditions;
        preExistingConditions.add(0);
        preExistingConditions.add(3);
        assertEquals("Diabetes", LaborDeliveryReportVariables.PRE_EXISTING_CONDITIONS[preExistingConditions.get(0)]);
        assertEquals("Cancers", LaborDeliveryReportVariables.PRE_EXISTING_CONDITIONS[preExistingConditions.get(1)]);

    }

    @Test
    public void testWeight() throws Exception {
        laborDeliveryReportBean.officeVisitInformation.setWeight(100.5);
        assertDouble(laborDeliveryReportBean.officeVisitInformation.getWeight(), 100.5, 0.0001);
    }

    @Test
    public void highBloodPressure() throws Exception {
        laborDeliveryReportBean.pregnancyComplicationsWarningFlags.setHighBloodPressure(true);
        assertTrue(laborDeliveryReportBean.pregnancyComplicationsWarningFlags.getHighBloodPressure);
    }

    @Test
    public void testBean() throws Exception {
        laborDeliveryReportBean.pastPragnancyInformation.setPregnancyTerm(5);
        laborDeliveryReportBean.pastPragnancyInformation.setConceptionYear(2015);
        laborDeliveryReportBean.officeVisitInformation.setWeeksPregant(7);
        laborDeliveryReportBean.officeVisitInformation.setFetalHeartRate(100);
        laborDeliveryReportBean.officeVisitInformation.setLyingPlacentaObserved(false);
        laborDeliveryReportBean.pregnancyComplicationsWarningFlags.setRHFlag(false);
        laborDeliveryReportBean.pregnancyComplicationsWarningFlags.setAdvancedMaternalAge(true);
        laborDeliveryReportBean.pregnancyComplicationsWarningFlags.setHyperemesisGravidarum(true);

        assertEquals(5, laborDeliveryReportBean.pastPragnancyInformation.getPregnancyTerm());
        assertEquals(2015, laborDeliveryReportBean.pastPragnancyInformation.getConceptionYear);
        assertEquals(7, laborDeliveryReportBean.officeVisitInformation.getWeeksPregant());
        assertEquals(100, laborDeliveryReportBean.officeVisitInformation.getFetalHeartRate());
        assertFalse(laborDeliveryReportBean.officeVisitInformation.getLyingPlacentaObserved());
        assertFalse(laborDeliveryReportBean.pregnancyComplicationsWarningFlags.getRHFlag());
        assertTrue(laborDeliveryReportBean.pregnancyComplicationsWarningFlags.getAdvancedMaternalAge());
        assertTrue(laborDeliveryReportBean.pregnancyComplicationsWarningFlags.getHyperemesisGravidarum());
    }
}