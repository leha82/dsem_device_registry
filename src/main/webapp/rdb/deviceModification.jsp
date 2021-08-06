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
	dbm.disconnect();	
%>
    
<html>
<head>
	<!-- jQuery  -->
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js" type="text/javascript"></script>
	<link rel="stylesheet" type="text/css" href = "../css/main.css">
		
	<script type="text/javascript">   
       	function goBack(){
       		window.history.back();
       	}
	</script>
    
	<title>Device metadata modification page</title>
</head>
<body>
	<div class="MainContent">
		<div class="MenuBar" id="device_top">
			<h1>Item Detail </h1>
			<jsp:include page="partMenuButton.jsp" flush="false" />
		</div>
		
		<form name='myform' action="actionDeviceModification.jsp" method="POST">
		<div class="SubMenuBar">
			<button class="SubMenuButton" type="submit">confirm</button>
			<button class="SubMenuButton" type="button" onclick="goBack();">back</button>
		</div>
		<div class="DeviceInfo">
			<h2>[<%= device_id %>] <%=di.getDevice_name()%></h2>
			<table>
				<thead>
					<th style="width: 30%;">Metadata</th>
					<th style="width: 70%;">Value</th>
				</thead>
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
			</table>
		</div>
	</form>
	</div>
	</body>
</html>