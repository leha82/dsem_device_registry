<%@page import="java.sql.*" pageEncoding="UTF-8" import="java.util.*, webmodules.mysql.*, structures.mysql.*" %>
<%@page import="java.io.*, java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%
	int device_id = Integer.parseInt(request.getParameter("id"));
	
	DBManager dbm = new DBManager(application.getRealPath("/"));
	dbm.connect();
	
	DeviceInfo di = dbm.getDeviceInfo(device_id);

	dbm.deleteTableDeviceMeasurement(di.getTable_name());
	dbm.deleteDeviceInfo(device_id);
	dbm.disconnect();

%>
<!DOCTYPE html>
<html>
<head>
	<script type="text/javascript">
		window.location.replace("deviceList.jsp");
	</script>
</head>
</html>