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

    /**
     * Takes in patient MID chosen by OB/GYN hcp's from the front end and return
     * a list of all obstetric history Bean object of that patient
     * @param mid
     * @return
     */
    public List<ObstetricsInitRecordBean> getPatientObstericsInitRecords(long mid) {
        try {
            List<ObstetricsInitRecordBean> result = obstetricsInitRecordDAO.getAllObstetricsInitRecord(mid);
            return result;
        } catch (DBException e) {
            return null;
        }
    }

    /**
     * Takes in patient MID chosen by hcps from the fron end and return a list of all pregnancy Bean object of that patient
     * @param mid
     * @return
     */
    public List<PregnancyBean> getAllPregnancy(long mid) {
        try {
            List<PregnancyBean> result = pregnancyDAO.getAllPregnancy(mid);
            return result;
        } catch (DBException e) {
            return null;
        }
    }



}
