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
    EditPatientAction action = new EditPatientAction(prodDAO,
            loggedInMID.longValue(), pidString);


    /* Now take care of updating information */

    boolean formIsFilled = request.getParameter("formIsFilled") != null
            && request.getParameter("formIsFilled").equals("true");


    // Updating obstetric history through ObstetricHistoryAction //
    ObstetricHistoryAction oba = new ObstetricHistoryAction(DAOFactory.getProductionInstance());


    PatientBean p;
    if (formIsFilled) {
        p = new BeanBuilder<PatientBean>().build(request
                .getParameterMap(), new PatientBean());
        try {
            action.updateInformation(p);
            loggingAction.logEvent(TransactionType.DEMOGRAPHICS_EDIT, loggedInMID.longValue(), p.getMID(), "");


%>


<br />
<div align=center>
    <span class="iTrustMessage">Information Successfully Updated</span>
</div>
<br />
<%
} catch (FormValidationException e) {
%>
<br />
<div align=center>
    <span class="iTrustError"><%=StringEscapeUtils.escapeHtml(e.getMessage()) %></span>
</div>
<br />
<%
        }
    } else {
        p = action.getPatient();
        loggingAction.logEvent(TransactionType.DEMOGRAPHICS_VIEW, loggedInMID.longValue(), p.getMID(), "");
    }

%>

