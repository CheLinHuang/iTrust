<%@page errorPage="/auth/exceptionHandler.jsp"%>

<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="edu.ncsu.csc.itrust.action.ViewMyOfficeVisitRecordsAction"%>
<%@page import="edu.ncsu.csc.itrust.model.old.beans.OfficeVisitRecordBean"%>
<%@page import="edu.ncsu.csc.itrust.model.old.dao.DAOFactory"%>

<%@include file="/global.jsp" %>

<%
    pageTitle = "iTrust - View My Messages";
%>

<%@include file="/header.jsp" %>

<div align=center>
    <h2>My Office Visit</h2>
    <%
        ViewMyOfficeVisitRecordsAction action = new ViewMyOfficeVisitRecordsAction(prodDAO, loggedInMID.longValue());
        List<OfficeVisitRecordBean> officeVisitRecords = action.getMyOfficeVisitRecords();
        session.setAttribute("officeVisitRecords", officeVisitRecords);
        if (officeVisitRecords.size() > 0) { %>
    <table class="fTable">
        <tr>
            <th>Patient</th>
            <th>Weeks of Pregnancy</th>
            <th>Weight Gain</th>
            <th>Blood Pressure</th>
            <th>Fetal Heart Rate</th>
            <th>Number of Pregnancy</th>
            <th>Low Lying Placenta</th>
            <th>Change</th>
            <th>Add Ultrasound Record</th>
        </tr>
        <%
            int index = 0;
            for(OfficeVisitRecordBean ov : officeVisitRecords) {

                String row = "<tr";
        %>
        <%=row+" "+((index%2 == 1)?"class=\"alt\"":"")+">"%>
        <td><%= StringEscapeUtils.escapeHtml("" + ( action.getName(ov.getPatient()) )) %></td>
        <td><%= StringEscapeUtils.escapeHtml("" + ( ov.getWeeksOfPregnant() )) %></td>
        <td><%= StringEscapeUtils.escapeHtml("" + ( ov.getWeightGain() )) %></td>
        <td><%= StringEscapeUtils.escapeHtml("" + ( ov.getBloodPressure() )) %></td>
        <td><%= StringEscapeUtils.escapeHtml("" + ( ov.getFetalHeartRate() )) %></td>
        <td><%= StringEscapeUtils.escapeHtml("" + ( ov.getNumberOfPregnancy() )) %></td>
        <td><%= StringEscapeUtils.escapeHtml("" + ( ov.getLowLyingPlacenta() )) %></td>
        <td>Edit</td>
        <td><a href="editOfficeVisitRecord.jsp?apt=<%=ov.getOfficeVisitRecordID() %>">Edit</a></td>
        <%--<td>Add</td>--%>
        <td><a href="documentUltraSound.jsp?apt=<%=ov.getOfficeVisitRecordID() %>">Add</a></td>
        </tr>
        <%
                index ++;
            }
        %>
    </table>
    <%	} else { %>
    <div>
        <i>You have no Office Visits</i>
    </div>
    <%	} %>
    <br />
</div>

<%@include file="/footer.jsp" %>
