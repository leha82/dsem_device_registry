package structures.mysql;

import java.util.*;

public class DeviceSpecific {
	public int id;
	public ArrayList<String> groupList;
	public ArrayList<String> keyList;
	public ArrayList<String> valueList;

	
	public DeviceSpecific() {
		this.id = 0;
		this.groupList = new ArrayList<String>();
		this.keyList = new ArrayList<String>();
		this.valueList = new ArrayList<String>();
	}

	public DeviceSpecific(int device_id) {
		this.id = device_id;
		this.groupList = new ArrayList<String>();
		this.keyList = new ArrayList<String>();
		this.valueList = new ArrayList<String>();
	}

	public DeviceSpecific(int device_id, ArrayList<String> group, ArrayList<String> key, ArrayList<String> value) {
		this.id = device_id;
		this.groupList = group;
		this.keyList = key;
		this.valueList = value;
	}
	
	public String getValue(String group, String key) {
		for (int i=0;i < keyList.size(); i++) {
			if (groupList.get(i).equals(group) && keyList.get(i).equals(key)) {
				return valueList.get(i);
			}
		}
		
		return null;
	}
	
	public void add(String group, String key, String value) {
		this.groupList.add(group);
		this.keyList.add(key);
		this.valueList.add(value);
	}

	public int size() {
		return this.keyList.size();
	}

	public String getGroup(int index) {
		return this.groupList.get(index);
	}

	public String getKey(int index) {
		return this.keyList.get(index);
	}

	public String getValue(int index) {
		return this.valueList.get(index);
	}
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
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
	
	public ArrayList<String> getGroupList() {
		return groupList;
	}

	public void setGroupList(ArrayList<String> groupList) {
		this.groupList = groupList;
	}

	public void printInfo() {
		System.out.println("**** Print information : " + this.id + " ****");
		for (int i=0; i<this.size(); i++) {
			System.out.println((i+1) + " - " + keyList.get(i) + " : " + valueList.get(i));
		}
		System.out.println("**** Print end ****");
	}
}
