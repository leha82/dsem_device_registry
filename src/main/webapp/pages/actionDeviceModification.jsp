<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.sql.*, java.util.*, webmodules.*, structures.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	int device_id = Integer.parseInt(request.getParameter("device_id"));
	int item_id = Integer.parseInt(request.getParameter("item_id"));
	
	DBManager dbm = new DBManager(application.getRealPath("/"));
	
	dbm.connect();
	DeviceInfo di = new DeviceInfo();
	di.setDevice_id(device_id);
	di.setDevice_name((String)request.getParameter("device_name"));
	di.setSystem_id((String)request.getParameter("system_id"));
	di.setItem_id(item_id);
	di.setDeployment_time((String)request.getParameter("deployment_time"));
	di.setDeployment_location((String)request.getParameter("deployment_location"));
	di.setLatitude((String)request.getParameter("latitude"));
	di.setLongitude((String)request.getParameter("longitude"));
	
	dbm.updateDeviceInfo(di);
	dbm.disconnect();
	out.println("<script type='text/javascript'>");
	out.println("	location.href='deviceDetail.jsp?id=" + device_id + "';");
	out.println("</script>");
%>
