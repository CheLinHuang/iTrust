package edu.ncsu.csc.itrust.unit.bean;

import edu.ncsu.csc.itrust.model.old.beans.ObstetricsInitRecordBean;
import junit.framework.TestCase;

import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.TimeZone;

public class ObstetricsInitRecordBeanTest extends TestCase {

  public void testBean() {
    ObstetricsInitRecordBean orb = new ObstetricsInitRecordBean();
    Calendar c = new GregorianCalendar(TimeZone.getTimeZone("UTC"));
    c.set(2018, Calendar.JANUARY, 1, 0, 0, 0);
    orb.setLMP(c.getTime());
    c.set(2018, Calendar.OCTOBER, 8, 0, 0, 0);
    orb.setWeeksOfPregnant(new int[]{5, 2});

    assertEquals(c.getTime(), orb.getEDD());
    assertEquals(5, orb.getWeeksOfPregnant()[0]);
    assertEquals(2, orb.getWeeksOfPregnant()[1]);
  }
}
