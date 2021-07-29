<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, webmodules.mysql.*, structures.mysql.*" %>
	<%@page import="java.io.*, java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
"http://www.w3.org/TR/html4/loose.dtd">

<%
	int device_id = Integer.parseInt(request.getParameter("id"));

	DBManager dbm = new DBManager();
	//SpecificDBManager dbm2 = new SpecificDBManager();
	
	dbm.connect();

	DeviceInfo di = dbm.getDeviceInfo(device_id);
	
	//DeviceSpecific ds = dbm.getDeviceSpecific(device_id);
	
	dbm.disconnect();
%>
    
<html>
	<head>
    
		<!-- jQuery  -->
		<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js"
				type="text/javascript"></script>
    	
		<style>
			h1 {
				border-collapse: collapse;
			}
			table {
				width: 600px;
				border: 1px solid #444444;
				border-collapse: collapse;
				margin: 5px;
			}
			th, td {
				width: 50%;
				border: 1px solid #444444;
				padding: 5px;
			}
			#no_border{
			border:0px;
			background:#ffffff;
			}
			.inputText {
				width: 95%;
				text-align : center;
			}
			.MainContent {
				position: absolute; left: 50%; 
				width: 1024px; margin-left: -512px;			
				text-align:center;		
			}
			.MenuBar {
				width:100%; height:100%; background:blue; 
				float:center; padding:15px;
				font-size:20px; color:white; font-weight:bold; text-decoration:none;
				text-align:center;	
			}
			.DeviceInfo {
				position: absolute; left: 50%; 
				width:600px; margin-left: -300px;		 
				height:100%; 
				text-align:center;
			}	
						
		</style>
		
		<script type="text/javascript">   
        	function goBack(){
        		window.history.back();
        	}
		</script>
    
		<title>Device metadata modification page</title>
	</head>

	<body>
	<div class="MainContent">
	<form name='myform6' action="actionDeviceModification.jsp" method="POST">
		<div class="MenuBar">
			<h1> Modifying Device Metadata </h1>
			<button type="button" onclick="location.href='deviceList.jsp'">Device List</button>
			<button type="submit">Modify</button>
			<button type="button" onclick="goBack();">Back</button>
		</div>
		<div class = "DeviceInfo">
			<h2>Device id : <%= di.getdevice_id() %> </h2>
			<h2 style = "text-align: left;">Device Metadata</h2>
			<table>
				<tr>
					<th>Device id</th>
					<td><input type="text" class="inputText" id="no_border" name="device_id" value="<%= di.getdevice_id() %>">
					</td>
				</tr>
				<tr>
					<th>Device name</th>
					<td><input type="text" class="inputText"  name="device_name" value="<%= di.getdevice_name() %>">
					</td>
				</tr>
				<tr>
					<th>Item id</th>
					<td><input type="text" class="inputText" id="item_id" name="item_id" value="<%= di.getitem_id() %>">
					</td>
				</tr>
				<tr>
					<th>System id</th>
					<td><input type="text" class="inputText" id="system_id" name="system_id" value="<%= di.getsystem_id() %>">
					</td>
				</tr>
				<tr>
					<th>Deployment time</th>
					<td><input type="text" class="inputText" id="deployment_time" name="deployment_time" 
							value="<%= di.getdeployment_time() %>">
					</td>
				</tr>
				<tr>
					<th>Deployment location</th>
					<td><input type="text" class="inputText" id="deployment_location" name="deployment_location" 
							value="<%= di.getdeployment_location() %>">
					</td>
				</tr>
				<tr>
					<th>Latitude</th>
					<td><input type="text" class="inputText" id="latitude" name="latitude" 
							value="<%= di.getlatitude() %>"></td>
				</tr>
				<tr>
					<th>longitude</th>
					<td><input type="text" class="inputText" id="longitude" name="longitude" value="<%= di.getlongitude() %>"></td>
				</tr>
			</table>
		</div>
	</form>
	</div>
	</body>
</html>