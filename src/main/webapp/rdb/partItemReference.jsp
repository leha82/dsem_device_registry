<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, webmodules.mysql.*, structures.mysql.*" %>

<%
//	int item_id = Integer.parseInt(request.getParameter("id"));
//	DBManager dbm = new DBManager(application.getRealPath("/"));
//	dbm.connect();
	
//	ArrayList<DeviceInfo> dilist = dbm.getList_Device(item_id);
	
//	dbm.disconnect();
	
	ArrayList<DeviceInfo> dilist = (ArrayList<DeviceInfo>)request.getAttribute("ref_devices");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
	Referencing Devices
	<table>
		<thead>
			<tr>
				<th style="width:20%;">Device ID</th>
				<th style="width:80%;">Device Name</th>
			</tr>
		</thead>
		<tbody>
<%
	if (dilist.size()==0) {
		out.write("<tr><td colspan=2>no devices</td></tr>");
	}
	for(int i = 0; i < dilist.size(); i++) {
		DeviceInfo di = dilist.get(i);
%>
			<tr>
				<td><%=di.getDevice_id()%></th>
				<td><%=di.getDevice_name()%></th>
			</tr>
<%
	}
%>
		</tbody>
	</table>
</body>
</html>