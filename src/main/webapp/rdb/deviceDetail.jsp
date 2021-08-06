<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, webmodules.mysql.*, structures.mysql.*" %>
	<%@page import="java.io.*, java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
"http://www.w3.org/TR/html4/loose.dtd">
    
<%
	int device_id = Integer.parseInt(request.getParameter("id"));

	DBManager dbm = new DBManager(application.getRealPath("/"));
	dbm.connect();
	DeviceInfo di = dbm.getDeviceInfo(device_id);
	ItemSpecific is = dbm.getItemSpecific(di.getItem_id());
	dbm.disconnect();	
	
	request.setAttribute("itemspecific", is);
%>
    
<html>
<head>
	<!-- jQuery  -->
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js" type="text/javascript"></script>
	<link rel="stylesheet" type="text/css" href = "../css/main.css">
	
	<script type="text/javascript">   
		function goBack() {
			window.history.back();
		}
		function confirmDelete(num) {
			if (num==1) {
				if (confirm('Delete device <%= di.getDevice_name() %> with measurement table?')) {
					location.href='actionDeleteDevicewTable.jsp?id=<%= device_id %>';
				}
			} else if (num==2) {
				if (confirm('Delete only device <%= di.getDevice_name() %> record in device list?')) {
					location.href='actionDeleteDevice.jsp?id=<%= device_id %>';
				}
			} else {
				
			}
		}
    </script>
	<title>Device Detail</title>
</head>
<body>
	<div class="MainContent">
		<div class="MenuBar" id="device_top">
			<h1>Item Detail </h1>
			<jsp:include page="partMenuButton.jsp" flush="false" />
		</div>
		<div class="SubMenuBar">
			<button class="SubMenuButton" type="button" onclick="confirmDelete(1);">delete with table</button>
			<button class="SubMenuButton" type="button" onclick="confirmDelete(2);">delete only record</button>
			<button class="SubMenuButton" type="button" onclick="location.href='deviceModification.jsp?id=<%=device_id%>'">modify</button>
			<button class="SubMenuButton" type="button" onclick="goBack();">back</button>
			<h2 style="text-align:center;">[<%= device_id %>] <%=di.getDevice_name()%></h2>

		</div>
		<div class="DeviceInfo">
			<table>
				<thead>
					<th style="width: 30%;">Metadata</th>
					<th style="width: 70%;">Value</th>
				</thead>
				<tr>
					<th>Device id</th>
					<td><%=device_id%></td>
				</tr>
				<tr>
					<th>Device name</th>
					<td><%=di.getDevice_name()%></td>
				</tr>
				<tr>
					<th>System id</th>
					<td><%=di.getSystem_id()%></td>
				</tr>
				<tr>
					<th>Table name</th>
					<td><%=di.getTable_name()%></td>
				</tr>
				<tr>
					<th>Item id</th>
					<td><%=di.getItem_id() %></td>
				</tr>
				<tr>
					<th>Item model</th>
					<td><%=di.getItem_name()%></td>
				</tr>
				<tr>
					<th>Deployment time</th>
					<td><%=di.getDeployment_time()%></td>
				</tr>
				<tr>
					<th>Deployment location</th>
					<td><%=di.getDeployment_location()%></td>
				</tr>
				<tr>
					<th>Latitude</th>
					<td><%=di.getLatitude()%></td>
				</tr>
				<tr>
					<th>Longitude</th>
					<td><%=di.getLongitude()%></td>
				</tr>
			</table>
			<br><br>
			<h2 style = "text-align: left;">Specific Metadata</h2>
			<jsp:include page="partSpecificDetail.jsp" flush="false" />
		</div>
	</div>
</body>
</html>