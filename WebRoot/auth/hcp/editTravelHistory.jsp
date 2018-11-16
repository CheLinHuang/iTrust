<%--
  Created by IntelliJ IDEA.
  User: jaewooklee
  Date: 11/15/18
  Time: 10:20 PM
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
<%@include file="/global.jsp" %>

<%
    pageTitle = "iTrust - Edit Travel History";
%>
<%@include file="/header.jsp" %>
<itrust:patientNav thisTitle="Edit Travel History" />
<br />
<%
    // Prompt User MID
    boolean active = false;
    String pidString = (String)session.getAttribute("pid");
    if (pidString == null || 1 > pidString.length()) {
        response.sendRedirect("/iTrust/auth/getPatientID.jsp?forward=hcp/editTravelHistory.jsp");
        return;
    }

    Role role = authDAO.getUserRole(Long.parseLong(pidString));
    if (role != Role.PATIENT) {
        %>
        <div align=center>
		    <h3 class="iTrustError">
            Cannot Edit. <%=authDAO.getUserName(Long.parseLong(pidString))%> is not a patient.
            </h3>
        </div>
<%
        return;
    }
    long MID = Long.parseLong(pidString);
    TravelHistoryDAO action = new TravelHistoryDAO(prodDAO);
    List<TravelHistoryBean> travelHistories = null;
    try {
        travelHistories = action.getTravelHistoriesByMID(MID);
    } catch (DBException e) {
%>
        <div align=center>
            <span class="iTrustError"><%=StringEscapeUtils.escapeHtml(e.getMessage()) %></span>
        </div>
        <br />
<%
        return;
    }

    if (travelHistories.size() == 0) {
        %>
        <div align=center>
            <h1>No Travel History for <%=authDAO.getUserName(MID)%></h1>
        </div>
        <%
    } else {
        Date startDate = new Date();
        Date endDate = new Date();
        String cities = "LA New York";
        %>
        <div align=center>
            <h1>Travel History for <%=authDAO.getUserName(MID)%></h1>
        </div>

        <table width="59%" border="1" align=center>
            <thead>
            <tr>
                <th>Start Date</th>
                <th>End Date</th>
                <th>Travelled Cities</th>
            </tr>
            </thead>
            <tbody>
            <%
                for (TravelHistoryBean travelHistory : travelHistories) {
                    startDate = travelHistory.getStartDate();
                    endDate = travelHistory.getEndDate();
                    cities = travelHistory.getTravelledCities();
                    %>
                    <tr>
                        <th><%=DateUtil.dateToSimpleDate(startDate)%></th>
                        <th><%=DateUtil.dateToSimpleDate(endDate)%></th>
                        <th><%=cities%></th>
                    </tr>
                    <%
                }
            %>
            </tbody>
        </table>
<%
    }

%>

<%@include file="/footer.jsp" %>
