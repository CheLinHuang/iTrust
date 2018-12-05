<%@page import="java.text.ParseException"%>
<%@page errorPage="/auth/exceptionHandler.jsp"%>

<%@page import="java.lang.*"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="edu.ncsu.csc.itrust.model.old.beans.OfficeVisitRecordBean"%>
<%@page import="edu.ncsu.csc.itrust.model.old.beans.UltraSoundRecordBean"%>
+<%@page import="edu.ncsu.csc.itrust.action.AddUltrasoundRecordAction"%>
<%@page import="edu.ncsu.csc.itrust.model.old.dao.mysql.PatientDAO"%>
<%@page import="edu.ncsu.csc.itrust.model.old.dao.UltraSoundRecordDAO"%>
<%@page import="edu.ncsu.csc.itrust.model.old.enums.BloodType"%>
<%@page import="edu.ncsu.csc.itrust.exception.ITrustException"%>
<%@page import="edu.ncsu.csc.itrust.exception.FormValidationException"%>

<%@include file="/global.jsp" %>

<%
    pageTitle = "iTrust - Document an Ultra Sound";

    String headerMessage = "Please fill out the form properly - one ultra sound record for one fetus.";

%>

<%@include file="/header.jsp" %>

<form id="mainForm" method="post" action="documentUltraSound.jsp">
    <%
        AddUltrasoundRecordAction action = new AddUltrasoundRecordAction(prodDAO, loggedInMID.longValue());
        long officeVisitRecordID = 0L;
        long patientID = 0L;
        boolean error = false;
        String hidden = "";
        String officevisitString="";

        if (request.getParameter("apt") != null) {
            officevisitString = (String) request.getParameter("apt");
            System.out.println("officevisitrecord1:" + officevisitString);
        }

        String crownRumpLength="";
        String biparietalDiameter="";
        String headCircumference="";
        String femurLength="";
        String abdominalCircumference="";
        String occipitofromtalDiameter="";
        String humerusLength="";
        String estimatedFetalWeight="";
        String image="/path/of/image";

        if (request.getParameter("ultraSoundRecord") != null) {

            UltraSoundRecordBean ulrecord = new UltraSoundRecordBean();
            officeVisitRecordID = Long.parseLong(request.getParameter("ovID"));
            System.out.println("officevisitrecord2:" + officeVisitRecordID);
            ulrecord.setOfficeVisitID(officeVisitRecordID);
            ulrecord.setUltraSoundImage(image);
            System.out.println("ultraSoundImage:" + image);

            double crownRumpLengthD = 0;
            double biparietalDiameterD = 0;
            double headCircumferenceD = 0;
            double femurLengthD = 0;
            double abdominalCircumferenceD = 0;
            double occipitofromtalDiameterD = 0;
            double humerusLengthD = 0;
            double estimatedFetalWeightD = 0;

            try{
                crownRumpLengthD = Double.parseDouble(request.getParameter("crownRumpLength"));
                biparietalDiameterD = Double.parseDouble(request.getParameter("biparietalDiameter"));
                headCircumferenceD = Double.parseDouble(request.getParameter("headCircumference"));
                femurLengthD = Double.parseDouble(request.getParameter("femurLength"));
                abdominalCircumferenceD = Double.parseDouble(request.getParameter("abdominalCircumference"));
                occipitofromtalDiameterD = Double.parseDouble(request.getParameter("occipitofromtalDiameter"));
                humerusLengthD = Double.parseDouble(request.getParameter("humerusLength"));
                estimatedFetalWeightD = Double.parseDouble(request.getParameter("estimatedFetalWeight"));

            } catch (NumberFormatException nfe){
                error = true;
            }
            if (error){
                headerMessage = "Invalid Value!";

            }else{
                System.out.println("crownRumpLengthD:" + crownRumpLengthD);
                System.out.println("biparietalDiameterD:" + biparietalDiameterD);
                System.out.println("headCircumferenceD:" + headCircumferenceD);
                System.out.println("femurLengthD:" + femurLengthD);
                System.out.println("abdominalCircumferenceD" + abdominalCircumferenceD);
                System.out.println("occipitofromtalDiameterD:" + occipitofromtalDiameterD);
                System.out.println("humerusLengthD:" + humerusLengthD);
                System.out.println("estimatedFetalWeightD:" + estimatedFetalWeightD);
                ulrecord.setCrownRumpLength(crownRumpLengthD);
                ulrecord.setBiparietalDiameter(biparietalDiameterD);
                ulrecord.setHeadCircumference(headCircumferenceD);
                ulrecord.setFemurLength(femurLengthD);
                ulrecord.setAbdoCircumference(abdominalCircumferenceD);
                ulrecord.setOcciFrontalDiameter(occipitofromtalDiameterD);
                ulrecord.setHumerusLength(humerusLengthD);
                ulrecord.setEstimatedFetalWeight(estimatedFetalWeightD);
                try{
                    headerMessage=action.addUltrasoundRecord(ulrecord, false);
                    if(headerMessage.startsWith("Success")){
                        //session.removeAttribute("pid");
                        System.out.println(headerMessage);
                    }
                } catch(FormValidationException e){
                    %>
                    <div align=center><span class="iTrustError"><%=StringEscapeUtils.escapeHtml(e.getMessage())%></span></div>
                    <%
                }
            }
        }


    %>
    <div align="left" <%=hidden %> id="ultraSoundDiv">
        <h2>Document an Ultra Sound</h2>
        <span class="iTrustMessage"><%= StringEscapeUtils.escapeHtml("" + (headerMessage )) %></span><br /><br />
        <span>Crown rump length: </span>
        <input style="width: 250px;" type="text" name="crownRumpLength" value="<%= StringEscapeUtils.escapeHtml("" + ( crownRumpLength)) %>" />
        <br /><br />
        <span>Biparietal diameter: </span>
        <input style="width: 250px;" type="text" name="biparietalDiameter" value="<%= StringEscapeUtils.escapeHtml("" + ( biparietalDiameter)) %>" />
        <br /><br />
        <span>Head circumference: </span>
        <input style="width: 250px;" type="text" name="headCircumference" value="<%= StringEscapeUtils.escapeHtml("" + ( headCircumference)) %>" />
        <br /><br />
        <span>Femur length: </span>
        <input style="width: 250px;" type="text" name="femurLength" value="<%= StringEscapeUtils.escapeHtml("" + ( femurLength)) %>" />
        <br /><br />
        <span>Occipitofrontal diameter: </span>
        <input style="width: 250px;" type="text" name="occipitofromtalDiameter" value="<%= StringEscapeUtils.escapeHtml("" + ( occipitofromtalDiameter)) %>" />
        <br /><br />
        <span>Abdominal circumference: </span>
        <input style="width: 250px;" type="text" name="abdominalCircumference" value="<%= StringEscapeUtils.escapeHtml("" + ( abdominalCircumference)) %>" />
        <br /><br />
        <span>Humerus length: </span>
        <input style="width: 250px;" type="text" name="humerusLength" value="<%= StringEscapeUtils.escapeHtml("" + ( humerusLength)) %>" />
        <br /><br />
        <span>Estimated fetal weight: </span>
        <input style="width: 250px;" type="text" name="estimatedFetalWeight" value="<%= StringEscapeUtils.escapeHtml("" + ( estimatedFetalWeight)) %>" />
        <br /><br />


        <input type="submit" value="submit" name="ultraSoundRecordButton"/>
        <input type="hidden" value="UltraSoundRecord" name="ultraSoundRecord"/>
        <input type="hidden" value="<%=officevisitString%>" name="ovID"/>

        <br />
        <br />
    </div>
</form>


<%@include file="/footer.jsp" %>

