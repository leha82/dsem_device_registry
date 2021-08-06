<%@page import="structures.mysql.*"%>
<%@page import="webmodules.mysql.*"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.Catch"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.* , java.util.*"%>
<%//actionRegistration.jsp %>

<%
request.setCharacterEncoding("UTF-8");
	DBManager dbm = new DBManager(application.getRealPath("/"));
	dbm.connect();
	ItemCommon ic = new ItemCommon();
	//Timestamp now_timestamp = new Timestamp(System.currentTimeMillis());
	
	ic.setModel_name(request.getParameter("model_name"));
//	ic.setRegistration_time(now_timestamp);
	ic.setDevice_type(request.getParameter("device_type"));
	ic.setManufacturer(request.getParameter("manufacturer"));
	ic.setCategory(request.getParameter("category"));
	
	dbm.insertItemCommon(ic);
	dbm.disconnect();
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js"
	type="text/javascript"></script>
     <script type="text/javascript">   
        function goBack(){
        window.history.back();
        	}
        window.location.replace("itemList.jsp");
    </script>
</head>
</html>