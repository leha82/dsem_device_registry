package structures.mongodb;

public class DeviceCommon {
	private Object id;
	private Object model_name;
	private Object registration_time;
	private Object device_type;
	private Object manufacturer;
	private Object category;

	public DeviceCommon() {
		this("","","","","","");
	}
	
	public DeviceCommon(Object id, Object model_name, Object registration_time, Object device_type, Object manufacturer,Object category) {
		this.id = id;
		this.model_name = model_name;
		this.registration_time = registration_time;
		this.device_type = device_type;
		this.manufacturer = manufacturer;
		this.category = category;
	}

	public Object getId() {
		return id;
	}

	public void setId(Object id) {
		this.id = id;
	}
	public Object getmodel_name() {
		return model_name;
	}

	public void setmodel_name(Object model_name) {
		this.model_name = model_name;
	}
	public Object getregistration_time() {
		return registration_time;
	}

	public void setregistration_time(Object registration_time) {
		this.registration_time = registration_time;
	}

	public Object getDevice_type() {
		return device_type;
	}

	public void setDevice_type(Object device_type) {
		this.device_type = device_type;
	}

	public Object getManufacturer() {
		return manufacturer;
	}

	public void setManufacturer(Object manufacturer) {
		this.manufacturer = manufacturer;
	}

	public Object getCategory() {
		return category;
	}

	public void setCategory(Object category) {
		this.category = category;
	}
	
	public String toString() {
		return   this.id + " / "+this.model_name + " / "+ this.registration_time + " / " + this.device_type + " / " + this.manufacturer + " / " 
				+ this.category + " / ";
	}
	
}