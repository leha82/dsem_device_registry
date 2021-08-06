<%@page import="java.util.*, webmodules.mysql.*, structures.mysql.*"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>

<%
	DBManager dbm = new DBManager(application.getRealPath("/"));
	dbm.connect();

	ArrayList<DeviceInfo> diList = dbm.getList_Device();
	
//	for (int i=0; i<diList.size(); i++) {
//		DeviceInfo di = diList.get(i);
//		ItemCommon ic = dbm.getItemCommon(di.getItem_id());
//		di.setItem_name(ic.getModel_name());
//	}
	
	dbm.disconnect();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" sype="text/css" href = "../css/main.css">
	
	<script location.href="./test?params=" + encodeURI(params); 
			src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js"
			type="text/javascript"></script>
	
	<script type="text/javascript">
		function goBack() {
			window.history.back();
		}
	</script>
	<title>Device List</title>
</head>

<body>
	<div class="MainContent">
		<div class="MenuBar" id="device_top">
			<h1>Device List</h1>
			<jsp:include page="menu.jsp" flush="false" />
		</div>
		<div class="SubMenuBar">
			<button class="SubMenuButton" type="button" onclick="location.href='deviceRegistration.jsp'">Register</button>
		</div>
		<table>
			<thead>
				<th>Device id</th>
				<th>Device name</th>
				<th>System id</th>
				<th>Item id</th>
				<th>Item Model</th>
				<th>Table name</th>
				<th>Deployment time</th>
				<th>Deployment location</th>
				<th>Latitude</th>
				<th>Longitude</th>
				<th>Modify</th>
				<th>Delete list</th>
				<th>Delete list with Measurement table</th>
			</thead>
			<tbody>
<%
	for(int i=0; i<diList.size(); i++) {
		DeviceInfo di = diList.get(i);
%>
				<tr>
					<td><%=di.getDevice_id()%></td>
					<td><%=di.getDevice_name()%></td>
					<td><%=di.getSystem_id()%></td>
					<td><a href="itemDetail.jsp?id=<%=di.getItem_id()%>"><%=di.getItem_id()%></a></td>
					<td><a href="itemDetail.jsp?id=<%=di.getItem_id()%>"><%=di.getItem_name()%></a></td>
					<td><%=di.getTable_name()%></td>
					<td><%=di.getDeployment_time()%></td>
					<td><%=di.getDeployment_location()%></td>
					<td><%=di.getLatitude()%></td>
					<td><%=di.getLongitude()%></td>
					<td>
						<button type="button" onclick="location.href='deviceModification.jsp?id=<%=di.getDevice_id()%>'" target="_blank" width="600px">modify</button>
					</td>
					<td>
						<button type="button" onclick="location.href='actionDeleteDevice.jsp?id=<%=di.getDevice_id()%>&item_id=<%=di.getItem_id()%>'" target="_blank" width="600px">delete</button>
					</td>
					<td>
						<button type="button" onclick="location.href='actionDeleteDevicewTable.jsp?id=<%=di.getDevice_id()%>&item_id=<%=di.getItem_id()%>'" target="_blank" width="600px">delete</button>
					</td>
				</tr>
<%
	}
%>
			</tbody>
		</table>
		</div>
</body>
</html>
