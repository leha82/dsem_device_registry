package structures.mongodb;

import java.util.*;

public class DeviceSpecific {
	public Object id;
	public ArrayList<Object> keyList;
	public ArrayList<Object> valueList;

	
	public DeviceSpecific() {
		this.id = "";
		this.keyList = new ArrayList<Object>();
		this.valueList = new ArrayList<Object>();
	}

	public DeviceSpecific(Object device_id) {
		this.id = device_id;
		this.keyList = new ArrayList<Object>();
		this.valueList = new ArrayList<Object>();
	}

	public DeviceSpecific(Object device_id, ArrayList<Object> key, ArrayList<Object> value) {
		this.id = device_id;
		this.keyList = key;
		this.valueList = value;
	}
	
	public Object getValue(Object key) {
		for (int i=0;i < keyList.size(); i++) {
			if (keyList.get(i).equals(key)) {
				return keyList.get(i);
			}
		}
		
		return null;
	}
	
	public void add(Object key, Object value) {
		this.keyList.add(key);
		this.valueList.add(value);
	}

	public int size() {
		return this.keyList.size();
	}
	
	public Object getKey(int index) {
		return this.keyList.get(index);
	}

	public Object getValue(int index) {
		return this.valueList.get(index);
	}
	
	public Object getId() {
		return id;
	}

	public void setId(Object id) {
		this.id = id;
	}

	public ArrayList<Object> getKeyList() {
		return keyList;
	}

	public void setKeyList(ArrayList<Object> keyList) {
		this.keyList = keyList;
	}

	public ArrayList<Object> getValueList() {
		return valueList;
	}

	public void setValueList(ArrayList<Object> valueList) {
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