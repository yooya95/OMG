package com.oracle.OMG.dao.jkDao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.OMG.dto.Item;
import com.oracle.OMG.dto.Purchase;
import com.oracle.OMG.dto.Warehouse;

import lombok.Data;
import lombok.RequiredArgsConstructor;

@Repository
@Data
@RequiredArgsConstructor
public class JkWareDaoImpl implements JkWareDao {

	private final SqlSession session;
	
	
	@Override
	public List<Warehouse> monthData(Map<String, String> params) {
		System.out.println("JkWareDaoImpl monthData start...");
		List<Warehouse> monthData = null;
		
		try {
			monthData = session.selectList("monthDataList", params);
			System.out.println("monthDatalistsize"+monthData);
			 System.out.println("Params: " + params);
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("JkWareDaoImpl monthDataList error?"+ e.getMessage());
		}
		
		return monthData;
	}


	@Override
	public List<Warehouse> getIOData(String monthIOData) {
		System.out.println("JkWareDaoImpl getIOData start...");
		List<Warehouse> getIOData = null;
		
		try {
			getIOData = session.selectList("getIOData", monthIOData);
			System.out.println("monthDatalistsize"+getIOData);
			 System.out.println("monthIOData: " + monthIOData);
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("JkWareDaoImpl getIOData error?"+ e.getMessage());
		}
		
		return getIOData;
	}


	@Override
	public List<Warehouse> getPurchaseData(Map<String, String> params) {
	    System.out.println("JkWareDaoImpl getPurchaseData start...");
	    
	    List<Warehouse> getPurchaseData = null;
	    
	    try {
	        getPurchaseData = session.selectList("getPurchaseData", params);
	        System.out.println("monthDatalistsize: " + getPurchaseData.size());
	        System.out.println("params: " + params);
	    } catch(Exception e) {
	        e.printStackTrace();
	        System.out.println("JkWareDaoImpl getPurchaseData error: " + e.getMessage());
	    }
	    return getPurchaseData;
	}


	@Override
	public List<Warehouse> getSalesData(String monthIOData) {
		System.out.println("JkWareDaoImpl getSalesData start...");
		List<Warehouse> getSalesData = null;
		
		try {
			getSalesData = session.selectList("getSalesData", monthIOData);
			System.out.println("monthDatalistsize"+getSalesData);
			 System.out.println("monthIOData: " + monthIOData);
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("JkWareDaoImpl getSalesData error?"+ e.getMessage());
		}
		return getSalesData;
	}


	@Override
	public List<Warehouse> getPurchaseDataResultMap(String month, String string) {
		System.out.println("JkWareDaoImpl getPurchaseDataResultMap start...");
		List<Warehouse> getPurchaseDataResultMap = null;
		
		try {
			getPurchaseDataResultMap = session.selectList("resultmap01", getPurchaseDataResultMap);
			System.out.println("getPurchaseDataResultMaptsize"+getPurchaseDataResultMap);
			 System.out.println("getPurchaseDataResultMap: " + getPurchaseDataResultMap);
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("JkWareDaoImpl getSalesData error?"+ e.getMessage());
		}
		return getPurchaseDataResultMap;
	}


   @Override
   public Map<String, Object> selectItem(@Param("code") int code, @Param("ym") String ym) {
       System.out.println("JkWareDaoImpl selectItemByCode start");
       Map<String, Object> itemDetails = null;
       try {
           // 매퍼 메서드에 파라미터를 전달하도록 수정
           Map<String, Object> parameters = new HashMap<>();
           parameters.put("code", code);
           parameters.put("ym", ym);
           
           itemDetails = session.selectOne("selectItem", parameters);
       } catch (Exception e) {
           System.out.println(e.getMessage());
       }
       return itemDetails;
   }


	@Override
	public int insertInv(Warehouse warehouse) {
		System.out.println("JkWareDaoImpl insertInv start");
		int result = 0;
	
		try {
			result = session.insert("insertInv", warehouse);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		
		}
		return result;
	}


	@Override
	public Map<String, Object> selectItem2(int code) {
		 System.out.println("JkWareDaoImpl selectItemByCode start");
		    Map<String, Object> itemDetails = null;
		    try {
		      
		        Map<String, Object> parameters = new HashMap<>();
		        parameters.put("code", code);
		       		        
		        itemDetails = session.selectOne("selectItem2", parameters);
		    } catch (Exception e) {
		        System.out.println(e.getMessage());
		    }
		    return itemDetails;
	}


