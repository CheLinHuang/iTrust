package edu.ncsu.csc.itrust.unit.bean;

import static org.easymock.EasyMock.expect;
import static org.easymock.classextension.EasyMock.createControl;
import static org.junit.Assert.fail;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.easymock.classextension.IMocksControl;
import org.junit.Before;
import org.junit.Test;

import edu.ncsu.csc.itrust.model.old.beans.LaborDeliveryReportBean;
import edu.ncsu.csc.itrust.model.old.beans.loaders.LaborDeliveryReportBeanLoader;
import junit.framework.TestCase;

public class LaborDeliveryReportBeanLoaderTest {
    private IMocksControl ctrl;
    private ResultSet rs;
    private LaborDeliveryReportBeanLoader load;

    @Override
    @Before
    public void setUp() throws Exception {
        ctrl = createControl();
        rs = ctrl.createMock(ResultSet.class);
        load = new LaborDeliveryReportBeanLoader();
    }

    @Test
    public void testLoadList() throws SQLException {
        List<LaborDeliveryReportBean> list;

        try {
            list = load.loadList(rs);
        } catch (SQLException e) {
            // TODO
        }

        assertEquals(0, list.size());
    }

    @Test
    public void testLoadSingle() {
        try {
            expect(rs.getString("estimatedDeliveryDate")).andReturn("");
            expect(rs.getBloodType("bloodType")).andReturn("");
            ctrl.replay();

            LaborDeliveryReportBean r = load.loadSingle(rs);
            assertEquals("", r.getString());
            assertEquals("", r.getBloodType());
        } catch (SQLException e) {
            // TODO
        }
    }

    @Test
    public void testLoadParameters() {
        try {
            load.loadParameters(null);
            fail();
        } catch (Exception e) {
            // TODO
        }
    }
}