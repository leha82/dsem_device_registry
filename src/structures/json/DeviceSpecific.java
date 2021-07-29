package structures.json;

import java.util.*;

public class DeviceSpecific {
	public String id;
	public ArrayList<String> keyList;
	public ArrayList<String> valueList;
	
	public DeviceSpecific() {
		this.id = "";
		this.keyList = new ArrayList<String>();
		this.valueList = new ArrayList<String>();
	}

	public DeviceSpecific(String device_id) {
		this.id = device_id;
		this.keyList = new ArrayList<String>();
		this.valueList = new ArrayList<String>();
	}

	public DeviceSpecific(String device_id, ArrayList<String> key, ArrayList<String> value) {
		this.id = device_id;
		this.keyList = key;
		this.valueList = value;
	}
	
	public String getValue(String key) {
		for (int i=0;i < keyList.size(); i++) {
			if (keyList.get(i).equals(key)) {
				return keyList.get(i);
			}
		}
		
		return null;
	}
	
	public void add(String key, String value) {
		this.keyList.add(key);
		this.valueList.add(value);
	}

	public int size() {
		return this.keyList.size();
	}
	
	public String getKey(int index) {
		return this.keyList.get(index);
	}

	public String getValue(int index) {
		return this.valueList.get(index);
	}
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public ArrayList<String> getKeyList() {
		return keyList;
	}

	public void setKeyList(ArrayList<String> keyList) {
		this.keyList = keyList;
	}

	public ArrayList<String> getValueList() {
		return valueList;
	}

	public void setValueList(ArrayList<String> valueList) {
		this.valueList = valueList;
	}
	
	public void printInfo() {
		System.out.println("**** Print information : " + this.id + " ****");
		for (int i=0; i<this.size(); i++) {
			System.out.println((i+1) + " - " + keyList.get(i) + " : " + valueList.get(i));
		}
		System.out.println("**** Print end ****");
	}
}