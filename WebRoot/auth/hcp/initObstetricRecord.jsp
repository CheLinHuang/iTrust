<%--
  Created by IntelliJ IDEA.
  User: roger
  Date: 11/14/18
  Time: 10:24 PM
  To change this template use File | Settings | File Templates.
--%>
<%@taglib prefix="itrust" uri="/WEB-INF/tags.tld"%>
<%@page errorPage="/auth/exceptionHandler.jsp"%>

<%@page import="edu.ncsu.csc.itrust.model.old.dao.DAOFactory"%>
<%@page import="edu.ncsu.csc.itrust.model.old.beans.PatientBean"%>
<%@page import="edu.ncsu.csc.itrust.action.EditPatientAction"%>
<%@page import="edu.ncsu.csc.itrust.BeanBuilder"%>
<%@page import="edu.ncsu.csc.itrust.model.old.enums.Ethnicity"%>
<%@page import="edu.ncsu.csc.itrust.model.old.enums.BloodType"%>
<%@page import="edu.ncsu.csc.itrust.exception.FormValidationException"%>
<%@page import="edu.ncsu.csc.itrust.model.old.enums.Gender"%>

<%@page import="java.util.List" %>
<%@page import="edu.ncsu.csc.itrust.model.old.dao.DAOFactory" %>
<%@page import="edu.ncsu.csc.itrust.action.SearchUsersAction" %>
<%@page import="edu.ncsu.csc.itrust.model.old.beans.PatientBean" %>

<%@page import="edu.ncsu.csc.itrust.model.old.beans.PregnancyBean" %>
<%@page import="edu.ncsu.csc.itrust.model.old.dao.mysql.PregnancyDAO" %>
<%@page import="edu.ncsu.csc.itrust.model.old.beans.ObstetricsInitRecordBean" %>
<%@page import="edu.ncsu.csc.itrust.model.old.dao.mysql.ObstetricsInitRecordDAO" %>
<%@page import="edu.ncsu.csc.itrust.model.old.validate.ObstetricsInitRecordBeanValidator" %>

<%@page import="edu.ncsu.csc.itrust.model.old.beans.loaders.ObstetricsInitRecordBeanLoader" %>
<%@page import="edu.ncsu.csc.itrust.model.old.beans.loaders.PregnancyBeanLoader" %>
<%@page import="edu.ncsu.csc.itrust.action.ObstetricHistoryAction" %>

<%@page import="java.time.format.DateTimeFormatter" %>
<%@page import="java.time.LocalDateTime" %>
<%@page import="java.time.LocalDate" %>
<%@page import="java.text.SimpleDateFormat" %>
<%@page import="java.util.Date" %>
<%@page import="java.time.temporal.ChronoUnit" %>


<%@include file="/global.jsp"%>

<%
    pageTitle = "iTrust - Initialize Obstetric Patient Obstetric Record";
%>

<%@include file="/header.jsp"%>
<itrust:patientNav thisTitle="Demographics" />
<%
    /* Require a Patient ID first */
    String pidString = (String) session.getAttribute("pid");
    // For reloading -> Calling the same page of itself recursively when needed
    String LMPDateString = request.getParameter("dateOfBirthStr");
    System.out.println(request.getParameter("dateOfBirthStr") + "------");

    boolean LMPDateStringIsNull = LMPDateString == null;





    // System.out.println(pidString);
    Long pid = pidString == null ? null : Long.parseLong(pidString);

    if (pidString == null || pidString.equals("") || 1 > pidString.length()) {
        out.println("pidstring is null");
        response.sendRedirect("/iTrust/auth/getPatientInfo.jsp?forward=hcp/getPatientInfo.jsp"); //
        return;
    }

    /* If the patient id doesn't check out, then kick 'em out to the exception handler */
//    EditPatientAction action = new EditPatientAction(prodDAO,
//            loggedInMID.longValue(), pidString);pidString


    /* Now take care of updating information */

    boolean formIsFilled = request.getParameter("formIsFilled") != null
            && request.getParameter("formIsFilled").equals("true");


    // Updating obstetric history through ObstetricHistoryAction //
    ObstetricHistoryAction oba = new ObstetricHistoryAction(DAOFactory.getProductionInstance());


    // Accessing latest preganancy history data for display in the prepopulated form
    List<PregnancyBean> pregnancyHistoryList = oba.getAllPregnancy(pid);
    PregnancyBean mostRecentPregnancy = null;
    if (pregnancyHistoryList.size() > 0) {
        mostRecentPregnancy = pregnancyHistoryList.get(0);
    }
