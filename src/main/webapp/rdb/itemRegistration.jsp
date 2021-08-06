<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%//deviceRegistration.jsp %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<link rel="stylesheet" sype="text/css" href = "../css/main.css">
	<script
		src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js"
		type="text/javascript"></script>
	<script type="text/javascript">
		function check() {
			if (myform.model_name.value == "" || myform.device_type.value == ""
					|| myform.manufacturer.value == "" ) {
				alert("Input values");
				myform.model_name.focus();
				myform.device_type.focus();
				myform.manufacturer.focus();
				return false;
			}
//			document.myform.action = "actionItemRegistration.jsp";
			document.myform.submit();
		}
	</script>
	<script type="text/javascript">   
		function goBack(){
			window.history.back();
		}
	</script>
    <title>Device Item Register</title>
</head>

<body>
	<div class="MainContent">
	<form name='myform' action="actionItemRegistration.jsp" method="post">
		<div class="MenuBar" id="item_top">
			<h1>Item Registration</h1>
			<jsp:include page="menu.jsp" flush="false" />
		</div>
		<div class="SubMenuBar">
			<button class="SubMenuButton" type="button" class="back" onclick="goBack();">back</button>
		</div>
		<div class="DeviceInfo">
			<h2>Register New Device Item</h2>
			<table>
				<thead>
					<th style="width: 30%;">Metadata</th>
					<th style="width: 70%;">Value</th>
				</thead>
				<tr>
					<th>Model name</th>
					<td><input type="text" class="inputText" name="model_name" placeholder="input" /></td>
				</tr>
				<tr>
					<th>Device type</th>
					<td><input type="text" class="inputText" name="device_type" placeholder="input" /></td>
				</tr>
				<tr>
					<th>Manufacturer</th>
					<td><input type="text" class="inputText" name="manufacturer" placeholder="input" /></td>
				</tr>
				<tr>
					<th>Category</th>
					<td><input type="text" class="inputText" name="category" placeholder="input" /></td>
				</tr>
			</table>
			<button type="button" onclick="check()" style="height:30px; margin:5px 0px;">submit</button>
		</div>
	</form>
	</div>
</body>
</html>
