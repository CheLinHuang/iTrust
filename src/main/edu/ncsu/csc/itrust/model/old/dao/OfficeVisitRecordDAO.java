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
                    "patientID, HCPID, weeksOfPregnant, weightGain, highbloodPressure, lowbloodPressure, fetalHeartRate," +
                    "numberOfPregnancy, lowLyingPlacenta, currentDate) VALUES (?,?,?,?,?,?,?,?,?,?,?)")), officeVisitRecordBean)){
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new DBException(e);
        }
    }

    public void modifyOfficeVisitRecord(final OfficeVisitRecordBean officeVisitRecordBean) throws SQLException, DBException{
        try(Connection conn = factory.getConnection(); PreparedStatement stmt =
                conn.prepareStatement("UPDATE officeVisitRecord SET weeksOfPregnant=?, " +
                "weightGain=?, highbloodPressure=?, lowbloodPressure=?, fetalHeartRate=?, numberOfPregnancy=?, lowLyingPlacenta=?, currentDate=? WHERE id=?")){
            stmt.setString(1, officeVisitRecordBean.getWeeksOfPregnant());
            stmt.setDouble(2, officeVisitRecordBean.getWeightGain());
            stmt.setDouble(3, officeVisitRecordBean.getHighBloodPressure());
            stmt.setDouble(4, officeVisitRecordBean.getLowBloodPressure());
            stmt.setDouble(5, officeVisitRecordBean.getFetalHeartRate());
            stmt.setInt(6, officeVisitRecordBean.getNumberOfPregnancy());
            stmt.setBoolean(7, officeVisitRecordBean.getLowLyingPlacenta());
            stmt.setTimestamp(8, officeVisitRecordBean.getCurrentDate());
            stmt.setLong(9, officeVisitRecordBean.getOfficeVisitRecordID());
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
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM officeVisitRecord WHERE id=? ORDER BY currentDate DESC")){
            stmt.setLong(1, id);
            results = stmt.executeQuery();
            List<OfficeVisitRecordBean> abList = officeVisitRecordBeanLoader.loadList(results);
            results.close();
            return abList;
        } catch (SQLException e) {
            throw new DBException(e);
        }
    }

    public List<OfficeVisitRecordBean> getPatientOfficeVisitRecord(final long id) throws SQLException, DBException {
        ResultSet results = null;
        try(Connection conn = factory.getConnection();
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM officeVisitRecord WHERE patientID=? ORDER BY currentDate DESC")){
            stmt.setLong(1, id);
            results = stmt.executeQuery();
            List<OfficeVisitRecordBean> abList = officeVisitRecordBeanLoader.loadList(results);
            results.close();
            return abList;
        } catch (SQLException e) {
            throw new DBException(e);
        }
    }

    public List<OfficeVisitRecordBean> getOfficeVisitRecordsFor(final long mid) throws SQLException, DBException {
        try (Connection conn = factory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(
                     "SELECT * FROM officeVisitRecord WHERE HCPID=? ORDER BY currentDate DESC;")){
            stmt.setLong(1, mid);

            ResultSet results = stmt.executeQuery();
            List<OfficeVisitRecordBean> abList = officeVisitRecordBeanLoader.loadList(results);
            results.close();
            return abList;
        } catch (SQLException e) {
            throw new DBException(e);
        }
    }

//    public List<ApptBean> getAllApptsFor(long mid) throws SQLException, DBException {
//        try (Connection conn = factory.getConnection();
//             PreparedStatement stmt = (mid >= MIN_MID)
//                     ? conn.prepareStatement("SELECT * FROM appointment WHERE doctor_id=? ORDER BY sched_date;")
//                     : conn.prepareStatement("SELECT * FROM appointment WHERE patient_id=? ORDER BY sched_date;")) {
//            stmt.setLong(1, mid);
//
//            final ResultSet results = stmt.executeQuery();
//            final List<ApptBean> abList = this.abloader.loadList(results);
//            results.close();
//            return abList;
//        } catch (SQLException e) {
//            throw new DBException(e);
//        }
//
//    }
}
