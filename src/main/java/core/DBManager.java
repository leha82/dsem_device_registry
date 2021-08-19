package core;

import java.sql.*;
import java.util.*;

import structures.*;

import java.io.*;

public class DBManager {
	private String dbDriverClass = "com.mysql.cj.jdbc.Driver";
	private String jdbcDriver; 

	private String dbIP;
	private int dbPort;
	private String dbID;
	private String dbPW;
	private String dbnameRegistry;
	private String dbnameMeasurement;
	private String tblCommon;
	private String tblSpecific;
	private String tblDevice;
	private String mdSensor;
	private String mdActuator;
	
	private Connection conn;
	private CoreModules cm;
	
	public DBManager(String configPath) {
		cm = new CoreModules();
		cm.loadConfigJson(configPath);

		dbIP = cm.getDbIP();
		dbPort = cm.getDbPort();
		dbID = cm.getDbID();
		dbPW = cm.getDbPW();
		dbnameRegistry = cm.getDbnameRegistry();
		dbnameMeasurement = cm.getDbnameMeasurement();
		tblCommon = cm.getTblCommon();
		tblSpecific = cm.getTblSpecific();
		tblDevice = cm.getTblDevice();
		mdSensor = cm.getMdSensor();
		mdActuator = cm.getMdActuator();
		
		jdbcDriver = "jdbc:mysql://" + dbIP + ":" + dbPort + "/" 
				+ dbnameRegistry + "?useUnicode=true&characterEncoding=utf8";
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
	
	
	// About Item Common
	public void insertItemCommon(ItemCommon ic) {
		try {
			String sql = "INSERT INTO " + tblCommon 
						+ " (item_id, model_name, registration_time, device_type, manufacturer, category)"
						+ " VALUES (?,?,?,?,?,?)";
			
			PreparedStatement pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, ic.getId());
			pstmt.setString(2, ic.getModel_name());
			pstmt.setString(3, ic.getRegistration_time());
			pstmt.setString(4, ic.getDevice_type());
			pstmt.setString(5, ic.getManufacturer());
			pstmt.setString(6, ic.getCategory());

			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println(e.getMessage());
			System.out.println("Error is occured in insertItemCommon()");
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
			System.out.println("Error is occured in getList_ItemCommon()");
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
			System.out.println("Error is occured in getItemCommon()");
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
			System.out.println("Error is occured in updateItemCommon()");
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
			System.out.println(e.getMessage());
			System.out.println("Error is occured in deleteItemCommon()");
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
			System.out.println("Error is occured in insertItemSpecific()");
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
			System.out.println("Error is occured in getItemSpecific()");
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
			System.out.println(e.getMessage());
			System.out.println("Error is occured in deleteItemSpecific()");
		}
	}
	
	public ArrayList<String> getDBModuleList(int item_id) {
		ArrayList<String> keylist = new ArrayList<String>();
		// get sensor and actuator list from specific table
		try {
			ResultSet rs = null;
			String sql = "SELECT md_value "
						+ " FROM " + tblSpecific
						+ " WHERE item_id = " + item_id + " and " 
						+ " (md_key ='" + mdSensor + "' or md_key ='" + mdActuator + "')"
						+ " ORDER BY md_key ASC;";
//			System.out.println(sql);
			
			Statement stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			
			while (rs.next()) {
				keylist.add(rs.getString(1));
			}
			
			rs.close();
			stmt.close();
		} catch (Exception e) {
			System.out.println(e.getMessage());
			System.out.println("Error is occured in checkSpecificInfo()");
		}
		
		return keylist;
		
	}
	
	public ArrayList<String> getInputModuleList(ArrayList<String> keylist, ArrayList<String> valuelist) {
		ArrayList<String> list = new ArrayList<String>();
		
		for (int i=0; i<keylist.size(); i++) {
			if (keylist.get(i).equals(mdSensor) || keylist.get(i).equals(mdActuator)) 
				list.add(valuelist.get(i));
		}
		
		return list;
	}
	
	
	
