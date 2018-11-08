package edu.ncsu.csc.itrust.unit.dao.travelhistory;

import edu.ncsu.csc.itrust.exception.DBException;
import edu.ncsu.csc.itrust.exception.ITrustException;
import edu.ncsu.csc.itrust.model.old.beans.TravelHistoryBean;
import edu.ncsu.csc.itrust.model.old.dao.mysql.TravelHistoryDAO;
import edu.ncsu.csc.itrust.model.old.dao.DAOFactory;
import edu.ncsu.csc.itrust.unit.datagenerators.TestDataGenerator;
import edu.ncsu.csc.itrust.unit.testutils.EvilDAOFactory;
import edu.ncsu.csc.itrust.unit.testutils.TestDAOFactory;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Date;
import java.util.List;

import static org.junit.Assert.*;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.fail;

public class TravelHistoryDAOTest {
    /** TravelHistoryDAO instance for testing */
    private TravelHistoryDAO tdao, evil2;
    private EvilDAOFactory evil;

    /** test instance of beans for testing */
    private TravelHistoryBean beanValid, beanInvalid;
    private static final long MID = 42L;
    private static final java.sql.Date REVDATE = new java.sql.Date(new Date().getTime());

    /**
     * Provide setup for the rest of the tests; initialize all globals.
     *
     * @throws Exception
     */
    @Before
    public void setUp() throws Exception {
        TestDataGenerator gen = new TestDataGenerator();
        gen.clearAllTables();
        gen.standardData();
        // gen.uc99TravelHistory();
        DAOFactory factory = TestDAOFactory.getTestInstance();

        tdao = new TravelHistoryDAO(factory);
        evil = new EvilDAOFactory(0);
        evil2 = new TravelHistoryDAO(evil);

        beanValid = new TravelHistoryBean();
        beanValid.setPatientMID(MID);
        beanValid.setStartDate(REVDATE);
        beanValid.setEndDate(REVDATE);

        beanInvalid = new TravelHistoryBean();
        beanInvalid.setPatientMID(MID);
        beanInvalid.setStartDate(REVDATE);
        beanInvalid.setEndDate(REVDATE);
    }

    /**
     * Tests adding a TravelHistory to the TravelHistoryTable.
     * Pre-condition: assuming the TravelHistoryDAO.getAllTravelHistory() works
     */
    @Test
    public final void testAddTravelHistoryValid() {
        try {
            // sanity check for the initial size of the entries in the TravelHistory
            // table
            List<TravelHistoryBean> l = tdao.getTravelHistoriesByMID(1L);
            assertEquals(6, l.size());
            // try adding a valid bean
            assertTrue(tdao.addTravelHistory(beanValid));
            // check the number of TravelHistory table entries went up by 1
            l = tdao.getTravelHistoriesByMID(1L);
            assertEquals(7, l.size());

            assertEquals(false, tdao.addTravelHistory(null));

        } catch (DBException e) {
            fail();
        } catch (ITrustException e) {
            e.printStackTrace();
        }
    }

    /**
     * Tests getting TravelHistory from a current database for a given Patient.
     *
     * @throws DBException
     */
    @Test(expected = DBException.class)
    public final void testGetTravelHistory() throws DBException {
        List<TravelHistoryBean> l = tdao.getTravelHistoriesByMID(1L);
        // test getting TravelHistory for p1
        assertEquals(4, l.size());

        // test getting TravelHistory for p2
        l = tdao.getTravelHistoriesByMID(2L);
        assertEquals(2, l.size());

        evil2.getTravelHistoriesByMID(3L);
    }

    /**
     * Tests adding an invalid TravelHistory
     */
    @Test
    public void testAddInvalidTravelHistory() {
        try {
            beanInvalid.setPatientMID(-1);
            tdao.addTravelHistory(beanInvalid);
            fail("Should have thrown an exception");
        } catch (DBException e) {
            assertEquals("A database exception has occurred. Please see the "
                            + "log in the console for stacktrace", e.getMessage());
        } catch (ITrustException e) {
            e.printStackTrace();
        }
    }

    /**
     * Tests getting TravelHistory with invalid dao
     */
    @Test
    public void testGetTravelHistoryEvilDAO() {
        try {
            evil2.getTravelHistoriesByMID(1L);
            fail("Should have thrown an exception");
        } catch (DBException e) {
            assertEquals("A database exception has occurred. Please see the "
                            + "log in the console for stacktrace", e.getMessage());
        }
    }
}
