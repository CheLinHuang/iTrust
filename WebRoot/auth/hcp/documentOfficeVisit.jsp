<%@page import="java.text.ParseException"%>
<%@page errorPage="/auth/exceptionHandler.jsp"%>

<%@page import="java.lang.*"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="edu.ncsu.csc.itrust.model.old.beans.OfficeVisitRecordBean"%>
<%@page import="edu.ncsu.csc.itrust.action.AddOfficeVisitRecordAction"%>
<%@page import="edu.ncsu.csc.itrust.model.old.dao.OfficeVisitRecordDAO"%>
<%@page import="edu.ncsu.csc.itrust.exception.ITrustException"%>
<%@page import="edu.ncsu.csc.itrust.exception.FormValidationException"%>

<%@include file="/global.jsp" %>

<%
    pageTitle = "iTrust - Document an Office Visit";

    String headerMessage = "Please fill out the form properly - all entries are required.";
%>

<%@include file="/header.jsp" %>

<form id="mainForm" method="post" action="documentOfficeVisit.jsp">
<%
    AddOfficeVisitRecordAction action = new AddOfficeVisitRecordAction(prodDAO, loggedInMID.longValue());
    //PatientDAO patientDAO = prodDAO.getPatientDAO();
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
    String weeksOfPregnant="";
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
                weeksOfPregnant = request.getParameter("weeksOfPregnant");
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
                } catch (NumberFormatException nfe){
                    error = true;
                }
                if (error){
                    headerMessage = "Invalid Value!";
                }else{
                    ovrecord.setWeightGain(weightGainD);
                    ovrecord.setBloodPressure(bloodPressureD);
                    ovrecord.setFetalHeartRate(fetalHeartRateD);
                    ovrecord.setNumberOfPregnancy(numberOfPregnancyI);
                    try {
                        headerMessage = action.addOfficeVisitRecord(ovrecord, false);
                        if(headerMessage.startsWith("Success")) {
                            session.removeAttribute("pid");
                        }
                    } catch (FormValidationException e){
                    %>
                    <div align=center><span class="iTrustError">test by yidan !********************************<%=StringEscapeUtils.escapeHtml(e.getMessage())%></span></div>
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
    <span>Weeks Of Pregnancy: </span>
    <input style="width: 250px;" type="text" name="weeksOfPregnant" value="<%= StringEscapeUtils.escapeHtml("" + ( weeksOfPregnant)) %>" />
    <br /><br />
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


