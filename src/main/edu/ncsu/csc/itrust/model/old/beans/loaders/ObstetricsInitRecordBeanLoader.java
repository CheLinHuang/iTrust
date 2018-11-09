package edu.ncsu.csc.itrust.model.old.beans.loaders;

import edu.ncsu.csc.itrust.model.old.beans.ObstetricsInitRecordBean;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ObstetricsInitRecordBeanLoader implements BeanLoader<ObstetricsInitRecordBean> {
  @Override
  public List<ObstetricsInitRecordBean> loadList(ResultSet rs) throws SQLException {
    List<ObstetricsInitRecordBean> list = new ArrayList<>();
    while (rs.next()) {
      list.add(loadSingle(rs));
    }
    return list;
  }

  @Override
  public ObstetricsInitRecordBean loadSingle(ResultSet rs) throws SQLException {
    ObstetricsInitRecordBean o = new ObstetricsInitRecordBean();
    o.setMID(rs.getLong("MID"));
    o.setLMP(rs.getString("LMP"));
    o.setEDD(rs.getString("EDD"));
    o.setWeeksOfPregnant(rs.getString("weeksOfPregnant"));
    o.setRecordCreatedTime(rs.getString("recordCreatedTime"));
    return o;
  }

  @Override
  public PreparedStatement loadParameters(PreparedStatement ps, ObstetricsInitRecordBean p) throws SQLException {
    int i = 1;
    ps.setLong(i++, p.getMID());
    ps.setString(i++, p.getLMP());
    ps.setString(i++, p.getEDD());
    ps.setString(i, p.getWeeksOfPregnant());
    return ps;
  }
}
