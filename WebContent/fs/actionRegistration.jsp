<%@page import="org.apache.jasper.tagplugins.jstl.core.Catch"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.* , java.util.*"%>
<%//actionRegistration.jsp %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style>
  table {
    width:20%;
    border: 1px solid #444444;
    border-collapse: collapse;
  }
  th, td {
    border: 1px solid #444444;
    padding: 5px;
  }
 
</style>
<style>
	p{width:1700px;height:60px;background:orange;list-style:none;padding-top:15px}
		p{float:center;margin-right:10px}					
	p{font-size:20px;color:black;font-weight:bold;text-decoration:none}	
</style>
<script
	src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js"
	type="text/javascript"></script>
<script type="text/javascript">   
        function check(no){
        	if (no == 1){
        	document.myform.action = "DbJson.jsp";
        	}
        	else if (no == 2){
        		document.myform.action = "db2.jsp";
        	}
        	else if (no == 3){
        		document.myform.action = "db3.jsp";
        	}
        	else if (no == 4){
        		document.myform.action = "db4.jsp";
            	}
        	else{
        	return;
        	}
        	document.myform.submit();
        	}
    </script>
     <script type="text/javascript">   
        function goBack(){
        window.history.back();
        	}
        window.location.replace("deviceList.jsp");
    </script>
</head>
<body>
 <form name='myform' action="db2.jsp" method="post">
<center>
<p>디바이스 등록 페이지<br>
		<button  type="button" class="back" onclick="check(1)">재등록</button>
		<button type="button" onclick="goBack();">뒤로가기</button>
		<button type="button" onclick="location.href='DbSelect.jsp'">디바이스 목록 보기</button></p>
	</center>
	</form>
</body>
</html>
<%
request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("usrid1");
	Timestamp now_timestamp = new Timestamp(System.currentTimeMillis());
	String dv = request.getParameter("dv1");
	String manufacturer = request.getParameter("manufac1");
	String cate = request.getParameter("cate1");
  	Connection conn=null;
 	PreparedStatement pstmt = null;
 	String str="";
  try{
     
        String jdbcUrl= "jdbc:mysql://localhost:3306/jsptest" ;
        String dbId="jspid";
        String dbPass= "jsppass";
 
        Class.forName( "com.mysql.jdbc.Driver");
        conn=DriverManager.getConnection(jdbcUrl,dbId ,dbPass );
        
        String sql = "insert into device_register_table (id, registration_time, device_type, manufacturer, category) values (?,?,?,?,?)";
        pstmt = conn.prepareStatement(sql);
        
        pstmt.setString(1, id);
        pstmt.setTimestamp(2, now_timestamp);
        pstmt.setString(3, dv);
        pstmt.setString(4, manufacturer);
        pstmt.setString(5, cate);
        
        pstmt.executeUpdate();
        
           out.println("----------------------------------->>> 디바이스 등록 완료");
        
  }catch(Exception e){
           e.printStackTrace();
           out.println("----------------------------------->>> 디바이스 등록 실패");
  }finally{ //리소스 해제
	  if(pstmt != null)
		  try{
			  pstmt.close();
		  }catch(SQLException sqle){}
  	if(conn != null){
  		try{
  			conn.close();
  		}catch(SQLException sqle){}
  	}
  }
%>