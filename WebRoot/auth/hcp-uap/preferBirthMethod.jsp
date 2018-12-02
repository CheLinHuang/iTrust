<%@page import="java.text.ParseException"%>
<%@page errorPage="/auth/exceptionHandler.jsp"%>

<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="edu.ncsu.csc.itrust.model.old.beans.ApptBean"%>
<%@page import="edu.ncsu.csc.itrust.model.old.beans.ApptTypeBean"%>
<%@page import="edu.ncsu.csc.itrust.model.old.beans.PatientBean"%>

<%@page import="edu.ncsu.csc.itrust.action.AddApptAction"%>
<%@page import="edu.ncsu.csc.itrust.action.EditApptTypeAction"%>
<%@page import="edu.ncsu.csc.itrust.action.ViewMyApptsAction"%>
<%@page import="edu.ncsu.csc.itrust.action.EditPatientAction"%>

<%@page import="edu.ncsu.csc.itrust.model.old.dao.mysql.PatientDAO"%>
<%@page import="edu.ncsu.csc.itrust.model.old.dao.mysql.ApptTypeDAO"%>
<%@page import="edu.ncsu.csc.itrust.exception.ITrustException"%>
<%@page import="edu.ncsu.csc.itrust.exception.FormValidationException"%>

<%@page import="edu.ncsu.csc.itrust.model.old.dao.DAOFactory"%>


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
	<h4><%= StringEscapeUtils.escapeHtml("" + ( action.getName(patientID) )) %> (<a href="/iTrust/auth/getPatientID.jsp?forward=hcp-uap/preferBirthMethod.jsp">Search for other patient</a>):</h4>


	<%
		String perfm=(String)request.getParameter("Perfermethod");
		System.out.println(perfm);
		if (perfm != null){
			System.out.println("add method to "+ patientID);
			try {
				long newMID = 1L;
				String pidString = (String) session.getAttribute("pid");
				PatientDAO PatientDAO = prodDAO.getPatientDAO();
			    PatientBean p = PatientDAO.getPatient(patientID);
				p.setperferMethod(perfm);
				EditPatientAction edit = new EditPatientAction(prodDAO, loggedInMID.longValue(), pidString);
				edit.updateInformation(p);

			    //action.updateInformation(p);
				//loggingAction.logEvent(TransactionType.DEMOGRAPHICS_EDIT, loggedInMID.longValue(), p.getMID(), "");


	%>
	<br />
	<div align=center>
		<span class="iTrustMessage">Information Successfully Updated</span>
	</div>
	<br />
	<%
		} catch (FormValidationException e) {
		}
		}
	%>

	<p>Current prefered childbirth method: <%=perfm%></p>
	<p>Please select prefered Childbirth Method:</p>
	<form>
	<div>
		<input type="radio" id="Perfermethod" name="Perfermethod" value="vaginal_delivery">
		<label for="vaginal_delivery">vaginal delivery</label>
	</div>

	<div>
		<input type="radio" id="Perfermethod" name="Perfermethod" value="vaginal_delivery_vacuum_assist">
		<label for="vaginal_delivery_vacuum_assist">vaginal delivery vacuum assist</label>
	</div>

	<div>
		<input type="radio" id="Perfermethod" name="Perfermethod" value="vaginal_delivery_forceps_assist">
		<label for="vaginal_delivery_forceps_assist">vaginal delivery forceps assist</label>
	</div>
    <div>
        <input type="radio" id="Perfermethod" name="Perfermethod" value="caesarean_section">
        <label for="caesarean_section">caesarean section</label>
    </div>
    <div>
        <input type="radio" id="Perfermethod" name="Perfermethod" value="miscarriage">
        <label for="miscarriage">miscarriage</label>
    </div>
    <div>
        <button type="submit">Submit</button>
    </div>
    </form>

</div>

<%@include file="/footer.jsp" %>
