<%@page import="java.sql.*" pageEncoding="UTF-8" 
import="java.util.*, webmodules.mysql.*, structures.mysql.*" %>
<%@page import="java.io.*, java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!-- item detail 페이지에서  global, specific 삭제하는 페이지 -->
		
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
%>
		
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<script type="text/javascript">
	alert("Item (<%= item_id %>) was deleted.");
	window.location.replace("itemList.jsp?id=<%= item_id %>");
</script>

<title>delete m_delete.jsp</title>
</head>

</html>