<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.sql.*, java.util.*, webmodules.*, structures.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	int id = Integer.parseInt(request.getParameter("id")); 

	DBManager dbm = new DBManager(application.getRealPath("/"));
	
	dbm.connect();
	ItemCommon ic = new ItemCommon();
	
	ic.setId(id);
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
	int size = Integer.valueOf(isSize);

	//System.out.println("size test = " + size);
	
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
			//System.out.print(i + " - seq: " + mdseq + " | group : " + mdgroup + " | key : " + mdkey + " |  value : " + mdvalue);
			//System.out.print("  added");	
		}
		//System.out.println();
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
		//System.out.print("index : " + (seq+1) + " | min : " + min + " | min seq index : " + minindex);
		sortedGroup.add(groupList.get(minindex));
		sortedKey.add(keyList.get(minindex));
		sortedValue.add(valueList.get(minindex));
		
		//System.out.println(" | seq : " + seqList.get(minindex) + " | group : " + groupList.get(minindex) 
		//					+ " | key : " + keyList.get(minindex) + " | value : " + valueList.get(minindex));
		
		seqList.remove(minindex);
		groupList.remove(minindex);
		keyList.remove(minindex);
		valueList.remove(minindex);
		seq++;
	}
	
	dbm.deleteItemSpecific(id);
	dbm.insertItemSpecific(id, sortedGroup, sortedKey, sortedValue);
	dbm.disconnect();
	
	
	out.println("<script type='text/javascript'>");
	out.println("	location.href='itemDetail.jsp?id=" + id + "';");
	out.println("</script>");
%>