<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, webmodules.mongodb.*, structures.mongodb.*" %>
	<%@page import="java.io.*, java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
"http://www.w3.org/TR/html4/loose.dtd">
    
<!-- jQuery  -->
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js"
	type="text/javascript"></script>
    
<%
    	String device_id = (String)request.getParameter("id");
		
    	MongoDBManager dbm = new MongoDBManager(); 
    	DeviceCommon dc = dbm.getDeviceCommon(device_id);
		DeviceSpecific ds = dbm.getDeviceSpecific(device_id); 
    	for(int i=0; i<ds.size(); i++) {
    		System.out.println("key " + ds.getKey(i));
    		System.out.println("value " + ds.getValue(i));
    	}
    %>
    
<html>
<head>

		<style>
			.header_1 {
				float:left;
			}
			.no-border { 
				border:0px; background:#ffffff; 
			}
			h1{
				border-collapse: collapse;
			}
			table {
				width: 600px;
				border: 1px solid #444444;
				border-collapse: collapse;
				margin: 5px;
			}
			th, td {
				width: 50%;
				border: 1px solid #444444;
				padding: 5px;
			}
			.inputText {
				width: 95%;
				text-align : center;
			}
			.MainContent {
				position: absolute; left: 50%; 
				width: 1024px; margin-left: -512px;			
				text-align:center;		
			}
			.MenuBar {
				width:100%; height:100%; background:orange; 
				float:center; padding:15px;
				font-size:20px; color:black; font-weight:bold; text-decoration:none;
				text-align:center;	
			}
			.DeviceInfo {
				position: absolute; left: 50%; 
				width:600px; margin-left: -300px;		 
				height:100%; 
				text-align:center;
			}				
		</style>

<script type="text/javascript">   
        function goBack(){
        window.history.back();
        	}
    </script>
<title>Device Metadata Detail</title>
</head>


<body>
	<div class="MainContent">
	<form name='myform6' action="ReviseFile.jsp" method="POST">
	<div class="MenuBar">
		<h1>Device Detail </h1>
			<button type="button" onclick="location.href='deviceList.jsp'">디바이스 목록 보기</button>
			<button type="button" onclick="location.href='deviceModification.jsp?id=<%=dc.getId()%>'">수정</button>
			<button type="button" onclick="location.href='actionDetail.jsp?id=<%=dc.getId()%>'">삭제</button>
			<button type="button" onclick="goBack();">뒤로 가기</button>
	</div>
	<h2>Device ID : <%= dc.getId() %> </h2>
	<h2 style = "text-align: left;">Global Metadata</h2>
	<table name="tb1" id="tb1" width="100%" border="1">
			<tr>
				<th>Id</th>
				<td> 
				<input type="text" class="no-border" id="id" name="id" value="<%= dc.getId() %>" style = "text-align : center;"></td>
			</tr>
			<tr>
				<th>Registration time</th>
				<td> 
				<input type="text" class="no-border" id="time" name="time" value="<%= dc.getregistration_time() %>" style = "text-align : center;"></td>
			</tr>
			<tr>
				<th>Model name</th>
				<td> 
				<input type="text" class="no-border" id="model_name" name="model_name" value="<%= dc.getmodel_name() %>" style = "text-align : center;"></td>
			</tr>
			<tr>
				<th>Device type</th>
				<td><input type="text" class="no-border" id="device_type" name="device_type" value="<%= dc.getDevice_type() %>" style = "text-align : center;"></td>
			</tr>
			<tr>
				<th>Manufacturer</th>
				<td><input type="text" class="no-border" id="manufacturer" name="manufacturer" value="<%= dc.getManufacturer() %>" style = "text-align : center;"></td>
			</tr>
		
			<tr>
				<th>Category</th>
				<td><input type="text" class="no-border" id="category" name="category" value="<%= dc.getCategory() %>" style = "text-align : center;"></td>
			</tr>
		</table><br><br><br><br>	
			
				<h2 style = "text-align: left;">Specific Metadata</h2>
				<table name="tb2" id="tb2" width="100%" border="1" >
			<%
				for(int i = 0; i < ds.size(); i++){
				%>
				<tr>
				<th id = 'key'><%= ds.getKey(i) %></th>
				    <td><input type='text'  class='no-border' id='value<%=(i + 1) %>' name='value<%=(i + 1) %>' value='<%= ds.getValue(i)%>' style = 'text-align : center;'></td>
				</tr>
				<%} %>
					</table>	
				</form>
			</div>
		</body>
	</html>