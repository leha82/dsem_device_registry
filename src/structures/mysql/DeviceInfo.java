package structures.mysql;

public class DeviceInfo {
	private int device_id;
	private int item_id;
	private String system_id;
	private String device_name;
	private String item_name;
	private String table_name;
	private String deployment_time;
	private String deployment_location;
	private String latitude;
	private String longitude;

	public DeviceInfo() {
		this(0, 0, "", "", "", "", "", "", "");
	}

	public DeviceInfo(int id, int item_id, String system_id, String device_name, String table_name, String deployment_time, 
			String deployment_location, String latitude, String longitude) {
		this.device_id = id;
		this.item_id = item_id;
		this.system_id = system_id;
		this.device_name = device_name;
		this.table_name = table_name;
		this.deployment_time = deployment_time;
		this.deployment_location = deployment_location;
		this.latitude = latitude;
		this.longitude = longitude;
	}

	public int getdevice_id() {
		return device_id;
	}

	public void setdevice_id(int device_id) {
		this.device_id = device_id;
	}

	public int getitem_id() {
		return item_id;
	}

	public void setitem_id(int item_id) {
		this.item_id = item_id;
	}
	
	public String getsystem_id() {
		return system_id;
	}

	public void setsystem_id(String system_id) {
		this.system_id = system_id;
	}
	
	public String getdevice_name() {
		return device_name;
	}

	public void setdevice_name(String device_name) {
		this.device_name = device_name;
	}
	
	public String gettable_name() {
		return table_name;
	}

	public void settable_name(String table_name) {
		this.table_name = table_name;
	}
	
	public String getdeployment_time() {
		return deployment_time;
	}

	public void setdeployment_time(String deployment_time) {
		this.deployment_time = deployment_time;
	}
	
	public String getdeployment_location() {
		return deployment_location;
	}

	public void setdeployment_location(String deployment_location) {
		this.deployment_location = deployment_location;
	}
	
	public String getlatitude() {
		return latitude;
	}

	public void setlatitude(String latitude) {
		this.latitude = latitude;
	}

	public String getlongitude() {
		return longitude;
	}

	public void setlongitude(String longitude) {
		this.longitude = longitude;
	}

	public String toString() {
		return this.device_id + " / " + this.item_id + " / "+ this.system_id + " / "+ 
	this.device_name + " / " + this.table_name + " / " + this.deployment_time + " / " + this.deployment_location + " / " + this.latitude + " / " + this.longitude;
	}

	public String getItem_name() {
		return item_name;
	}

	public void setItem_name(String item_name) {
		this.item_name = item_name;
	}

}
