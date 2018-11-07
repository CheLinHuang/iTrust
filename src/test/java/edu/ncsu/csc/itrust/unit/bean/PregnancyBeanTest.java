package edu.ncsu.csc.itrust.unit.bean;

import edu.ncsu.csc.itrust.model.old.beans.PregnancyBean;
import junit.framework.TestCase;

public class PregnancyBeanTest  extends TestCase {
  public void testBean() {
    PregnancyBean pb = new PregnancyBean();
    pb.setYearOfConception(2018);
    pb.setWeightGain(10.5);
    pb.setHoursInLabor(5.1);
    pb.setDeliveryType("vaginal delivery");
    pb.setWeeksOfPregnant(55);
    pb.setDaysOfPregnant(4);

    assertEquals(2018, pb.getYearOfConception());
    assertEquals(10.5, pb.getWeightGain());
    assertEquals(5.1, pb.getHoursInLabor());
    assertEquals("vaginal delivery", pb.getDeliveryType());
    assertEquals(55, pb.getWeeksOfPregnant());
    assertEquals(4, pb.getDaysOfPregnant());
  }
}
