package edu.ncsu.csc.itrust.unit.dao.travelhistory;

import edu.ncsu.csc.itrust.exception.DBException;
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
    private static final Date REVDATE = new java.sql.Date(new Date().getTime());

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
        beanValid.setMID(MID);
        beanValid.setStartDate(REVDATE);
        beanValid.setEndDate(REVDATE);

        beanInvalid = new TravelHistoryBean();
        beanInvalid.setMID(MID);
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
            List<TravelHistoryBean> l = tdao.getAllTravelHistory();
            assertEquals(6, l.size());
            // try adding a valid bean
            assertTrue(tdao.addTravelHistory(beanValid));
            // check the number of TravelHistory table entries went up by 1
            l = tdao.getAllTravelHistory();
            assertEquals(7, l.size());

            assertEquals(false, tdao.addTravelHistory(null));

        } catch (DBException e) {
            fail();
        }

    }

    /**
     * Tests getting TravelHistory from a current database for a given Patient.
     *
     * @throws DBException
     */
    @Test(expected = DBException.class)
    public final void testGetTravelHistory() throws DBException {
        List<TravelHistoryBean> l = tdao.getAllTravelHistory(1);
        // test getting TravelHistory for p1
        assertEquals(4, l.size());

        // test getting TravelHistory for p2
        l = tdao.getTravelHistory(2);
        assertEquals(2, l.size());

        evil2.getAllTravelHistory();
    }

    /**
     * Tests that ALL in table TravelHistory are retrieved when called.
     */
    @Test
    public final void testGetAllTravelHistory() {
        List<TravelHistoryBean> l;
        try {

            l = tdao.getAllTravelHistory(1);
            assertEquals(4, l.size());
            l.clear();
            assertEquals(0, l.size());

        } catch (Exception e) {
            fail();
        }
    }

    /**
     * Tests adding an invalid TravelHistory
     */
    @Test
    public void testAddInvalidTravelHistory() {
        try {
            beanInvalid.setMID(-1);
            tdao.addTravelHistory(beanInvalid);
            fail("Should have thrown an exception");
        } catch (DBException e) {
            assertEquals("A database exception has occurred. Please see the "
                            + "log in the console for stacktrace", e.getMessage());
        }
    }

    /**
     * Tests getting TravelHistory with invalid dao
     */
    @Test
    public void testGetTravelHistoryEvilDAO() {
        try {
            evil2.getTravelHistory(1);
            fail("Should have thrown an exception");
        } catch (DBException e) {
            assertEquals("A database exception has occurred. Please see the "
                            + "log in the console for stacktrace", e.getMessage());
        }
    }

    /**
     * Tests getting all of the TravelHistory with invalid dao
     */
    @Test
    public void testGetAllTravelHistoryEvilDAO() {
        try {
            evil2.getAllTravelHistory(1);
            fail("Should have thrown an exception");
        } catch (DBException e) {
            assertEquals("A database exception has occurred. Please see the "
                            + "log in the console for stacktrace", e.getMessage());
        }
    }
}
