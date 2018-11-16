<%@page import="java.text.ParseException"%>
<%@page errorPage="/auth/exceptionHandler.jsp"%>

<%@page import="java.lang.*"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="edu.ncsu.csc.itrust.model.old.beans.OfficeVisitRecordBean"%>
<%@page import="edu.ncsu.csc.itrust.action.AddOfficeVisitRecordAction"%>   // Need to add UC93 files
<%@page import="edu.ncsu.csc.itrust.model.old.dao.mysql.PatientDAO"%>
<%@page import="edu.ncsu.csc.itrust.model.old.dao.OfficeVisitRecordDAO"%>
<%@page import="edu.ncsu.csc.itrust.model.old.enums.BloodType"%>
<%@page import="edu.ncsu.csc.itrust.exception.ITrustException"%>
<%@page import="edu.ncsu.csc.itrust.exception.FormValidationException"%>

<%@include file="/global.jsp" %>


<%
    pageTitle = "iTrust - Document an Office Visit";

    String headerMessage = "Please fill out the form properly - all entries are required.";

    String noticeMessage = "";
%>

<%@include file="/header.jsp" %>

<form id="mainForm" method="post" action="documentOfficeVisit.jsp">
<%
    AddOfficeVisitRecordAction action = new AddOfficeVisitRecordAction(prodDAO, loggedInMID.longValue());
    //ObstetricHistoryAction oba = new ObstetricHistoryAction(DAOFactory.getProductionInstance());   Remember to modify me -- UC93
    PatientDAO patientDAO = prodDAO.getPatientDAO();
    long patientID = 0L;
    boolean error = false;
    boolean isObstetrics = true;
    String hidden = "";

    if (session.getAttribute("pid") != null) {
        String pidString = (String) session.getAttribute("pid");
        patientID = Long.parseLong(pidString);
        try {
            action.getName(patientID);
        } catch (ITrustException ite) {
            patientID = 0L;
        }

        //isObstetrics = ;   whether or not is an obstetrics patient;
    }
    else {
        session.removeAttribute("pid");
    }

    String weightGain="";
    String weeksOfPregnant="20-01";  // For test. Modify me --- UC93
    String lowLyingPlacenta="";
    String bloodPressure="";
    String fetalHeartRate="";
    String numberOfPregnancy="";


    if (patientID == 0L) {
        response.sendRedirect("/iTrust/auth/getPatientID.jsp?forward=hcp/documentOfficeVisit.jsp");
    }else if(!isObstetrics){
    %>
    <div align=center>
        <span class="iTrustError">Not a current obstetrics patient! Please try again!</span>
        <br />
        <a href="/iTrust/auth/getPatientID.jsp?forward=hcp/documentOfficeVisit.jsp">Back</a>		</div>
    <%
    }else{
        if (request.getParameter("officeVisitRecord") != null) {

            /** Modify me ---UC93
            // Get obstetrics patient initializations list
            List<PregnancyBean> pregnancyHistoryList = oba.getAllPregnancy(patientID);
            PregnancyBean mostRecentPregnancy = null;
            if (pregnancyHistoryList.size() > 0)
                mostRecentPregnancy = pregnancyHistoryList.get(0);
            weeksOfPregnant = mostRecentPregnancy.getWeeksOfPregnant();
             **/

            if(request.getParameter("weightGain").equals(""))
                headerMessage = "Please input weight gain.";

            else if(request.getParameter("lowLyingPlacenta").equals(""))
                headerMessage = "Please input Low Lying Placenta";
            else if(request.getParameter("bloodPressure").equals(""))
                headerMessage = "Please input Blood Pressure";
            else if(request.getParameter("fetalHeartRate").equals(""))
                headerMessage = "Please input Fetal Heart Rate";
            else if(request.getParameter("numberOfPregnancy").equals(""))
                headerMessage = "Please input Number Of Pregnancy";
            else {
                weightGain = request.getParameter("weightGain");
                lowLyingPlacenta = request.getParameter("lowLyingPlacenta");
                bloodPressure = request.getParameter("bloodPressure");
                fetalHeartRate = request.getParameter("fetalHeartRate");
                numberOfPregnancy = request.getParameter("numberOfPregnancy");
                OfficeVisitRecordBean ovrecord = new OfficeVisitRecordBean();
                ovrecord.setHcp(loggedInMID);
                ovrecord.setPatient(patientID);
                ovrecord.setWeeksOfPregnant(weeksOfPregnant);
                Date date = new Date();
                ovrecord.setLowLyingPlacenta(Boolean.parseBoolean(lowLyingPlacenta));
                ovrecord.setCurrentDate(new Timestamp(date.getTime()));
                double weightGainD = 0;
                double bloodPressureD = 0;
                double fetalHeartRateD = 0;
                int numberOfPregnancyI = 0;
                try{
                    weightGainD = Double.parseDouble(weightGain);
                    bloodPressureD = Double.parseDouble(bloodPressure);
                    fetalHeartRateD = Double.parseDouble(fetalHeartRate);
                    numberOfPregnancyI = Integer.parseInt(numberOfPregnancy);
                } catch (NumberFormatException nfe){
                    error = true;
                }
                if (error){
                    headerMessage = "Invalid Value!";
                }else{
                    String bloodType = "";
                    ovrecord.setWeightGain(weightGainD);
                    ovrecord.setBloodPressure(bloodPressureD);
                    ovrecord.setFetalHeartRate(fetalHeartRateD);
                    ovrecord.setNumberOfPregnancy(numberOfPregnancyI);
                    try {
                        headerMessage = action.addOfficeVisitRecord(ovrecord, false);
                        if(headerMessage.startsWith("Success")) {
                            bloodType = patientDAO.getPatient(patientID).getBloodType().toString();
                            int weeks = Integer.valueOf(weeksOfPregnant.split("-")[0]);
                            if(!bloodType.equals("N/S") && weeks > 28){
                                String symbol = bloodType.substring(bloodType.length() - 1);
                                if(symbol.equals("-"))
                                    noticeMessage =  "**** Needs RH immune globulin shot if not have yet! ****";
                            }
                            session.removeAttribute("pid");
                        }
                    } catch (FormValidationException e){
                    %>
                    <div align=center><span class="iTrustError"><%=StringEscapeUtils.escapeHtml(e.getMessage())%></span></div>
                    <%
                    }
                }
            }
        }

%>
<div align="left" <%=hidden %> id="officeVisitDiv">
    <h2>Document an Office Visit</h2>
    <h4>with <%= StringEscapeUtils.escapeHtml("" + ( action.getName(patientID) )) %> (<a href="/iTrust/auth/getPatientID.jsp?forward=hcp/documentOfficeVisit.jsp">someone else</a>):</h4>
    <span class="iTrustMessage"><%= StringEscapeUtils.escapeHtml("" + (headerMessage )) %></span><br /><br />
    <span class="iTrustMessage"><%= StringEscapeUtils.escapeHtml("" + (noticeMessage )) %></span><br /><br />
    <span>Weight Gain: </span>
    <input style="width: 250px;" type="text" name="weightGain" value="<%= StringEscapeUtils.escapeHtml("" + ( weightGain)) %>" />
    <br /><br />
    <span>Blood Pressure: </span>
    <input style="width: 250px;" type="text" name="bloodPressure" value="<%= StringEscapeUtils.escapeHtml("" + ( bloodPressure)) %>" />
    <br /><br />
    <span>Fetal Heart Rate: </span>
    <input style="width: 250px;" type="text" name="fetalHeartRate" value="<%= StringEscapeUtils.escapeHtml("" + ( fetalHeartRate)) %>" />
    <br /><br />
    <span>Number of Pregnancy: </span>
    <input style="width: 250px;" type="text" name="numberOfPregnancy" value="<%= StringEscapeUtils.escapeHtml("" + ( numberOfPregnancy)) %>" />
    <br /><br />
    <span>Low Lying Placenta: </span>
    <select name="lowLyingPlacenta">
        <%
            String LLP = "";
            for(int i = 0; i < 2; i++){
                if (i == 0)
                    LLP = "true";
                else
                    LLP = "false";
                %>
                    <option <% if(LLP.toString().equals(lowLyingPlacenta)) out.print("selected='selected'"); %> value="<%=LLP%>"><%= StringEscapeUtils.escapeHtml("" + (LLP)) %></option>
                <%
            }
        %>
    </select>
    <br /><br />



    <input type="submit" value="submit" name="officeVisitRecordButton"/>
    <input type="hidden" value="OfficeVisitRecord" name="officeVisitRecord"/>

    <br />
    <br />
</div>
</form>
<% } %>

<%@include file="/footer.jsp" %>


