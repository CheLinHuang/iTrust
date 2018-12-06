package edu.ncsu.csc.itrust.model.old.beans.loaders;

import edu.ncsu.csc.itrust.model.old.beans.PreExistingConditionRecordBean;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/*
 * A loader for PreExistingConditionRecordBean.
 * Loads in information to/from beans using ResultSets and PreparedStatements. Use the superclass to enforce consistency
 */

public class PreExistingConditionRecordBeanLoader implements BeanLoader<PreExistingConditionRecordBean>{

    @Override
    public List<PreExistingConditionRecordBean> loadList(ResultSet rs) throws SQLException {
        List<PreExistingConditionRecordBean> list = new ArrayList<>();
        while (rs.next()) {
            list.add(loadSingle(rs));
        }
        return list;
    }

    @Override
    public PreExistingConditionRecordBean loadSingle(ResultSet rs) throws SQLException {
        PreExistingConditionRecordBean preCondition = new PreExistingConditionRecordBean(rs.getLong("patientMID"),
                rs.getString("icdInfo"));
        return preCondition;
    }

    @Override
    public PreparedStatement loadParameters(PreparedStatement ps, PreExistingConditionRecordBean bean) throws SQLException {
        int i = 1;
        ps.setLong(i++, bean.getPatientMID());
        ps.setString(i++, bean.getIcdInfo());
        return ps;
    }
}
