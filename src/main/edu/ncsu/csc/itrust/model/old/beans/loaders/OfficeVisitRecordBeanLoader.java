package edu.ncsu.csc.itrust.model.old.beans.loaders;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import edu.ncsu.csc.itrust.model.old.beans.OfficeVisitRecordBean;

public class OfficeVisitRecordBeanLoader implements BeanLoader<OfficeVisitRecordBean>{
    @Override
    public List<OfficeVisitRecordBean> loadList(ResultSet rs) throws SQLException {
        List<OfficeVisitRecordBean> list = new ArrayList<OfficeVisitRecordBean>();
        while (rs.next()) {
            list.add(loadSingle(rs));
        }
        return list;
    }

    @Override
    public OfficeVisitRecordBean loadSingle(ResultSet rs) throws SQLException {
        OfficeVisitRecordBean ovRecordBean = new OfficeVisitRecordBean();
        ovRecordBean.setOfficeVisitRecordID(rs.getLong("id"));
        ovRecordBean.setBloodPressure(rs.getDouble("bloodPressure"));
        ovRecordBean.setHcp(rs.getLong("HCPID"));
        ovRecordBean.setPatient(rs.getLong("patientID"));
        ovRecordBean.setFetalHeartRate(rs.getDouble("fetalHeartRate"));
        ovRecordBean.setLowLyingPlacenta(rs.getBoolean("lowLyingPlacenta"));
        ovRecordBean.setNumberOfPregnancy(rs.getInt("numberOfPregnancy"));
        ovRecordBean.setWeightGain(rs.getDouble("weightGain"));
        ovRecordBean.setCurrentDate(rs.getTimestamp("currentDate"));
        ovRecordBean.setWeeksOfPregnant(rs.getString("weeksOfPregnant"));
        return ovRecordBean;
    }

    @Override
    public PreparedStatement loadParameters(PreparedStatement ps, OfficeVisitRecordBean bean) throws SQLException {
        ps.setLong(1, bean.getOfficeVisitRecordID());
        ps.setLong(2, bean.getPatient());
        ps.setLong(3, bean.getHcp());
        ps.setString(4, bean.getWeeksOfPregnant());
        ps.setDouble(5, bean.getWeightGain());
        ps.setDouble(6, bean.getBloodPressure());
        ps.setDouble(7, bean.getFetalHeartRate());
        ps.setInt(8, bean.getNumberOfPregnancy());
        ps.setBoolean(9, bean.getLowLyingPlacenta());
        ps.setTimestamp(10, bean.getCurrentDate());
        return ps;
    }
}
