<%@page import="structures.mysql.*"%>
<%@page import="webmodules.mysql.*"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.Catch"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.* , java.util.*"%>
<%//actionRegistration.jsp %>

<%
	request.setCharacterEncoding("UTF-8");
	DBManager dbm = new DBManager();
	dbm.connect();
	DeviceCommon dc = new DeviceCommon();

	Timestamp now_timestamp = new Timestamp(System.currentTimeMillis());
	dc.setmodel_name(request.getParameter("model1"));
	dc.setregistration_time(now_timestamp);
	dc.setDevice_type(request.getParameter("dv1"));
	dc.setManufacturer(request.getParameter("manufac1"));
	dc.setCategory(request.getParameter("cate1"));
	
	dbm.insertGlobalList(dc);
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
        window.location.replace("deviceItemList.jsp");
    </script>
</head>
</html>