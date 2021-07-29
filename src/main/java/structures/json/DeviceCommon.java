package structures.json;

public class DeviceCommon {
	private String id;
	private String registration_time;
	private String device_type;
	private String manufacturer;
	private String category;

	public DeviceCommon() {
		this("","","","","");
	}
	
	public DeviceCommon(String id, String registration_time, String device_type, String manufacturer,String category) {
		this.id = id;
		this.registration_time = registration_time;
		this.device_type = device_type;
		this.manufacturer = manufacturer;
		this.category = category;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	public String getregistration_time() {
		return registration_time;
	}

	public void setregistration_time(String registration_time) {
		this.registration_time = registration_time;
	}

	public String getDevice_type() {
		return device_type;
	}

	public void setDevice_type(String device_type) {
		this.device_type = device_type;
	}

	public String getManufacturer() {
		return manufacturer;
	}

	public void setManufacturer(String manufacturer) {
		this.manufacturer = manufacturer;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}
	
	public String toString() {
		return this.id + " / " + this.registration_time + " / " + this.device_type + " / " + this.manufacturer + " / " 
				+ this.category + " / ";
	}
	
}