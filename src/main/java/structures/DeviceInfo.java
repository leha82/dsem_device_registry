package structures;

import java.text.SimpleDateFormat;
import java.util.Date;

import core.CoreModules;

public class DeviceInfo {
	private int device_id;
	private int item_id;
	private String system_id;
	private String device_name;
	private String item_name;
	private String table_name;
	private String deployment_time;
	private String deployment_location;
	private Double latitude;
	private Double longitude;
	private boolean enabled;

	public DeviceInfo() {
		this(0, "", "", "", 0, "", "", "", null, null, true);
	}

	public DeviceInfo(int device_id, String device_name, String system_id, String table_name,
			int item_id, String deployment_time, String deployment_location, 
			Double latitude, Double longitude) {
		this(device_id, device_name, system_id, table_name, item_id, "", deployment_time, 
				deployment_location, latitude, longitude, true);
	}
	
	public DeviceInfo(int device_id, String device_name, String system_id,  String table_name, 
			int item_id, String item_name, String deployment_time, String deployment_location, 
			Double latitude, Double longitude, boolean enabled) {
		this.device_id = device_id;
		this.item_id = item_id;
		this.system_id = system_id;
		this.device_name = device_name;
		this.item_name = item_name;
		this.table_name = table_name;
		this.deployment_time = deployment_time;
		this.deployment_location = deployment_location;
		this.latitude = latitude;
		this.longitude = longitude;
		this.enabled = enabled;
	}

	public int getDevice_id() {
		return device_id;
	}

	public void setDevice_id(int device_id) {
		this.device_id = device_id;
	}
	
	public String getDevice_name() {
		return device_name;
	}

	public void setDevice_name(String device_name) {
		this.device_name = device_name;
	}
	
	public String getSystem_id() {
		return system_id;
	}

	public void setSystem_id(String system_id) {
		this.system_id = system_id;
	}

	
	public String getTable_name() {
		return table_name;
	}

	public void setTable_name(String table_name) {
		this.table_name = table_name;
	}

	public int getItem_id() {
		return item_id;
	}

	public void setItem_id(int item_id) {
		this.item_id = item_id;
	}

	public String getItem_name() {
		return item_name;
	}

	public void setItem_name(String item_name) {
		this.item_name = item_name;
	}
	
	public String getDeployment_time() {
		return deployment_time;
	}

	public void setDeployment_time(String deployment_time) {
		try {
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date date = format.parse(deployment_time);
			this.deployment_time = deployment_time;
		} catch (Exception e) {
			this.deployment_time = CoreModules.getCurrentTime();
		}
		
	}
	
	public String getDeployment_location() {
		return deployment_location;
	}

	public void setDeployment_location(String deployment_location) {
		this.deployment_location = deployment_location;
	}
	
	public Double getLatitude() {
		return latitude;
	}

	public void setLatitude(Double latitude) {
		this.latitude = latitude;
	}

	public void setLatitude(String latitude) {
		try {
			Double lat = Double.parseDouble(latitude);
			this.latitude = lat;
		} catch (Exception e) {
			this.latitude = null;				
		}
	}
	
	public Double getLongitude() {
		return longitude;
	}

	public void setLongitude(Double longitude) {
		this.longitude = longitude;
	}
	
	public void setLongitude(String longitude) {
		try {
			Double lon = Double.parseDouble(longitude);
			this.longitude = lon;
		} catch (Exception e) {
			this.longitude = null;				
		}
	}
	
	public String getLatitudeString() {
		String lat = "";
		if (latitude != null ) 
			lat = String.valueOf(latitude);
		return lat;
	}
	
	public String getLongitudeString() {
		String lon = "";
		if (longitude != null ) 
			lon = String.valueOf(longitude);
		return lon;
	}

	public boolean isEnabled() {
		return enabled;
	}

	public int getEnabled() {
		if (this.enabled) return 1;
		return 0;
	}
	
	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}
	
	public void setEnabled(int enabled) {
		if (enabled == 1)
			this.enabled = true;
		else 
			this.enabled = false;
	}

	public String toString() {
		return this.device_id + " / " + this.item_id + " / "+ this.system_id + " / "
				+ this.device_name + " / " + this.table_name + " / " + this.deployment_time 
				+ " / " + this.deployment_location + " / " + this.latitude + " / " + this.longitude;
	}

}
