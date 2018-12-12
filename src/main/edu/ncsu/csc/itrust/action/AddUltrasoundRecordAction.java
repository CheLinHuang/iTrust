package edu.ncsu.csc.itrust.action;

import java.sql.SQLException;
import java.util.List;

import java.sql.SQLException;

import edu.ncsu.csc.itrust.exception.DBException;
import edu.ncsu.csc.itrust.exception.FormValidationException;
import edu.ncsu.csc.itrust.logger.TransactionLogger;
import edu.ncsu.csc.itrust.model.old.beans.UltraSoundRecordBean;
import edu.ncsu.csc.itrust.model.old.dao.DAOFactory;
import edu.ncsu.csc.itrust.model.old.enums.TransactionType;
import edu.ncsu.csc.itrust.model.old.validate.UltrasoundRecordBeanValidator;

public class AddUltrasoundRecordAction extends UltrasoundRecordAction {
    private UltrasoundRecordBeanValidator validator = new UltrasoundRecordBeanValidator();
    private long loggedInMID;

    public AddUltrasoundRecordAction(DAOFactory factory, long loggedInMID) {
        super(factory, loggedInMID);
        this.loggedInMID = loggedInMID;
    }

    public String addUltrasoundRecord(UltraSoundRecordBean ultrasoundRecord, boolean ignoreConflicts) throws FormValidationException, SQLException, DBException {
        validator.validate(ultrasoundRecord);

        try {
            ultrasoundRecordDAO.addUltraSoundRecord(ultrasoundRecord);
            return "Success: Ultrasound Record added";
        }
        catch (SQLException e) {
            return e.getMessage();
        }
    }

    public UltraSoundRecordBean getUltrasoundRecord(final long officevisitRecordID) throws FormValidationException, SQLException, DBException{
        try {
            UltraSoundRecordBean ultrasound = null;
            ultrasound = ultrasoundRecordDAO.getUltraSoundRecord(officevisitRecordID);
            return ultrasound;
        }
        catch (SQLException e) {
            return null;
        }
    }


}
