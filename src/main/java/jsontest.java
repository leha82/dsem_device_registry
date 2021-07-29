import java.io.*;

import org.json.simple.*;
import org.json.simple.parser.*;

public class jsontest {
	
	public static void main(String[] args) {
		String path = System.getProperty("user.dir");
	    System.out.println("Working Directory = " + path);
	    
	    File dir = new File(path);
	    File files[] = dir.listFiles();

	    for (int i = 0; i < files.length; i++) {
	        System.out.println("file: " + files[i]);
	    }

	    String filename = path + "\\" + "config.json";
		JSONArray devarr;
		JSONParser parser = new JSONParser();
		JSONObject jsonObject; 
	    
		try {
			jsonObject = (JSONObject) parser.parse(new FileReader(filename));
			
			String DB_IP = (String) jsonObject.get("DB_IP");
			int DB_PORT = Integer.parseInt((String)jsonObject.get("DB_PORT"));
			String DB_ID = (String) jsonObject.get("DB_ID");
			String DB_PW = (String) jsonObject.get("DB_PW");
			String DB_REGISTRY_DB = (String) jsonObject.get("DB_REGISTRY_DB");
			String DB_MEASUREMENT_DB = (String) jsonObject.get("DB_MEASUREMENT_DB");
			String DB_GLOBAL_TABLE = (String) jsonObject.get("DB_GLOBAL_TABLE");
			String DB_SPECIFIC_TABLE = (String) jsonObject.get("DB_SPECIFIC_TABLE");
			String DB_DEVICE_TABLE = (String) jsonObject.get("DB_DEVICE_TABLE");

			System.out.println(DB_IP);
			System.out.println(DB_PORT);
			System.out.println(DB_ID);
			System.out.println(DB_PW);
			System.out.println(DB_REGISTRY_DB);
			System.out.println(DB_MEASUREMENT_DB);
			System.out.println(DB_GLOBAL_TABLE);
			System.out.println(DB_SPECIFIC_TABLE);
			System.out.println(DB_DEVICE_TABLE);
			
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
}
