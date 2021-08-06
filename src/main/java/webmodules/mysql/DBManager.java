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
	public String tblCommon;
	public String tblSpecific;
	public String tblDevice;
	public String mdSensor;
	public String mdActuator;
	
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
			dbnameRegistry = (String) jsonObject.get("DBN_DEVICE_REGISTRY");
			dbnameMeasurement = (String) jsonObject.get("DBN_DEVICE_MEASUREMENT");
			tblCommon = (String) jsonObject.get("TABLE_COMMON");
			tblSpecific = (String) jsonObject.get("TABLE_SPECIFIC");
			tblDevice = (String) jsonObject.get("TABLE_DEVICE");
			mdSensor = (String) jsonObject.get("METADATA_SENSOR");
			mdActuator = (String) jsonObject.get("METADATA_ACTUATOR");
			
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
	
	
	// About Global metadata
	public void insertItemCommon(ItemCommon ic) {
		try {
			String sql = "INSERT INTO " + tblCommon 
						+ " (item_id, model_name, registration_time, device_type, manufacturer, category)"
						+ " VALUES (?,?,now(),?,?,?)";
			
			PreparedStatement pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, ic.getId());
			pstmt.setString(2, ic.getModel_name());
			pstmt.setString(3, ic.getDevice_type());
			pstmt.setString(4, ic.getManufacturer());
			pstmt.setString(5, ic.getCategory());

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public ArrayList<ItemCommon> getList_ItemCommon() {
		ArrayList<ItemCommon> iclist = new ArrayList<ItemCommon>(); 
		try {
			ResultSet rs = null;
			String sql = "SELECT item_id, model_name, registration_time, device_type, manufacturer, category"
						+ " FROM " + tblCommon;
			PreparedStatement pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();
			while (rs.next()) {
				ItemCommon ic = new ItemCommon();
				ic.setId(rs.getInt(1));
				ic.setModel_name(rs.getString(2));
				ic.setRegistration_time(rs.getString(3));
				ic.setDevice_type(rs.getString(4));
				ic.setManufacturer(rs.getString(5));
				ic.setCategory(rs.getString(6));
				
//				System.out.println(ic.toString());
				
				iclist.add(ic);
			}
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return iclist;
	}
	
	public ItemCommon getItemCommon(int item_id) {
		ItemCommon ic = new ItemCommon(); 
		try {
			ResultSet rs = null;
			String sql = "SELECT item_id, model_name, registration_time, device_type, manufacturer, category"
						+ " FROM " + tblCommon
						+ " WHERE item_id = '" + item_id + "';";
			
			PreparedStatement pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();
			while (rs.next()) {
				ic.setId(rs.getInt(1));
				ic.setModel_name(rs.getString(2));
				ic.setRegistration_time(rs.getString(3));
				ic.setDevice_type(rs.getString(4));
				ic.setManufacturer(rs.getString(5));
				ic.setCategory(rs.getString(6));
//				System.out.println(ic.toString());
			}
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return ic;
	}

	public void updateItemCommon(ItemCommon ic) {
		try {
			String sql = "UPDATE " + tblCommon 
						+ " SET model_name=?, device_type=?, manufacturer=?, category=?"
						+ " WHERE item_id=?";
			PreparedStatement pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, ic.getModel_name());
			pstmt.setString(2, ic.getDevice_type());
			pstmt.setString(3, ic.getManufacturer());
			pstmt.setString(4, ic.getCategory());
			pstmt.setInt(5, ic.getId());
			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}
	
	public void deleteItemCommon(int item_id) {
		try {
			String sql = "DELETE FROM " + tblCommon + " WHERE item_id=?";
			PreparedStatement pstmt = null;
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, item_id);
			pstmt.executeUpdate();
		} 
		catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	// about Specific Metadata
	
	public void insertItemSpecific(int item_id, ArrayList<String> groupList, ArrayList<String> keyList, ArrayList<String> valueList) {
		try {
			String sql = "INSERT INTO " + tblSpecific 
						+ " (item_id, md_group, md_key, md_value, sequence)"
						+ " VALUES (?,?,?,?,?)"
						+ " ON DUPLICATE KEY UPDATE item_id=?, md_group=?, md_key=?, md_value=?, sequence=?;";
			PreparedStatement pstmt = conn.prepareStatement(sql);
		     for(int i = 0; i < valueList.size();i++){
		    	 pstmt.setInt(1, item_id);
		    	 pstmt.setString(2, groupList.get(i));
		    	 pstmt.setString(3, keyList.get(i));
		    	 pstmt.setString(4, valueList.get(i));
		    	 pstmt.setInt(5, i+1);
		    	 pstmt.setInt(6, item_id);
		    	 pstmt.setString(7, groupList.get(i));
		    	 pstmt.setString(8, keyList.get(i));
		    	 pstmt.setString(9, valueList.get(i));
		    	 pstmt.setInt(10, i+1);
//		    	 System.out.println(pstmt.toString());
		    	 pstmt.executeUpdate();    		 
		     }
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}
		
	public ItemSpecific getItemSpecific(int item_id) {
		ItemSpecific is = new ItemSpecific(); 
		
		try {
			ResultSet rs = null;
			String sql = "SELECT item_id, md_group, md_key, md_value, sequence "
						+ "FROM " + tblSpecific + " "
						+ "WHERE item_id = " + item_id + " "
						+ "ORDER BY sequence ASC;";
			
//			System.out.println(sql);
			
			PreparedStatement pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				is.setId(rs.getInt(1));
				is.add(rs.getString(2), rs.getString(3), rs.getString(4));
			}
			
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return is;
	}
	
	public void deleteItemSpecific(int item_id) {
		try {
			String sql = "DELETE FROM " + tblSpecific + " WHERE item_id=?";
			
			PreparedStatement pstmt = null;
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, item_id);
			
//			System.out.println(pstmt.toString());
			pstmt.executeUpdate();
		} 
		catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	
	// about Device List
	public ArrayList<DeviceInfo> getList_Device() {
		ArrayList<DeviceInfo> dlist = new ArrayList<DeviceInfo>(); 
		try {
			ResultSet rs = null;
	
			String sql = "SELECT d.device_id, d.item_id, ic.model_name, d.system_id, d.device_name, "
					+ "d.table_name, d.deployment_time, d.deployment_location, d.latitude, d.longitude "
					+ "FROM " + tblDevice + " d, " + tblCommon + " ic "
					+ "WHERE d.item_id = ic.item_id;";
			
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				DeviceInfo di = new DeviceInfo();
				di.setDevice_id(rs.getInt(1));
				di.setItem_id(rs.getInt(2));
				di.setItem_name(rs.getString(3));
				di.setSystem_id(rs.getString(4));
				di.setDevice_name(rs.getString(5));
				di.setTable_name(rs.getString(6));
				di.setDeployment_time(rs.getString(7));
				di.setDeployment_location(rs.getString(8));
				di.setLatitude(rs.getString(9));
				di.setLongitude(rs.getString(10));
//				System.out.println(di.toString());
				
				dlist.add(di);
			}
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return dlist;
	}
	
	public DeviceInfo getDeviceInfo(int device_id){
		DeviceInfo di = new DeviceInfo(); 
		try {
			String sql = "SELECT d.device_id, d.item_id, ic.model_name, d.system_id, d.device_name, "
						+ "d.table_name, d.deployment_time, d.deployment_location, d.latitude, d.longitude "
						+ "FROM " + tblDevice + " d, " + tblCommon + " ic "
						+ "WHERE d.device_id = " + device_id + " AND d.item_id = ic.item_id;";

			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {
				di.setDevice_id(rs.getInt(1));
				di.setItem_id(rs.getInt(2));
				di.setItem_name(rs.getString(3));
				di.setSystem_id(rs.getString(4));
				di.setDevice_name(rs.getString(5));
				di.setTable_name(rs.getString(6));
				di.setDeployment_time(rs.getString(7));
				di.setDeployment_location(rs.getString(8));
				di.setLatitude(rs.getString(9));
				di.setLongitude(rs.getString(10));
			}
			
			rs.close();
			stmt.close();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		
		return di;
	}
	
	public void insertDeviceInfo(DeviceInfo di) {
		try {
			String sql = "INSERT INTO " + tblDevice 
						+ " (item_id, system_id, device_name, table_name, deployment_time,"
						+ " deployment_location, latitude, longitude)"
						+ " VALUES (?,?,?,?,?,?,?,?)";
			
			PreparedStatement pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, di.getItem_id());
			pstmt.setString(2, di.getSystem_id());
			pstmt.setString(3, di.getDevice_name());
			pstmt.setString(4, di.getTable_name());
			pstmt.setString(5, di.getDeployment_time());
			pstmt.setString(6, di.getDeployment_location());
			pstmt.setString(7, di.getLatitude());
			pstmt.setString(8, di.getLongitude());

			pstmt.executeUpdate();

//			System.out.println("----------------------------------->>> Device Registration Success");
		} catch (Exception e) {
			e.printStackTrace();
//			System.out.println("----------------------------------->>> Device Registration Failure");
		}
	}

	public void updateDeviceInfo(DeviceInfo di) {
		try {
			String sql = "UPDATE " + tblDevice 
						+ " SET item_id=?, system_id=?, device_name=?, deployment_time=?, "
						+ "deployment_location=?, latitude=?, longitude=?"
						+ " WHERE device_id=?";
			PreparedStatement pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, di.getItem_id());
			pstmt.setString(2, di.getSystem_id());
			pstmt.setString(3, di.getDevice_name());
			pstmt.setString(4, di.getDeployment_time());
			pstmt.setString(5, di.getDeployment_location());
			pstmt.setString(6, di.getLatitude());
			pstmt.setString(7, di.getLongitude());
			pstmt.setInt(8, di.getDevice_id());
			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}	
	
	public void deleteDeviceInfo(int device_id) {
		try {
			String sql = "DELETE FROM " + tblDevice 
						+ " WHERE device_id=?";
//			System.out.println(sql);

			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, device_id);
			pstmt.executeUpdate();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}
	
	public int getLastDeviceId() {
		int device_id = 0;
		try {
			String sql = "SELECT device_id " 
						+ " FROM " + tblDevice 
						+ " ORDER BY device_id DESC LIMIT 1;";
//			System.out.println(sql);
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
		
	public void createTable_DeviceMeasurement(int item_id, String table_Name) {
		ArrayList<String> keyList = new ArrayList<String>();

		try {
			// get sensor spec from specific_metadata
			String select_sql = "SELECT * FROM " + tblSpecific
						+ " WHERE item_id = " + item_id
						+ " AND md_key ='" + mdSensor + "';";

			PreparedStatement pstmt = conn.prepareStatement(select_sql);
			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {
				String key = rs.getString("md_value");
				keyList.add(key);
			}
		
			String select_sql2 = "SELECT * FROM " + tblSpecific
					+ " WHERE item_id = " + item_id
					+ " AND md_key = '" + mdActuator + "';";

			PreparedStatement pstmt2 = conn.prepareStatement(select_sql2);
			ResultSet rs2 = pstmt2.executeQuery();
		
			while (rs2.next()) {
				String key = rs2.getString("md_value");
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
	public void deleteTableDeviceMeasurement(String table_name) {
		try {
			String deleteSql = "DROP TABLE " + dbnameMeasurement + "." + table_name;

			Statement stmt = this.conn.createStatement();
			stmt.executeUpdate(deleteSql);
//			System.out.println(table_name + " Table delete");
		} 
		catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	
}
