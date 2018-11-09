package edu.ncsu.csc.itrust.model.old.beans.loaders;

import edu.ncsu.csc.itrust.model.old.beans.PregnancyBean;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PregnancyBeanLoader implements BeanLoader<PregnancyBean>  {
  @Override
  public List<PregnancyBean> loadList(ResultSet rs) throws SQLException {
    List<PregnancyBean> list = new ArrayList<>();
    while (rs.next()) {
      list.add(loadSingle(rs));
    }
    return list;
  }

  @Override
  public PregnancyBean loadSingle(ResultSet rs) throws SQLException {
    PregnancyBean p = new PregnancyBean();
    p.setMID(rs.getLong("MID"));
    p.setDeliveryType(rs.getString("deliveryType"));
    p.setWeeksOfPregnant(rs.getString("weeksOfPregnant"));
    p.setHoursInLabor(rs.getDouble("hoursInLabor"));
    p.setWeightGain(rs.getDouble("weightGain"));
    p.setYearOfConception(rs.getInt("yearOfConception"));
    return p;
  }

  @Override
  public PreparedStatement loadParameters(PreparedStatement ps, PregnancyBean p) throws SQLException {
    int i = 1;
    ps.setLong(i++, p.getMID());
    ps.setInt(i++, p.getYearOfConception());
    ps.setString(i++, p.getWeeksOfPregnant());
    ps.setDouble(i++, p.getHoursInLabor());
    ps.setDouble(i++, p.getWeightGain());
    ps.setString(i, p.getDeliveryType());
    return ps;
  }
}
