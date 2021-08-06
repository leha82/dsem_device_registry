<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, webmodules.mysql.*, structures.mysql.*" %>
	<%@page import="java.io.*, java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
"http://www.w3.org/TR/html4/loose.dtd">
    
<%
    int item_id = Integer.parseInt(request.getParameter("id"));

	DBManager dbm = new DBManager(application.getRealPath("/"));

	dbm.connect();
	ItemCommon ic = dbm.getItemCommon(item_id);
	ItemSpecific is = dbm.getItemSpecific(item_id);
	dbm.disconnect();	

%>
    
<html>
<head>
	<!-- jQuery  -->
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js" type="text/javascript"></script>
	<link rel="stylesheet" sype="text/css" href = "../css/main.css">
	<script type="text/javascript">   
		function goBack() {
			window.history.back();
		}
		function confirmDelete() {
			if (confirm('Delete Item <%=ic.getModel_name()%> ?')) {
				location.href='actionDeleteItem.jsp?id=<%=ic.getId()%>';
			}
		}
    </script>
    
	<title>Device Item Metadata Detail</title>
</head>
<body>
	<div class="MainContent">
		<div class="MenuBar" id="item_top">
			<h1>Item Detail </h1>
			<jsp:include page="menu.jsp" flush="false" />
		</div>
		<div class="SubMenuBar">
			<button class="SubMenuButton" type="button" onclick="confirmDelete();">delete</button>
			<button class="SubMenuButton" type="button" onclick="location.href='itemModification.jsp?id=<%=ic.getId()%>'">modify</button>
			<button class="SubMenuButton" type="button" onclick="goBack();">back</button>
		</div>
		<div class="DeviceInfo">
			<h2>[<%= ic.getId() %>] <%=ic.getModel_name()%></h2>
			<h2 style = "text-align: left;">Common Metadata</h2>
			
			<table>
				<thead>
					<th style="width: 30%;">Metadata</th>
					<th style="width: 70%;">Value</th>
				</thead>
				<tr>
					<th>Item id</th>
					<td><%= ic.getId() %></td>
				</tr>
				<tr>
					<th>Registration time</th>
					<td><%=ic.getRegistration_time()%></td>
				</tr>
				<tr>
					<th>Model name</th>
					<td><%=ic.getModel_name()%></td>
				</tr>
				<tr>
					<th>Device type</th>
					<td><%= ic.getDevice_type() %></td>
				</tr>
				<tr>
					<th>Manufacturer</th>
					<td><%= ic.getManufacturer() %></td>
				</tr>
			
				<tr>
					<th>Category</th>
					<td><%= ic.getCategory() %></td>
				</tr>
			</table>
			<br><br>
			<h2 style = "text-align: left;">Specific Metadata</h2>
			<table>
				<thead>
					<th style="width:10%;">Group</th>
					<th style="width:45%;">Key</th>
					<th style="width:45%;">Value</th>
				</thead>
<%
	for(int i = 0; i < is.size(); i++) {
%>
				<tr>
					<td><%=is.getGroup(i)%></th>
					<td><%=is.getKey(i)%></th>
					<td><%= is.getValue(i)%></td>
				</tr>
<%
	}
%>
			</table>
		</div>
	</div>
</body>
</html>