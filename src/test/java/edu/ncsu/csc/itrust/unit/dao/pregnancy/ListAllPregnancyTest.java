package edu.ncsu.csc.itrust.unit.dao.pregnancy;

import edu.ncsu.csc.itrust.model.old.beans.PregnancyBean;
import edu.ncsu.csc.itrust.model.old.dao.mysql.PregnancyDAO;
import edu.ncsu.csc.itrust.unit.datagenerators.TestDataGenerator;
import edu.ncsu.csc.itrust.unit.testutils.TestDAOFactory;
import junit.framework.TestCase;

import java.util.List;

public class ListAllPregnancyTest extends TestCase {
  private PregnancyDAO pregnancyDAO = TestDAOFactory.getTestInstance().getPregnancyDAO();

  @Override
  protected void setUp() throws Exception {
    TestDataGenerator gen = new TestDataGenerator();
    gen.clearAllTables();
    gen.pregnancy1();
  }

  public void testListAllPregnancy() throws Exception {
    List<PregnancyBean> list = pregnancyDAO.getAllPregnancy(1L);
    assertEquals(1, list.size());
    PregnancyBean pregnancyBean = list.get(0);

    assertEquals(1, pregnancyBean.getMID());
    assertEquals(2018, pregnancyBean.getYearOfConception());
    assertEquals(40, pregnancyBean.getWeeksOfPregnant());
    assertEquals(6, pregnancyBean.getDaysOfPregnant());
    assertEquals(4.5, pregnancyBean.getHoursInLabor());
    assertEquals(20.0, pregnancyBean.getWeightGain());
    assertEquals("vaginal delivery", pregnancyBean.getDeliveryType());
  }
}