	// about Device List
	public ArrayList<DeviceInfo> getList_Device() {
		ArrayList<DeviceInfo> dlist = new ArrayList<DeviceInfo>(); 
		try {
			ResultSet rs = null;
	
			String sql = "SELECT d.device_id, d.item_id, ic.model_name, d.system_id, d.device_name, "
					+ "d.table_name, d.deployment_time, d.deployment_location, d.latitude, d.longitude, d.enabled "
					+ "FROM " + tblDevice + " d, " + tblCommon + " ic "
					+ "WHERE d.item_id = ic.item_id;";
			
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
//			System.out.println("Get Device List : ");
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
				di.setEnabled(rs.getInt(11));
//				System.out.println(di.toString());
				
				dlist.add(di);
			}
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.getMessage());
			System.out.println("Error is occured in getList_Device()");
		}
		
		return dlist;
	}
	
	public ArrayList<DeviceInfo> getList_Device(int item_id) {
		ArrayList<DeviceInfo> dlist = new ArrayList<DeviceInfo>(); 
		try {
			ResultSet rs = null;
	
//			String sql = "SELECT device_id, device_name, system_id, table_name, "
//					+ "item_id, deployment_time, deployment_location, latitude, longitude, enabled "
//					+ "FROM " + tblDevice + " " 
//					+ "WHERE item_id = " + item_id;
			
			String sql = "SELECT d.device_id, d.device_name, d.system_id, d.table_name, d.item_id, ic.model_name, "
					+ "d.deployment_time, d.deployment_location, d.latitude, d.longitude, d.enabled "
					+ "FROM " + tblDevice + " d, " + tblCommon + " ic "
					+ "WHERE d.item_id = " + item_id +" and d.item_id = ic.item_id;";
			
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
//			System.out.println("Get Device List : ");
			while (rs.next()) {
				DeviceInfo di = new DeviceInfo();
				
				di.setDevice_id(rs.getInt(1));
				di.setDevice_name(rs.getString(2));
				di.setSystem_id(rs.getString(3));
				di.setTable_name(rs.getString(4));
				di.setItem_id(rs.getInt(5));
				di.setItem_name(rs.getString(6));
				di.setDeployment_time(rs.getString(7));
				di.setDeployment_location(rs.getString(8));
				di.setLatitude(rs.getString(9));
				di.setLongitude(rs.getString(10));
				di.setEnabled(rs.getInt(11));
//				System.out.println(di.toString());
				
				dlist.add(di);
			}
			rs.close();
			pstmt.close();
		} catch (Exception e) {
			System.out.println(e.getMessage());
			System.out.println("Error is occured in getList_Device(int item_id)");
		}
		
		return dlist;
	}

	
	public DeviceInfo getDeviceInfo(int device_id){
		DeviceInfo di = new DeviceInfo(); 
		try {
			String sql = "SELECT d.device_id, d.device_name, d.system_id, d.table_name, d.item_id, ic.model_name, "
						+ "d.deployment_time, d.deployment_location, d.latitude, d.longitude, d.enabled "
						+ "FROM " + tblDevice + " d, " + tblCommon + " ic "
						+ "WHERE d.device_id = " + device_id + " AND d.item_id = ic.item_id;";

			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {
				di.setDevice_id(rs.getInt(1));
				di.setDevice_name(rs.getString(2));
				di.setSystem_id(rs.getString(3));
				di.setTable_name(rs.getString(4));
				di.setItem_id(rs.getInt(5));
				di.setItem_name(rs.getString(6));
				di.setDeployment_time(rs.getString(7));
				di.setDeployment_location(rs.getString(8));
				di.setLatitude(rs.getString(9));
				di.setLongitude(rs.getString(10));
				di.setEnabled(rs.getInt(11));
			}
			
			rs.close();
			stmt.close();
		} catch (Exception e) {
			System.out.println(e.getMessage());
			System.out.println("Error is occured in getDeviceInfo()");
		}
		
		return di;
	}
	
	public boolean insertDeviceInfo(DeviceInfo di) {
		try {
			String sql = "INSERT INTO " + tblDevice 
						+ " (device_name, system_id, table_name, item_id, deployment_time,"
						+ " deployment_location, latitude, longitude, enabled)"
						+ " VALUES (?,?,?,?,?,?,?,?, 1)";
			
			PreparedStatement pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, di.getDevice_name());
			pstmt.setString(2, di.getSystem_id());
			pstmt.setString(3, di.getTable_name());
			pstmt.setInt(4, di.getItem_id());
			pstmt.setString(5, di.getDeployment_time());
			pstmt.setString(6, di.getDeployment_location());
			
			if (di.getLatitude()!=null) 
				pstmt.setDouble(7, di.getLatitude());
			else 
				pstmt.setNull(7, Types.NULL);
			
			if (di.getLongitude()!= null) 
				pstmt.setDouble(8, di.getLongitude());
			else 
				pstmt.setNull(8, Types.NULL);
			
			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println(e.getMessage());
			System.out.println("Error is occured in insertDeviceInfo()");
			return false;
		}
		return true;
	}

	public void updateDeviceInfo(DeviceInfo di) {
		try {
			String sql = "UPDATE " + tblDevice 
						+ " SET device_name=?, system_id=?, item_id=?, deployment_time=?, "
						+ "deployment_location=?, latitude=?, longitude=?"
						+ " WHERE device_id=?";
			PreparedStatement pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, di.getDevice_name());
			pstmt.setString(2, di.getSystem_id());
			pstmt.setInt(3, di.getItem_id());
			pstmt.setString(4, di.getDeployment_time());
			pstmt.setString(5, di.getDeployment_location());

//			pstmt.setDouble(6, di.getLatitude());
//			pstmt.setDouble(7, di.getLongitude());

			if (di.getLatitude()!=null) 
				pstmt.setDouble(6, di.getLatitude());
			else 
				pstmt.setNull(6, Types.NULL);
			
			if (di.getLongitude()!= null) 
				pstmt.setDouble(7, di.getLongitude());
			else 
				pstmt.setNull(7, Types.NULL);
			
			
			pstmt.setInt(8, di.getDevice_id());
			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println(e.getMessage());
			System.out.println("Error is occured in updateDeviceInfo()");
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
			System.out.println("Error is occured in deleteDeviceInfo()");
		}
	}
	
	public int getLastDeviceId() {
		int device_id = 0;
		try {
			String sql = "SELECT device_id " 
						+ " FROM " + tblDevice 
						+ " ORDER BY device_id DESC LIMIT 1;";
//			System.out.println(sql);
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {
				device_id = rs.getInt(1);
			}

			rs.close();
			stmt.close();
		} catch (Exception e) {
			System.out.println(e.getMessage());
			System.out.println("Error is occured in updateDeviceTableName()");

		}
		return device_id;
	}
		
	public boolean updateDeviceTableName(int device_id, String table_name) {
		try {
			String sql = "UPDATE " + tblDevice 
						+ " SET table_name=?, enabled=1"
						+ " WHERE device_id=?";
			PreparedStatement pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, table_name);
			pstmt.setInt(2, device_id);
			
//			System.out.println(pstmt.toString());
			
			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println(e.getMessage());
			System.out.println("Error is occured in updateDeviceTableName()");
			return false;
		}
