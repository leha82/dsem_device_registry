<%@page import="java.util.*, webmodules.mysql.*, structures.mysql.*"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>

<%
	DBManager dbm = new DBManager();
	dbm.connect();

	ArrayList<DeviceInfo> dcList = dbm.getDeviceInfo();
	
	for (int i=0; i<dcList.size(); i++) {
		DeviceInfo dl = dcList.get(i);
		DeviceCommon dc = dbm.getDeviceCommon(dl.getitem_id());
		dl.setItem_name(dc.getmodel_name());
	}
	
	dbm.disconnect();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style>
 	h1 	  {
  	  	border-collapse: collapse; 
    }
	table {
		width: 106%;
		margin-left: auto;
		margin-right: auto;
		border: 1px solid #444444;
		border-collapse: collapse;
	}
	th, td {
		border: 1px solid #444444;
		padding: 5px;
		text-align : center;
	}
    .MainContent {
  		position: absolute; left: 50%;
  		width: 1024px; margin-left: -512px;
  		text-align:center;
  	}
  	.MenuBar {
  		width:103%; height:100%; background:blue;
  		float:center; padding:15px;
  		font-size:20px; color:white; font-weight:bold; text-decoration:none;
  		text-align:center;
  	}
  	.InputText {
  		width: 95%;
  		text-align : center;
  	}
  
</style>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script location.href="./test?params=" + encodeURI(params); 
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js"
	type="text/javascript"></script>
<script type="text/javascript">
	function goBack() {
		window.history.back();
	}
</script>
<title>Device List</title>
</head>

<body>
	<div class="MainContent">
	<div class="MenuBar">
			 <h1>Device List</h1>
			 <button type="button" onclick="location.href='itemRegistration.jsp'">Item Registration</button>
			 <button type="button" onclick="location.href='deviceItemList.jsp'">Item List</button>&nbsp;&nbsp;
			 <button type="button" onclick="location.href='deviceRegistration.jsp'">Device Registration</button>
			 <button type="button" onclick="location.href='deviceList.jsp'">Device List</button>
	</div>
		<table>
				<tr>
					<th>Device id</th>
					<th>Device name</th>
					<th>System id</th>
					<th>Item id</th>
					<th>Model name</th>
					<th>Table name</th>
					<th>Deployment time</th>
					<th>Deployment location</th>
					<th>Latitude</th>
					<th>Longitude</th>
					<th>Modify</th>
					<th>Delete list</th>
					<th>Delete list with Measurement table</th>
				</tr>
			<tbody>
				<%
					for(int i=0; i<dcList.size(); i++) {
								DeviceInfo dl = dcList.get(i);
				%>
				<tr>
					<td><%= dl.getdevice_id()%></td>
					<td><%= dl.getdevice_name()%></td>
					<td><%= dl.getsystem_id() %></td>
					<td><%= dl.getitem_id() %></td>
					<td><%= dl.getItem_name() %></td>
					<td><%= dl.gettable_name() %></td>
					<td><%= dl.getdeployment_time() %></td>
					<td><%= dl.getdeployment_location() %></td>
					<td><%= dl.getlatitude()%></td>
					<td><%= dl.getlongitude() %></td>
					<td>
						<button type="button" onclick="location.href='deviceModification.jsp?id=<%=dl.getitem_id()%>'" target="_blank" width="600px">modify</button>
					</td>
					<td>
						<button type="button" onclick="location.href='actionDeleteDevice.jsp?id=<%=dl.getdevice_id()%>&item_id=<%=dl.getitem_id() %>'" target="_blank" width="600px">delete</button>
					</td>
					<td>
						<button type="button" onclick="location.href='actionDeleteDevicewTable.jsp?id=<%=dl.getdevice_id()%>&item_id=<%=dl.getitem_id() %>'" target="_blank" width="600px">delete</button>
					</td>
				</tr>

				<%
					}
				%>
					

			</tbody>
		</table>
		</div>
</body>
</html>
