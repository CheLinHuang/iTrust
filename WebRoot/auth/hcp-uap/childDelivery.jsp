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

<%@page import="edu.ncsu.csc.itrust.action.AddPatientAction"%>
<%@page import="edu.ncsu.csc.itrust.BeanBuilder"%>
<%@page import="edu.ncsu.csc.itrust.model.old.beans.PatientBean"%>
<%@page import="edu.ncsu.csc.itrust.exception.FormValidationException"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Map.Entry"%>

<%@include file="/global.jsp" %>

<%
	pageTitle = "iTrust - Schedule an Appointment";

String headerMessage = "Please fill out the form properly - comments are optional.";
%>

<%@include file="/header.jsp" %>
<form id="mainForm" method="post" action="childDelivery.jsp">
		<input type="hidden" name="formIsFilled" value="true"> <br />
<%-- <%
			AddApptAction action = new AddApptAction(prodDAO, loggedInMID.longValue());
			PatientDAO patientDAO = prodDAO.getPatientDAO(); 
			
			long patientID = 0L;
			
			boolean isDead = false;
			if (session.getAttribute("pid") != null) {
				String pidString = (String) session.getAttribute("pid");
				patientID = Long.parseLong(pidString);
				try {
			action.getName(patientID);
				} catch (ITrustException ite) {
			patientID = 0L;
				}
				
				isDead = patientDAO.getPatient(patientID).getDateOfDeathStr().length()>0;
			}
			else {
				session.removeAttribute("pid");
			}
			
			String lastSchedDate="";
			String lastTime1="";
			String lastTime2="";
			String lastTime3="";
			String lastComment="";
			String last_gender="";
			String last_delivery_method="";
			
			if (patientID == 0L) {
				response.sendRedirect("/iTrust/auth/getPatientID.jsp?forward=hcp-uap/childDelivery.jsp");
			} else if(isDead){
		%>
		<div align=center>
			<span class="iTrustError">Cannot schedule appointment. This patient is deceased. Please return and select a different patient.</span>
			<br />
			<a href="/iTrust/auth/getPatientID.jsp?forward=hcp-uap/childDelivery.jsp">Back</a>		</div>
		<%	
	}
%> --%>

<%
	//This page is not actually a "page", it just adds a user and forwards.
	AddApptAction action = new AddApptAction(prodDAO, loggedInMID.longValue());
	//PatientDAO patientDAO = prodDAO.getPatientDAO(); 
	long patientID = 0L;
	
	boolean isDead = false;
	if (session.getAttribute("pid") != null) {
		String pidString = (String) session.getAttribute("pid");
		patientID = Long.parseLong(pidString);
		try {
	action.getName(patientID);
		} catch (ITrustException ite) {
	patientID = 0L;
		}
		
		//isDead = patientDAO.getPatient(patientID).getDateOfDeathStr().length()>0;
	}
	else {
		session.removeAttribute("pid");
	}

	
	String lastSchedDate="";
	String lastTime1="";
	String lastTime2="";
	String lastTime3="";
	String lastComment="";
	String last_gender="";
	String last_delivery_method="";

	boolean formIsFilled = request.getParameter("formIsFilled") != null && request.getParameter("formIsFilled").equals("true");
	if (formIsFilled) {
		//This page is not actually a "page", it just adds a user and forwards.
		PatientBean p = new BeanBuilder<PatientBean>().build(request.getParameterMap(), new PatientBean());
		 Map<String, String[]> map = request.getParameterMap();
	     Set set = map.entrySet();
	     Iterator it = set.iterator();
	     
	     while (it.hasNext()) {
	    	 Map.Entry<String, String[]> entry = (Entry<String, String[]>) it.next();
	             String paramName = entry.getKey();
	             System.out.print(paramName);
	             String[] paramValues = entry.getValue();
	             for (int i = 0; i < paramValues.length; i++) {
	                    System.out.println("   "+paramValues[i]);
	             }
	     }
	     
	     
		try{
			boolean isDependent = false;
			long representativeId = -1L;
			/*if(request.getParameter("isDependent") != null && request.getParameter("isDependent").equals("on")){
				isDependent = true;
			}
			
			if(request.getParameter("repId") != "" && isDependent){
				representativeId = Long.valueOf(request.getParameter("repId"));
			}else if(isDependent && request.getParameter("repId") == ""){
				throw new FormValidationException("Representative MID must be filled if the patient is marked as a dependent.");
			} */
			long newMID = 1L; 
			/* if(isDependent){
				newMID = new AddPatientAction(prodDAO, loggedInMID.longValue()).addDependentPatient(p, representativeId, loggedInMID.longValue());
			}else{
				newMID = new AddPatientAction(prodDAO, loggedInMID.longValue()).addPatient(p, loggedInMID.longValue());
			} */
			newMID = new AddPatientAction(prodDAO, loggedInMID.longValue()).addPatient(p, loggedInMID.longValue());
			session.setAttribute("pid", Long.toString(newMID));
			String fullname;
			String password;
			password = p.getPassword();
			fullname = p.getFullName();
	%>
		<div align=center>
			<span class="iTrustMessage">New patient <%= StringEscapeUtils.escapeHtml("" + (fullname)) %> successfully added!</span>
			<br />
			<table class="fTable">
				<tr>
					<th colspan=2>New Patient Information</th>
				</tr>
				<tr>
					<td class="subHeaderVertical">MID:</td>
					<td><%= StringEscapeUtils.escapeHtml("" + (newMID)) %></td>
				</tr>
				<tr>
					<td class="subHeaderVertical">Temporary Password:</td>
					<td><%= StringEscapeUtils.escapeHtml("" + (password)) %></td>
				</tr>
			</table>
			<br />Please get this information to <b><%= StringEscapeUtils.escapeHtml("" + (fullname)) %></b>! 
			<p>
				<a href = "/iTrust/auth/hcp-uap/childDelivery.jsp">Continue to patient information.</a>
			</p>
		</div>
	<%
		} catch(FormValidationException e){
	%>
		<div align=center>
			<span class="iTrustError"><%=StringEscapeUtils.escapeHtml(e.getMessage()) %></span>
		</div>
	<%
		}
	}
