<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*,core.*, structures.*"%>
<%
	DBManager dbm = new DBManager(application.getRealPath("/"));

	dbm.connect();
	ArrayList<ItemCommon> icList = dbm.getList_ItemCommon();
	dbm.disconnect();
%>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" type="text/css" href = "../css/main.css">
	
	<title>Device Item List</title>
</head>

<body>
	<header>
		<jsp:include page="partItemHeader.jsp" flush="false" />
	</header>
	<main>
		<div class="SubTitleBar">
			<h1>Item List</h1>
		</div>
		<div class="WideTable">
			<div class="SubMenuBar">
				<button type="button" onclick="location.href='itemRegistration.jsp'">Register</button>
			</div>		
			<table>
				<thead>
					<tr>
						<th>Item id</th>
						<th>Registration time</th>
						<th>Model name</th>
						<th>Device type</th>
						<th>Manufacturer</th>
						<th>Category</th>
						<th>Detail</th>
					</tr>
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
								onclick="location.href='itemDetail.jsp?item_id=<%=ic.getId()%>'">detail</button></td>
					</tr>
	
<%
	}
%>
				</tbody>
			</table>
		</div>
	</main>
</body>
</html>