//
//    String LMPValue = "";
//    String formattedEDD = "";
//    String weeksPregnant = "";
//    String yearOfConception = "";
//    String weekOfPregnancy = "";
//    String hoursInLabor = "";
//    String weightGain = "";
//    String deliveryType = "";

    if (formIsFilled) {
%>
<br />
<div align=center>
    <span class="iTrustMessage">Obstetric Initialized for Patient MID : <%=pidString%></span>
</div>
<br />
<%
    }

////    PatientBean p;
//    if (formIsFilled) {
////        p = new BeanBuilder<PatientBean>().build(request
////                .getParameterMap(), new PatientBean());
////        try {
//////            action.updateInformation(p);
//
//
//            int initializationRecord = oba.initializationObstetricRecord(pidString, LMPValue, formattedEDD, weeksPregnant);
//            if (initializationRecord != -1) {
//                System.out.println("Init Record okay~!");
//            }
//            // Add only if prior pregnancy is not in the iTrust system
//            int addPregnanacyInfo = 0;
//            if (mostRecentPregnancy == null) {
//                addPregnanacyInfo = oba.addPregnancyInformation(pidString, yearOfConception, weekOfPregnancy, hoursInLabor, weightGain, deliveryType);
//            }
//            if (addPregnanacyInfo != -1) {
//                System.out.println("Pregnancy okay~!");
//            }
//
//
//            // loggingAction.logEvent(TransactionType.DEMOGRAPHICS_EDIT, loggedInMID.longValue(), p.getMID(), "");


%>


<%--<br />--%>
<%--<div align=center>--%>
    <%--<span class="iTrustMessage">Obstetric Initialized for Patient MID : <%=pidString%></span>--%>
<%--</div>--%>
<%--<br />--%>
<%--<%--%>
<%--} catch (FormValidationException e) {--%>
<%--%>--%>
<%--<br />--%>
<%--<div align=center>--%>
    <%--<span class="iTrustError"><%=StringEscapeUtils.escapeHtml(e.getMessage()) %></span>--%>
<%--</div>--%>
<%--<br />--%>
<%--<%--%>
<%--//        }--%>
    <%--}--%>
<%--//    else {--%>
<%--//        p = action.getPatient();--%>
<%--//        loggingAction.logEvent(TransactionType.DEMOGRAPHICS_VIEW, loggedInMID.longValue(), p.getMID(), "");--%>
<%--//    }--%>
<%--%>--%>

<form id="editForm" action="initObstetricRecord.jsp" method="post"><input type="hidden"
                                                                  name="formIsFilled" value="true"> <br />
    <table cellspacing=0 align=center cellpadding=0>
        <tr>
            <td width="15px">&nbsp;</td>
            <td valign=top>

                <table class="fTable" align=center style="width: 350px;">
                    <tr>
                        <th colspan=2>Obstetric Initialize Information</th>
                    </tr>
                    <%
                        // Time and Date related!
                        // Java 8 approach
                        DateTimeFormatter DATE_FORMAT = DateTimeFormatter.ofPattern("MM/dd/yyyy");

                        //LocalDateTime todaysDate = LocalDateTime.now();
                        LocalDate todaysDate = LocalDate.now();

                        String formattedTodaysDate = todaysDate.format(DATE_FORMAT);
                        //System.out.println(formattedTodaysDate);

