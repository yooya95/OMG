package com.oracle.OMG.dao.chDao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Repository;

import com.oracle.OMG.dto.PurDetail;
import com.oracle.OMG.dto.Purchase;

import lombok.Data;

@Repository
@Data
public class ChPurDaoImpl implements ChPurDao {
	
	private final SqlSession session;
	// 발주서 리스트 조회
	@Override
	public List<Purchase> purList(Purchase purchase) {
		System.out.println("ChPurDaoImpl purList start...");
		List<Purchase> purList = null;
		
		try {
			purList = session.selectList("chPurList",purchase);
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("ChPurDaoImpl purList e.getMessage()" + e.getMessage());
		}
		System.out.println("ChPurDaoImpl purList.size()->" + purList.size());
		return purList;
	}
	// 발주 상세 
	@Override
	public List<PurDetail> purDList(Purchase p) {
		System.out.println("ChPurDaoImpl purList start...");
		List<PurDetail> purDList = null;
		
		try {
			purDList = session.selectList("chPurDList", p);
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("ChPurDaoImpl purList e.getMessage()" + e.getMessage());
		}
		
		return purDList;
	}

	@Override
	public Purchase onePur(Purchase purchase) {
		System.out.println("ChPurDaoImpl onePur start...");
		
		Purchase pc = null;
		try {
			pc = session.selectOne("chPurOne", purchase);
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("ChPurDaoImpl purchase e.getMessage()" + e.getMessage());
		}
		return pc;
	}
	@Override
	public int totalPur(Purchase purchase) {
		System.out.println("ChPurDaoImpl totalPur start...");
		
		int total = 0;
		try {
			total = session.selectOne("chTotalPur",purchase);
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("ChPurDaoImpl totalPur e.getMessage()" + e.getMessage());
		}
		return total;
	}
	@Override
	public int insertDetail(PurDetail pd) {
		System.out.println("ChPurDaoImpl insertDetail start...");
		
		int result = 0;
		try {
			result = session.insert("chInsertDetail", pd);
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("ChPurDaoImpl insertDetail e.getMessage()" + e.getMessage());
		}
		return result;
	}
	@Override
	public int countDitem(PurDetail purDetail) {
		System.out.println("ChPurDaoImpl countDitem start...");
		
		int result = 0;
		try {
			result = session.selectOne("chCountDitem", purDetail);
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("ChPurDaoImpl countDitem e.getMessage()" + e.getMessage());
		}
		return result;
	}
	@Override
	public int writePur(Purchase purchase) {
		System.out.println("ChPurDaoImpl writePur start...");
		
		int result = 0;
		try {
			result = session.insert("chPurWrite", purchase);
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("ChPurDaoImpl writePur e.getMessage()" + e.getMessage());
		}
		return result;
	}
	@Override
	public int detailWrite(List<PurDetail> detailList) {
		System.out.println("ChPurDaoImpl detailWrite start...");
		
		int result = 0;
		for(PurDetail pd : detailList) {
			try {
				System.out.println("detailWrite count---------->" + result);
				result += session.insert("detailWrite", pd);
				
			} catch (Exception e) {
				e.printStackTrace();
				System.out.println("ChPurDaoImpl detailWrite e.getMessage()" + e.getMessage());
			}
		}
		return result;
	}
	@Override
	public int qtyUpdate(PurDetail pd) {
		System.out.println("ChPurDaoImpl detailWrite start...");
		
		int result = 0;
		try {
			result = session.update("chQtyUpdate", pd);
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("ChPurDaoImpl detailWrite e.getMessage()" + e.getMessage());
		}
		return result;
	}
	@Override
	public int completePur(Purchase purchase) {
		System.out.println("ChPurDaoImpl completePur start...");
		
		int result = 0;
		try {
			result = session.update("chcompletePur", purchase);
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("ChPurDaoImpl completePur e.getMessage()" + e.getMessage());
		}
		return result;
	}
	@Override
	public int deletePur(Purchase purchase) {
		System.out.println("ChPurDaoImpl deletePur start...");
		
		int result = 0;
		try {
			result = session.delete("chdeletePur", purchase);
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("ChPurDaoImpl deletePur e.getMessage()" + e.getMessage());
		}
		return result;
	}
	@Override
	public int purUpdate(Purchase purchase) {
		System.out.println("ChPurDaoImpl purUpdate start...");
		
		int result = 0;
		try {
			result = session.update("chpurUpdate", purchase);
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("ChPurDaoImpl deletePur e.getMessage()" + e.getMessage());
		}
		return result;
	}
	@Override
	public int deletePurDet(PurDetail purDetail) {
		System.out.println("ChPurDaoImpl deltePurDet start...");
		
		int result = 0;
		try {
			result = session.delete("chDeletePurDet", purDetail);
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("ChPurDaoImpl deltePurDet e.getMessage()" + e.getMessage());
		}
		return result;
	}

	
}
