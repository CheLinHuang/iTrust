package edu.ncsu.csc.itrust.model.old.beans.loaders;

import edu.ncsu.csc.itrust.model.old.beans.TravelHistoryBean;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * A loader for TravelHistoryBean.
 * Loads in information to/from beans using ResultSets and PreparedStatements. Use the superclass to enforce consistency.
*/
public class TravelHistoryBeanLoader implements BeanLoader<TravelHistoryBean> {
    @Override
    public List<TravelHistoryBean> loadList(ResultSet rs) throws SQLException {
        ArrayList<TravelHistoryBean> list = new ArrayList<>();
        while (rs.next()) {
            list.add(loadSingle(rs));
        }
        return list;
    }

    @Override
    public TravelHistoryBean loadSingle(ResultSet rs) throws SQLException {
        TravelHistoryBean travelHistory = new TravelHistoryBean(rs.getDate("startDate"), rs.getDate("endDate"), rs.getString("travelledCities"), rs.getLong("patientMID"));
        return travelHistory;
    }

    @Override
    public PreparedStatement loadParameters(PreparedStatement ps, TravelHistoryBean bean) throws SQLException {
        throw new IllegalStateException("unimplemented!");
    }
}