<form id="editForm" action="editPatient.jsp" method="post"><input type="hidden"
                                                                  name="formIsFilled" value="true"> <br />
    <table cellspacing=0 align=center cellpadding=0>
        <tr>
            <%--<td valign=top>--%>
                <%--<table class="fTable" align=center style="width: 350px;">--%>
                    <%--<tr>--%>
                        <%--<th colspan=2>Patient Information</th>--%>
                    <%--</tr>--%>
                    <%--<tr>--%>

                        <%--<td class="subHeaderVertical">First Name:</td>--%>
                        <%--<td><input name="firstName" value="<%= StringEscapeUtils.escapeHtml("" + (p.getFirstName())) %>" type="text"></td>--%>
                    <%--</tr>--%>
                    <%--<tr>--%>
                        <%--<td class="subHeaderVertical">Last Name:</td>--%>
                        <%--<td><input name="lastName" value="<%= StringEscapeUtils.escapeHtml("" + (p.getLastName())) %>" type="text"></td>--%>
                    <%--</tr>--%>
                    <%--<tr>--%>
                        <%--<td class="subHeaderVertical">Email:</td>--%>
                        <%--<td><input name="email" value="<%= StringEscapeUtils.escapeHtml("" + (p.getEmail())) %>" type="text"></td>--%>
                    <%--</tr>--%>
                    <%--<tr>--%>
                        <%--<td class="subHeaderVertical">Address:</td>--%>
                        <%--<td><input name="streetAddress1"--%>
                                   <%--value="<%= StringEscapeUtils.escapeHtml("" + (p.getStreetAddress1())) %>" type="text"><br />--%>
                            <%--<input name="streetAddress2" value="<%= StringEscapeUtils.escapeHtml("" + (p.getStreetAddress2())) %>" type="text"></td>--%>
                    <%--</tr>--%>
                    <%--<tr>--%>
                        <%--<td class="subHeaderVertical">City:</td>--%>
                        <%--<td><input name="city" value="<%= StringEscapeUtils.escapeHtml("" + (p.getCity())) %>" type="text">--%>
                        <%--</td>--%>
                    <%--</tr>--%>
                    <%--<tr>--%>
                        <%--<td class="subHeaderVertical">State:</td>--%>
                        <%--<td><itrust:state name="state" value="<%= StringEscapeUtils.escapeHtml(p.getState()) %>" /></td>--%>
                    <%--</tr>--%>
                    <%--<tr>--%>
                        <%--<td class="subHeaderVertical">Zip:</td>--%>
                        <%--<td>--%>
                            <%--<input name="zip" value="<%= StringEscapeUtils.escapeHtml("" + (p.getZip())) %>" maxlength="10" type="text" size="10">--%>
                        <%--</td>--%>
                    <%--</tr>--%>
                    <%--<tr>--%>
                        <%--<td class="subHeaderVertical">Phone:</td>--%>
                        <%--<td>--%>
                            <%--<input name="phone" value="<%= StringEscapeUtils.escapeHtml("" + (p.getPhone())) %>" type="text" size="12" maxlength="12">--%>
                    <%--</tr>--%>
                    <%--<tr>--%>
                        <%--<td class="subHeaderVertical">Mother MID:</td>--%>
                        <%--<td><input name="motherMID" value="<%= StringEscapeUtils.escapeHtml("" + (p.getMotherMID())) %>"--%>
                                   <%--maxlength="10" type="text"></td>--%>
                    <%--</tr>--%>

                    <%--<tr>--%>
                        <%--<td class="subHeaderVertical">Father MID:</td>--%>
                        <%--<td><input name="fatherMID" value="<%= StringEscapeUtils.escapeHtml("" + (p.getFatherMID())) %>"--%>
                                   <%--maxlength="10" type="text"></td>--%>
                    <%--</tr>--%>
                    <%--<tr>--%>
                        <%--<td class="subHeaderVertical">Credit Card Type:</td>--%>
                        <%--<td><select name="creditCardType">--%>
                            <%--<option value="">Select:</option>--%>
                            <%--<option value="MASTERCARD" <%= StringEscapeUtils.escapeHtml("" + ( p.getCreditCardType().equals("MASTERCARD") ? "selected" : "" )) %>>Mastercard</option>--%>
                            <%--<option value="VISA" <%= StringEscapeUtils.escapeHtml("" + ( p.getCreditCardType().equals("VISA") ? "selected" : "" )) %>>Visa</option>--%>
                            <%--<option value="DISCOVER" <%= StringEscapeUtils.escapeHtml("" + ( p.getCreditCardType().equals("DISCOVER") ? "selected" : "" )) %>>Discover</option>--%>
                            <%--<option value="AMEX" <%= StringEscapeUtils.escapeHtml("" + ( p.getCreditCardType().equals("AMEX") ? "selected" : "" )) %>>American Express</option>--%>
                        <%--</select>--%>
                        <%--</td>--%>
                    <%--</tr>--%>
                    <%--<tr>--%>
                        <%--<td class="subHeaderVertical">Credit Card Number:</td>--%>
                        <%--<td><input name="creditCardNumber" value="<%= StringEscapeUtils.escapeHtml("" + (p.getCreditCardNumber())) %>"--%>
                                   <%--maxlength="19" type="text"></td>--%>
                    <%--</tr>--%>
                    <%--<tr>--%>
                        <%--<td class="subHeaderVertical">Directions to Home:</td>--%>
                        <%--<td ><textarea name="directionsToHome"><%= StringEscapeUtils.escapeHtml("" + (p.getDirectionsToHome())) %></textarea></td>--%>
                    <%--</tr>--%>
                    <%--<tr>--%>
                        <%--<td class="subHeaderVertical">Religion:</td>--%>
                        <%--<td ><input name="religion" value="<%= StringEscapeUtils.escapeHtml("" + (p.getReligion())) %>" type="text"></td>--%>
                    <%--</tr>--%>
                    <%--<tr>--%>
                        <%--<td class="subHeaderVertical">Language:</td>--%>
                        <%--<td ><input name="language" value="<%= StringEscapeUtils.escapeHtml("" + (p.getLanguage())) %>" type="text"></td>--%>
                    <%--</tr>--%>
                    <%--<tr>--%>
                        <%--<td class="subHeaderVertical">Spiritual Practices:</td>--%>
                        <%--<td ><textarea name="spiritualPractices"><%= StringEscapeUtils.escapeHtml("" + (p.getSpiritualPractices())) %></textarea></td>--%>
                    <%--</tr>--%>
                    <%--<tr>--%>
                        <%--<td class="subHeaderVertical">Alternate Name:</td>--%>
                        <%--<td ><input name="alternateName" value="<%= StringEscapeUtils.escapeHtml("" + (p.getAlternateName())) %>" type="text"></td>--%>
                    <%--</tr>--%>
                <%--</table>--%>
                <%--<br />--%>
                <%--<table class="fTable" align=center style="width: 350px;">--%>
                    <%--<tr>--%>
                        <%--<th colspan=2>Insurance Information</th>--%>
                    <%--</tr>--%>
                    <%--<tr>--%>
                        <%--<td class="subHeaderVertical">Name:</td>--%>
                        <%--<td><input name="icName" value="<%= StringEscapeUtils.escapeHtml("" + (p.getIcName())) %>" type="text">--%>
                        <%--</td>--%>
                    <%--</tr>--%>
                    <%--<tr>--%>
                        <%--<td class="subHeaderVertical">Address:</td>--%>
                        <%--<td><input name="icAddress1" value="<%= StringEscapeUtils.escapeHtml("" + (p.getIcAddress1())) %>"--%>
                                   <%--type="text"><br />--%>
                            <%--<input name="icAddress2" value="<%= StringEscapeUtils.escapeHtml("" + (p.getIcAddress2())) %>" type="text">--%>
                        <%--</td>--%>
                    <%--</tr>--%>
                    <%--<tr>--%>
                        <%--<td class="subHeaderVertical">City:</td>--%>
                        <%--<td><input name="icCity" value="<%= StringEscapeUtils.escapeHtml("" + (p.getIcCity())) %>" type="text">--%>
                        <%--</td>--%>
                    <%--</tr>--%>

                    <%--<tr>--%>
                        <%--<td class="subHeaderVertical">State:</td>--%>
                        <%--<td><itrust:state name="icState" value="<%= StringEscapeUtils.escapeHtml(p.getIcState()) %>" />--%>
                        <%--</td>--%>
                    <%--</tr>--%>
                    <%--<tr>--%>
                        <%--<td class="subHeaderVertical">Zip:</td>--%>
                        <%--<td>--%>
                            <%--<input name="icZip" value="<%= StringEscapeUtils.escapeHtml("" + (p.getIcZip())) %>" maxlength="10" type="text" size="10">--%>
                        <%--</td>--%>
                    <%--</tr>--%>
                    <%--<tr>--%>
                        <%--<td class="subHeaderVertical">Phone:</td>--%>
                        <%--<td>--%>
                            <%--<input name="icPhone" value="<%= StringEscapeUtils.escapeHtml("" + (p.getIcPhone())) %>" type="text" size="12" maxlength="12">--%>
                        <%--</td>--%>
                    <%--</tr>--%>
                    <%--<tr>--%>
                        <%--<td class="subHeaderVertical">Insurance ID:</td>--%>
                        <%--<td><input name="icID" value="<%= StringEscapeUtils.escapeHtml("" + (p.getIcID())) %>" type="text">--%>
                        <%--</td>--%>
                    <%--</tr>--%>
                <%--</table>--%>
            <%--</td>--%>

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
                                       value="<%= LMPDateStringIsNull ? StringEscapeUtils.escapeHtml("" + formattedTodaysDate) : StringEscapeUtils.escapeHtml("" + LMPDateString) %>">
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
                                   value="<%=weeks.toString()%>-<%=days.toString()%>" type="text" size="12" maxlength="12">
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

                    <%
                        List<PregnancyBean> pregnancyHistoryList = oba.getAllPregnancy(pid);
                        PregnancyBean mostRecentPregnancy = pregnancyHistoryList.get(0);
                    %>

                    <tr>
                        <td class="subHeaderVertical">Year of Conception:</td>
                        <td><input name="yearOfConception"
                                   value="<%= mostRecentPregnancy == null ? "" : StringEscapeUtils.escapeHtml("" + (mostRecentPregnancy.getYearOfConception())) %>" type="text"></td>
                    </tr>
                    <tr>
                        <td class="subHeaderVertical">Weeks of Pregnancy:</td>
                        <td>
                            <input name="weekOfPregnancy"
                                   value="<%= mostRecentPregnancy == null ? "" : StringEscapeUtils.escapeHtml("" + (mostRecentPregnancy.getWeeksOfPregnant())) %>" type="text" size="12" maxlength="12">
                        </td>
                    </tr>
                    <tr>
                        <td class="subHeaderVertical">Hours In Labor:</td>
                        <td>
                            <input name="hoursInLabor"
                                   value="<%= mostRecentPregnancy == null ? "" : StringEscapeUtils.escapeHtml("" + (mostRecentPregnancy.getHoursInLabor())) %>" type="text" size="12" maxlength="12">
                        </td>
                    </tr>
                    <tr>
                        <td class="subHeaderVertical">Weight Gain:</td>
                        <td>
                            <input name="weightGain"
                                   value="<%= mostRecentPregnancy == null ? "" : StringEscapeUtils.escapeHtml("" + (mostRecentPregnancy.getWeightGain())) %>" type="text" size="12" maxlength="12">
                        </td>
                    </tr>
                    <tr>
                        <td class="subHeaderVertical">Delivery Type:</td>
                        <td>
                            <input name="deliveryType"
                                   value="<%= mostRecentPregnancy == null ? "" : StringEscapeUtils.escapeHtml("" + (mostRecentPregnancy.getDeliveryType())) %>" type="text" size="12" maxlength="12">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <br />

    <div align=center>
        <% if(p.getDateOfDeactivationStr().equals("")){ %>
        <input type="submit" name="action" style="font-size: 16pt; font-weight: bold;" value="Edit Patient Record">
        <% } else { %>
        <span style="font-size: 16pt; font-weight: bold;">Patient is deactivated.  Cannot edit.</span>
        <% } %>
        <br /><br />
        <span style="font-size: 14px;">
		Note: in order to set the password for this user, use the "Reset Password" link at the login page.
	</span>
    </div>
</form>
<br />
<br />
<itrust:patientNav thisTitle="Demographics" />

<%@include file="/footer.jsp"%>


