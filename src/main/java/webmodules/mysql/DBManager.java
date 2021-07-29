package webmodules.mysql;

import java.sql.*;
import java.util.*;
import structures.mysql.*;

public class DBManager {
	public static String DB_DRIVERCLASS = "com.mysql.jdbc.Driver";
//	public static String DEFAULT_IP = "203.234.62.115";
	public static String DEFAULT_IP = "220.68.27.113";
	public static int DEFAULT_PORT = 23306;
	public static String DEFAULT_DATABASE = "DeviceRegistry";
	public static String DEFAULT_ID = "dsem_iot";
	public static String DEFAULT_PW = "dsem_iot";

	public Connection conn;
	public String jdbcDriver; 
	public String dbUser;
	public String dbPwd;
	public String global_table = "DeviceRegistry.global_metadata";
	public String specific_table = "DeviceRegistry.specific_metadata";
	public String devicelist_table = "DeviceRegistry.device_list";
	public String devicemeasurement_db = "Measurement";
	
	public DBManager() {
		this.conn = null;
		this.dbUser = DBManager.DEFAULT_ID;
		this.dbPwd = DBManager.DEFAULT_PW;
		this.jdbcDriver = "jdbc:mysql://" + DBManager.DEFAULT_IP + ":" + DEFAULT_PORT + "/" 
				+ DBManager.DEFAULT_DATABASE + "?useUnicode=true&characterEncoding=utf8";
		
	}

