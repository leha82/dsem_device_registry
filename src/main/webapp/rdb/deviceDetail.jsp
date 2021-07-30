<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, webmodules.mysql.*, structures.mysql.*" %>
	<%@page import="java.io.*, java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
"http://www.w3.org/TR/html4/loose.dtd">
    
<%
	int item_id = Integer.parseInt(request.getParameter("id"));

	DBManager dbm = new DBManager(application.getRealPath("/"));
	dbm.connect();
	DeviceCommon dc = dbm.getDeviceCommon(item_id);
	DeviceSpecific ds = dbm.getDeviceSpecific(item_id);
	dbm.disconnect();	

//	for(int i=0; i<ds.size(); i++) {
//		System.out.println("key " + ds.getKey(i));
//		System.out.println("value " + ds.getValue(i));
//	}

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
			width:100%; height:100%; background:orange; 
			float:center; padding:15px;
			font-size:20px; color:black; font-weight:bold; text-decoration:none;
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
	<title>Device Item Metadata Detail</title>
</head>
<body>
	<div class="MainContent">
	<form name='myform6' action="ReviseFile.jsp" method="POST">
		<div class="MenuBar">
			<h1>Device Item Detail </h1>
			<button type="button" onclick="location.href='deviceItemList.jsp'">Item List</button>
			<button type="button" onclick="location.href='deviceItemModification.jsp?id=<%=dc.getId()%>'">Item Modify</button>
			<button type="button" onclick="goBack();">Back</button>&nbsp;&nbsp;&nbsp;
			<button type="button" onclick="location.href='actionDetail.jsp?id=<%=dc.getId()%>'">Delete</button>
		</div>
		<div class="DeviceInfo">
			<h2>Item id : <%= dc.getId() %> </h2>
			<h2 style = "text-align: left;">Common Metadata</h2>
			
			<table>
				<tr>
					<th>Item id</th>
					<td><%= dc.getId() %></td>
				</tr>
				<tr>
					<th>Registration time</th>
					<td><%= dc.getregistration_time() %></td>
				</tr>
				<tr>
					<th>Model name</th>
					<td><%= dc.getmodel_name() %></td>
				</tr>
				<tr>
					<th>Device type</th>
					<td><%= dc.getDevice_type() %></td>
				</tr>
				<tr>
					<th>Manufacturer</th>
					<td><%= dc.getManufacturer() %></td>
				</tr>
			
				<tr>
					<th>Category</th>
					<td><%= dc.getCategory() %></td>
				</tr>
			</table>
			<br><br>
			<h2 style = "text-align: left;">Specific Metadata</h2>
			<table>
<%
	for(int i = 0; i < ds.size(); i++) {
%>
				<tr>
					<th id = 'key'><%= ds.getKey(i) %></th>
					<td><%= ds.getValue(i)%></td>
				</tr>
<%
	}
%>
			</table>
		</div>
	</form>
	</div>
</body>
</html>