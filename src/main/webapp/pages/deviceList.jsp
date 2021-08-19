<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*,core.*, structures.*"%>
<%
	DBManager dbm = new DBManager(application.getRealPath("/"));

	dbm.connect();
	ArrayList<DeviceInfo> diList = dbm.getList_Device();
	dbm.disconnect();
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
	</script>
	<title>Device List</title>
</head>

<body>
	<header>
		<jsp:include page="partDeviceHeader.jsp" flush="false" />
	</header>
	<main>
		<div class="SubTitleBar">
			<h1>Device List</h1>
		</div>
		<div class="WideTable">
			<div class="SubMenuBar">
				<button type="button" onclick="location.href='deviceRegistration.jsp'">Register</button>
			</div>
			<table>
				<thead>
					<tr>
						<th>Device id</th>
						<th>Device name</th>
						<th>System id</th>
						<th>Item id</th>
						<th>Item Model</th>
						<th>Deployment time</th>
						<th>Deployment location</th>
						<th>Status</th>
						<th>Detail</th>
					</tr>
				</thead>
				<tbody>
<%
	for(int i=0; i<diList.size(); i++) {
		DeviceInfo di = diList.get(i);
		String disabled = "";
		if (!di.isEnabled()) disabled="class='Disabled'";
%>
					<tr <%= disabled %>>
						<td><%=di.getDevice_id()%></td>
						<td><%=di.getDevice_name()%></td>
						<td><%=di.getSystem_id()%></td>
	  					<td class="Clickable" onclick="location.href='itemDetail.jsp?item_id=<%=di.getItem_id()%>'"><%=di.getItem_id()%></td>
						<td class="Clickable" onclick="location.href='itemDetail.jsp?item_id=<%=di.getItem_id()%>'"><%=di.getItem_name()%></td> 
						<td><%=di.getDeployment_time()%></td>
						<td><%=di.getDeployment_location()%></td>
						<td><%= (di.isEnabled())?"enabled":"disabled" %></td>
						<td>
							<button type="button" 
								onclick="location.href='deviceDetail.jsp?device_id=<%=di.getDevice_id()%>'">detail</button>
						</td> 
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
