<%@page import="java.text.ParseException"%>
<%@page errorPage="/auth/exceptionHandler.jsp"%>

<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="edu.ncsu.csc.itrust.model.old.beans.ApptBean"%>
<%@page import="edu.ncsu.csc.itrust.model.old.beans.ApptTypeBean"%>
<%@page import="edu.ncsu.csc.itrust.action.AddApptAction"%>
<%@page import="edu.ncsu.csc.itrust.action.EditApptTypeAction"%>
<%@page import="edu.ncsu.csc.itrust.action.ViewMyApptsAction"%>
<%@page import="edu.ncsu.csc.itrust.model.old.dao.mysql.PatientDAO"%>
<%@page import="edu.ncsu.csc.itrust.model.old.dao.mysql.ApptTypeDAO"%>
<%@page import="edu.ncsu.csc.itrust.exception.ITrustException"%>
<%@page import="edu.ncsu.csc.itrust.exception.FormValidationException"%>

<%@include file="/global.jsp" %>

<%
	pageTitle = "iTrust - Prefer Childbirth Method";

%>

<%@include file="/header.jsp" %>
		
<%
			AddApptAction action = new AddApptAction(prodDAO, loggedInMID.longValue());
			
			long patientID = 0L;
			String hidden = ""; 
			
			boolean isDead = false;
			if (session.getAttribute("pid") != null) {
				String pidString = (String) session.getAttribute("pid");
				patientID = Long.parseLong(pidString);
				try {
			action.getName(patientID);
				} catch (ITrustException ite) {
			patientID = 0L;
				}
				
			}
			else {
				session.removeAttribute("pid");
			}
			
			
			if (patientID == 0L) {
				response.sendRedirect("/iTrust/auth/getPatientID.jsp?forward=hcp-uap/preferBirthMethod.jsp");
			} else if(isDead){
				%>
				<div align=center>
					<span class="iTrustError">Cannot schedule appointment. This patient is deceased. Please return and select a different patient.</span>
					<br />
					<a href="/iTrust/auth/getPatientID.jsp?forward=hcp/preferBirthMethod.jsp">Back</a>		</div>
				<%	
			}
			

%>

<div align="left" <%=hidden %> id="apptDiv">
	<h2>Prefered Childbirth Method UI to be implemented</h2>
	<h4><%= StringEscapeUtils.escapeHtml("" + ( action.getName(patientID) )) %> (<a href="/iTrust/auth/getPatientID.jsp?forward=hcp-uap/preferBirthMethod.jsp">Search for other patient</a>):</h4>
</div>

<%@include file="/footer.jsp" %>