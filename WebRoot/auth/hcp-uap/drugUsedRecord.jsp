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
	pageTitle = "iTrust - Drug Used Record";

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
				response.sendRedirect("/iTrust/auth/getPatientID.jsp?forward=hcp-uap/drugUsedRecord.jsp");
			} else if(isDead){
				%>
				<div align=center>
					<span class="iTrustError">Cannot schedule appointment. This patient is deceased. Please return and select a different patient.</span>
					<br />
					<a href="/iTrust/auth/getPatientID.jsp?forward=hcp/drugUsedRecord.jsp">Back</a>		</div>
				<%	
			}
			

%>

<div align="left" <%=hidden %> id="apptDiv">

	<h4><%= StringEscapeUtils.escapeHtml("" + ( action.getName(patientID) )) %> (<a href="/iTrust/auth/getPatientID.jsp?forward=hcp-uap/drugUsedRecord.jsp">Search for other patient</a>):</h4>
	<p>Drug Used Record: </p>
</div>
<form>
	<div>
	<input type="radio" name="Pitocin" id="Pitocin" value="Pitocin">
	<label for="Pitocin">Pitocin</label>
	<input type="radio" name="Nitrous oxide" id="Nitrous oxide" value="Nitrous oxide">
	<label for="Nitrous oxide">Nitrous oxide</label>
	<input type="radio" name="Pethidine" id="Pethidine" value="Pethidine">
	<label for="Pethidine">Pethidine</label>
	<input type="radio" name="Epidural anaesthesia" id="Epidural anaesthesia" value="Epidural anaesthesia">
	<label for="Epidural anaesthesia">Epidural anaesthesia</label>
	<input type="radio" name="Magnesium sulfate" id="Magnesium sulfate" value="Magnesium sulfate">
	<label for="Magnesium sulfate">Magnesium sulfate</label>
	<input type="radio" name="RH immune globulin" id="RH immune globulin" value="RH immune globulin">
	<label for="RH immune globulin">RH immune globulin</label>
	</div>
	<div>
		<button type="submit">Submit</button>
	</div>
</form>

<%@include file="/footer.jsp" %>