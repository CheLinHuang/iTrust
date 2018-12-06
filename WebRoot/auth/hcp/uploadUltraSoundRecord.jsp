<%@page import="java.text.ParseException"%>
<%@page errorPage="/auth/exceptionHandler.jsp"%>
<%@page import="java.lang.*"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="edu.ncsu.csc.itrust.exception.ITrustException"%>
<%@page import="edu.ncsu.csc.itrust.exception.FormValidationException"%>
<%@ page import = "java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import = "javax.servlet.http.*" %>
<%@ page import = "org.apache.commons.fileupload.*" %>
<%@ page import = "org.apache.commons.fileupload.disk.*" %>
<%@ page import = "org.apache.commons.fileupload.servlet.*" %>
<%@ page import = "org.apache.commons.io.output.*" %>

<%@include file="/global.jsp" %>

<%
    pageTitle = "iTrust - Upload an Ultrasound File";

    String headerMessage = "You can upload the image of UltraSound here. Accepted format: .jpg .png .pdf";

%>

<%@include file="/header.jsp" %>

<form id="mainForm" action="uploadUltraSoundRecord.jsp" method="post" enctype="multipart/form-data">
<%

    String filePath ="";

    File file;
    int maxFileSize = 5000 * 1024;
    int maxMemSize = 5000 * 1024;
    String ovid = "";
    //ServletContext context = pageContext.getServletContext();
    //String filePath = context.getInitParameter("file-upload");

    ovid = request.getParameter("ovID");
    File currentDirectory = new File(new File(".").getAbsolutePath());

    filePath = currentDirectory.getAbsolutePath() + "./webapps/data/";

    System.out.println("filePath is:" + filePath);

    // Verify the content type
    String contentType = request.getContentType();

    if (contentType != null && contentType.indexOf("multipart/form-data") >= 0) {
        out.println("coming into contentType!!!");
        DiskFileItemFactory factory = new DiskFileItemFactory();
        // Create a new file upload handler
        factory.setSizeThreshold(maxMemSize);
        // Location to save data that is larger than maxMemSize.
        factory.setRepository(new File(filePath));

        ServletFileUpload upload = new ServletFileUpload(factory);

        // maximum file size to be uploaded.
        upload.setSizeMax( maxFileSize );

        try {
            // Parse the request to get file items.
            List fileItems = upload.parseRequest(request);

            // Process the uploaded file items
            Iterator i = fileItems.iterator();
            headerMessage = "";
            while ( i.hasNext () ) {
                FileItem fi = (FileItem)i.next();
                if ( !fi.isFormField () ) {
                    // Get the uploaded file parameters
                    String fieldName = fi.getFieldName();
                    String fileName = fi.getName();
                    boolean isInMemory = fi.isInMemory();
                    long sizeInBytes = fi.getSize();

                    // Write the file
                    if( fileName.lastIndexOf("\\") >= 0 ) {
                        file = new File( filePath +
                                fileName.substring( fileName.lastIndexOf("\\"))) ;
                    } else {
                        file = new File( filePath +
                                fileName.substring(fileName.lastIndexOf("\\")+1)) ;
                    }
                    fi.write(file);
                    headerMessage += "Uploaded File: " + fileName + " Successfully!";
                    filePath = filePath + fileName;
                }
            }

        } catch(Exception ex) {
            System.out.println(ex);
        }
    }
%>

    <div align="left" id="ultraSoundRecordDiv">
        <h2>Upload an Ultra Sound</h2>
        <span class="iTrustMessage"><%= StringEscapeUtils.escapeHtml("" + (headerMessage )) %></span><br /><br />
        <input type="file" name="ultrasoundImage" size="50" />
        <br />
        <input name="upload" type="button" class="button1" onClick="self.location='uploadUltraSoundRecord.jsp?ovID=<%=ovid%>'" value="Upload" />
        <input type="hidden" value="upload" name="uploadFile" />
        <input type="hidden" value="<%=ovid%>" name="officevisitID" />
        <br />
        <br />
        <br />
        <span class="iTrustMessage"><a href="documentUltraSound.jsp?ovid=<%=ovid%>&filepath=<%=filePath%>">Return</a></span>
        <br />
    </div>
</form>

<%@include file="/footer.jsp" %>