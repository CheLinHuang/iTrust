package edu.ncsu.csc.itrust.model.old.dao;

import edu.ncsu.csc.itrust.exception.DBException;
import edu.ncsu.csc.itrust.model.old.beans.UltraSoundRecordBean;
import edu.ncsu.csc.itrust.model.old.beans.loaders.UltraSoundRecordBeanLoader;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class UltraSoundRecordDAO {
    private DAOFactory factory;
    private UltraSoundRecordBeanLoader ultraSoundRecordBeanLoader;

    public UltraSoundRecordDAO(DAOFactory factory){
        this.factory = factory;
        this.ultraSoundRecordBeanLoader = new UltraSoundRecordBeanLoader();
    }

    public void addUltraSoundRecord(final UltraSoundRecordBean ultraSoundRecordBean) throws SQLException, DBException{
        try(Connection conn = factory.getConnection(); PreparedStatement stmt =
                ultraSoundRecordBeanLoader.loadParameters(conn.prepareStatement("INSERT INTO ultraSoundRecord(id, officeVisitRecordID, " +
                        "crownRumpLength, biparietalDiameter, headCircumference, " +
                        "femurLength, occiFrontalDiameter, abdoCircumference, humerusLength, " +
                        "estimatedFetalWeight, ultraSoundImage) VALUES (?,?,?,?,?,?,?,?,?,?,?)"), ultraSoundRecordBean)){
            stmt.executeUpdate();
        } catch (SQLException e) {
            throw new DBException(e);
        }
    }


    public UltraSoundRecordBean getUltraSoundRecord(final long officeVisitRecordID) throws SQLException, DBException{
        ResultSet results = null;
        try(Connection conn = factory.getConnection(); PreparedStatement stmt = conn.prepareStatement("SELECT * FROM " +
                "ultraSoundRecord WHERE officeVisitRecordID=?")){
            stmt.setLong(1, officeVisitRecordID);
            results = stmt.executeQuery();
            List<UltraSoundRecordBean> abList = ultraSoundRecordBeanLoader.loadList(results);
            if (abList != null){
                return abList.get(0);
            } else{
                return null;
            }
        } catch (SQLException e) {
            throw new DBException(e);
        }
    }
}
