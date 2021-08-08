<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.util.*, webmodules.mysql.*, structures.mysql.*" %>
<%
	int device_id = Integer.parseInt(request.getParameter("id"));

	DBManager dbm = new DBManager(application.getRealPath("/"));
	dbm.connect();
	DeviceInfo di = dbm.getDeviceInfo(device_id);
	dbm.disconnect();	
%>

<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" type="text/css" href = "../css/main.css">
		
	<script type="text/javascript">   
       	function goBack(){
       		window.history.back();
       	}
	</script>
    
	<title>Device metadata modification page</title>
</head>
<body>
	<header>
		<jsp:include page="partDeviceHeader.jsp" flush="false" />
	</header>
	<main>
		<div class="SubTitleBar">
			<h1>Device Modification</h1>
		</div>
		<h2>[<%= device_id %>] <%=di.getDevice_name()%></h2>
		<form name='formdevmodi' action="actionDeviceModification.jsp" method="POST">
		<div class="NarrowTable">
			<div class="SubMenuBar">
				<button class="SubMenuButton" type="submit">confirm</button>
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
				<tbody>
					<tr>
						<th>Device id</th>
						<td><input type="text" class="inputText" name="device_id" 
								value="<%=device_id%>" readonly />
					</tr>
					<tr>
						<th>Device name</th>
						<td><input type="text" class="inputText" name="device_name" 
								value="<%=di.getDevice_name()%>"></td>
					</tr>
					<tr>
						<th>System id</th>
						<td><input type="text" class="inputText" name="system_id" 
								value="<%=di.getSystem_id()%>"></td>
					</tr>
					<tr>
						<th>Table name</th>
						<td><input type="text" class="inputText" name="table_name" 
								value="<%=di.getTable_name()%>" readonly />
					</tr>
					<tr>
						<th>Item id</th>
						<td><input type="text" class="inputText" name="item_id" 
								value="<%=di.getItem_id()%>"></td>
					</tr>
					<tr>
						<th>Item model</th>
						<td><input type="text" class="inputText" name="item_name" 
								value="<%=di.getItem_name()%>" readonly />
					</tr>
					<tr>
						<th>Deployment time</th>
						<td><input type="text" class="inputText" name="deployment_time" 
								value="<%=di.getDeployment_time()%>"></td>
					</tr>
					<tr>
						<th>Deployment location</th>
						<td><input type="text" class="inputText" name="deployment_location" 
								value="<%=di.getDeployment_location()%>">
						</td>
					</tr>
					<tr>
						<th>Latitude</th>
						<td><input type="text" class="inputText" name="latitude" 
								value="<%=di.getLatitude()%>"></td>
					</tr>
					<tr>
						<th>Longitude</th>
						<td><input type="text" class="inputText" name="longitude" 
								value="<%=di.getLongitude()%>"></td>
					</tr>
				</tbody>
			</table>
		</div>
		</form>
	</main>
	</body>
</html>