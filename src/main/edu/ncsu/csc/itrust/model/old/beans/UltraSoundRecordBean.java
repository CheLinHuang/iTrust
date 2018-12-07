package edu.ncsu.csc.itrust.model.old.beans;

public class UltraSoundRecordBean {
    private long ultraSoundID;
    private long officeVisitID;
    private double crownRumpLength;
    private double biparietalDiameter;
    private double headCircumference;
    private double femurLength;
    private double occiFrontalDiameter;
    private double abdoCircumference;
    private double humerusLength;
    private double estimatedFetalWeight;
    private String ultraSoundImage;


    public void setUltraSoundID(long ultraSoundID){
        this.ultraSoundID = ultraSoundID;
    }

    public long getUltraSoundID(){
        return ultraSoundID;
    }

    public void setOfficeVisitID(long officeVisitID){
        this.officeVisitID = officeVisitID;
    }

    public long getOfficeVisitID(){
        return officeVisitID;
    }

    public void setCrownRumpLength(double crownRumpLength){
        this.crownRumpLength = crownRumpLength;
    }

    public double getCrownRumpLength(){
        return crownRumpLength;
    }

    public void setBiparietalDiameter(double biparietalDiameter){
        this.biparietalDiameter = biparietalDiameter;
    }

    public double getBiparietalDiameter(){
        return biparietalDiameter;
    }

    public void setHeadCircumference(double headCircumference){
        this.headCircumference = headCircumference;
    }

    public double getHeadCircumference(){
        return headCircumference;
    }

    public double getFemurLength(){
        return femurLength;
    }

    public void setFemurLength(double femurLength){
        this.femurLength = femurLength;
    }

    public double getOcciFrontalDiameter(){
        return occiFrontalDiameter;
    }

    public void setOcciFrontalDiameter(double occiFrontalDiameter){
        this.occiFrontalDiameter = occiFrontalDiameter;
    }

    public double getAbdoCircumference() {
        return abdoCircumference;
    }

    public void setAbdoCircumference(double abdoCircumference){
        this.abdoCircumference = abdoCircumference;
    }

    public double getHumerusLength(){
        return humerusLength;
    }

    public void setHumerusLength(double humerusLength){
        this.humerusLength = humerusLength;
    }
    public void setEstimatedFetalWeight(double estimatedFetalWeight){
        this.estimatedFetalWeight = estimatedFetalWeight;
    }

    public double getEstimatedFetalWeight(){
        return estimatedFetalWeight;
    }

    public void setUltraSoundImage(String ultraSoundImage){
        this.ultraSoundImage = ultraSoundImage;
    }

    public String getUltraSoundImage(){
        return ultraSoundImage;
    }

    /**
     * Returns true if both id's are equal. Probably needs more advance field by field checking.
     */
    @Override public boolean equals(Object other) {

        if ( this == other ){
            return true;
        }

        if ( !(other instanceof UltraSoundRecordBean) ){
            return false;
        }

        UltraSoundRecordBean otherUltrasoundRecord = (UltraSoundRecordBean)other;
        return otherUltrasoundRecord.getUltraSoundID() == getUltraSoundID();

    }
}
