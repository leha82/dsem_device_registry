<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*, webmodules.mysql.*, structures.mysql.*"%>
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
						<th>Table name</th>
						<th>Item id</th>
						<th>Item Model</th>
						<th>Deployment time</th>
						<th>Deployment location</th>
						<th>Latitude</th>
						<th>Longitude</th>
						<th>Detail</th>
					</tr>
				</thead>
				<tbody>
<%
	for(int i=0; i<diList.size(); i++) {
		DeviceInfo di = diList.get(i);
		if (di.getLatitude().length()>10) di.setLatitude(di.getLatitude().substring(0, 10));
		if (di.getLongitude().length()>10) di.setLongitude(di.getLongitude().substring(0, 10));

%>
					<tr>
						<td><%=di.getDevice_id()%></td>
						<td><%=di.getDevice_name()%></td>
						<td><%=di.getSystem_id()%></td>
						<td><%=di.getTable_name()%></td>
						<td><a href="itemDetail.jsp?id=<%=di.getItem_id()%>"><%=di.getItem_id()%></a></td>
						<td><a href="itemDetail.jsp?id=<%=di.getItem_id()%>"><%=di.getItem_name()%></a></td>
						<td><%=di.getDeployment_time()%></td>
						<td><%=di.getDeployment_location()%></td>
						<td><%=di.getLatitude()%></td>
						<td><%=di.getLongitude()%></td>
						<td>
							<button type="button" 
								onclick="location.href='deviceDetail.jsp?id=<%=di.getDevice_id()%>'">detail</button>
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
