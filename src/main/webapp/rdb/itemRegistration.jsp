<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<link rel="stylesheet" type="text/css" href = "../css/main.css">
	
	<script type="text/javascript">
		function goBack(){
			window.history.back();
		}
		
		function check() {
			if (myform.model_name.value == "" || myform.device_type.value == ""
					|| myform.manufacturer.value == "" ) {
				alert("Input values");
				myform.model_name.focus();
				myform.device_type.focus();
				myform.manufacturer.focus();
				return false;
			}
			document.myform.submit();
		}
	</script>
    <title>Device Item Register</title>
</head>

<body>
	<header>
		<jsp:include page="partItemHeader.jsp" flush="false" />
	</header>
	<main>
		<div class="SubTitleBar">
			<h1>Register New Item</h1>
		</div>
		<form name='myform' action="actionItemRegistration.jsp" method="post">
		<div class="NarrowTable">
			<div class="SubMenuBar">
				<button class="SubMenuButton" type="button" onclick="check()">submit</button>
				<button class="SubMenuButton" type="button" class="back" onclick="goBack();">back</button>
			</div>
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
		</div>
		</form>
	</main>
</body>
</html>
