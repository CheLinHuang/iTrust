package edu.ncsu.csc.itrust.action;

import java.sql.SQLException;

import edu.ncsu.csc.itrust.exception.DBException;
import edu.ncsu.csc.itrust.exception.FormValidationException;
import edu.ncsu.csc.itrust.logger.TransactionLogger;
import edu.ncsu.csc.itrust.model.old.beans.OfficeVisitRecordBean;
import edu.ncsu.csc.itrust.model.old.dao.DAOFactory;
import edu.ncsu.csc.itrust.model.old.enums.TransactionType;

public class AddOfficeVisitRecordAction extends OfficeVisitRecordAction {
    private long loggedInMID;

    public AddOfficeVisitRecordAction(DAOFactory factory, long loggedInMID) {
        super(factory, loggedInMID);
        this.loggedInMID = loggedInMID;
    }

    public String addOfficeVisitRecord(OfficeVisitRecordBean ov, boolean ignoreConflicts) throws FormValidationException, SQLException, DBException {
        try {
            officeVisitRecordDAO.addOfficeVisitRecord(ov);
            TransactionLogger.getInstance().logTransaction(TransactionType.OFFICE_VISIT_RECORD_ADD, loggedInMID, ov.getPatient(), "" + ov.getOfficeVisitRecordID());
            return "Success: Office Visit Record for " + ov.getCurrentDate() + " added";
        } catch (SQLException e) {
            return e.getMessage();
        }
    }
}
