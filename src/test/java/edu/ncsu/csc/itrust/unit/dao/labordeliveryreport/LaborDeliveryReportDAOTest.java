package edu.ncsu.csc.itrust.unit.dao.labordeliveryreport;

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
        //testBean.setDateRequested(new Timestamp(Calendar.getInstance().getTimeInMillis()));
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

        //assertEquals("Test Hospital", testBean.getRecHospitalName());
        //testBean.setRecHospitalAddress("Test");

        assertTrue(testDAO.updateLaborDeliveryReport(testBean));
        List<LaborDeliveryReportBean> list = testDAO.getAllLaborDeliveryReport();
        assertEquals(1, list.size());
        //assertEquals("Test", list.get(0).getRecHospitalAddress());
    }

    /**
     * testGetLaborDeliveryReportByID
     *
     * @throws DBException
     */
    public void testGetLaborDeliveryReportByID() throws DBException {
        assertTrue(testDAO.getAllLaborDeliveryReport("1").isEmpty());
        testDAO.addLaborDeliveryReport(testBean);
        testBean = testDAO.getAllLaborDeliveryReport("1").get(0);

        LaborDeliveryReportBean idTestBean = testDAO.getLaborDeliveryReportID(testBean.getReportID());
//        assertTrue(idTestBean != null);
//        assertEquals(testBean.getReleaseID(), idTestBean.getReleaseID());
//        assertEquals(testBean.getDateRequested(), idTestBean.getDateRequested());
//        assertEquals("1", idTestBean.getReleaseHospitalID());
//        assertEquals(1L, idTestBean.getPid());
//        assertEquals("Test Hospital", idTestBean.getRecHospitalName());
//        assertEquals("5 Test Drive", idTestBean.getRecHospitalAddress());
//        assertEquals("Doctor", idTestBean.getDocFirstName());
//        assertEquals("Test", idTestBean.getDocLastName());
//        assertEquals("555-555-5555", idTestBean.getDocPhone());
//        assertEquals("test@test.com", idTestBean.getDocEmail());
//        assertEquals("Justification", idTestBean.getJustification());
//        assertEquals(0, idTestBean.getStatus());
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
