<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%//deviceRegistration.jsp %>
<!DOCTYPE html>
<html>
<head>
<style>
  h1 {
  	  border-collapse: collapse;
  }
  table {
    width:600px;
	border: 1px solid #444444;
	border-collapse: collapse;
	margin: 5px;
  }
  th, td {
	width: 50%;
	border: 1px solid #444444;
	padding: 5px;	
  }
  .MainContent{
  	position: absolute; left: 50%;
  	width: 1024px; margin-left: -512px;
  	text-align:center;
  }
  .MenuBar{
  	width:100%; height:100%; background:orange;
  	float:center; padding:15px;
  	font-size:20px; color:black; font-weight:bold; text-decoration:none;
  	text-align:center;
  }
  .InputText{
  	width: 95%;
  	text-align : center;
  }
  
</style>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js"
	type="text/javascript"></script>
<script type="text/javascript">
	function check(no) {
		if (myform.model1.value == "" || myform.dv1.value == ""
				|| myform.manufac1.value == "" ) {
			alert("값을 입력해 주세요");
			myform.model1.focus();
			myform.dv1.focus();
			myform.manufac1.focus();
	
			return false;
		}
		if (no == 1) {
			document.myform.action = "actionRegistration.jsp";
		} else if (no == 2) {
			document.myform.action = "test2.jsp";
		} else if (no == 3) {
			document.myform.action = "db3.jsp";
		} else if (no == 4) {
			document.myform.action = "db4.jsp";
		} else {
			return;
		}
		document.myform.submit();
	}
</script>
 <script type="text/javascript">   
        function goBack(){
        window.history.back();
        	}
    </script>
    <title>Deivce Register</title>
</head>
<body>
<div class="MainContent">
	<form name='myform' action="DbSelect.jsp" method="post">
	<div class="MenuBar">
			<h1>Device Register</h1>
			<button  type="button" class="back" onclick="goBack();">뒤로가기</button></p>
	</div>
	<br><br>
		<table id="example" border="3px" style="margin-left: auto; margin-right: auto;">
			
			<tr>
				<th>Model name</th>
				<td><input type="text" class="InputText" name="model1" placeholder="입력" style="width:300px;height:30px;" /></td>
			</tr>
			<tr>
				<th>Device type</th>
				<td><input type="text" class="InputText" name="dv1" placeholder="입력" style="width:300px;height:30px;" /></td>
			</tr>
			<tr>
				<th>Manufacturer</th>
				<td><input type="text" class="InputText" name="manufac1" placeholder="입력" style="width:300px;height:30px;" />
			</tr>
			
			<tr>
				<th>Category</th>
				<td><input type="text" class="InputText" name="cate1" placeholder="입력" style="width:300px;height:30px;" />
			</tr>
			
			<tr>
				<th>등록</th>
				<td><button type="button" onclick="check(1)"style="width:304px;height:30px;">등록</button></td>
			</tr>
	
				</table>
			</form>
		</div>
	</body>
</html>