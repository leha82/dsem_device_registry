<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.sql.*, java.util.*,core.*, structures.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	DBManager dbm = new DBManager(application.getRealPath("/"));
	
	dbm.connect();
	ItemCommon ic = new ItemCommon();

	//Timestamp now_timestamp = new Timestamp(System.currentTimeMillis());
	
	ic.setModel_name(request.getParameter("model_name"));
	ic.setRegistration_time(CoreModules.getCurrentTime());
	ic.setDevice_type(request.getParameter("device_type"));
	ic.setManufacturer(request.getParameter("manufacturer"));
	ic.setCategory(request.getParameter("category"));
	
	dbm.insertItemCommon(ic);
	dbm.disconnect();
	
	out.println("<script type='text/javascript'>");
	out.println("	alert('Item (" + ic.getModel_name() + ") is registered');");
	out.println("	location.href='itemList.jsp';");
	out.println("</script>");
%>
