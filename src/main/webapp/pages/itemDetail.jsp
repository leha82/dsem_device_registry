<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.util.*, core.*, structures.*" %>
<%
    int item_id = Integer.parseInt(request.getParameter("item_id"));

	DBManager dbm = new DBManager(application.getRealPath("/"));

	dbm.connect();
	ItemCommon ic = dbm.getItemCommon(item_id);
	ItemSpecific is = dbm.getItemSpecific(item_id);
	ArrayList<DeviceInfo> dilist = dbm.getList_Device(item_id);
	
	dbm.disconnect();	

	request.setAttribute("itemspecific", is);
	request.setAttribute("ref_devices", dilist);
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
			var dilist_size = <%= dilist.size() %>;
			if (dilist_size > 0) {
				alert('You cannot delete this item. The item is referenced by several devices. Modify or delete the devices first.');
				return false;
			}
			
			if (confirm('Delete Item <%=ic.getModel_name()%> ?')) {
				location.href='actionDeleteItem.jsp?item_id=<%=ic.getId()%>';
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
				<button class="SubMenuButton" type="button" onclick="location.href='itemModification.jsp?item_id=<%=ic.getId()%>'">modify</button>
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
			<br><br>
			<jsp:include page="partItemReference.jsp" flush="false" />
			<div class="SubMenuBar">
				<button class="SubMenuButton" type="button" onclick="confirmDelete();">delete item</button>
			</div>
			<br><br>
		</div>
	</main>
</body>
</html>