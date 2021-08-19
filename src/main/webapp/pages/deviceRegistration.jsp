<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.util.*,core.*, structures.*"%>
<%
	DBManager dbm = new DBManager(application.getRealPath("/"));

	dbm.connect();
	ArrayList<ItemCommon> iclist = dbm.getList_ItemCommon();
	dbm.disconnect();
%>


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
			if (devform.lat.value!="" && isNaN(devform.lat.value)) {
				alert("Input numeric value in latitude");
				devform.lat.focus();
				return false;
			}

			if (devform.lon.value!="" && isNaN(devform.lon.value)) {
				alert("Input numeric value in latitude");
				devform.lon.focus();
				return false;
			}
			
/* 			if (myform.item_id.value == "" || myform.deployment_time.value == ""
					|| myform.lat.value == "" ) {
				alert("Input values");
	
				myform.item_id.focus();
				myform.deployment_time.focus();
				myform.lat.focus();
		
				return false;
			}
*/

			devform.submit();
		}
	</script>
	
    <title>Device Registration</title>
</head>

<body>
	<header>
		<jsp:include page="partDeviceHeader.jsp" flush="false" />
	</header>
	<main>
		<div class="SubTitleBar">
			<h1>Register New Device</h1>
		</div>
		<form name='devform' action="actionDeviceRegistration.jsp" method="post">
		<div class="NarrowTable">
			<div class="SubMenuBar">
				<button class="SubMenuButton" type="button" onclick="check()">submit</button>
				<button class="SubMenuButton" type="button" class="back" onclick="goBack();">back</button>
			</div>
			<table>
				<thead>
					<tr>
						<th style="width: 30%;">Attribute</th>
						<th style="width: 70%;">Value</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th>Device name</th>
						<td><input type="text" class="inputText" name="device_name" placeholder="Input" /></td>
					</tr>
					
					<tr>
						<th>System id</th>
						<td><input type="text" class="inputText" name="system_id" placeholder="Input" /></td>
					</tr>
					
					<tr>
						<th>Item id</th>
						<td>
							<select class="inputText" name="item_id">
<%
	for (int i=0; i<iclist.size(); i++) {
		ItemCommon ic = iclist.get(i);
%>
								<option value="<%= ic.getId() %>">(<%= ic.getId() %>)<%= ic.getModel_name() %></option>
<%		
	}
%>						
							</select>
						</td>
					</tr>
					
					<tr>
						<th>Deployment time</th>
						<td><input type="text" class="inputText" name="deployment_time" placeholder="yyyy-MM-dd HH:mm:ss"
							value="<%= CoreModules.getCurrentTime() %>" /></td>
					</tr>
					
					<tr>
						<th>Deployment location</th>
						<td><input type="text" class="inputText" name="deployment_location" placeholder="Input" /></td>
					</tr>
					
					<tr>
						<th>Latitude</th>
						<td><input type="text" class="inputText" name="lat" placeholder="Input GPS position" /></td>
					</tr>
					
					<tr>
						<th>Longitude</th>
						<td><input type="text" class="inputText" name="lon" placeholder="Input GPS position" /></td>
					</tr>
				</tbody>
			</table>
		</div>
	</form>
	</main>
</body>
</html>