//		System.out.println("update success");
		return true;
	}
	
	public boolean updateDeviceEnabled(int device_id, boolean enabled) {
		try {
			String sql = "UPDATE " + tblDevice 
						+ " SET enabled=?"
						+ " WHERE device_id=?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			
			int enabledInt = 0;
			if (enabled) enabledInt = 1;
			
			pstmt.setInt(1, enabledInt);
			pstmt.setInt(2, device_id);
			
//			System.out.println(pstmt.toString());
			
			pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println(e.getMessage());
			System.out.println("Error is occured in updateDeviceTableName()");
			return false;
		}
//		System.out.println("update success");
		return true;
	}
	
	public int getCount_DeviceMeasurement(String table_Name) {
		int cnt = 0;
		try {
			// get sensor spec from specific_metadata
			String sql = "SELECT count(*) FROM " + dbnameMeasurement + "." + table_Name + ";";

			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);

			while (rs.next()) {
				cnt = rs.getInt(1);
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
			System.out.println("Error is occured in getCount_DeviceMeasurement()");
		}
		
		return cnt;
	}
		
	public boolean createTable_DeviceMeasurement(int item_id, String table_Name) {
		ArrayList<String> keyList = new ArrayList<String>();

		try {
			// get sensor spec from specific_metadata
			String select_sql = "SELECT * FROM " + tblSpecific
						+ " WHERE item_id = " + item_id
						+ " AND md_key ='" + mdSensor + "';";

			PreparedStatement pstmt = conn.prepareStatement(select_sql);
			ResultSet rs = pstmt.executeQuery();

			System.out.println(pstmt.toString());

			while (rs.next()) {
				String key = rs.getString("md_value");
				keyList.add(key);
			}
		
			String select_sql2 = "SELECT * FROM " + tblSpecific
					+ " WHERE item_id = " + item_id
					+ " AND md_key = '" + mdActuator + "';";

			PreparedStatement pstmt2 = conn.prepareStatement(select_sql2);
			ResultSet rs2 = pstmt2.executeQuery();
		
			System.out.println(pstmt2.toString());

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

			System.out.println(createSql);
			
			for (int j = 0; j < keyList.size(); j++) {
				String alterSql = "ALTER TABLE " + dbnameMeasurement + "." + table_Name 
							+ " ADD " + keyList.get(j) + " varchar(200)";
				stmt.execute(alterSql);
				System.out.println(alterSql);

			}
		}

		catch (SQLException e) {
			System.out.println(e.getMessage());
			System.out.println("Error is occured in createTable_DeviceMeasurement()");
			return false;
		}
		
		return true;
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
			System.out.println(e.getMessage());
			System.out.println("Error is occured in deleteTableDeviceMeasurement()");
		}
	}
	
}
