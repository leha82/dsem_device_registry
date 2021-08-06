<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<link rel="stylesheet" sype="text/css" href = "../css/main.css">
	
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js"
		type="text/javascript"></script>
	<script type="text/javascript">
		function check() {
			if (myform.item_id.value == "" || myform.deployment_time.value == ""
					|| myform.lat.value == "" ) {
				alert("Input values");
	
				myform.item_id.focus();
				myform.deployment_time.focus();
				myform.lat.focus();
		
				return false;
			}
			
			//document.myform.action = "actionDeviceRegistration.jsp";
			document.myform.submit();
		}
	
        function goBack(){
			window.history.back();
		}
	</script>
	
    <title>Device Registration</title>
</head>

<body>
	<div class="MainContent">
	<form name='myform' action="actionDeviceRegistration.jsp" method="post">
		<div class="MenuBar" id="device_top">
			<h1>Device Registration</h1>
			<jsp:include page="menu.jsp" flush="false" />
		</div>
		<div class="SubMenuBar">
			<button class="SubMenuButton" type="button" class="back" onclick="goBack();">back</button>
		</div>
		<div class="DeviceInfo">
			<h2>Register New Device</h2>
			<table>
				<thead>
						<th style="width: 30%;">Metadata</th>
						<th style="width: 70%;">Value</th>
				</thead>
				<tr>
					<th>Device name</th>
					<td><input type="text" class="inputText" name="device_name" placeholder="Input" /></td>
				</tr>
				
				<tr>
					<th>Item id</th>
					<td><input type="text" class="inputText" name="item_id" placeholder="Input" /></td>
				</tr>
				
				<tr>
					<th>System id</th>
					<td><input type="text" class="inputText" name="system_id" placeholder="Input" /></td>
				</tr>
				
				<tr>
					<th>Deployment time</th>
					<td><input type="text" class="inputText" name="deployment_time" placeholder="Input" /></td>
				</tr>
				
				<tr>
					<th>Deployment location</th>
					<td><input type="text" class="inputText" name="deployment_location" placeholder="Input" /></td>
				</tr>
				
				<tr>
					<th>Latitude</th>
					<td><input type="text" class="inputText" name="lat" placeholder="Input" /></td>
				</tr>
				
				<tr>
					<th>Longitude</th>
					<td><input type="text" class="inputText" name="lon" placeholder="Input" /></td>
				</tr>
			</table>
			<button type="button" onclick="check()" style="height:30px; margin:5px 0px;">submit</button>
		</div>
	</form>
	</div>
</body>
</html>
