<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, webmodules.mongodb.*, structures.mongodb.*" %>
	<%@page import="java.io.*, java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" 
"http://www.w3.org/TR/html4/loose.dtd">

<%
	String device_id = (String)request.getParameter("id");
	MongoDBManager dbm = new MongoDBManager();
	DeviceCommon dc = dbm.getDeviceCommon(device_id);
	DeviceSpecific ds = dbm.getDeviceSpecific(device_id);
	for(int i=0; i<ds.size(); i++) {
		
		System.out.println("key #" + (i+1) + " : " + ds.getKey(i));
		System.out.println("value #" + (i+1) + " : " + ds.getValue(i));
	}
%>
    
<html>
	<head>
    
		<!-- jQuery  -->
		<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js"
				type="text/javascript"></script>
    	
		<style>
			h1 {
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
			#append_row{
			float : left;
			margin : 5px;
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
    
		<title>Device metadata modification page</title>
	</head>

	<body>
	<div class="MainContent">
	<form name='myform6' action="actionModification.jsp" method="POST">
		<div class="MenuBar">
			<h1> Modifying Device Metadata </h1>
			<button type="button" onclick="location.href='deviceList.jsp'">디바이스 목록 보기</button>
			<button type="submit" id="changeBtn">수정완료</button>
			<button type="button" onclick="goBack();">뒤로 가기</button>
		</div>
		<div class = "DeviceInfo">
			<h2>Device ID : <%= dc.getId() %> </h2>
			<h2 style = "text-align: left;">Global Metadata</h2>
			<table>
				<tr>
					<th>Id</th>
					<td><input type="text" class="inputText" id="id" name="id" value="<%= dc.getId() %>">
					</td>
				</tr>
				<tr>
					<th>Registration time</th>
					<td><input type="text" class="inputText" id="time" name="time" value="<%= dc.getregistration_time()%>">
					</td>
				</tr>
				<tr>
					<th>Model name</th>
					<td><input type="text" class="inputText" id="model_name" name="model_name"
							value="<%= dc.getmodel_name() %>">
					</td>
				</tr>
				<tr>
					<th>Device type</th>
					<td><input type="text" class="inputText" id="device_type" name="device_type" 
							value="<%= dc.getDevice_type() %>">
					</td>
				</tr>
				<tr>
					<th>Manufacturer</th>
					<td><input type="text" class="inputText" id="manufacturer" name="manufacturer" 
							value="<%= dc.getManufacturer() %>">
					</td>
				</tr>
				<tr>
					<th>Category</th>
					<td><input type="text" class="inputText" id="category" name="category" 
							value="<%= dc.getCategory() %>"></td>
				</tr>
			</table>

			<h2 style = "text-align: left;">Specific Metadata</h2>
			<input type="button" id="append_row" name="append_row" value="add_row">
			<table>
			<%
			for(int i = 0; i < ds.size(); i++){
			%>
				<tr>
					<td><input type='text' class="inputText" id='Dkey<%= i %>' name='Dkey<%= i %>' 
						value='<%= ds.getKey(i)%>'>
					</td>
				    <td><input type='text' class="inputText" id='Dvalue<%= i %>' name='Dvalue<%= i %>' 
				    	value='<%= ds.getValue(i)%>'>
				    </td>
					<td><input type='button' name='delspecific' class='delspecific' value='Delete'
						onclick='deleteRow(this)'/>
					</td>
				</tr>
				
			<%
			}
			%>
				<tbody id="AddOption">
			    		
			    </tbody>
			</table>
		</div>

		<input type='hidden' name='jsonData2'>
		<input type='hidden' name='Dsize'>

		<!-- 동적 테이블  -->
		<script type="text/javascript">
			
			var dsSize = <%=ds.size()%>
			ds_index = dsSize;
			//yform6.dsSize.value = dsSize; 
			
		    $('#append_row').click(function(){ //추가 기능
		
		        var contents = '<tr>';
		        contents += '<td><input type = "text" class="inputText" placeholder="metadata_key' + ds_index 
		        			+ '" id = "Dkey' + ds_index + '" name = "Dkey' + ds_index + '"/></td>';
				contents += '<td><input type = "text" class="inputText" placeholder="metadata_value' + ds_index 
							+ '" id = "Dvalue' + ds_index + '" name = "Dvalue' + ds_index + '"/></td>';
				
				//파라미터로 만들어 보내기 get, post 형식으로 ..
		        contents += '<td><input type="button" name="delRow" class="delRow" value="Delete"'
		        			+ 'onclick="deleteRow(this)"/></td>';
		        contents += '</tr>';
		        
		        ds_index++;
		        
		        $('#AddOption').append(contents); // 추가할 공간
		        
//		        $('.delRow').click(function(){ // 삭제기능
//		        	--key_index;
//					--value_index;
//		            $(this).parent().parent().remove(); 
//		        });
		       
		    });
		</script>

		<!-- specific 행 삭제-->
		<script type="text/javascript">
			function deleteRow(obj){
				 $(obj).parent().parent().remove();
			}
		</script>
		
		<!-- size 입력 받기  -->
		<script>
			$("#changeBtn").click(function() {
				myform6.Dsize.value = ds_index;
			});
		</script>

	</form>
	</div>
	</body>
</html>