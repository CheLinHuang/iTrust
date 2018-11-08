package edu.ncsu.csc.itrust.model.old.beans;

import java.sql.Date;
import java.util.List;
import java.util.Objects;

/**
 * A bean for storing TravelHistory data of patients
 */

public class TravelHistoryBean {
    Date startDate;
    Date endDate;
    List<String> travelledCities;
    long patientMID;

    public TravelHistoryBean(Date sd, Date ed, List<String> tc, long pmid) {
        startDate = sd;
        endDate = ed;
        travelledCities = tc;
        patientMID = pmid;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public List<String> getTravelledCities() {
        return travelledCities;
    }

    public void setTravelledCities(List<String> travelledCities) {
        this.travelledCities = travelledCities;
    }

    public long getPatientMID() {
        return patientMID;
    }

    public void setPatientMID(long patientMID) {
        this.patientMID = patientMID;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        TravelHistoryBean that = (TravelHistoryBean) o;
        return patientMID == that.patientMID &&
                Objects.equals(startDate, that.startDate) &&
                Objects.equals(endDate, that.endDate) &&
                Objects.equals(travelledCities, that.travelledCities);
    }

    @Override
    public int hashCode() {
        return Objects.hash(startDate, endDate, travelledCities, patientMID);
    }
}
