<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.sql.*, java.util.*, core.*, structures.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	int item_id = Integer.parseInt(request.getParameter("item_id")); 

	DBManager dbm = new DBManager(application.getRealPath("/"));
//	System.out.println("modified action : " + item_id);
	
	dbm.connect();
	ItemCommon ic = new ItemCommon();
	
	ic.setId(item_id);
	ic.setModel_name(request.getParameter("model_name"));
	ic.setDevice_type(request.getParameter("device_type"));
	ic.setManufacturer(request.getParameter("manufacturer"));
	ic.setCategory(request.getParameter("category"));
	dbm.updateItemCommon(ic);

	ArrayList<Integer> seqList = new ArrayList<Integer>();
	ArrayList<String> groupList = new ArrayList<String>();
	ArrayList<String> keyList = new ArrayList<String>();
	ArrayList<String> valueList = new ArrayList<String>();
	
	String isSize = request.getParameter("isSize");
//	System.out.println("isSize : "+ isSize);
	
	int size = Integer.valueOf(isSize);

	for(int i = 0; i < size; i++) {
		String mdseq = request.getParameter("Dseq" + i);
		String mdgroup = request.getParameter("Dgroup" + i);
		String mdkey = request.getParameter("Dkey" + i);
		String mdvalue =  request.getParameter("Dvalue" + i);

		//System.out.print(i + " - seq: " + mdseq + " | group : " + mdgroup + " | key : " + mdkey + " |  value : " + mdvalue);

		int seq=0;

		if (!(mdseq=="" || mdseq==null || mdseq.equals("null")))	
			seq= Integer.parseInt(mdseq);
	
		if (!(mdgroup=="" || mdgroup==null || mdgroup.equals("null")) &&
			!(mdkey=="" || mdkey==null || mdkey.equals("null")) &&
			!(mdvalue == "" || mdvalue==null || mdvalue.equals("null"))) {
			seqList.add(seq);
			groupList.add(mdgroup);
			keyList.add(mdkey);
			valueList.add(mdvalue);
		}
	}
	
	ArrayList<String> sortedGroup = new ArrayList<String>();
	ArrayList<String> sortedKey = new ArrayList<String>();
	ArrayList<String> sortedValue = new ArrayList<String>();
    
	// sorting group,key,value array by seq list
	int seq=0; 
	while (seqList.size()>0) {
		// find min value greater than 0
		int min = seqList.get(0);
		int minindex = 0;
		for (int i=1; i<seqList.size(); i++) {
			if (seqList.get(i) > 0) {
				if (min <= 0 || min > seqList.get(i)) {
					min = seqList.get(i);
					minindex = i; 
				}
			}
		}
		sortedGroup.add(groupList.get(minindex));
		sortedKey.add(keyList.get(minindex));
		sortedValue.add(valueList.get(minindex));
		
		seqList.remove(minindex);
		groupList.remove(minindex);
		keyList.remove(minindex);
		valueList.remove(minindex);
		seq++;
	}
	
	
	// check the specific information and it affects measurement table.
	ArrayList<String> originlist = dbm.getDBModuleList(ic.getId());
	ArrayList<String> inputlist = dbm.getInputModuleList(sortedKey, sortedValue); 
	
//	System.out.print("original sensor and actuator : ");
//	for (int i=0; i<originlist.size(); i++) 
//		System.out.print(originlist.get(i) + " ");
//	System.out.println();

//	System.out.print("input sensor and actuator : ");
//	for (int i=0; i<inputlist.size(); i++) 
//		System.out.print(inputlist.get(i) + " ");
//	System.out.println();

	// change specific information of item	
	dbm.deleteItemSpecific(ic.getId());
	dbm.insertItemSpecific(ic.getId(), sortedGroup, sortedKey, sortedValue);
	
	// Treat measurement tables of referred devices
	if (!CoreModules.isKeyListSame(originlist, inputlist)) {
		System.out.println("the key list is not same.");
		ArrayList<DeviceInfo> dilist = dbm.getList_Device(ic.getId());
		
//		ArrayList<DeviceInfo> disabledList = new ArrayList<DeviceInfo>();
		for (int i=0; i<dilist.size(); i++) {
			DeviceInfo di = dilist.get(i);
			System.out.print("device " + di.getDevice_id() + " : " + di.getTable_name() + " ... ");
			
			// if measurement table of each device has sensing data, the device set to be disabled.
			// otherwise, if the table is empty, measurement table is re-created.
			if (dbm.getCount_DeviceMeasurement(di.getTable_name())>0 && di.isEnabled()) {
				System.out.print("disabled.");
				dbm.updateDeviceEnabled(di.getDevice_id(), false);
			} else {
				dbm.deleteTableDeviceMeasurement(di.getTable_name());
				System.out.print("deleted. ");
				
				if (dbm.createTable_DeviceMeasurement(di.getItem_id(), di.getTable_name())) {
					System.out.print("And table is recreated.");
				} else {
					System.out.println("Table " + di.getTable_name() + " cannot be re-created.");
					System.out.print("device " + di.getDevice_id() + " is disabled.");
//					dbm.updateDeviceTableName(di.getDevice_id(), "");
					dbm.updateDeviceEnabled(di.getDevice_id(), false);
				}
			}
				
			System.out.println();
		}
	}

	dbm.disconnect();
	
	out.println("<script type='text/javascript'>");
	out.println("	location.href='itemDetail.jsp?item_id=" + ic.getId() + "';");
	out.println("</script>");
%>
