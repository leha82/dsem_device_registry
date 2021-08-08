package structures;

public class Actuation {
	public int id;
	public int device_id;
	public String actuator;
	public String set_state;
	public String timestamp;
	
	public Actuation() {
		this(0, 0, "", "", "");
	}
	
	public Actuation(int id, int device_id, String actuator, String set_state, String timestamp) {
		this.id = id;
		this.device_id = device_id;
		this.actuator = actuator;
		this.set_state = set_state;
		this.timestamp = timestamp;
	}
	
	public int getId() {
		return id;
	}
	
	public void setId(int id) {
		this.id = id;
	}
	
	public int getDevice_id() {
		return device_id;
	}
	
	public void setDevice_id(int device_id) {
		this.device_id = device_id;
	}
	
	public String getActuator() {
		return actuator;
	}
	
	public void setActuator(String actuator) {
		this.actuator = actuator;
	}
	
	public String getSet_state() {
		return set_state;
	}
	
	public void setSet_state(String set_state) {
		this.set_state = set_state;
	}
	
	public String getTimestamp() {
		return timestamp;
	}
	
	public void setTimestamp(String timestamp) {
		this.timestamp = timestamp;
	}
}
