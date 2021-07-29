<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
  h1 {
  	  border-collapse: collapse;
  }
  table {
    width:600px;
	border: 1px solid #444444;
	border-collapse: collapse;
	margin: 5px;
  }
  th, td {
	width: 50%;
	border: 1px solid #444444;
	padding: 5px;	
  }
  .MainContent{
  	position: absolute; left: 50%;
  	width: 1024px; margin-left: -512px;
  	text-align:center;
  }
  .MenuBar{
  	width:100%; height:100%; background:blue;
  	float:center; padding:15px;
  	font-size:20px; color:white; font-weight:bold; text-decoration:none;
  	text-align:center;
  }
  .InputText{
  	width: 95%;
  	text-align : center;
  }
  
</style>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js"
	type="text/javascript"></script>
<script type="text/javascript">
	function check(no) {
		if (myform.item_id.value == "" || myform.deployment_time.value == ""
				|| myform.lat.value == "" ) {
			alert("Input values");

			myform.item_id.focus();
			myform.deployment_time.focus();
			myform.lat.focus();
	
			return false;
		}
		if (no == 1) {
			document.myform.action = "actionDeviceRegistration.jsp";
		} else {
			return;
		}
		document.myform.submit();
	}
</script>
 <script type="text/javascript">   
        function goBack(){
        window.history.back();
        	}
    </script>
    <title>Device Registration</title>
</head>

<body>
<div class="MainContent">
	<form name='myform' action="DbSelect.jsp" method="post">
	<div class="MenuBar">
			<h1>Device Register</h1>
			<button  type="button" class="back" onclick="goBack();">Back</button></p>
	</div>
	<br><br>
		<table id="example" border="3px" style="margin-left: auto; margin-right: auto;">
			<tr>
				<th>Device name</th>
				<td><input type="text" class="InputText" name="device_name" placeholder="Input" style="width:300px;height:30px;" /></td>
			</tr>
			
			<tr>
				<th>Item id</th>
				<td><input type="text" class="InputText" name="item_id" placeholder="Input" style="width:300px;height:30px;" /></td>
			</tr>
			
			<tr>
				<th>System id</th>
				<td><input type="text" class="InputText" name="system_id" placeholder="Input" style="width:300px;height:30px;" /></td>
			</tr>
			
			<tr>
				<th>Deployment time</th>
				<td><input type="text" class="InputText" name="deployment_time" placeholder="Input" style="width:300px;height:30px;" /></td>
			</tr>
			
			<tr>
				<th>Deployment location</th>
				<td><input type="text" class="InputText" name="deployment_location" placeholder="Input" style="width:300px;height:30px;" /></td>
			</tr>
			
			<tr>
				<th>Latitude</th>
				<td><input type="text" class="InputText" name="lat" placeholder="Input" style="width:300px;height:30px;" /></td>
			</tr>
			
			<tr>
				<th>Longitude</th>
				<td><input type="text" class="InputText" name="lon" placeholder="Input" style="width:300px;height:30px;" />
			</tr>
			
			<tr>
				<th>Register</th>
				<td><button type="button" onclick="check(1)"style="width:304px;height:30px;">Register</button></td>
			</tr>
				</table>
			</form>
		</div>
	</body>
</html>
