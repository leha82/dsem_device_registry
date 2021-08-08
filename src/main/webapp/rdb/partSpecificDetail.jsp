<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, webmodules.mysql.*, structures.mysql.*" %>

<%
//	int item_id = Integer.parseInt(request.getParameter("id"));
//	DBManager dbm = new DBManager(application.getRealPath("/"));
//	dbm.connect();
//	ItemSpecific is = dbm.getItemSpecific(item_id);
//	dbm.disconnect();
	ItemSpecific is = (ItemSpecific) request.getAttribute("itemspecific");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Show table about Specific Metadata</title>
</head>
<body>
	Specific Information
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
</body>
</html>