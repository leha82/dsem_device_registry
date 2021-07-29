package webmodules.mysql;

import java.sql.*;
import java.util.*;
import structures.mysql.*;
import java.io.*;
import org.json.simple.*;
import org.json.simple.parser.*;

public class DBManager {
	public String configFilename = "config.json";

	public String dbDriverClass = "com.mysql.cj.jdbc.Driver";
	public String jdbcDriver; 

	public String dbIP;
	public int dbPort;
	public String dbID;
	public String dbPW;
	public String dbnameRegistry;
	public String dbnameMeasurement;
	public String tblGlobal;
	public String tblSpecific;
	public String tblDevice;
	
	public Connection conn;
	
	public DBManager(String configPath) {
		String filename = configPath + configFilename;
//		System.out.println(filename);
		setConfig(filename);
		
		conn = null;
		jdbcDriver = "jdbc:mysql://" + dbIP + ":" + dbPort + "/" 
				+ dbnameRegistry + "?useUnicode=true&characterEncoding=utf8";
		
	}

	public void setConfig(String configfile) {
	    JSONParser parser = new JSONParser();
		JSONObject jsonObject; 
	    
		try {
			jsonObject = (JSONObject) parser.parse(new FileReader(configfile));
			
			dbIP = (String) jsonObject.get("DB_IP");
			dbPort = Integer.parseInt((String)jsonObject.get("DB_PORT"));
			dbID = (String) jsonObject.get("DB_ID");
			dbPW = (String) jsonObject.get("DB_PW");
			dbnameRegistry = (String) jsonObject.get("DB_REGISTRY_DB");
			dbnameMeasurement = (String) jsonObject.get("DB_MEASUREMENT_DB");
			tblGlobal = (String) jsonObject.get("DB_GLOBAL_TABLE");
			tblSpecific = (String) jsonObject.get("DB_SPECIFIC_TABLE");
			tblDevice = (String) jsonObject.get("DB_DEVICE_TABLE");
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
	}
	
	
	public boolean connect() {
		try {
			Class.forName(dbDriverClass);
			conn = DriverManager.getConnection(jdbcDriver, dbID, dbPW);
			
		} catch (Exception e) {
			System.out.println(e.getMessage());
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
			e.printStackTrace();
			return false;
		}
		return true;
	}
	
	public void insertGlobalList(DeviceCommon dc) {
		try {
			String sql = "INSERT INTO " + tblGlobal 
						+ " (item_id, model_name, registration_time, device_type, manufacturer, category)"
						+ " VALUES (?,?,?,?,?,?)";
			
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
			String sql = "SELECT item_id, model_name, registration_time, device_type, manufacturer, category"
						+ " FROM " + tblGlobal;
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
			String sql = "DELETE FROM " + tblGlobal + " WHERE item_id=?";
			PreparedStatement pstmt = null;
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, item_id);
			pstmt.executeUpdate();
		} 
		catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public void deleteSpecificTable(int item_id) {
		try {
			String sql = "DELETE FROM " + tblSpecific + " WHERE item_id=?";
			PreparedStatement pstmt = null;
			pstmt = conn.prepareStatement(sql);
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
			String sql = "SELECT device_id, item_id, system_id, device_name, table_name, deployment_time,"
						+ " deployment_location, latitude, longitude "
						+ " FROM " + tblDevice;
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
			String sql = "SELECT item_id, model_name, registration_time, device_type, manufacturer, category"
						+ " FROM " + tblGlobal
						+ " WHERE item_id = '" + item_id + "';";
			
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
			String sql = "SELECT device_id, item_id, system_id, device_name, table_name, "
					+ "deployment_time, deployment_location, latitude, longitude"
					+ " FROM " + tblDevice 
					+ " WHERE device_id = " + device_id;

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
			
			sql = "SELECT model_name"
					+ " FROM " + tblGlobal  
					+ " WHERE item_id = " + di.getitem_id();

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
			String sql = "SELECT device_id, item_id, system_id, device_name, table_name,"
						+ " deployment_time, deployment_location, latitude, longitude"
						+ " FROM " + tblDevice 
						+ " WHERE device_id = '" + device_id + "';";
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
			String sql = "INSERT INTO " + tblSpecific 
						+ " (item_id, metadata_key, metadata_value)"
						+ " VALUES (?,?,?)"
						+ " ON DUPLICATE KEY UPDATE item_id=?, metadata_key=?, metadata_value=?";
			
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
			String sql = "SELECT item_id, metadata_key, metadata_value"
						+ " FROM " + tblSpecific
						+ " WHERE item_id = '" + item_id + "';";
			
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
			String sql = "SELECT device_id " 
						+ " FROM " + tblDevice 
						+ " ORDER BY device_id DESC LIMIT 1;";
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
			String sql = "UPDATE " + tblGlobal 
						+ " SET model_name=?, device_type=?, manufacturer=?, category=?"
						+ " WHERE item_id=?";
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
			String sql = "UPDATE " + tblDevice 
						+ " SET item_id=?, system_id=?, device_name=?, deployment_time=?, "
						+ "deployment_location=?, latitude=?, longitude=?"
						+ " WHERE device_id=?";
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
			String sql = "UPDATE " + tblDevice 
						+ " SET table_name=?"
						+ " WHERE device_id=?";
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
			String sql = "INSERT INTO " + tblDevice 
						+ " (item_id, system_id, device_name, table_name, deployment_time,"
						+ " deployment_location, latitude, longitude)"
						+ " VALUES (?,?,?,?,?,?,?,?)";
			
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
			String sql = "DELETE FROM " + tblDevice 
						+ " WHERE device_id=?";
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
			// get sensor spec from specific_metadata
			String select_sql = "SELECT * FROM " + tblSpecific
						+ " WHERE item_id = " + item_id
						+ " AND (metadata_key LIKE 'sensor-%')";

			PreparedStatement pstmt = conn.prepareStatement(select_sql);
			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {
				String key = rs.getString("metadata_value");
				keyList.add(key);
			}
		
			String select_sql2 = "SELECT * FROM " + tblSpecific
					+ " WHERE item_id = " + item_id
					+ " AND (metadata_key LIKE 'actuator-%')";

			PreparedStatement pstmt2 = conn.prepareStatement(select_sql2);
			ResultSet rs2 = pstmt2.executeQuery();
		
			while (rs2.next()) {
			String key = rs2.getString("metadata_value");
			keyList.add(key);
			}

			// create measurement table
			String createSql = "CREATE TABLE " + dbnameMeasurement + "." + table_Name 
						+ " (" + "id INT AUTO_INCREMENT, timestamp DATETIME," 
						+ " PRIMARY KEY(id))";
			Statement stmt = this.conn.createStatement();
			stmt.execute(createSql);

			for (int j = 0; j < keyList.size(); j++) {
				String alterSql = "ALTER TABLE " + dbnameMeasurement + "." + table_Name 
							+ " ADD " + keyList.get(j) + " varchar(200)";
				stmt.execute(alterSql);
			}
		}

		catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	// delete measurement table
	public void deleteMeasurementTable(String table_name) {
		try {
			String deleteSql = "DROP TABLE " + dbnameMeasurement + "." + table_name;

			Statement stmt = this.conn.createStatement();
			stmt.executeUpdate(deleteSql);
			System.out.println(table_name + " Table delete");
		} 
		catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	
}
