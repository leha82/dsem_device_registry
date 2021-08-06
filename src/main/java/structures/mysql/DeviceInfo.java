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
		this(0, 0, "", "", "", "", "", "", "", "");
	}

	public DeviceInfo(int id, int item_id, String system_id, String device_name, String table_name, String deployment_time, 
			String deployment_location, String latitude, String longitude) {
		this(id, item_id, system_id, device_name, "", table_name, deployment_time, deployment_location, latitude, longitude);
	}
	
	public DeviceInfo(int id, int item_id, String system_id, String device_name, String item_name, String table_name, String deployment_time, 
			String deployment_location, String latitude, String longitude) {
		this.device_id = id;
		this.item_id = item_id;
		this.system_id = system_id;
		this.device_name = device_name;
		this.item_name = item_name;
		this.table_name = table_name;
		this.deployment_time = deployment_time;
		this.deployment_location = deployment_location;
		this.latitude = latitude;
		this.longitude = longitude;
	}

	public int getDevice_id() {
		return device_id;
	}

	public void setDevice_id(int device_id) {
		this.device_id = device_id;
	}

	public int getItem_id() {
		return item_id;
	}

	public void setItem_id(int item_id) {
		this.item_id = item_id;
	}
	
	public String getSystem_id() {
		return system_id;
	}

	public void setSystem_id(String system_id) {
		this.system_id = system_id;
	}
	
	public String getDevice_name() {
		return device_name;
	}

	public void setDevice_name(String device_name) {
		this.device_name = device_name;
	}
	
	public String getTable_name() {
		return table_name;
	}

	public void setTable_name(String table_name) {
		this.table_name = table_name;
	}
	
	public String getDeployment_time() {
		return deployment_time;
	}

	public void setDeployment_time(String deployment_time) {
		this.deployment_time = deployment_time;
	}
	
	public String getDeployment_location() {
		return deployment_location;
	}

	public void setDeployment_location(String deployment_location) {
		this.deployment_location = deployment_location;
	}
	
	public String getLatitude() {
		return latitude;
	}

	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}

	public String getLongitude() {
		return longitude;
	}

	public void setLongitude(String longitude) {
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