//                        // java 7 approach
//                        SimpleDateFormat DATE_FORMAT = new SimpleDateFormat("MM/dd/yyyy");
//                        Date today = new Date();
//                        String date = DATE_FORMAT.format(today);
//                        System.out.println(date);

                    %>
                    <tr>
                        <td class="subHeaderVertical">LMP:</td>
                            <td>
                                <input type=text name="dateOfBirthStr" maxlength="10"
                                       size="10" id="LMPvalue"
                                        <% String LMPValue = LMPDateStringIsNull ? formattedTodaysDate : LMPDateString; %>
                                       value="<%= StringEscapeUtils.escapeHtml("" + LMPValue) %>">
                                <input
                                        type=button value="Select Date"
                                        onclick="displayDatePicker('dateOfBirthStr');">
                                <%--<input type="button" value="Calculate EDD"--%>
                                       <%--onclick="#">--%>
                                <a href="" onclick="location.href = $(this).attr('href')+'?dateOfBirthStr=' + document.getElementById('LMPvalue').value;return false;">Update EDD</a>
                            </td>
                    </tr>
                    <%
                        LocalDate LMPDate;
                        if (LMPDateStringIsNull) {
                            LMPDate = LocalDate.now();
                        } else {
                            // LMP date is passed back as string and parsed from string into LocalDate type for further calculation
                            DateTimeFormatter DATE_FORMAT_INPUT = DateTimeFormatter.ofPattern("MM/dd/yyyy");
                            LMPDate = LocalDate.parse(LMPDateString, DATE_FORMAT_INPUT);
                        }

                        LocalDate EDD = LMPDate.plusDays(280);
                        String formattedEDD = EDD.format(DATE_FORMAT);
                        //System.out.println(formattedEDD);
                    %>
                    <tr>
                        <td class="subHeaderVertical">EDD:</td>
                        <td>
                            <input name="EDD"
                                   value="<%=formattedEDD%>" type="text" size="12" maxlength="12">
                        </td>
                    </tr>
                    <%
                        // String LMPDateString = request.getParameter("dateOfBirthStr");
                        System.out.println(LMPDateString);

                        System.out.println(LMPDate);

                        Long totalDaysOfPregnancy = ChronoUnit.DAYS.between(LMPDate, todaysDate);
                        Long weeks = totalDaysOfPregnancy / 7;
                        Long  days = totalDaysOfPregnancy % 7;
                    %>
                    <tr>
                        <td class="subHeaderVertical">Weeks Pregnant:</td>
                        <td>
                            <input name="weeksPregnant"
                                   <% String weeksPregnant = weeks.toString() + "-" + days.toString(); %>
                                   value="<%=weeksPregnant%>" type="text" size="12" maxlength="12">
                        </td>
                    </tr>
                    <tr>
                        <td class="subHeaderVertical">Record Created Date:</td>
                        <td>
                            <input name="recordeCreatedDate"
                                   value="<%=todaysDate%>" type="text" size="12" maxlength="12">
                        </td>

                    </tr>
                </table>

                <br />

                <table class="fTable" align=center style="width: 350px;">
                    <tr>
                        <th colspan=2>Pregnancy Information</th>
                    </tr>

                    <%--<%--%>
                        <%--List<PregnancyBean> pregnancyHistoryList = oba.getAllPregnancy(pid);--%>
                        <%--PregnancyBean mostRecentPregnancy = pregnancyHistoryList.get(0);--%>
                    <%--%>--%>

                    <tr>
                        <td class="subHeaderVertical">Year of Conception:</td>
                        <td><input name="yearOfConception"
                                   <%String yearOfConception = mostRecentPregnancy == null ? "" : Integer.toString(mostRecentPregnancy.getYearOfConception()); %>
                                   value="<%= yearOfConception %>" type="text"></td>
                    </tr>
                    <tr>
                        <td class="subHeaderVertical">Weeks of Pregnancy:</td>
                        <td>
                        <%String weekOfPregnancy = mostRecentPregnancy == null ? "" : mostRecentPregnancy.getWeeksOfPregnant(); %>
                        <%
                            String week = "";
                            String day = "";
                            if (!weekOfPregnancy.equals("")) {
                                String[] weekDayStringArray = weekOfPregnancy.split("-");
                                week = weekDayStringArray[0];
                                day = weekDayStringArray[1];
                            }
                        %>
                            <select name="weeksOfPregnancy">
                                <% if (!weekOfPregnancy.equals("")) { %>
                                    <option value="<%=week%>"><%=week%></option>
                                <%} else {%>
                                    <option value="">Select:</option>
                                    <% for (int i = 0; i <= 42; i++) { %>
                                        <option value="<%=i%>"><%=i%></option>
                                    <%}%>
                                <%}%>
                            </select>
                            -
                            <select name="daysOfPregnancy">
                                <% if (!day.equals("")) { %>
                                    <option value="<%=day%>"><%=day%></option>
                                <%} else {%>
                                    <option value="">Select:</option>
                                    <% for (int i = 0; i <= 6; i++) { %>
                                        <option value="<%=i%>"><%=i%></option>
                                    <%}%>
                                <%}%>
                            </select>
                        </td>
                        <%--<td>--%>
                            <%--<input name="weekOfPregnancy"--%>
                                    <%--<%String weekOfPregnancy = mostRecentPregnancy == null ? "" : mostRecentPregnancy.getWeeksOfPregnant(); %>--%>
                                   <%--value="<%= weekOfPregnancy %>" type="text" size="12" maxlength="12">--%>
                        <%--</td>--%>
                    </tr>
                    <tr>
                        <td class="subHeaderVertical">Hours In Labor:</td>
                        <td>
                            <input name="hoursInLabor"
                                    <%String hoursInLabor = mostRecentPregnancy == null ? "" : Double.toString(mostRecentPregnancy.getHoursInLabor()); %>
                                   value="<%= hoursInLabor %>" type="text" size="12" maxlength="12">
                        </td>
                    </tr>
                    <tr>
                        <td class="subHeaderVertical">Weight Gain:</td>
                        <td>
                            <input name="weightGain"
                                    <%String weightGain = mostRecentPregnancy == null ? "" : Double.toString(mostRecentPregnancy.getWeightGain()); %>
                                   value="<%= weightGain %>" type="text" size="12" maxlength="12">
                        </td>
                    </tr>
                    <tr>
                        <td class="subHeaderVertical">Delivery Type:</td>
                        <%String deliveryType = mostRecentPregnancy == null ? "" : mostRecentPregnancy.getDeliveryType(); %>
                        <td>
                            <select name="deliveryType">
                                <% if (!deliveryType.equals("")) { %>
                                    <option value="<%=deliveryType%>"><%=deliveryType%></option>
                                    <option value="vaginal delivery">Vaginal Delivery</option>
                                    <option value="vaginal delivery vacuum assist">Vaginal Delivery Vacuum Assist</option>
                                    <option value="vaginal delivery forceps assist">Vaginal Delivery Forceps Assist</option>
                                    <option value="caesarean section">Caesarean Section</option>
                                    <option value="miscarriage">Miscarriage</option>
                                <%} else {%>
                                <option value="">Select:</option>
                                <option value="vaginal delivery">Vaginal Delivery</option>
                                <option value="vaginal delivery vacuum assist">Vaginal Delivery Vacuum Assist</option>
                                <option value="vaginal delivery forceps assist">Vaginal Delivery Forceps Assist</option>
                                <option value="caesarean section">Caesarean Section</option>
                                <option value="miscarriage">Miscarriage</option>
                                <%}%>
                            </select>
                            <%--<input name="deliveryType"--%>
                                    <%--<%String deliveryType = mostRecentPregnancy == null ? "" : mostRecentPregnancy.getDeliveryType(); %>--%>
                                   <%--value="<%= deliveryType %>" type="text" size="20" maxlength="20">--%>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <br />

    <div align=center>
        <%--<% if(p.getDateOfDeactivationStr().equals("")){ %>--%>
        <input type="submit" name="action" style="font-size: 16pt; font-weight: bold;" value="Edit Patient Record">
        <%
            //    PatientBean p;
            if (formIsFilled) {
//        p = new BeanBuilder<PatientBean>().build(request
//                .getParameterMap(), new PatientBean());
//        try {
////            action.updateInformation(p);


                int initializationRecord = oba.initializationObstetricRecord(pidString, LMPValue, formattedEDD, weeksPregnant);
                if (initializationRecord != -1) {
                    System.out.println("Init Record okay~!");
                }
//                // Add only if prior pregnancy is not in the iTrust system
//                int addPregnanacyInfo = 0;

                yearOfConception = request.getParameter("yearOfConception");
                // weekOfPregnancy = request.getParameter("weekOfPregnancy");
                String weekString = request.getParameter("weeksOfPregnancy");
                String dayString = request.getParameter("daysOfPregnancy");
                weekOfPregnancy = weekString + "-" + dayString;



                hoursInLabor = request.getParameter("hoursInLabor");
                weightGain = request.getParameter("weightGain");
                deliveryType = request.getParameter("deliveryType");

                System.out.println(yearOfConception);
                System.out.println(weekOfPregnancy);
                System.out.println(hoursInLabor);
                System.out.println(weightGain);
                System.out.println(deliveryType);

                System.out.println("+++++++Before++++++");

                System.out.println(pidString);
                int addPregnanacyInfo = oba.addPregnancyInformation(pidString, yearOfConception, weekOfPregnancy, hoursInLabor, weightGain, deliveryType);

                System.out.println("-------After--------");
                System.out.println(pidString);

                System.out.println(yearOfConception);
                System.out.println(weekOfPregnancy);
                System.out.println(hoursInLabor);
                System.out.println(weightGain);
                System.out.println(deliveryType);

                if (addPregnanacyInfo != -1) {
                    System.out.println("Pregnancy okay~!");
                }
                // loggingAction.logEvent(TransactionType.DEMOGRAPHICS_EDIT, loggedInMID.longValue(), p.getMID(), "");
            } else {
                System.out.println("No Idea wtf to do...");
            }

        %>

        <%--<% } else { %>--%>
        <%--<span style="font-size: 16pt; font-weight: bold;">Patient is deactivated.  Cannot edit.</span>--%>
        <%--<% } %>--%>
        <%--<br /><br />--%>
        <%--<span style="font-size: 14px;">--%>
		<%--Note: in order to set the password for this user, use the "Reset Password" link at the login page.--%>
	<%--</span>--%>
    </div>
</form>
<br />
<br />
<itrust:patientNav thisTitle="Demographics" />

<%@include file="/footer.jsp"%>


