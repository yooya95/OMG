package com.oracle.OMG.dao.jkDao;

import java.util.List;
import java.util.Map;


import com.oracle.OMG.dto.Purchase;
import com.oracle.OMG.dto.Warehouse;

public interface JkWareDao {
	
	// 리스트
	List<Warehouse> monthData(Map<String, String> params);
	List<Warehouse> getIOData(String monthIOData);
	List<Warehouse> getPurchaseData(Map<String, String> params);
	List<Warehouse> getSalesData(String monthIOData);
	List<Warehouse> getPurchaseDataResultMap(String month, String string);

	// 기초재고 생성
	int insertInv(Warehouse warehouse);

	Map<String, Object> 		selectItem(int code, String ym);
	Map<String, Object> 		selectItem2(int code);

	int updateInv(Warehouse warehouse);
	int deleteInv(Warehouse warehouse);

	List<Purchase> 				purMonthData(String month);
	
	List<Warehouse> 			inboundList();
	int							inboundTotal(Warehouse warehouse);
	
	
	
	// 프로시져 호출
	void 						callOutoundPD(String salesDate, int custCodeStr);
	void 						callInboundPD(String purDate, int custCode);
	void 						callCloseMonth(String inboundMonth);
	
	
	// 입출고 조회
	List<Warehouse> 			monthOutbound(String outboundMonth);
	List<Warehouse> 			monthInbound(String inboundMonth);
	

}
