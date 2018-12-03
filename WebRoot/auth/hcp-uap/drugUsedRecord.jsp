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
<%@page import="edu.ncsu.csc.itrust.model.old.dao.DAOFactory"%>
<%@page import="edu.ncsu.csc.itrust.model.old.beans.PatientBean"%>
<%@page import="edu.ncsu.csc.itrust.action.EditPatientAction"%>

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

	<p>Current prefered childbirth method: <%%></p>
	<p>Please select used drug Record: </p>
</div>

<% String Pitocin =(String)request.getParameter("Pitocin");
	System.out.println(Pitocin);
	String Nitrous_oxide =(String)request.getParameter("Nitrous oxide");
	System.out.println(Nitrous_oxide);
	String Pethidine =(String)request.getParameter("Pethidine");
	System.out.println(Pethidine);
	String Epidural_anaesthesia =(String)request.getParameter("Epidural anaesthesia");
	System.out.println(Epidural_anaesthesia);
	String Magnesium_sulfate =(String)request.getParameter("Magnesium sulfate");
	System.out.println(Magnesium_sulfate);
	String RH =(String)request.getParameter("RH immune globulin");
	System.out.println(RH);


	String pidString = (String) session.getAttribute("pid");
	PatientDAO PatientDAO = prodDAO.getPatientDAO();
	PatientBean p = PatientDAO.getPatient(patientID);
	Boolean drug1 = p.getdrug1();
	System.out.println("first drug drom database" +drug1);

	if(Pitocin != null){
		try {
			p.setdrug1(true);
			EditPatientAction edit = new EditPatientAction(prodDAO, loggedInMID.longValue(), pidString);
			edit.updateInformation(p);
		} catch (FormValidationException e) { }

	}
%>
<form>
	<div>
	<input type="checkbox" name="Pitocin" id="Pitocin" value="Pitocin">
	<label for="Pitocin">Pitocin</label>
		<br />
	<input type="checkbox" name="Nitrous oxide" id="Nitrous oxide" value="Nitrous oxide">
	<label for="Nitrous oxide">Nitrous oxide</label>
		<br />
	<input type="checkbox" name="Pethidine" id="Pethidine" value="Pethidine">
	<label for="Pethidine">Pethidine</label>
		<br />
	<input type="checkbox" name="Epidural anaesthesia" id="Epidural anaesthesia" value="Epidural anaesthesia">
	<label for="Epidural anaesthesia">Epidural anaesthesia</label>
		<br />
	<input type="checkbox" name="Magnesium sulfate" id="Magnesium sulfate" value="Magnesium sulfate">
	<label for="Magnesium sulfate">Magnesium sulfate</label>
		<br />
	<input type="checkbox" name="RH immune globulin" id="RH immune globulin" value="RH immune globulin" <%="checked"%>>
	<label for="RH immune globulin">RH immune globulin</label>
		<br />
	</div>
	<div>
		<button type="submit">Submit</button>
	</div>
</form>

<%@include file="/footer.jsp" %>