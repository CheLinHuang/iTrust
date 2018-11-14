<%--
  Created by IntelliJ IDEA.
  User: roger
  Date: 11/13/18
  Time: 9:09 PM
  To change this template use File | Settings | File Templates.
--%>
<%@include file="/global.jsp" %>
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





<%
    pageTitle = "iTrust - Please Select a Patient";
%>

<%@include file="/header.jsp" %>

<%
    String uid_pid = request.getParameter("UID_PATIENTID");
    Long pid = uid_pid == null ? null : Long.parseLong(uid_pid);
    System.out.println(uid_pid);

    session.setAttribute("pid", uid_pid);
//    if (null != uid_pid && !"".equals(uid_pid)) {
//        response.sendRedirect(request.getParameter("forward"));
//    }

    String firstName = request.getParameter("FIRST_NAME");
    String lastName = request.getParameter("LAST_NAME");
    if(firstName == null)
        firstName = "";
    if(lastName == null)
        lastName = "";
%>
<h1>
    <%= uid_pid %>
</h1>

<%
    ObstetricHistoryAction oba = new ObstetricHistoryAction(DAOFactory.getProductionInstance());
    List<ObstetricsInitRecordBean> historyList = oba.getPatientObstericsInitRecords(pid);
%>
    <table style="width:100%">
        <tr>
            <th>LMP</th>
            <th>EDD</th>
            <th>Weeks of Pregnancy</th>
            <th>Time of Record</th>
        </tr>


<%
    for (ObstetricsInitRecordBean b : historyList) {
%>
        <tr>
            <th><%= b.getLMP() %></th>
            <th><%= b.getEDD() %></th>
            <th><%= b.getWeeksOfPregnant() %></th>
            <th><%= StringEscapeUtils.escapeHtml("" + b.getRecordCreatedTime()) %></th>
        </tr>
<%
    }
%>
    </table>

<p><%=historyList%></p>




<%@include file="/footer.jsp" %>
