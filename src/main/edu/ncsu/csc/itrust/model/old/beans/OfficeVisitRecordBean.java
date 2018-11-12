package edu.ncsu.csc.itrust.model.old.beans;


import java.sql.Timestamp;

public class OfficeVisitRecordBean {
    private long officeVisitRecordID;
    private long patient;
    private long hcp;
    private String weeksOfPregnant;
    private double weightGain;
    private double bloodPressure;
    private double fetalHeartRate;
    private int numberOfPregnancy;
    private boolean lowLyingPlacenta;
    private Timestamp currentDate;

    public long getOfficeVisitRecordID(){
        return officeVisitRecordID;
    }

    public void setOfficeVisitRecordID(long officeVisitRecordID){
        this.officeVisitRecordID = officeVisitRecordID;
    }

    public long getPatient(){
        return patient;
    }

    public void setPatient(long patient){
        this.patient = patient;
    }

    public long getHcp(){
        return hcp;
    }

    public void setHcp(long hcp){
        this.hcp = hcp;
    }

    public String getWeeksOfPregnant(){
        return weeksOfPregnant;
    }

    public void setWeeksOfPregnant(String weeksOfPregnant){
        this.weeksOfPregnant = weeksOfPregnant;
    }

    public double getWeightGain(){
        return weightGain;
    }

    public void setWeightGain(double weightGain){
        this.weightGain = weightGain;
    }

    public double getBloodPressure(){
        return bloodPressure;
    }

    public void setBloodPressure(double bloodPressure){
        this.bloodPressure = bloodPressure;
    }

    public void setFetalHeartRate(double fetalHeartRate){
        this.fetalHeartRate = fetalHeartRate;
    }

    public double getFetalHeartRate(){
        return fetalHeartRate;
    }

    public void setNumberOfPregnancy(int numberOfPregnancy){
        this.numberOfPregnancy = numberOfPregnancy;
    }

    public int getNumberOfPregnancy(){
        return numberOfPregnancy;
    }

    public void setLowLyingPlacenta(boolean lowLyingPlacenta){
        this.lowLyingPlacenta = lowLyingPlacenta;
    }

    public boolean getLowLyingPlacenta(){
        return lowLyingPlacenta;
    }

    public Timestamp getCurrentDate(){
        return currentDate;
    }

    public void setCurrentDate(Timestamp currentDate){
        this.currentDate = currentDate;
    }

    /**
     * Returns true if both id's are equal. Probably needs more advance field by field checking.
     */
    @Override public boolean equals(Object other) {

        if (this == other) {
            return true;
        }

        if (!(other instanceof OfficeVisitRecordBean)) {
            return false;
        }

        OfficeVisitRecordBean otherOfficeVisitRecord = (OfficeVisitRecordBean)other;
        return otherOfficeVisitRecord.getOfficeVisitRecordID() == getOfficeVisitRecordID();

    }
}