	public boolean connect() {
		try {
			Class.forName(DBManager.DB_DRIVERCLASS);
			conn = DriverManager.getConnection(this.jdbcDriver, this.dbUser, this.dbPwd);
			
		} catch (Exception e) {
			e.printStackTrace();
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
	
	public void insertGlobalList(DeviceCommon dc) {
		try {
//			String sql = "insert into deviceregistry.global_metadata (item_id, model_name, registration_time,"
			String sql = "insert into global_metadata (item_id, model_name, registration_time,"
						+ " device_type, manufacturer, category)"
						+ " values (?,?,?,?,?,?)";
			
			PreparedStatement pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, dc.getId());
			pstmt.setString(2, dc.getmodel_name());
			pstmt.setTimestamp(3, dc.getregistration_time());
			pstmt.setString(4, dc.getDevice_type());
			pstmt.setString(5, dc.getManufacturer());
			pstmt.setString(6, dc.getCategory());

			pstmt.executeUpdate();

			System.out.println("----------------------------------->>> Device Registration Success");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("----------------------------------->>> Device Registration Failure");
		}
	}
	
	public ArrayList<DeviceCommon> getGlobalList() {
		ArrayList<DeviceCommon> devList = new ArrayList<DeviceCommon>(); 
		try {
			ResultSet rs = null;
			String sql = "select item_id, model_name, registration_time, device_type, manufacturer, category"
						+ " from " + global_table;
			PreparedStatement pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();
			while (rs.next()) {
				DeviceCommon dc = new DeviceCommon();
				dc.setId(rs.getInt(1));
				dc.setmodel_name(rs.getString(2));
				dc.setregistration_time(rs.getTimestamp(3));
				dc.setDevice_type(rs.getString(4));
				dc.setManufacturer(rs.getString(5));
				dc.setCategory(rs.getString(6));
				
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
	
	public void deleteGlobalTable(int item_id) {
		try {
			PreparedStatement pstmt = null;
			pstmt = conn.prepareStatement("DELETE FROM deviceregistry.global_metadata WHERE item_id=?");
			pstmt.setInt(1, item_id);
			pstmt.executeUpdate();
		} 
		catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public void deleteSpecificTable(int item_id) {
		try {
			PreparedStatement pstmt = null;
			pstmt = conn.prepareStatement("DELETE FROM deviceregistry.specific_metadata WHERE item_id=?");
			pstmt.setInt(1, item_id);
			pstmt.executeUpdate();
		} 
		catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public ArrayList<DeviceInfo> getDeviceInfo() {
		ArrayList<DeviceInfo> devList = new ArrayList<DeviceInfo>(); 
		try {
			ResultSet rs = null;
			String sql = "select device_id, item_id, system_id, device_name, table_name, deployment_time,"
						+ " deployment_location, latitude, longitude "
						+ " from " + devicelist_table;
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				DeviceInfo di = new DeviceInfo();
				di.setdevice_id(rs.getInt(1));
				di.setitem_id(rs.getInt(2));
				di.setsystem_id(rs.getString(3));
				di.setdevice_name(rs.getString(4));
				di.settable_name(rs.getString(5));
				di.setdeployment_time(rs.getString(6));
				di.setdeployment_location(rs.getString(7));
				di.setlatitude(rs.getString(8));
				di.setlongitude(rs.getString(9));
				System.out.println(di.toString());
				
				devList.add(di);
			}
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return devList;
	}
	
	public DeviceCommon getDeviceCommon(int item_id) {
		DeviceCommon dc = new DeviceCommon(); 
		try {
			ResultSet rs = null;
			String sql = "select item_id, model_name, registration_time, device_type, manufacturer, category"
						+ " from " + global_table
						+ " where item_id = '" + item_id + "';";
			
			System.out.println(sql);
			
			PreparedStatement pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();
			while (rs.next()) {
				dc.setId(rs.getInt(1));
				dc.setmodel_name(rs.getString(2));
				dc.setregistration_time(rs.getTimestamp(3));
				dc.setDevice_type(rs.getString(4));
				dc.setManufacturer(rs.getString(5));
				dc.setCategory(rs.getString(6));
				System.out.println(dc.toString());
			}
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return dc;
	}
	
	public DeviceInfo getDeviceInfo(int device_id){
		DeviceInfo di = new DeviceInfo(); 
		try {
			String sql = "select device_id, item_id, system_id, device_name, table_name, "
					+ "deployment_time, deployment_location, latitude, longitude "
					+ "from " + devicelist_table + " " 
					+ "where device_id = " + device_id;

			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {
				di.setdevice_id(rs.getInt(1));
				di.setitem_id(rs.getInt(2));
				di.setsystem_id(rs.getString(3));
				di.setdevice_name(rs.getString(4));
				di.settable_name(rs.getString(5));
				di.setdeployment_time(rs.getString(6));
				di.setdeployment_location(rs.getString(7));
				di.setlatitude(rs.getString(8));
				di.setlongitude(rs.getString(9));
			}
			
			sql = "select model_name "
					+ "from " + global_table + " " 
					+ "where item_id = " + di.getitem_id();

			rs = stmt.executeQuery(sql);

			while (rs.next()) {
				di.setItem_name(rs.getNString(1));
			}
			
			System.out.println(di.toString());
			
			rs.close();
			stmt.close();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return di;
	}
	public DeviceInfo getModifyDeviceIdList(int device_id){
		DeviceInfo dl = new DeviceInfo(); 
		try {
			ResultSet rs = null;
			String sql = "select device_id, item_id, system_id, device_name, table_name,"
						+ " deployment_time, deployment_location, latitude, longitude"
						+ " from " + devicelist_table 
						+ " where device_id = '" + device_id + "';";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				dl.setdevice_id(rs.getInt(1));
				dl.setitem_id(rs.getInt(2));
				dl.setsystem_id(rs.getString(3));
				dl.setdevice_name(rs.getString(4));
				dl.settable_name(rs.getString(5));
				dl.setdeployment_time(rs.getString(6));
				dl.setdeployment_location(rs.getString(7));
				dl.setlatitude(rs.getString(8));
				dl.setlongitude(rs.getString(9));
				System.out.println(dl.toString());
			}
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return dl;
	}
	public void insertSpecificList(int id, ArrayList<String> keyList, ArrayList<String> valueList) {
		try {
			String sql = "insert into specific_metadata (item_id, metadata_key, metadata_value) values (?,?,?) ON DUPLICATE KEY UPDATE item_id=?, metadata_key=?, metadata_value=?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
		     for(int i = 0; i < keyList.size();i++){
		    	 pstmt.setInt(1, id);
		    	 pstmt.setString(2, keyList.get(i));
		    	 pstmt.setString(3, valueList.get(i));
		    	 pstmt.setInt(4, id);
		    	 pstmt.setString(5, keyList.get(i));
		    	 pstmt.setString(6, valueList.get(i));
		    	 pstmt.executeUpdate();    		 
		     }
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}
		
	public DeviceSpecific getDeviceSpecific(int item_id) {
		DeviceSpecific ds = new DeviceSpecific(); 
		try {
			ResultSet rs = null;
			String sql = "select item_id, metadata_key, metadata_value"
						+ " from " + specific_table
						+ " where item_id = '" + item_id + "';";
			
			System.out.println(sql);
			
			PreparedStatement pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				ds.setId(rs.getInt(1));
				ds.add(rs.getString(2), rs.getString(3));
			}
			
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return ds;
	}

	public int getLastDeviceId() {
		int device_id = 0;
		try {
			String sql = "select device_id " + " from " + devicelist_table 
						+ " order by device_id desc limit 1;";
			System.out.println(sql);
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {
				device_id = rs.getInt(1);
			}

			rs.close();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return device_id;
	}
	
	public void updateGlobalList(DeviceCommon dc) {
		try {
			String sql = "update global_metadata set model_name=?, device_type=?, manufacturer=?, category=? where item_id=?";
			PreparedStatement pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, dc.getmodel_name());
			pstmt.setString(2, dc.getDevice_type());
			pstmt.setString(3, dc.getManufacturer());
			pstmt.setString(4, dc.getCategory());
			pstmt.setInt(5, dc.getId());
			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}
	
	public void updateDeviceList(DeviceInfo di) {
		try {
			String sql = "update deviceregistry.device_list set item_id=?, system_id=?, device_name=?, deployment_time=?, deployment_location=?, latitude=?, longitude=? where device_id=?";
			PreparedStatement pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, di.getitem_id());
			pstmt.setString(2, di.getsystem_id());
			pstmt.setString(3, di.getdevice_name());
			pstmt.setString(4, di.getdeployment_time());
			pstmt.setString(5, di.getdeployment_location());
			pstmt.setString(6, di.getlatitude());
			pstmt.setString(7, di.getlongitude());
			pstmt.setInt(8, di.getdevice_id());
			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}
	
	public void updateDeviceTableName(int device_id, String table_name) {
		try {
			String sql = "update deviceregistry.device_list set table_name=? where device_id=?";
			PreparedStatement pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, table_name);
			pstmt.setInt(2, device_id);
			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}
	
	public void insertDeviceList(DeviceInfo di) {
		try {
			String sql = "insert into deviceregistry.device_list (item_id, system_id, device_name,"
						+ " table_name, deployment_time, deployment_location, latitude, longitude)"
						+ " values (?,?,?,?,?,?,?,?)";
			
			PreparedStatement pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, di.getitem_id());
			pstmt.setString(2, di.getsystem_id());
			pstmt.setString(3, di.getdevice_name());
			pstmt.setString(4, di.gettable_name());
			pstmt.setString(5, di.getdeployment_time());
			pstmt.setString(6, di.getdeployment_location());
			pstmt.setString(7, di.getlatitude());
			pstmt.setString(8, di.getlongitude());

			pstmt.executeUpdate();

			System.out.println("----------------------------------->>> Device Registration Success");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("----------------------------------->>> Device Registration Failure");
		}
	}

	public void deleteDevice(int device_id) {
		try {
			String sql = "delete from " + devicelist_table 
					+ " where device_id=?";
			System.out.println(sql);

			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, device_id);
			pstmt.executeUpdate();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}
	
	public void createMeasurementTable(int item_id, String table_Name) {
		ArrayList<String> keyList = new ArrayList<String>();

		try {
			// specific_metadata 컬럼 받아오기
			String select_sql = "select * from " + specific_table
						+ " where item_id = " + item_id
						+ " and (metadata_key like 'sensor-%')";

			PreparedStatement pstmt = conn.prepareStatement(select_sql);
			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {
				String key = rs.getString("metadata_value");
				keyList.add(key);
			}
		
			String select_sql2 = "select * from " + specific_table
					+ " where item_id = " + item_id
					+ " and (metadata_key like 'actuator-%')";

			PreparedStatement pstmt2 = conn.prepareStatement(select_sql2);
			ResultSet rs2 = pstmt2.executeQuery();
		
			while (rs2.next()) {
			String key = rs2.getString("metadata_value");
			keyList.add(key);
			}

			// 테이블 생성
			String createSql = "create table " + devicemeasurement_db + "." + table_Name 
						+ " (" + "id int auto_increment, timestamp datetime," 
						+ " primary key(id))";
			Statement stmt = this.conn.createStatement();
			stmt.execute(createSql);

			for (int j = 0; j < keyList.size(); j++) {
				String alterSql = "alter table " + devicemeasurement_db + "." + table_Name 
							+ " add " + keyList.get(j) + " varchar(200)";
				stmt.execute(alterSql);
			}
		}

		catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	// 테이블 삭제
	public void deleteMeasurementTable(String table_name) {
		try {
			String deleteSql = "drop table devicemeasurement." + table_name;

			Statement stmt = this.conn.createStatement();
			stmt.executeUpdate(deleteSql);
			System.out.println(table_name + " Table delete");
		} 
		catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	
}
