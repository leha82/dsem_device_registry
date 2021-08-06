<%@page import="structures.mysql.*"%>
<%@page import="webmodules.mysql.*"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.Catch"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.util.*"%>
<%
	//actionRegistration.jsp
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
        window.location.replace("deviceList.jsp");
    </script>
</head>

<body>
</body>
</html>

<%
request.setCharacterEncoding("UTF-8");
	DBManager dbm = new DBManager(application.getRealPath("/"));
	
	dbm.connect();
//	int item_id = Integer.parseInt(request.getParameter("item_id"));
//	ItemCommon ic = dbm.getItemCommon(item_id);
	
	DeviceInfo di = new DeviceInfo();
	
	di.setItem_id(Integer.parseInt(request.getParameter("item_id")));
	di.setSystem_id(request.getParameter("system_id"));
//	di.setItem_name(ic.getModel_name());
	di.setDevice_name(request.getParameter("device_name"));
	di.setTable_name("table_name");
	di.setDeployment_time(request.getParameter("deployment_time"));
	di.setDeployment_location(request.getParameter("deployment_location"));
	di.setLatitude(request.getParameter("lat"));
	di.setLongitude(request.getParameter("lon"));
	
	dbm.insertDeviceInfo(di);
// 테이블 이름 잘라서 생성

	int device_id = dbm.getLastDeviceId();

	//table_name 생성 device / 0000 + device_id
	String tableno = "0000" + device_id;
	String table_name = "device" + tableno.substring(tableno.length() - 4);

	di.setDevice_id(device_id);
	di.setTable_name(table_name);
	
	dbm.updateDeviceTableName(device_id, table_name);
	
// 자동 생성 테이블
	dbm.createTable_DeviceMeasurement(di.getItem_id(), di.getTable_name());
	
	dbm.disconnect();
%>