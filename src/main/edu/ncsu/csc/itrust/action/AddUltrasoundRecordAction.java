package edu.ncsu.csc.itrust.action;

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

    public String addUltrasoundRecordAction(UltraSoundRecordBean ultrasoundRecord, boolean ignoreConflicts) throws FormValidationException, SQLException, DBException {
        validator.validate(ultrasoundRecord);

        try {
            ultrasoundRecordDAO.addUltraSoundRecord(ultrasoundRecord);
            TransactionLogger.getInstance().logTransaction(TransactionType.ULTRASOUND_RECORD_ADD, loggedInMID, ultrasoundRecord.getOfficeVisitID(), "");
            return "Success: Ultrasound Record added";
        }
        catch (SQLException e) {
            return e.getMessage();
        }
    }
}
