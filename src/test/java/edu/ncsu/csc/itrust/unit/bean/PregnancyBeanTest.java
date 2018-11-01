package edu.ncsu.csc.itrust.unit.bean;

import edu.ncsu.csc.itrust.model.old.beans.PregnancyBean;
import junit.framework.TestCase;

public class PregnancyBeanTest  extends TestCase {
  public void testBean() {
    PregnancyBean pb = new PregnancyBean();
    pb.setYearOfConception(2018);
    pb.setWeightGain(10.5);
    pb.setHoursInLabor(5.1);
    pb.setDeliveryType("Vaginal Delivery");
    pb.setWeeksOfPregnant(new int[]{5, 2});

    assertEquals(2018, pb.getYearOfConception());
    assertEquals(10.5, pb.getWeightGain());
    assertEquals(5.1, pb.getHoursInLabor());
    assertEquals("Vaginal Delivery", pb.getDeliveryType());
    assertEquals(5, pb.getWeeksOfPregnant()[0]);
    assertEquals(2, pb.getWeeksOfPregnant()[1]);
  }
}
