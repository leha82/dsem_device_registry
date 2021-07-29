package webmodules.mongodb;

import java.net.UnknownHostException;
import java.security.Timestamp;
import java.sql.*;
import java.util.*;

import java.text.SimpleDateFormat;

//import com.sun.org.apache.bcel.internal.generic.DMUL;

import structures.mongodb.*;
//import sun.awt.SunHints.Value;

//import org.apache.jasper.tagplugins.jstl.core.Catch;
import org.bson.Document;
import org.bson.conversions.Bson;
import org.bson.types.ObjectId;

import com.mongodb.ServerAddress;
import com.mongodb.MongoClient;
import com.mongodb.MongoException;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.model.UpdateOptions;
import com.mongodb.client.result.UpdateResult;

import static com.mongodb.client.model.Filters.*;

public class MongoDBManager {
	private static String MongoDB_IP = "localhost";
	private static int MongoDB_PORT = 27017;
	private static String DB_NAME = "dbtest";

	private MongoClient mongoClient;
	private MongoDatabase db;
	private MongoCollection<Document> collection;

//	private String model_name;
//	private String registration_time;
//	private String device_type;
//	private String manufacturer;
//	private String category;

	public MongoDBManager() {

	}

	public void connectDB(String collectionName) {
		// Connect to MongoDB
		mongoClient = new MongoClient(new ServerAddress(MongoDB_IP, MongoDB_PORT));

		// Mongo mongo = new Mongo("localhost", 27017);
		db = mongoClient.getDatabase(DB_NAME);
		collection = db.getCollection(collectionName);
	}
	
	public void disconnectDB() {
		if (mongoClient!=null)
			mongoClient.close();
	}
	
	public void insertDeviceCommon(String modelName, String deviceType, 
			String manufacturer, String category) {

		connectDB("device_regi9");
		
		try {
			// DBCollection collection = db.getCollection("device_regi3");
			Calendar cal = Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy / MM / dd / HH:mm:ss");
			String now_time = sdf.format(cal.getTime());

//			BasicDBObject document = new BasicDBObject();
//			document.put("registrationTime", now_time);
//			document.put("modelName", modelName);
//			document.put("deviceType", deviceType);
//			document.put("manufacturer", manufacturer);
//			document.put("category", catergory);
//
//			collection.insert(document);

			Document document = new Document("registrationTime", now_time);
			document.append("modelName", modelName);
			document.append("deviceType", deviceType);
			document.append("manufacturer", manufacturer);
			document.append("category", category);
			collection.insertOne(document);
			
			System.out.println("collection-----test----->>>>>" + document.size());
			//BasicDBObject searchQuery = new BasicDBObject();
			// searchQuery.put("modelName", modelName);
			// DBCursor cursor = collection.find(searchQuery);
			// DBCursor cursor = collection.find();

			MongoCursor<Document> cursor = collection.find().iterator();
			while (cursor.hasNext()) {
				System.out.println(cursor.next().toJson());
			}
			cursor.close();

			System.out.println("���� ��� ���� ����");
		} catch (MongoException e) {
			e.printStackTrace();
		}
		
		disconnectDB();
	}
	public void updateDeviceCommon(String id ,String time, String modelName, String deviceType, 
			String manufacturer, String category) {

		connectDB("device_regi9");
		
		try {
			//collection.deleteOne(new Document("_id", new ObjectId(id)));
			collection.deleteOne(new Document("_id", new ObjectId(id)));
			Document document = new Document();
			document.append("_id",  new ObjectId(id));
			document.append("registrationTime", time);
			document.append("modelName", modelName);
			document.append("deviceType", deviceType);
			document.append("manufacturer", manufacturer);
			document.append("category", category);
			
			collection.insertOne(document);
			
			System.out.println("collection-----test----->>>>>" + document.size());

			MongoCursor<Document> cursor = collection.find().iterator();
			while (cursor.hasNext()) {
				System.out.println(cursor.next().toJson());
			}
			cursor.close();

			System.out.println("���� ��� ���� ����");
		} catch (MongoException e) {
			e.printStackTrace();
		}
		
		disconnectDB();
	}
	public ArrayList<DeviceCommon> getDeviceList() {
		ArrayList<DeviceCommon> devList = new ArrayList<DeviceCommon>();
		
		connectDB("device_regi9");

		// Iterator<DBObject> cursor = collection.find().iterator();
		// DBCursor cursor2 = (DBCursor) collection.find().iterator();
		try {
			
			MongoCursor<Document> cursor = collection.find().iterator();

//			ArrayList<DBObject> doc2 = new ArrayList<DBObject>();
//			DBCursor cursor2 = collection.find();
			int i=1;
			while (cursor.hasNext()) {
				Document document = cursor.next();
				//doc2.add(doc);
				System.out.println("doctest-->>>>>>__>>>" + i++); // collection �� �ִ� ��� ������ ��
				System.out.println("cursortest->>>>>>>>>>>>>>" + document.toJson().toString());

//				ArrayList<Object> key = new ArrayList<Object>(doc.keySet()); // key ����
//				DBObject value = collection.findOne(); // value ����

				DeviceCommon dc = new DeviceCommon();
				String id = (String) document.get("_id").toString();
				dc.setId(id);
				// for (int i = 0; i < key.size(); i++) {
				// System.out.printf("%s : %s%n", key.get(i), value.get((String) key.get(i)));
				// System.out.printf("%s : %s%n", key.get(i), doc.get((String) key.get(i)));
				// System.out.println("<>" + key.get(i) + " : " + doc.get((String) key.get(i)));

				dc.setregistration_time(document.get("registrationTime"));
				dc.setmodel_name(document.get("modelName"));
				dc.setDevice_type(document.get("deviceType"));
				dc.setManufacturer(document.get("manufacturer"));
				dc.setCategory(document.get("category"));
				devList.add(dc);

				// }
				System.out.println(dc.toString());
				System.out.println(dc.getId().toString());
			}

			cursor.close();

		} catch (MongoException e) {
			System.out.println(e.getMessage());
		}

		disconnectDB();
		
		return devList;
	}

