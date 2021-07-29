<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@page import="java.io.*, java.util.*, structures.mysql.*, webmodules.mysql.*"%>
<%//actionModification.jsp %>

<!-- Device metadata 수정 -->
<%
	request.setCharacterEncoding("UTF-8");
	int device_id = Integer.parseInt(request.getParameter("device_id"));
	int item_id = Integer.parseInt(request.getParameter("item_id"));
	
	DBManager dbm = new DBManager();
	dbm.connect();
	DeviceInfo di = new DeviceInfo();
	di.setitem_id(Integer.parseInt(request.getParameter("item_id")));
	di.setsystem_id((String)request.getParameter("system_id"));
	di.setdevice_name((String)request.getParameter("device_name"));
	di.setdeployment_time((String)request.getParameter("deployment_time"));
	di.setdeployment_location((String)request.getParameter("deployment_location"));
	di.setlatitude((String)request.getParameter("latitude"));
	di.setlongitude((String)request.getParameter("longitude"));
	di.setdevice_id(Integer.parseInt(request.getParameter("device_id")));
	dbm.updateDeviceList(di);
	dbm.disconnect();
	System.out.println(item_id);
	%>

<!-- 자동 테이블 생성 -->
<%
//	DBManager dbm2 = new DBManager();
//dbm2.connect();
//DeviceInfo dl = dbm2.getDeviceInfo(item_id);
//dbm2.disconnect();

//AutoDBConnector adb = new AutoDBConnector();
//adb.deleteTable(dl.gettable_name());	
//adb.createTable(item_id, dl.gettable_name());
%>

<html>
<head>
<script type="text/javascript">   
		function goBack(){
			window.history.back();
		}
		window.location.replace("deviceList.jsp");
	</script>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Device metadata modification page</title>
</head>
<body>
Device metadata modification page
</body>
</html>

