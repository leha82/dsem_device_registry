<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.util.*, webmodules.*, structures.*" %>
<%
	int item_id = Integer.parseInt(request.getParameter("id"));

	DBManager dbm = new DBManager(application.getRealPath("/"));
	
	dbm.connect();
	
	ItemCommon ic = dbm.getItemCommon(item_id);
	ItemSpecific is = dbm.getItemSpecific(item_id);
	
	dbm.disconnect();

//	for(int i=0; i<is.size(); i++) {
//		System.out.println("group #" + (i+1) + " : " + is.getGroup(i));
//		System.out.println("key #" + (i+1) + " : " + is.getKey(i));
//		System.out.println("value #" + (i+1) + " : " + is.getValue(i));
//	}
%>

<!DOCTYPE html> 
<html>
<head>
	<!-- jQuery -->  
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js" 
		type="text/javascript"></script>
	<link rel="stylesheet" type="text/css" href = "../css/main.css">
	<script type="text/javascript">   
       	function goBack(){
       		window.history.back();
       	}
	</script>
   
	<title>Device metadata modification page</title>
</head>

<body>
	<header>
		<jsp:include page="partItemHeader.jsp" flush="false" />
	</header>
	<main>
		<div class="SubTitleBar">
			<h1>Item Modification</h1>
		</div>
		<h2>[<%=ic.getId()%>] <%=ic.getModel_name()%></h2>
		</div>
		<form name='formitemmodi' action="actionItemModification.jsp" method="POST">
		<div class="NarrowTable">
			<div class="SubMenuBar">
				<button class="SubMenuButton" type="submit" id="changeBtn">confirm</button>
				<button class="SubMenuButton" type="button" onclick="goBack();">back</button>
			</div>
			Common Information
			<table>
				<thead>
					<tr>
						<th style="width: 30%;">Attribute</th>
						<th style="width: 70%;">Value</th>
					</tr>
				</thead>
				<tr>
					<th>Item id</th>
					<td><input type="text" class="inputText" id="id" name="id" 
						value="<%=ic.getId()%>" readonly /></td>
				</tr>
				<tr>
					<th>Registration time</th>
					<td><input type="text" class="inputText" id="id" name="id" 
						value="<%=ic.getRegistration_time()%>" readonly /></td>
				</tr>
				<tr>
					<th>Model name</th>
					<td><input type="text" class="inputText" id="model_name" name="model_name"
							value="<%=ic.getModel_name()%>"></td>
				</tr>
				<tr>
					<th>Device type</th>
					<td><input type="text" class="inputText" id="device_type" name="device_type" 
							value="<%=ic.getDevice_type()%>"></td>
				</tr>
				<tr>
					<th>Manufacturer</th>
					<td><input type="text" class="inputText" id="manufacturer" name="manufacturer" 
							value="<%=ic.getManufacturer()%>"></td>
				</tr>
				<tr>
					<th>Category</th>
					<td><input type="text" class="inputText" id="category" name="category" 
							value="<%=ic.getCategory()%>"></td>
				</tr>
			</table>
	
			<h2 style = "text-align: left;">Specific Information</h2>
			<table>
				<thead>
					<th>No</th>
					<th>Group</th>
					<th style="width:50%;">Key</th>
					<th style="width:50%;">Value</th>
					<th>
						<input type="button" id="append_row" value="add">
					</th>
				</thead>
			<%
			for(int i = 0; i < is.size(); i++){
			%>
				<tr>
					<td><input type='text' class="inputText" name='Dseq<%=i%>' 
						value='<%=i+1%>'></td>
					<td><input type='text' class="inputText" name='Dgroup<%=i%>' 
						value='<%=is.getGroup(i)%>'></td>
					<td><input type='text' class="inputText" name='Dkey<%=i%>'
						value='<%=is.getKey(i)%>'></td>
				    <td><input type='text' class="inputText" name='Dvalue<%=i%>' 
				    	value='<%= is.getValue(i)%>'></td>
					<td><input type='button' value='delete' onclick='deleteRow(this)'/></td>
				</tr>
				
			<%
			}
			%>
				<tbody id="AddOption">
			    </tbody>
			</table>
		</div>
		
		<input type='hidden' name='isSize'>
		
		<script type="text/javascript">
			var isSize = <%=is.size()+1%>			
			is_index = isSize-1;
			
		    $('#append_row').click(function(){ 
		        var contents = '<tr>';
		        contents += '<td><input type = "text" class="inputText" placeholder="no' + (is_index+1)
							+ '" name = "Dseq' + is_index + '"/></td>';
		        contents += '<td><input type = "text" class="inputText" placeholder="group' + (is_index+1)
    						+ '" name = "Dgroup' + is_index + '"/></td>';
		        contents += '<td><input type = "text" class="inputText" placeholder="key' + (is_index+1) 
		        			+ '" name = "Dkey' + is_index + '"/></td>';
				contents += '<td><input type = "text" class="inputText" placeholder="value' + (is_index+1)
							+ '" name = "Dvalue' + is_index + '"/></td>';
		        contents += '<td><input type="button" value="delete" onclick="deleteRow(this)"/></td>';
		        contents += '</tr>';
		        
		        is_index++;
		        $('#AddOption').append(contents); 
		    });
		
			function deleteRow(obj){
				 $(obj).parent().parent().remove();
			}

			$("#changeBtn").click(function() {
				formitemmodi.isSize.value = is_index;
			});
		</script>
	
	</form>
	</main>
</body>
</html>