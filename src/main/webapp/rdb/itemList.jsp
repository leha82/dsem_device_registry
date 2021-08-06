<%@page import="java.util.*, webmodules.mysql.*, structures.mysql.*"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	DBManager dbm = new DBManager(application.getRealPath("/"));

	dbm.connect();

	ArrayList<ItemCommon> icList = dbm.getList_ItemCommon();
	
	dbm.disconnect();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" sype="text/css" href = "../css/main.css">
	
	<script location.href="./test?params="
		+encodeURI(params); 
		src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js"
		type="text/javascript"></script>
	<title>Device Item List</title>
</head>

<body>
	<div class="MainContent">
		<div class="MenuBar" id="item_top">
			<h1>Item List</h1>
			<jsp:include page="menu.jsp" flush="false" />
		</div>
		<div class="SubMenuBar">
			<button class="SubMenuButton" type="button" onclick="location.href='itemRegistration.jsp'">Register</button>
		</div>
		<table>
			<thead>
				<th>Item id</th>
				<th>Registration time</th>
				<th>Model name</th>
				<th>Device type</th>
				<th>Manufacturer</th>
				<th>Category</th>
				<th>Detail</th>
			</thead>
			<tbody>
				<%
				for(int i=0; i<icList.size(); i++) {
								ItemCommon ic = icList.get(i);
				%>
				<tr>
					<td><%= ic.getId() %></td>
					<td><%= ic.getRegistration_time() %></td>
					<td><%=ic.getModel_name()%></td>
					<td><%= ic.getDevice_type() %></td>
					<td><%= ic.getManufacturer() %></td>
					<td><%= ic.getCategory()%></td>
					<td><button type="button"
							onclick="location.href='itemDetail.jsp?id=<%=ic.getId()%>'">detail</button></td>
				</tr>

				<%
					}
				%>
					

			</tbody>
		</table>
	</div>
</body>
</html>
