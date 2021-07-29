<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@page import="java.io.*, java.util.*, structures.json.*, webmodules.json.*"%>
<%//actionModification.jsp %>
<%
	request.setCharacterEncoding("UTF-8");
	String id = (String)request.getParameter("id");
	System.out.println(id);
	String device_type = (String)request.getParameter("device_type");
	String manufacturer = (String)request.getParameter("manufacturer");
	String category = (String)request.getParameter("category");
	Connection conn = null;
	PreparedStatement pstmt = null;
	Class.forName("com.mysql.jdbc.Driver");
	try{
	String jdbcDriver = "jdbc:mysql://localhost:3306/jsptest?"+"useUnicode=true&characterEncoding=euckr";
	String dbUser = "jspid";
	String dbPass = "jsppass";
	conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
	pstmt = conn.prepareStatement("update device_register_table set device_type=?, manufacturer=?, category=? where id=?");
	pstmt.setString(1, device_type);
	pstmt.setString(2, manufacturer);
	pstmt.setString(3, category);
	pstmt.setString(4, id);
	pstmt.executeUpdate();
	//pstmt.setString(5, time);
	}finally{
		if (pstmt != null) try { pstmt.close(); } catch(SQLException ex) {}
		if (conn != null) try { conn.close(); } catch(SQLException ex) {}
	 	}
	%>
	
	<%
	ArrayList<String> new_keylist = new ArrayList<String>();
	ArrayList<String> new_valuelist = new ArrayList<String>();
	
	String DSize = request.getParameter("Dsize"); //ID 값을 제외한 JSON 객체 수 
	String key [] = new String [Integer.valueOf(DSize)];
	String value [] = new String [Integer.valueOf(DSize)];
	System.out.println("size test = " + DSize);
	
	for(int i = 0; i < Integer.valueOf(DSize); i++){
		String mdkey = request.getParameter("Dkey" + i);
		String mdvalue =  request.getParameter("Dvalue" + i);
		
		System.out.print(i + " - key : " + mdkey + " |  value : " + mdvalue);
		
		if ( !(mdkey=="" || mdkey==null 
			|| mdvalue == "" || mdvalue==null)) {
			if (!(mdkey.equals("null") && mdvalue.equals("null"))) {
				new_keylist.add(mdkey);
				new_valuelist.add(mdvalue);
				
				System.out.print("  added");	
			}
		}
//		key [i] = request.getParameter("Dkey" + i);
//		value [i]= request.getParameter("Dvalue" + i);
//		new_keylist.add(key[i]);
//		new_valuelist.add(value[i]);
		
		System.out.println();
	}
	
	DeviceSpecific new_ds = new DeviceSpecific();
	new_ds.setId(id);
	new_ds.setKeyList(new_keylist);
	new_ds.setValueList(new_valuelist);
	
	JsonManager jm = new JsonManager();
	jm.replaceJSONFile(new_ds);
	
	request.setCharacterEncoding("UTF-8");
	//d
%>

<html>
<head>
<script type="text/javascript">   
		function goBack(){
			window.history.back();
		}
		window.location.replace("deviceDetail.jsp?id=<%= id %> ");
	</script>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Device metadata modification page</title>
</head>
<body>
수정 데이터 저장 페이지
</body>
</html>