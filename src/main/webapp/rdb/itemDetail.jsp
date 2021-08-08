<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.util.*, webmodules.mysql.*, structures.mysql.*" %>
<%
    int item_id = Integer.parseInt(request.getParameter("id"));

	DBManager dbm = new DBManager(application.getRealPath("/"));

	dbm.connect();
	ItemCommon ic = dbm.getItemCommon(item_id);
	ItemSpecific is = dbm.getItemSpecific(item_id);
	dbm.disconnect();	

	request.setAttribute("itemspecific", is);
%>
    
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" type="text/css" href = "../css/main.css">
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
	<header>
		<jsp:include page="partItemHeader.jsp" flush="false" />
	</header>
	<main>
		<div class="SubTitleBar">
			<h1>Item Detail</h1>
		</div>
		<h2>[<%= ic.getId() %>] <%=ic.getModel_name()%></h2>
		<div class="NarrowTable">
			<div class="SubMenuBar">
				<button class="SubMenuButton" type="button" onclick="location.href='itemModification.jsp?id=<%=ic.getId()%>'">modify</button>
				<button class="SubMenuButton" type="button" onclick="goBack();">back</button>
			</div>
			Common Information
			<table>
				<thead>
					<th style="width: 30%;">Attribute</th>
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
			<jsp:include page="partSpecificDetail.jsp" flush="false" />
			<div class="SubMenuBar">
				<button class="SubMenuButton" type="button" onclick="confirmDelete();">delete item</button>
			</div>
			<br><br>
		</div>
	</main>
</body>
</html>