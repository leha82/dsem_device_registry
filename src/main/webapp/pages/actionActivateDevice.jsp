<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.sql.*, java.util.*, core.*, structures.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	int device_id = Integer.parseInt(request.getParameter("device_id"));
	
	DBManager dbm = new DBManager(application.getRealPath("/"));
	
	dbm.connect();
	
	DeviceInfo di = dbm.getDeviceInfo(device_id);
	dbm.deleteTableDeviceMeasurement(di.getTable_name());
	dbm.createTable_DeviceMeasurement(di.getItem_id(), di.getTable_name());
	dbm.updateDeviceEnabled(device_id, true);
	
	dbm.disconnect();
	out.println("<script type='text/javascript'>");
	out.println("	location.href='deviceDetail.jsp?device_id=" + device_id + "';");
	out.println("</script>");
%>
