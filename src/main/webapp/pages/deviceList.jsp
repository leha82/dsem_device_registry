<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.*, webmodules.*, structures.*"%>
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
		
		String lat = di.getLatitudeString();
		if (lat.length()>10) lat = lat.substring(0, 10);

		String lon = di.getLongitudeString();
		if (lon.length()>10) lon = lon.substring(0, 10);
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
						<td><%=lat%></td>
						<td><%=lon%></td>
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
