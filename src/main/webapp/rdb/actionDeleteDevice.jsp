<%@page import="java.sql.*" pageEncoding="UTF-8" 
import="java.util.*, webmodules.mysql.*, structures.mysql.*" %>
<%@page import="java.io.*, java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<!-- only delete device in devices table. -->
<%
int device_id = Integer.parseInt(request.getParameter("id"));
	
	DBManager dbm = new DBManager(application.getRealPath("/"));
	dbm.connect();
	dbm.deleteDeviceInfo(device_id);
	dbm.disconnect();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript">
window.location.replace("deviceList.jsp");
</script>
<title>delete m_delete.jsp</title>
</head>
<body>

</body>
</html>