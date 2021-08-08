<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.util.*, webmodules.mysql.*, structures.mysql.*" %>
<%
	int device_id = Integer.parseInt(request.getParameter("id"));

	DBManager dbm = new DBManager(application.getRealPath("/"));
	dbm.connect();
	DeviceInfo di = dbm.getDeviceInfo(device_id);
	ItemSpecific is = dbm.getItemSpecific(di.getItem_id());
	dbm.disconnect();	
	
	request.setAttribute("itemspecific", is);
%>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" type="text/css" href = "../css/main.css">
	<script type="text/javascript">   
		function goBack() {
			window.history.back();
		}
		
		function confirmDelete(num) {
			if (num==1) {
				if (confirm('Delete device <%= di.getDevice_name() %> with measurement table?')) {
					location.href='actionDeleteDevice.jsp?id=<%= device_id %>&type=1';
				}
			} else if (num==2) {
				if (confirm('Delete only device <%= di.getDevice_name() %> record in device list?')) {
					location.href='actionDeleteDevice.jsp?id=<%= device_id %>&type=2';
				}
			} else {
				
			}
		}
    </script>
	<title>Device Detail</title>
</head>
<body>
	<header>
		<jsp:include page="partDeviceHeader.jsp" flush="false" />
	</header>
	<main>
		<div class="SubTitleBar">
			<h1>Device Detail</h1>
		</div>
		<h2>[<%= device_id %>] <%=di.getDevice_name()%></h2>
		<div class="NarrowTable">
			<div class="SubMenuBar">
				<button class="SubMenuButton" type="button" onclick="location.href='deviceModification.jsp?id=<%=device_id%>'">modify</button>
				<button class="SubMenuButton" type="button" onclick="goBack();">back</button>
			</div>
			Device Information
			<table>
				<thead>
					<tr>
						<th style="width: 30%;">Attribute</th>
						<th style="width: 70%;">Value</th>
					</tr>
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
					<td><%= di.getLatitudeString()%></td>
				</tr>
				<tr>
					<th>Longitude</th>
					<td><%= di.getLongitudeString()%></td>
				</tr>
			</table>
			<br><br>
			<jsp:include page="partSpecificDetail.jsp" flush="false" />
			<div class="SubMenuBar">
				<button class="SubMenuButton" type="button" onclick="confirmDelete(1);">delete device with table</button>
				<button class="SubMenuButton" type="button" onclick="confirmDelete(2);">delete device only record</button>
			</div>
			<br><br>
		</div>
	</main>
</body>
</html>