<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.sql.*, java.util.*, webmodules.mysql.*, structures.mysql.*" %>
<%
	int item_id = Integer.parseInt(request.getParameter("id"));
	//System.out.println(send_id + " <-- delete this id ");
	request.setCharacterEncoding("utf-8");
	
	DBManager dbm = new DBManager(application.getRealPath("/"));
	dbm.connect();
	
	dbm.deleteItemCommon(item_id);
	dbm.deleteItemSpecific(item_id);
	
	dbm.disconnect();
	System.out.println("item_id : " + item_id + " is deleted.");
	
	out.println("<script type='text/javascript'>");
	out.println("	location.href='itemList.jsp?id=" + item_id + "';");
	out.println("</script>");
%>
		