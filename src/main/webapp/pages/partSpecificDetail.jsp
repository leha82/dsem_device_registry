<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, webmodules.*, structures.*" %>

<%
	ItemSpecific is = (ItemSpecific) request.getAttribute("itemspecific");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
	Specific Information
	<table>
		<thead>
			<tr>
				<th style="width:10%;">Group</th>
				<th style="width:45%;">Key</th>
				<th style="width:45%;">Value</th>
			</tr>
		</thead>
		<tbody>
<%
	if (is.size()==0) {
		out.write("<tr><td colspan=3>no specific information</td></tr>");
	}

	for(int i = 0; i < is.size(); i++) {
%>
			<tr>
				<td><%=is.getGroup(i)%></td>
				<td><%=is.getKey(i)%></td>
				<td><%= is.getValue(i)%></td>
			</tr>
<%
	}
%>
		</tbody>
	</table>
</body>
</html>