package edu.ncsu.csc.itrust.unit.dao.travelhistory;

import edu.ncsu.csc.itrust.exception.DBException;
import edu.ncsu.csc.itrust.exception.ITrustException;
import edu.ncsu.csc.itrust.model.old.beans.TravelHistoryBean;
import edu.ncsu.csc.itrust.model.old.dao.mysql.TravelHistoryDAO;
import edu.ncsu.csc.itrust.model.old.dao.DAOFactory;
import edu.ncsu.csc.itrust.unit.datagenerators.TestDataGenerator;
import edu.ncsu.csc.itrust.unit.testutils.TestDAOFactory;
import junit.framework.TestCase;
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

public class TravelHistoryDAOTest extends TestCase {
    /** TravelHistoryDAO instance for testing */
    private TravelHistoryDAO tdao = TestDAOFactory.getTestInstance().getTravelHistoryDAO();
    /**
     * Provide setup for the rest of the tests; initialize all globals.
     *
     * @throws Exception
     */
    @Before
    public void setUp() throws Exception {
        TestDataGenerator gen = new TestDataGenerator();
        gen.clearAllTables();
        gen.travelHistory1();
    }

    /**
     * Tests adding a TravelHistory to the TravelHistoryTable.
     * Pre-condition: assuming the TravelHistoryDAO.getAllTravelHistory() works
     */
    @Test
    public final void testAddTravelHistoryValid() {
        try {
            TravelHistoryBean thb = new TravelHistoryBean();
            thb.setPatientMID(12L);
            java.sql.Date before = new java.sql.Date(System.currentTimeMillis() - 100000L);
            java.sql.Date rightNow = new java.sql.Date(System.currentTimeMillis());
            thb.setStartDate(before);
            thb.setEndDate(rightNow);
            thb.setTravelledCities("Paris,France");
            tdao.addTravelHistory(thb);
            assertEquals(1, tdao.getTravelHistoriesByMID(12).size());
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
        try {
            List<TravelHistoryBean> l = tdao.getTravelHistoriesByMID(16L);
            // test getting TravelHistory for p1
            assertEquals(1, l.size());
        } catch (DBException e) {
            fail();
        } catch (ITrustException e) {
            e.printStackTrace();
        }
    }
}
