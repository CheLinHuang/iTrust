package edu.ncsu.csc.itrust.model.old.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import edu.ncsu.csc.itrust.exception.DBException;
import edu.ncsu.csc.itrust.model.old.beans.loaders.OfficeVisitRecordBeanLoader;
import edu.ncsu.csc.itrust.model.old.beans.OfficeVisitRecordBean;
import edu.ncsu.csc.itrust.model.old.dao.DAOFactory;

import javax.xml.transform.Result;

public class OfficeVisitRecordDAO {
    private DAOFactory factory;
    private OfficeVisitRecordBeanLoader officeVisitRecordBeanLoader;


    public OfficeVisitRecordDAO(DAOFactory factory){
        this.factory = factory;
        this.officeVisitRecordBeanLoader = new OfficeVisitRecordBeanLoader();
    }

    public void addOfficeVisitRecord(final OfficeVisitRecordBean officeVisitRecordBean) throws SQLException, DBException{
        try(Connection conn = factory.getConnection();
            PreparedStatement stmt = officeVisitRecordBeanLoader.loadParameters((conn.prepareStatement
                    ("INSERT INTO officeVisitRecord(id," +
                    "patientID, HCPID, weeksOfPregnant, weightGain, bloodPressure, fetalHeartRate," +
                    "numberOfPregnancy, lowLyingPlacenta, currentDate) VALUES (?,?,?,?,?,?,?,?,?,?)")), officeVisitRecordBean)){
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new DBException(e);
        }
    }

    public void modifyOfficeVisitRecord(final OfficeVisitRecordBean officeVisitRecordBean) throws SQLException, DBException{
        try(Connection conn = factory.getConnection(); PreparedStatement stmt =
                conn.prepareStatement("UPDATE officeVisitRecord SET weeksOfPregnant=?, " +
                "weightGain=?, bloodPressure=?, fetalHeartRate=?, numberOfPregnancy=?, lowLyingPlacenta=?, currentDate=? WHERE id=?")){
            stmt.setString(1, officeVisitRecordBean.getWeeksOfPregnant());
            stmt.setDouble(2, officeVisitRecordBean.getWeightGain());
            stmt.setDouble(3, officeVisitRecordBean.getBloodPressure());
            stmt.setDouble(4, officeVisitRecordBean.getFetalHeartRate());
            stmt.setInt(5, officeVisitRecordBean.getNumberOfPregnancy());
            stmt.setBoolean(6, officeVisitRecordBean.getLowLyingPlacenta());
            stmt.setTimestamp(7, officeVisitRecordBean.getCurrentDate());
            stmt.setLong(8, officeVisitRecordBean.getOfficeVisitRecordID());
            stmt.executeUpdate();
        } catch (SQLException e){
            throw new DBException(e);
        }
    }

    public void deleteOfficeVisitRecord(final OfficeVisitRecordBean officeVisitRecordBean) throws SQLException, DBException{
        try(Connection conn = factory.getConnection(); PreparedStatement stmt =
                conn.prepareStatement("DElETE FROM officeVisitRecord WHERE id=?")){
            stmt.setLong(1, officeVisitRecordBean.getOfficeVisitRecordID());
            stmt.executeUpdate();
        } catch (SQLException e){
            throw new DBException(e);
        }
    }

    public List<OfficeVisitRecordBean> getOfficeVisitRecord(final long id) throws SQLException, DBException {
        ResultSet results = null;
        try(Connection conn = factory.getConnection();
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM officeVisitRecord WHERE HCPID=?")){
            stmt.setLong(1, id);
            results = stmt.executeQuery();
            List<OfficeVisitRecordBean> abList = officeVisitRecordBeanLoader.loadList(results);
            return abList;
        } catch (SQLException e) {
            throw new DBException(e);
        }
    }
}
