package edu.ncsu.csc.itrust.unit.dao.labordeliveryreport;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import edu.ncsu.csc.itrust.exception.DBException;
import edu.ncsu.csc.itrust.model.old.beans.LaborDeliveryReportBean;
import edu.ncsu.csc.itrust.model.old.dao.mysql.LaborDeliveryReportDAO;
import edu.ncsu.csc.itrust.model.old.dao.DAOFactory;
import edu.ncsu.csc.itrust.unit.datagenerators.TestDataGenerator;
import edu.ncsu.csc.itrust.unit.testutils.EvilDAOFactory;
import edu.ncsu.csc.itrust.unit.testutils.TestDAOFactory;
import junit.framework.TestCase;

public class LaborDeliveryReportDAOTest extends TestCase {

    private TestDataGenerator gen = new TestDataGenerator();
    private DAOFactory factory = TestDAOFactory.getTestInstance();
    private DAOFactory evilFactory = EvilDAOFactory.getEvilInstance();
    private LaborDeliveryReportDAO testDAO;
    private LaborDeliveryReportBean testBean;

    @Override
    protected void setUp() throws Exception {
        gen.clearAllTables();
        testDAO = new LaborDeliveryReportDAO(factory);
        testBean = new LaborDeliveryReportBean();
    }

    /**
     * testAddLaborDeliveryReport
     *
     * @throws DBException
     */
    public void testAddLaborDeliveryReport() throws DBException {
        assertTrue(testDAO.getAllLaborDeliveryReport().isEmpty());
        assertTrue(testDAO.addLaborDeliveryReport(testBean));

        List<LaborDeliveryReportBean> list = testDAO.getAllLaborDeliveryReport();
        assertEquals(1, list.size());
    }

    /**
     * testUpdateLaborDeliveryReport
     *
     * @throws DBException
     */
    public void testUpdateLaborDeliveryReport() throws DBException {
        assertTrue(testDAO.getAllLaborDeliveryReport().isEmpty());
        testDAO.addLaborDeliveryReport(testBean);
        testBean = testDAO.getAllLaborDeliveryReport().get(0);

        ArrayList<Integer> preExistingConditions = testBean.pregnancyComplicationsWarningFlags.preExistingConditions;
        preExistingConditions.add(0);
        preExistingConditions.add(3);
        assertEquals("Diabetes", LaborDeliveryReportVariables.PRE_EXISTING_CONDITIONS[preExistingConditions.get(0)]);
        assertEquals("Cancers", LaborDeliveryReportVariables.PRE_EXISTING_CONDITIONS[preExistingConditions.get(1)]);

        assertTrue(testDAO.updateLaborDeliveryReport(testBean));
        List<LaborDeliveryReportBean> list = testDAO.getAllLaborDeliveryReport();
        assertEquals(1, list.size());
    }

    /**
     * testGetLaborDeliveryReportByID
     *
     * @throws DBException
     */
    public void testGetLaborDeliveryReportByID() throws DBException {
        assertTrue(testDAO.getAllLaborDeliveryReport().isEmpty());
        testDAO.addLaborDeliveryReport(testBean);
        testBean = testDAO.getAllLaborDeliveryReport().get(0);

        testBean.idTestBean = testDAO.getLaborDeliveryReportID(testBean.getReportID());
        testBean.pastPragnancyInformation.setPregnancyTerm(5);
        testBean.pastPragnancyInformation.setConceptionYear(2015);
        testBean.officeVisitInformation.setWeeksPregant(7);
        testBean.officeVisitInformation.setFetalHeartRate(100);
        testBean.officeVisitInformation.setLyingPlacentaObserved(false);
        testBean.pregnancyComplicationsWarningFlags.setRHFlag(false);
        testBean.pregnancyComplicationsWarningFlags.setAdvancedMaternalAge(true);
        testBean.pregnancyComplicationsWarningFlags.setHyperemesisGravidarum(true);

        assertEquals(5, testBean.pastPragnancyInformation.getPregnancyTerm());
        assertEquals(2015, testBean.pastPragnancyInformation.getConceptionYear);
        assertEquals(7, testBean.officeVisitInformation.getWeeksPregant());
        assertEquals(100, testBean.officeVisitInformation.getFetalHeartRate());
        assertFalse(testBean.officeVisitInformation.getLyingPlacentaObserved());
        assertFalse(testBean.pregnancyComplicationsWarningFlags.getRHFlag());
        assertTrue(testBean.pregnancyComplicationsWarningFlags.getAdvancedMaternalAge());
        assertTrue(testBean.pregnancyComplicationsWarningFlags.getHyperemesisGravidarum());
    }

    /**
     * testGetAllLaborDeliveryReport
     *
     * @throws DBException
     */
    public void testGetAllLaborDeliveryReport() throws DBException {
        assertTrue(testDAO.getAllLaborDeliveryReport().isEmpty());
        testDAO.addLaborDeliveryReport(testBean);

        List<LaborDeliveryReportBean> testList = testDAO.getAllLaborDeliveryReport();
        assertEquals(1, testList.size());

        testDAO.addLaborDeliveryReport(testBean);
        testList = testDAO.getAllLaborDeliveryReport();
        assertEquals(2, testList.size());

        testBean.setId(2L);
        testDAO.addLaborDeliveryReport(testBean);
        testList = testDAO.getAllLaborDeliveryReport();
        assertEquals(2, testList.size());
    }

    /**
     * testDBException
     */
    public void testDBException() {
        testDAO = new LaborDeliveryReportDAO(evilFactory);

        try {
            testDAO.addLaborDeliveryReport(testBean);
            // Fail if exception isn't caught
            fail();
        } catch (DBException e) {
            // TODO
        }

        try {
            testDAO.updateLaborDeliveryReport(testBean);
            // Fail if exception isn't caught
            fail();
        } catch (DBException e) {
            // TODO
        }

        try {
            testDAO.getLaborDeliveryReportID(0L);
            // Fail if exception isn't caught
            fail();
        } catch (DBException e) {
            // TODO
        }

        try {
            testDAO.getAllLaborDeliveryReport();
            // Fail if exception isn't caught
            fail();
        } catch (DBException e) {
            // TODO
        }
    }
}