%>

<div align="left"  id="apptDiv">
	<h2>Child Birth Date and Time</h2>
	<h4>with <%= StringEscapeUtils.escapeHtml("" + ( action.getName(patientID) )) %> (<a href="/iTrust/auth/getPatientID.jsp?forward=hcp-uap/childDelivery.jsp">someone else</a>):</h4>
		
		<span>First Name:</span>
		<input name="firstName" type="text"><br/><br/>
		
		<span>Last Name:</span>
		<input name="lastName" type="text"><br/><br/>
		
		<Span>Gender:</Span>
		<select name="genderStr"><option value="Male">Male</option>
		<option value="Female">Female</option>
		</select><br /><br />
		
		
		<span>Birth Date: </span><input type=text name="dateOfBirthStr" maxlength="10"
					size="10"> <input
					type=button value="Select Date"
					onclick="displayDatePicker('dateOfBirthStr');">
		<br/><br/>
		<span>Birth Time: </span>
		<select name="time1">
			<%
				String hour = "";
				for(int i = 1; i <= 12; i++) {
					if(i < 10) hour = "0"+i;
					else hour = i+"";
					%>
						<option value="<%=hour%>"><%= StringEscapeUtils.escapeHtml("" + (hour)) %></option>
					<%
				}
			%>
		</select>:<select name="time2">
			<%
				String min = "";
				for(int i = 0; i < 60; i+=5) {
					if(i < 10) min = "0"+i;
					else min = i+"";
					%>
						<option value="<%=min%>"><%= StringEscapeUtils.escapeHtml("" + (min)) %></option>
					<%
				}
			%>
		</select>
		<select name="time3"><option  value="AM">AM</option
		><option   value="PM">PM</option></select><br /><br />
		
		<span>Delivery Method</span>
		<select name="delivery_method">
		<option   value="vaginal delivery">vaginal delivery</option>
		<option  value="vaginal delivery vacuum assist">vaginal delivery vacuum assist</option>
		<option   value="vaginal delivery forceps assist">vaginal delivery forceps assist</option>
		<option  value="caesarean section">caesarean section</option>
		<option  value="miscarriage">miscarriage</option>
		
		</select><br /><br />
		
		<input type="submit" value="Confirm" name="scheduleButton"/>
		<!-- <input type="submit" style="font-size: 16pt; font-weight: bold;" value="Add patient"> -->
		<input type="hidden" value="Schedule" name="schedule"/>
		<input type="hidden" id="override" name="override" value="noignore"/>

	<br />
	<br />
</div>
	</form>

<%@include file="/footer.jsp" %>