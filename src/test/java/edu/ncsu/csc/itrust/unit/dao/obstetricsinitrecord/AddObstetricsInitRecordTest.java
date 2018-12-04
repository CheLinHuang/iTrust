package edu.ncsu.csc.itrust.unit.dao.obstetricsinitrecord;

import edu.ncsu.csc.itrust.model.old.beans.ObstetricsInitRecordBean;
import edu.ncsu.csc.itrust.model.old.dao.mysql.ObstetricsInitRecordDAO;
import edu.ncsu.csc.itrust.unit.datagenerators.TestDataGenerator;
import edu.ncsu.csc.itrust.unit.testutils.TestDAOFactory;
import junit.framework.TestCase;

public class AddObstetricsInitRecordTest extends TestCase {
  private ObstetricsInitRecordDAO obstetricsInitRecordDAO = TestDAOFactory.getTestInstance().getObstetricsInitRecordDAO();

  @Override
  protected void setUp() throws Exception {
    TestDataGenerator gen = new TestDataGenerator();
    gen.clearAllTables();
  }

  public void testAddObstetricsInitRecord() throws Exception {
    ObstetricsInitRecordBean obstetricsInitRecordBean = new ObstetricsInitRecordBean();
    obstetricsInitRecordBean.setMID(1L);
    obstetricsInitRecordBean.setLMP("01/01/2018");
    obstetricsInitRecordBean.setEDD("10/08/2018");
    obstetricsInitRecordBean.setWeeksOfPregnant("20-6");
    obstetricsInitRecordDAO.addObstetricsInitRecord(obstetricsInitRecordBean);
    assertEquals(1, obstetricsInitRecordDAO.getAllObstetricsInitRecord(1L).size());
  }
}
