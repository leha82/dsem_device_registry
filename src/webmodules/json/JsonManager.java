package webmodules.json;

import org.json.simple.*;
import org.json.simple.parser.*;

import structures.json.DeviceSpecific;

import java.io.*;
import java.util.ArrayList;
import java.util.TreeMap;

public class JsonManager {
	public String filename;
	public static JSONArray devarr;
	
	public JsonManager() {
		this.filename = "C:/Users/DSEM/Desktop/기타 프로그램/jsontest/json11.json";
		this.devarr = null;
	}

	public JsonManager(String filename) {
		this.filename = filename;
		this.devarr = null;
	}
	
	public void readJsonFile() {
		JSONParser parser = new JSONParser();
				
		try {
			this.devarr = (JSONArray) parser.parse(new FileReader(this.filename));

			for (Object obj : this.devarr) {
				JSONObject device = (JSONObject) obj;
				System.out.println(device.toJSONString());
//				DeviceSpecific ds = new DeviceSpecific();
//				ds.setId((String) device.get("id"));
//				ds.keyList.add(
				
			}
			System.out.println();
			//System.out.println(this.devarr.toJSONString());
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ParseException e) {
			e.printStackTrace();
		}
	}

	public void writeJsonFile() {
		try {
			PrintWriter file = new PrintWriter(this.filename);
			
			file.println(this.devarr.toJSONString());
			System.out.println(this.devarr.toJSONString());
			file.flush();
			file.close();
		} catch (IOException e) {
			e.printStackTrace();
		} 
	}
	
	public void addObjectToJsonArray(DeviceSpecific ds) {
		ds.printInfo();

		JSONObject dev = new JSONObject();
		dev.put("id", ds.getId());
	
		for (int i=0; i<ds.getKeyList().size();i++) {
			dev.put(ds.getKey(i), ds.getValue(i));
		}
		System.out.println(dev.toJSONString());
		
		int obj_index = findObjectFromArray(ds.getId());
		if (obj_index > -1) {
			this.devarr.remove(obj_index);
		}
		this.devarr.add(dev);
		System.out.println(this.devarr.toJSONString());
	}
	
	public int findObjectFromArray(String id) {
		for (int i=0; i<this.devarr.size(); i++) {
			JSONObject dev_in_arr = (JSONObject) this.devarr.get(i);
			String dev_id = (String) dev_in_arr.get("id");
			if (dev_id.equals(id)) {
				return i;
			}
		}
		return -1;
	}
	public void deleteObject(DeviceSpecific id) {
		this.readJsonFile();		
		
		for (int i=0; i<this.devarr.size(); i++) {
			JSONObject dev_in_arr = (JSONObject) this.devarr.get(i);
			String dev_id = (String) dev_in_arr.get("id");
			if (dev_id.equals(id.getId())) {
				this.devarr.remove(i);
				System.out.println("delete test" + "///////" + devarr);
				this.writeJsonFile();
			}
		}
	}
	public void replaceJSONFile(DeviceSpecific ds) {
		System.out.println("*** File Read");
		this.readJsonFile();
	
		System.out.println("*** Add object to JSON Array");
		this.addObjectToJsonArray(ds);
		
		System.out.println("*** File Write");
		this.writeJsonFile();
		
	}
	public static void main(String[] args) {
		
	}
}