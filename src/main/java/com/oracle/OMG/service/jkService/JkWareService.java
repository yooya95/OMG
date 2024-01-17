package com.oracle.OMG.service.jkService;

import java.util.List;
import java.util.Map;

import com.oracle.OMG.dto.Item;
import com.oracle.OMG.dto.Purchase;
import com.oracle.OMG.dto.Warehouse;

public interface JkWareService {

	List<Warehouse> monthData(Map<String, String> params);
	List<Warehouse> getPurchaseData(Map<String, String> params);
	List<Warehouse> getSalesData(String monthIOData);
	List<Warehouse> getIOData(String monthIOData);
	List<Warehouse> getPurchaseDataResultMap(String month, String string);
	
	// 제품조회
	Map<String, Object> 		selectItem(int code, String ym);
	Map<String, Object> 		selectItem2(int code);

	// 기초재고 관리
	int 						insertInv(Warehouse warehouse);
	int 						updateInv(Warehouse warehouse);
	int 						deleteInv(Warehouse warehouse);
	
	// 발주 조회
	List<Purchase>				purMonthData(String month);
	
	List<Warehouse> 			inboundList();
	int 						inboundTotal(Warehouse warehouse);
	
	
	// 입고 출고 프로시져 호출
	Map<String, String> 		callInboundPD(String purDate, int custCode);
	Map<String, String> 		callOutboundPD(String salesDate, int custCodeStr);
	
	// 마감 프로시저 호출
	Map<String, String> 		callCloseMonth(String inboundMonth);
	
	//입출고 조회
	List<Warehouse> 			monthOutbound(String outboundMonth);
	List<Warehouse> 			monthInbound(String inboundMonth);
	
	
	

	
	
}