	public DeviceCommon getDeviceCommon(String device_id) {
		
		connectDB("device_regi9");

		DeviceCommon dc = new DeviceCommon();
		
		try {
//			MongoCursor<Document> cursor = collection.find(eq("_id",device_id)).iterator();
			Document document = collection.find(eq("_id",new ObjectId(device_id))).first();

			if (document!=null) {
				dc.setId(document.get("_id").toString());
				dc.setregistration_time(document.get("registrationTime"));
				dc.setmodel_name(document.get("modelName"));
				dc.setDevice_type(document.get("deviceType"));
				dc.setManufacturer(document.get("manufacturer"));
				dc.setCategory(document.get("category"));
			}

		} catch (MongoException e) {
			System.out.println(e.getMessage());
		}

		disconnectDB();
		
		return dc;
	}

	public void deleteDeviceCommon(String device_id) {
		connectDB("device_regi9"); 
		collection.deleteOne(new Document("_id", new ObjectId(device_id)));
		disconnectDB();
		deleteDeviceSpecific(device_id);
		//device common ����
		disconnectDB();
	}
	
	public void insertDeviceSpecific(String device_id, ArrayList<String> keyList, ArrayList<String> valueList) {
		connectDB("device_regi6"); 
		System.out.println("������� ����");
		deleteDeviceSpecific(device_id);
		
		try {
//			BasicDBObject document = new BasicDBObject();
			Document document = new Document("cd_oid", new ObjectId(device_id));

			for (int i = 0; i < keyList.size(); i++) {
				document.append(keyList.get(i), valueList.get(i));
			}
//			collection.insert(document);
			collection.insertOne(document);
			
			System.out.println("collection-----test----->>>>>" + document.size());

			MongoCursor<Document> cursor = collection.find().iterator();

			while (cursor.hasNext()) {
				System.out.println(cursor.next());
			}
		} catch (MongoException e) {
			e.printStackTrace();
		}
		
		disconnectDB();
	}

	public DeviceSpecific getDeviceSpecific(String device_id) {
		DeviceSpecific ds = new DeviceSpecific();

		connectDB("device_regi6");
		try {
			Document document = collection.find(eq("cd_oid", new ObjectId(device_id))).first();

			if (document!=null) {
				ArrayList<Object> keyList = new ArrayList<Object>(document.keySet()); // key ����
				String key2 = keyList.get(1).toString();
				ds.setId(document.get(key2));
				
				for (int i=0; i<keyList.size(); i++) {
//					System.out.println(key.get(i).toString());
					String key = keyList.get(i).toString();
					
					if (!key.equals("_id") && !key.equals("cd_oid")) {
						ds.add(key, document.get(key));
					}
				}
			}

		} catch (MongoException e) {
			System.out.println(e.getMessage());
		}

		disconnectDB();
		
		return ds;
	}

	public void deleteDeviceSpecific(String device_id) {
		connectDB("device_regi6");
		collection.deleteOne(new Document("cd_oid", new ObjectId(device_id)));
		// device specific ����  cd_oid == device_id�� �����ɷ� ObjectId ��ü �̿�
	}
	
	public static void main(String[] args) {
		// MongoDBManager mgb = new MongoDBManager();
		// mgb.getDeviceList();
	}
}