	@Override
	public int updateInv(Warehouse warehouse) {
		System.out.println("JkWareDaoImpl updateInv start");
		int result = 0;
	
		try {
			result = session.update("updateInv", warehouse);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		
		}
		return result;
	}


	@Override
	public int deleteInv(Warehouse warehouse) {
		System.out.println("JkWareDaoImpl deleteInv start");
		int result = 0;
	
		try {
			result = session.delete("deleteInv", warehouse);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		
		}
		return result;
	}


	@Override
	public List<Purchase> purMonthData(String month) {
		System.out.println("JkWareDaoImpl monthData start...");
		List<Purchase> purMonthData = null;
		
		try {
			purMonthData = session.selectList("purMonthData", month);
			System.out.println("monthDatalistsize"+purMonthData);
			 System.out.println("Params: " + purMonthData);
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("JkWareDaoImpl monthDataList error?"+ e.getMessage());
		}
		
		return purMonthData;
	}


	@Override
	public void callInboundPD(String purDate, int custCode) {
	    try {
	        Map<String, Object> parameters = new HashMap<>();
	        parameters.put("purDate", purDate);
	        parameters.put("custCode", custCode);

	        // 프로시저 호출
	        int updatedRows = session.update("callInboundPD", parameters);
	        
	        // 업데이트된 행의 수를 출력
	        System.out.println("Updated rows: " + updatedRows);
	    } catch (Exception e) {
	        // 프로시저 호출 중 오류 처리
	        e.printStackTrace();
	    }
	}


	@Override
	public List<Warehouse> inboundList() {
		System.out.println("JkWareDaoImpl monthData start...");
		List<Warehouse> inboundList = null;
		
		try {
			inboundList = session.selectList("inboundList");
			System.out.println("monthDatalistsize"+inboundList);
			 System.out.println("Params: " + inboundList);
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("JkWareDaoImpl inboundList error?"+ e.getMessage());
		}
		
		return inboundList;
	}


	@Override
	public int inboundTotal(Warehouse warehouse) {
	System.out.println("JkWareDaoImpl inboundTotal start...");
		
		int inboundTotal = 0;
		try {
			inboundTotal = session.selectOne("inboundTotal",warehouse);
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("JkWareDaoImpl inboundTotal e.getMessage()" + e.getMessage());
		}
		return inboundTotal;
	}


	@Override
	public List<Warehouse> monthInbound(String inboundMonth) {
		System.out.println("JkWareDaoImpl monthInbound start...");
		List<Warehouse> monthInbound = null;
		
		try {
			monthInbound = session.selectList("monthInbound", inboundMonth);
			System.out.println("monthDatalistsize"+monthInbound);
			 System.out.println("Params: " + monthInbound);
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("JkWareDaoImpl inboundList error?"+ e.getMessage());
		}
		
		return monthInbound;
	}


	@Override
	public void callOutoundPD(String salesDate, int custCode) {
		 try {
		        Map<String, Object> parameters = new HashMap<>();
		        parameters.put("salesDate", salesDate);
		        parameters.put("custCode", custCode);

		        // 프로시저 호출
		        int updatedRows = session.update("callOutboundPD", parameters);
		        
		        // 업데이트된 행의 수를 출력
		        System.out.println("Updated rows: " + updatedRows);
		    } catch (Exception e) {
		        // 프로시저 호출 중 오류 처리
		        e.printStackTrace();
		    }
		}
		
	@Override
	public List<Warehouse> monthOutbound(String outboundMonth) {
		System.out.println("JkWareDaoImpl monthOutbound start...");
		List<Warehouse> monthOutbound = null;
		
		try {
			monthOutbound = session.selectList("monthOutbound", outboundMonth);
			System.out.println("monthDatalistsize"+monthOutbound);
			 System.out.println("Params: " + monthOutbound);
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("JkWareDaoImpl inboundList error?"+ e.getMessage());
		}
		
		return monthOutbound;
	}


	@Override
	public void callCloseMonth(String inboundMonth) {
	    System.out.println("JkWareDaoImpl callOutoundPD start...");

	    try {
	        int updatedRows = session.update("callCloseMonth", inboundMonth);

	        // 업데이트된 행의 수를 출력
	        System.out.println("Updated rows: " + updatedRows);
	    } catch (Exception e) {
	        // 프로시저 호출 중 오류 처리
	        e.printStackTrace();
	    }
	}


	
}
