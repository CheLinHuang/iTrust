package edu.ncsu.csc.itrust.action;


import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;

import edu.ncsu.csc.itrust.exception.DBException;
import edu.ncsu.csc.itrust.model.old.beans.PatientBean;
import edu.ncsu.csc.itrust.model.old.dao.DAOFactory;

import java.sql.SQLException;

import edu.ncsu.csc.itrust.exception.DBException;

import edu.ncsu.csc.itrust.action.SearchUsersAction;
import edu.ncsu.csc.itrust.model.old.beans.PregnancyBean;
import edu.ncsu.csc.itrust.model.old.dao.mysql.PregnancyDAO;
import edu.ncsu.csc.itrust.model.old.beans.ObstetricsInitRecordBean;
import edu.ncsu.csc.itrust.model.old.dao.mysql.ObstetricsInitRecordDAO;
import edu.ncsu.csc.itrust.model.old.beans.loaders.ObstetricsInitRecordBeanLoader;
import edu.ncsu.csc.itrust.model.old.beans.loaders.PregnancyBeanLoader;



public class ObstetricHistoryAction {
    private ObstetricsInitRecordDAO obstetricsInitRecordDAO;
    private PregnancyDAO pregnancyDAO;

    public ObstetricHistoryAction(DAOFactory factory) {
        this.obstetricsInitRecordDAO = factory.getObstetricsInitRecordDAO();
        this.pregnancyDAO = factory.getPregnancyDAO();
    }

    public List<ObstetricsInitRecordBean> getPatientObstericsInitRecords(long mid) {
        try {
            List<ObstetricsInitRecordBean> result = obstetricsInitRecordDAO.getAllObstetricsInitRecord(mid);
            return result;
        } catch (DBException e) {
            return null;
        }
    }

}
