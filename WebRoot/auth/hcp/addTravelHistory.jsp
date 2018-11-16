<%--
  Created by IntelliJ IDEA.
  User: jaewooklee
  Date: 11/16/18
  Time: 3:00 AM
  To change this template use File | Settings | File Templates.
--%>
<%@taglib prefix="itrust" uri="/WEB-INF/tags.tld" %>
<%@page errorPage="/auth/exceptionHandler.jsp" %>

<%@page import="java.util.List"%>
<%@page import="edu.ncsu.csc.itrust.model.old.enums.Role" %>
<%@page import="edu.ncsu.csc.itrust.model.old.dao.mysql.TravelHistoryDAO" %>
<%@page import="edu.ncsu.csc.itrust.model.old.beans.TravelHistoryBean" %>
<%@page import="edu.ncsu.csc.itrust.exception.DBException" %>
<%@page import="java.util.Date" %>
<%@page import="edu.ncsu.csc.itrust.DateUtil" %>
<%@page import="java.lang.StringBuilder"%>
<%@include file="/global.jsp" %>

<%
    pageTitle = "iTrust - Add Travel History";
%>
<%@include file="/header.jsp" %>
<itrust:patientNav thisTitle="Add Travel History" />
<br />
<%
    String pidString = request.getParameter("patientMID");
%>
<form method="post" action="addTravelHistoryToDB.jsp?patientMID=<%=pidString%>">
    Starting Date(Format: "yyyy/MM/dd"):<br>
    <input type="text" name="startDate">
    <br>
    Ending Date(Format: "yyyy/MM/dd"):<br>
    <input type="text" name="endDate">
    <br>
    Travelled Cities(Format: "city,country & city,country & ..."):<br>
    <input type="text" name="travelledCities">
    <br><br>
    <div align="center">
        <input type="submit" value="Add Travel History">
    </div>

</form>
<br />
<br />
<itrust:patientNav thisTitle="Add Travel History" />
<%@include file="/footer.jsp" %>