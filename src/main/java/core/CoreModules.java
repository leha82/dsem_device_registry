package core;

import java.text.SimpleDateFormat;
import java.io.*;
import java.util.*;
import org.json.simple.*;
import org.json.simple.parser.*;


public class CoreModules {
	private static String DEFAULT_CONFIG_FILE = "config.json";
	private String configFilename;
	
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
	
	// static methods
	public static String getCurrentTime() {
		return new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(System.currentTimeMillis());
	}
	
	public static boolean checkDatetime(String inputDate) {
		try {
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date date = format.parse(inputDate);
		} catch (Exception e) {
			return false;
		}
		return true;
	}
	
	public static boolean isKeyListSame(ArrayList<String> listA, ArrayList<String> listB) {
		listA.sort(Comparator.naturalOrder());
		listB.sort(Comparator.naturalOrder());
		
//		System.out.println("issame size : " + listA.size() + " , " + listB.size());
		
		if (listA.size() != listB.size()) return false;
		
		for (int i=0; i<listA.size(); i++) {
			String a = listA.get(i);
			String b = listB.get(i);

//			System.out.println(i + " : " + a + " , " + b);
			
			if (!a.equals(b)) return false;
		}
		
		return true;
	}
	
//	public static void main(String[] args) {
//		System.out.println(Double.parseDouble(null));
//	}
		
	// non-static methods
	public CoreModules() {
	}

	public void loadConfigJson(String configPath) {
		configFilename = configPath + DEFAULT_CONFIG_FILE;
		
	    JSONParser parser = new JSONParser();
		JSONObject jsonObject; 
				
		try {
			jsonObject = (JSONObject) parser.parse(new FileReader(configFilename));
			
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
			System.out.println("Error is occured in setConfig()");
		}
	}
	
	public String getDbIP() {
		return dbIP;
	}

	public void setDbIP(String dbIP) {
		this.dbIP = dbIP;
	}

	public int getDbPort() {
		return dbPort;
	}

	public void setDbPort(int dbPort) {
		this.dbPort = dbPort;
	}

	public String getDbID() {
		return dbID;
	}

	public void setDbID(String dbID) {
		this.dbID = dbID;
	}

	public String getDbPW() {
		return dbPW;
	}

	public void setDbPW(String dbPW) {
		this.dbPW = dbPW;
	}

	public String getDbnameRegistry() {
		return dbnameRegistry;
	}

	public void setDbnameRegistry(String dbnameRegistry) {
		this.dbnameRegistry = dbnameRegistry;
	}

	public String getDbnameMeasurement() {
		return dbnameMeasurement;
	}

	public void setDbnameMeasurement(String dbnameMeasurement) {
		this.dbnameMeasurement = dbnameMeasurement;
	}

	public String getTblCommon() {
		return tblCommon;
	}

	public void setTblCommon(String tblCommon) {
		this.tblCommon = tblCommon;
	}

	public String getTblSpecific() {
		return tblSpecific;
	}

	public void setTblSpecific(String tblSpecific) {
		this.tblSpecific = tblSpecific;
	}

	public String getTblDevice() {
		return tblDevice;
	}

	public void setTblDevice(String tblDevice) {
		this.tblDevice = tblDevice;
	}

	public String getMdSensor() {
		return mdSensor;
	}

	public void setMdSensor(String mdSensor) {
		this.mdSensor = mdSensor;
	}

	public String getMdActuator() {
		return mdActuator;
	}

	public void setMdActuator(String mdActuator) {
		this.mdActuator = mdActuator;
	}
}
