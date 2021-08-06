<%@page import="java.sql.*" pageEncoding="UTF-8" 
import="java.util.*, webmodules.mysql.*, structures.mysql.*" %>
<%@page import="java.io.*, java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!-- item detail 페이지에서  global, specific 삭제하는 페이지 -->
		
		<%
				int send_id = Integer.parseInt(request.getParameter("id"));
							System.out.println(send_id + " <-- delete this id ");
							request.setCharacterEncoding("utf-8");
							
							DBManager dbm = new DBManager(application.getRealPath("/"));
							dbm.connect();
							dbm.deleteGlobalItem(send_id);
							dbm.deleteSpecificItem(send_id);
							dbm.disconnect();
							// 자동 테이블 삭제 -- 보류
							// 
						//			DBManager dbm = new DBManager();
								//dbm.connect();
						//				DeviceInfo di = dbm.getDeviceInfo(send_id);
						//				dbm.disconnect();

								//AutoDBConnector adb = new AutoDBConnector();
								//adb.deleteTable(di.gettable_name());
				%>
		
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<script type="text/javascript">
window.location.replace("deviceItemList.jsp?id=<%= send_id %> ");
</script>

<title>delete m_delete.jsp</title>
</head>

</html>