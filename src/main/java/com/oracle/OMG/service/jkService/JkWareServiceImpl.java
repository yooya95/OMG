package com.oracle.OMG.service.jkService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;


import com.oracle.OMG.dao.jkDao.JkWareDao;
import com.oracle.OMG.dto.Item;
import com.oracle.OMG.dto.Purchase;
import com.oracle.OMG.dto.Warehouse;

import lombok.Data;

@Service
@Data
public class JkWareServiceImpl implements JkWareService {
	
	private final JkWareDao jwd;

	@Override
	public List<Warehouse> monthData(Map<String, String> params) {
		System.out.println("JkWareServiceImpl monthData Start...");
		
		List<Warehouse> monthData = jwd.monthData(params);
		
		return monthData;
	}

	@Override
	public List<Warehouse> getPurchaseData(Map<String, String> params) {
		System.out.println("JkWareServiceImpl getPurchaseData Start...");
		
		List<Warehouse> getPurchaseData = jwd.getPurchaseData(params);
		
		
		return getPurchaseData;
	}

	@Override
	public List<Warehouse> getSalesData(String monthIOData) {
		System.out.println("JkWareServiceImpl getIOData Start...");
		List<Warehouse> getSalesData = jwd.getSalesData(monthIOData);
		return getSalesData;
	}

	@Override
	public List<Warehouse> getIOData(String monthIOData) {
		System.out.println("JkWareServiceImpl getIOData Start...");
		List<Warehouse> getIOData = jwd.getIOData(monthIOData);
		return getIOData;
	}

	@Override
	public List<Warehouse> getPurchaseDataResultMap(String month, String string) {
		System.out.println("JkWareServiceImpl getPurchaseDataResultMap Start...");
		List<Warehouse> getPurchaseDataResultMap = jwd.getPurchaseDataResultMap(month, string);
		return getPurchaseDataResultMap;
	}

	  @Override
	   public Map<String, Object> selectItem(int code, String ym) {
	      System.out.println("JkWareServiceImpl selectItem Start...");
	      
	      Map<String, Object> selectItem= jwd.selectItem(code, ym);
	      
	      return selectItem;
	   }

	@Override
	public int insertInv(Warehouse warehouse) {
		System.out.println("JkWareServiceImpl insertInv start");
		int result = jwd.insertInv(warehouse);

		return result;
	}

	@Override
	public Map<String, Object> selectItem2(int code) {
		System.out.println("JkWareServiceImpl selectItem2 Start...");
		
		Map<String, Object> selectItem2= jwd.selectItem2(code);
		
		return selectItem2;
	}

	@Override
	public int updateInv(Warehouse warehouse) {
		System.out.println("JkWareServiceImpl updateInv Start...");
		int result = jwd.updateInv(warehouse);
		System.out.println("warehouse"+warehouse);
		
		return result;
	}

	@Override
	public int deleteInv(Warehouse warehouse) {
		System.out.println("JkWareServiceImpl deleteInv Start...");
		int result = jwd.deleteInv(warehouse);
		System.out.println("service result"+result);
		
		return result;
	}

	@Override
	public List<Purchase> purMonthData(String month) {
		System.out.println("JkWareServiceImpl monthData Start...");
		List<Purchase> purMonthData = jwd.purMonthData(month);
		return purMonthData;
	}

    @Override
    public Map<String, String> callInboundPD(String purDate, int custCode) {
        Map<String, String> response = new HashMap<>();

        try {
            // 프로시저 호출
            jwd.callInboundPD(purDate, custCode);

            // 성공적으로 프로시저가 호출되면 성공 메시지를 추가
            response.put("status", "success");
            response.put("message", "Inbound process completed successfully.");
        } catch (Exception e) {
            // 실패 시 실패 메시지를 추가
            response.put("status", "error");
            response.put("message", "Error during the inbound process: " + e.getMessage());
        }

        return response;
    }

	@Override
	public List<Warehouse> inboundList() {
		System.out.println("JkWareServiceImpl inboundList Start...");
		
		List<Warehouse> inboundList = jwd.inboundList();
		
		return inboundList;
	}

	@Override
	public int inboundTotal(Warehouse warehouse) {
		System.out.println("JkWareServiceImpl inboundTotal Start...");
		int inboundTotal = 0;
		
		inboundTotal = jwd.inboundTotal(warehouse);
		
		return  inboundTotal;
	}

	@Override
	public List<Warehouse> monthInbound(String inboundMonth) {
	System.out.println("JkWareServiceImpl monthInbound Start...");
		
		List<Warehouse> monthInbound = jwd.monthInbound(inboundMonth);
		
		return monthInbound;
	}

	@Override
	public Map<String, String> callOutboundPD(String salesDate, int custCode) {
		  Map<String, String> response = new HashMap<>();

	        try {
	            // 프로시저 호출
	            jwd.callOutoundPD(salesDate, custCode);

	            // 성공적으로 프로시저가 호출되면 성공 메시지를 추가
	            response.put("status", "success");
	            response.put("message", "Inbound process completed successfully.");
	        } catch (Exception e) {
	            // 실패 시 실패 메시지를 추가
	            response.put("status", "error");
	            response.put("message", "Error during the inbound process: " + e.getMessage());
	        }

	        return response;
	}

	@Override
	public List<Warehouse> monthOutbound(String outboundMonth) {
		System.out.println("JkWareServiceImpl monthOutbound Start...");
		
		List<Warehouse> monthOutbound = jwd.monthOutbound(outboundMonth);
		
		return monthOutbound;
	}

	@Override
	public Map<String, String> callCloseMonth(String inboundMonth) {
		  Map<String, String> response = new HashMap<>();

	        try {
	            // 프로시저 호출
	            jwd.callCloseMonth(inboundMonth);

	            // 성공적으로 프로시저가 호출되면 성공 메시지를 추가
	            response.put("status", "success");
	            response.put("message", "Inbound process completed successfully.");
	        } catch (Exception e) {
	            // 실패 시 실패 메시지를 추가
	            response.put("status", "error");
	            response.put("message", "Error during the inbound process: " + e.getMessage());
	        }

	        return response;
	}
	



}
