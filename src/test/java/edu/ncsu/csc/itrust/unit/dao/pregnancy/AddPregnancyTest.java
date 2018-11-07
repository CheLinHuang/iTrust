package edu.ncsu.csc.itrust.unit.dao.pregnancy;

import edu.ncsu.csc.itrust.model.old.beans.PregnancyBean;
import edu.ncsu.csc.itrust.model.old.dao.mysql.PregnancyDAO;
import edu.ncsu.csc.itrust.unit.datagenerators.TestDataGenerator;
import edu.ncsu.csc.itrust.unit.testutils.TestDAOFactory;
import junit.framework.TestCase;

public class AddPregnancyTest extends TestCase {
  private PregnancyDAO pregnancyDAO = TestDAOFactory.getTestInstance().getPregnancyDAO();

  @Override
  protected void setUp() throws Exception {
    TestDataGenerator gen = new TestDataGenerator();
    gen.clearAllTables();
  }

  public void testAddPregnancy() throws Exception {
    PregnancyBean pregnancyBean = new PregnancyBean();
    pregnancyBean.setMID(1L);
    pregnancyBean.setYearOfConception(2018);
    pregnancyBean.setDeliveryType("vaginal delivery");
    pregnancyDAO.addPregnancy(pregnancyBean);
    assertEquals(1, pregnancyDAO.getAllPregnancy(1L).size());
  }
}