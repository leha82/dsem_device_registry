<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*,core.*, structures.*" %>

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
				<th style="width:60%;">Device Name</th>
				<th style="width:20%;">Status</th>
			</tr>
		</thead>
		<tbody>
<%
	if (dilist.size()==0) {
		out.write("<tr><td colspan=3>no devices</td></tr>");
	}
	for(int i = 0; i < dilist.size(); i++) {
		DeviceInfo di = dilist.get(i);
		String disabled = "";
		if (!di.isEnabled()) disabled="Disabled";
%>
			<tr class="Clickable <%= disabled %>" onclick="location.href='deviceDetail.jsp?device_id=<%=di.getDevice_id()%>'">
				<td><%=di.getDevice_id()%></td>
				<td><%=di.getDevice_name()%></td>
				<td><%= (di.isEnabled())?"enabled":"disabled" %></td>
			</tr>
<%
	}
%>
		</tbody>
	</table>
</body>
</html>