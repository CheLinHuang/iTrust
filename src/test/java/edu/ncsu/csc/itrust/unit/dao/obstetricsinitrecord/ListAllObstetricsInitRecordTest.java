package edu.ncsu.csc.itrust.unit.dao.obstetricsinitrecord;

import edu.ncsu.csc.itrust.model.old.beans.ObstetricsInitRecordBean;
import edu.ncsu.csc.itrust.model.old.dao.mysql.ObstetricsInitRecordDAO;
import edu.ncsu.csc.itrust.unit.datagenerators.TestDataGenerator;
import edu.ncsu.csc.itrust.unit.testutils.TestDAOFactory;
import junit.framework.TestCase;

import java.util.List;

public class ListAllObstetricsInitRecordTest extends TestCase {
  private ObstetricsInitRecordDAO obstetricsInitRecordDAO = TestDAOFactory.getTestInstance().getObstetricsInitRecordDAO();

  @Override
  protected void setUp() throws Exception {
    TestDataGenerator gen = new TestDataGenerator();
    gen.clearAllTables();
    gen.obstetricsInitRecord1();
  }

  public void testListAllObstetricsInitRecord() throws Exception {
    List<ObstetricsInitRecordBean> list = obstetricsInitRecordDAO.getAllObstetricsInitRecord(6L);
    assertEquals(1, list.size());
    ObstetricsInitRecordBean obstetricsInitRecordBean = list.get(0);

    assertEquals(6, obstetricsInitRecordBean.getMID());
    assertEquals("20-6", obstetricsInitRecordBean.getWeeksOfPregnant());
    assertEquals("01/01/2018", obstetricsInitRecordBean.getLMP());
    assertEquals("10/08/2018", obstetricsInitRecordBean.getEDD());
  }
}
