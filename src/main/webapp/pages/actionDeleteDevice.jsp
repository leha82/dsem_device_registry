<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.sql.*, java.util.*, webmodules.*, structures.*" %>
<%
	int device_id = Integer.parseInt(request.getParameter("id"));
	int type = Integer.parseInt(request.getParameter("type"));

	DBManager dbm = new DBManager(application.getRealPath("/"));
	
	dbm.connect();
	if (type==1) {
		DeviceInfo di = dbm.getDeviceInfo(device_id);
		dbm.deleteTableDeviceMeasurement(di.getTable_name());
	}
	
	dbm.deleteDeviceInfo(device_id);
	dbm.disconnect();

	out.println("<script type='text/javascript'>");
	out.println("	location.href='deviceList.jsp';");
	out.println("</script>");
%>
