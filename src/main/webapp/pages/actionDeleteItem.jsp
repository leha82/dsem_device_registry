<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.sql.*, java.util.*, webmodules.*, structures.*" %>
<%
	request.setCharacterEncoding("utf-8");
	
	int item_id = Integer.parseInt(request.getParameter("id"));
	
	DBManager dbm = new DBManager(application.getRealPath("/"));
	dbm.connect();
	
	ArrayList<DeviceInfo> dilist = dbm.getList_Device(item_id);
	
	dbm.deleteItemCommon(item_id);
	dbm.deleteItemSpecific(item_id);
	
	System.out.println("item_id : " + item_id + " is deleted.");
	
	dbm.disconnect();
	
	out.println("<script type='text/javascript'>");
	out.println("	location.href='itemList.jsp';");
	out.println("</script>");
%>
		