<%@page import="java.util.*, webmodules.mysql.*, structures.mysql.*"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	DBManager dbm = new DBManager(application.getRealPath("/"));

	dbm.connect();

	ArrayList<DeviceCommon> dcList = dbm.getGlobalList();
	
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
		width: 103%;
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
  		width:100%; height:100%; background:orange;
  		float:center; padding:15px;
  		font-size:20px; color:black; font-weight:bold; text-decoration:none;
  		text-align:center;
  	}
  	.InputText {
  		width: 95%;
  		text-align : center;
  	}
  
</style>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script location.href="./test?params="
	+encodeURI(params); 
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js"
	type="text/javascript"></script>
<script type="text/javascript">
	function goBack() {
		window.history.back();
	}
</script>
<title>Device Item List</title>
</head>

<body>
	<div class="MainContent">
	<form name='myform' action="db2.jsp" method="post">
	<div class="MenuBar">
			 <h1>Device Item List</h1>
			 <button type="button" onclick="location.href='itemRegistration.jsp'">Item Registration</button>
			 <button type="button" onclick="location.href='deviceItemList.jsp'">Item List</button>&nbsp;&nbsp;
			 <button type="button" onclick="location.href='deviceRegistration.jsp'">Device Registration</button>
			 <button type="button" onclick="location.href='deviceList.jsp'">Device List</button>
	</div>
		<table id="tb1" width="100%" border="1">
				<tr>
					<th>Item id</th>
					<th>Registration time</th>
					<th>Model name</th>
					<th>Device type</th>
					<th>Manufacturer</th>
					<th>Category</th>
					<th>Detail</th>
				</tr>
			<tbody>
				<%
					for(int i=0; i<dcList.size(); i++) {
						DeviceCommon dc = dcList.get(i); 
				%>
				<tr>
					<td><%= dc.getId() %></td>
					<td><%= dc.getregistration_time() %></td>
					<td><%= dc.getmodel_name()%></td>
					<td><%= dc.getDevice_type() %></td>
					<td><%= dc.getManufacturer() %></td>
					<td><%= dc.getCategory()%></td>
					<%-- <td>
						<button type="button"
							onclick="location.href='Jsontest1.jsp?id=<%=dc.getId()%>'">Add</button>
					</td>
					--%>
					<td>
						<button type="button"
							onclick="location.href='deviceDetail.jsp?id=<%=dc.getId()%>'">detail</button>
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
