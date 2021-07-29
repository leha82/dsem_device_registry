package webmodules.json;

import java.sql.*;
import java.util.*;
import structures.json.*;

public class DBManager {
	public static String DB_DRIVERCLASS = "com.mysql.jdbc.Driver";
	public static String DEFAULT_IP = "localhost";
	public static String DEFAULT_DATABASE = "jsptest";
	public static String DEFAULT_ID = "jspid";
	public static String DEFAULT_PW = "jsppass";

	public Connection conn;
	public String jdbcDriver; 
	public String dbUser;
	public String dbPwd;

	public DBManager() {
		this.conn = null;
		
		this.dbUser = DBManager.DEFAULT_ID;
		this.dbPwd = DBManager.DEFAULT_PW;
		this.jdbcDriver = "jdbc:mysql://" + DBManager.DEFAULT_IP + ":3306/" 
				+ DBManager.DEFAULT_DATABASE + "?useUnicode=true&characterEncoding=utf8";

	}

	public boolean connect() {
		try {
			Class.forName(DBManager.DB_DRIVERCLASS);
			conn = DriverManager.getConnection(this.jdbcDriver, this.dbUser, this.dbPwd);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return false;
		}
		return true;
	}
	
	public boolean disconnect() {
		try {
			
			conn.close();
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return false;
		}
		return true;
	}

	public ArrayList<DeviceCommon> getDeviceList() {
		ArrayList<DeviceCommon> devList = new ArrayList<DeviceCommon>(); 
		try {
			ResultSet rs = null;
			String sql = "select id, registration_time, device_type, manufacturer,"
						+ "category from device_register_table";
			PreparedStatement pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();
			while (rs.next()) {
				DeviceCommon dc = new DeviceCommon();
				dc.setId(rs.getString(1));
				dc.setregistration_time(rs.getString(2));
				dc.setDevice_type(rs.getString(3));
				dc.setManufacturer(rs.getString(4));
				dc.setCategory(rs.getString(5));
				
				System.out.println(dc.toString());
				
				devList.add(dc);
			}
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return devList;
	}
	
	public DeviceCommon getDeviceCommon(String device_id) {
		DeviceCommon dc = new DeviceCommon(); 
		try {
			ResultSet rs = null;
			String sql = "select id, registration_time, device_type, manufacturer,"
						+ "category from device_register_table"
						+ " where id = '" + device_id + "';";
			
			System.out.println(sql);
			
			PreparedStatement pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();
			while (rs.next()) {
				dc.setId(rs.getString(1));
				dc.setregistration_time(rs.getString(2));
				dc.setDevice_type(rs.getString(3));
				dc.setManufacturer(rs.getString(4));
				dc.setCategory(rs.getString(5));
				System.out.println(dc.toString());
			}
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return dc;
	}
	
}