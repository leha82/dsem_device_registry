<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.sql.*, java.util.*, webmodules.mysql.*, structures.mysql.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	DBManager dbm = new DBManager(application.getRealPath("/"));
	
	dbm.connect();
//	int item_id = Integer.parseInt(request.getParameter("item_id"));
//	ItemCommon ic = dbm.getItemCommon(item_id);
	
	DeviceInfo di = new DeviceInfo();
	
	di.setDevice_name(request.getParameter("device_name"));
	di.setItem_id(Integer.parseInt(request.getParameter("item_id")));
	di.setSystem_id(request.getParameter("system_id"));
//	di.setItem_name(ic.getModel_name());
	di.setTable_name("no_table");
	di.setDeployment_time(request.getParameter("deployment_time"));
	di.setDeployment_location(request.getParameter("deployment_location"));
	di.setLatitude(request.getParameter("lat"));
	di.setLongitude(request.getParameter("lon"));
	
	if (dbm.insertDeviceInfo(di)) {
		int device_id = dbm.getLastDeviceId();
		di.setDevice_id(device_id);
		
		//table_name is defined as "device + 0000 + {device_id}
		String tableno = "0000" + device_id;
		String table_name = "device" + tableno.substring(tableno.length() - 4);

		// table is automatically created in DeviceMeasurement database
		
		if (dbm.createTable_DeviceMeasurement(di.getItem_id(), table_name)) {
			dbm.updateDeviceTableName(device_id, table_name);
		} else {
			out.println("<script type='text/javascript'>");
			out.println("	alert('Device Measurement Table cannot be created.');");
			out.println("</script>");
		}
	}
	
	dbm.disconnect();
	
	out.println("<script type='text/javascript'>");
	out.println("	alert('Device (" + di.getDevice_name() + ") is registered');");
	out.println("	location.href='deviceList.jsp';");
	out.println("</script>");
%>