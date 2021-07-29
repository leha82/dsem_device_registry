package webmodules.json;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Iterator;
import java.util.Set;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import structures.json.*;

public class FileManager {
	public static String JSON_FILENAME = "C:/Users/DSEM/Desktop/기타 프로그램/jsontest/json11.json";
	public static String ar[]; // key
	public static String ar2[]; // value
	public static String Id;
	public static Set<String> s;
	public static Collection s2;

	public FileManager() {
	}

	public DeviceSpecific getDeviceSpecific(String device_id) throws ParseException, IOException {
		DeviceSpecific ds = new DeviceSpecific(device_id);
		JsonManager jm = new JsonManager();
		JSONParser parser = new JSONParser();
		JSONArray de_ar = (JSONArray) parser.parse(new FileReader(this.JSON_FILENAME));

		for (Object o : de_ar) {
			JSONObject parse = (JSONObject) o;
			String js_Id = (String) parse.get("id");
			DeviceSpecific dv = new DeviceSpecific(js_Id);
			s = parse.keySet();
			s2 = parse.values();

			String[] arr = s.toArray(new String[s.size()]);
			String[] arr2 = (String[]) s2.toArray(new String[s2.size()]);
			Iterator iterator;
			iterator = s.iterator();
			Iterator<String> iterator2 = s2.iterator();

			String str = "";
			String str2 = "";

			while (iterator.hasNext() && iterator2.hasNext()) {
				str = (String) iterator.next();
				str2 = (String) iterator2.next();

				if (str == null || str2 == null)
					continue;

				if (str.equals("id") || str2.equals(Id)) {
					iterator.remove();
					// iterator2.remove();
					break;
				}
			}

			for (String k : s) {
				Set<String> v = parse.keySet();
				ar = v.toArray(new String[v.size()]);
			}

			for (Object v : s2) {
				Collection v2 = parse.values();
				ar2 = (String[]) v2.toArray(new String[v2.size()]);
			}

			for (int i = 0; i < ar.length; i++) {
				if (js_Id.equals(device_id)) {

					ds.add(ar[i], ar2[i]);

				}
			}
		}

		return ds;
	}

	public DeviceSpecific getDeviceSpecific2(String device_id) throws ParseException, IOException {
		DeviceSpecific ds = new DeviceSpecific(device_id);

		// 파일에서 device_id 부분만을 읽어서 처리
		// 파일 열기

		// json 타입으로 읽어오기

		// for로 jsonarray 돌려서 하나의 json id 마다 지니는 모든 key/value list를 읽기

		// json 타입 중 id== device_id 부분의 다른 key, value를 ds에 넣기

		// ds.add(key, value);

		File file = new File(JSON_FILENAME);
		String text = "";

		ArrayList<String> JSONArray_string = new ArrayList<String>();

		if (file.exists()) {
			BufferedReader inFile = new BufferedReader(new FileReader(file));
			String sLine = null;
			while ((sLine = inFile.readLine()) != null) {
				text = text + sLine;
				// text = sLine;

				// System.out.println("d"+text);
				// if (sLine.substring(0, 1).equals("]")) {

				JSONArray_string.add(text);

				// text = "";
				System.out.println("====" + JSONArray_string + "/////");
				// }
			}
		}

		JSONParser jsonParser = new JSONParser();
		JSONArray parse2;
		// JSONArray a = new JSONArray();

		Iterator iterator;

		ArrayList<JSONArray> parseArray = new ArrayList<JSONArray>();

		for (int i = 0; i < JSONArray_string.size(); i++) {
			parse2 = (JSONArray) jsonParser.parse(JSONArray_string.get(i));
			parseArray.add(parse2);

		}

		for (int j = 0; j < parseArray.size(); j++) {

			for (Object o : parseArray.get(j)) {
				JSONObject parse = (JSONObject) o;
				Id = (String) parse.get("id");
				DeviceSpecific dv = new DeviceSpecific(Id);
//				
//				Set ks = parse.keySet();
//				for (int i=0; i<ks.size(); i++) {
//					String key = (String) ks.iterator().next();
//					String value = (String) parse.get(key);
//					
//					ds.add(key, value);
//				}
//				

				s = parse.keySet();
				s2 = parse.values();

				String[] arr = s.toArray(new String[s.size()]);
				String[] arr2 = (String[]) s2.toArray(new String[s2.size()]);
				// System.out.println(arr2[0]);

				iterator = s.iterator();
				Iterator<String> iterator2 = s2.iterator();
				// System.out.println("id ="+ Id);

				String str = "";
				String str2 = "";

				while (iterator.hasNext() && iterator2.hasNext()) {
					str = (String) iterator.next();
					str2 = (String) iterator2.next();

					if (str == null || str2 == null)
						continue;

					if (str.equals("id") || str2.equals(Id)) {
						iterator.remove();
						// iterator2.remove();
						break;
					}

				}

				for (String aq : s) {
					Set<String> v = parse.keySet();
					ar = v.toArray(new String[v.size()]);
					// System.out.println("KEY === " + aq);
					// System.out.println("ar key test = " + ar[0] + " " + ar[1] + " " + ar[2] + " "
					// + ar[3]);

				}

				for (Object awa : s2) {
					Collection v2 = parse.values();
					ar2 = (String[]) v2.toArray(new String[v2.size()]);
					// System.out.println("VALUE === "+ awa);
					// System.out.println("ar2 value test = " + ar2[0] + " " + ar2[1] + " " + ar2[2]
					// + " " + ar2[3]);
				}

				for (int i = 0; i < ar.length; i++) {
					if (Id.equals(device_id)) {

						ds.add(ar[i], ar2[i]);

					}
				}
			}
		}
		return ds;
	}

	public ArrayList<DeviceSpecific> getAllDeviceSpecific() {
		ArrayList<DeviceSpecific> dslist = new ArrayList<DeviceSpecific>();
		// 파일로부터 모든 ds를 만들어 arraylist로 생성
		// dslist.add(parse);

		return dslist;
	}

	public boolean storeAllDeviceSpecific(ArrayList<DeviceSpecific> dslist) {
		// 현재 DSList의 모든 ds를 json 파일로 새로 쓴다.

		return true;

	}

	public ArrayList<DeviceSpecific> replaceDeviceSpecific(ArrayList<DeviceSpecific> dslist, DeviceSpecific new_ds) {
		// DSList의 요구되는 ds를 dslist에 수정해서 넣거나 추가한다.

		// 1. DSList를 하나씩 훑으면서, new_ds의 id값과 동일한 ds를 찾는다.

		// 2. 동일한 ds를 찾았으면 new_ds로 대체한다.

		// 3. 동일한 ds가 없다면 new_ds를 dslist에 추가한다.

		return dslist;

	}

	public static void main(String[] args) {

	}
}