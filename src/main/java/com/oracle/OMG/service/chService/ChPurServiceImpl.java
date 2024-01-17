package com.oracle.OMG.service.chService;

import java.util.List;

import org.springframework.stereotype.Service;

import com.oracle.OMG.dao.chDao.ChPurDao;
import com.oracle.OMG.dto.PurDetail;
import com.oracle.OMG.dto.Purchase;

import lombok.Data;

@Service
@Data
public class ChPurServiceImpl implements ChPurService {
	
	private final ChPurDao chPurDao;

	@Override
	public List<Purchase> purList(Purchase purchase) {
		System.out.println("ChPurServiceImpl purList Start...");
		
		List<Purchase> purList = chPurDao.purList(purchase);
		
		return purList;
	}

	@Override
	public List<PurDetail> purDList(Purchase p) {
		System.out.println("ChPurServiceImpl purDList Start...");
		
		List<PurDetail> purDList = chPurDao.purDList(p);
		
		return purDList;
	}

	@Override
	public Purchase onePur(Purchase purchase) {
		System.out.println("ChPurServiceImpl onePur Start...");
		
		Purchase pc = null;
		
		pc = chPurDao.onePur(purchase);
		
		return pc;
	}

	@Override
	public int totalPur(Purchase purchase) {
		System.out.println("ChPurServiceImpl totalPur Start...");
		int total = 0;
		
		total = chPurDao.totalPur(purchase);
		
		
		return total;
	}

	@Override
	public int insertDetail(PurDetail pd) {
		System.out.println("ChPurServiceImpl insertDetail Start...");
		int result = 0;
		
		result = chPurDao.insertDetail(pd);
		
		
		return result;
	}

	@Override
	public int countDitem(PurDetail purDetail) {
		System.out.println("ChPurServiceImpl countDitem Start...");
		int result = 0;
		
		result = chPurDao.countDitem(purDetail);
		
		
		return result;
	}

	@Override
	public int writePur(Purchase purchase) {
		System.out.println("ChPurServiceImpl writePur Start...");
		int result = 0;
		
		result = chPurDao.writePur(purchase);
		
		return result;
	}

	@Override
	public int detailWrite(List<PurDetail> detailList) {
		System.out.println("ChPurServiceImpl detailWrite Start...");
		int result = 0;
		
		result = chPurDao.detailWrite(detailList);
		
		return result;
	}

	@Override
	public int qtyUpdate(PurDetail pd) {
		System.out.println("ChPurServiceImpl qtyUdate Start...");
		int result = 0;
		
		result = chPurDao.qtyUpdate(pd);
		
		return result;
	}

	@Override
	public int completePur(Purchase purchase) {
		System.out.println("ChPurServiceImpl completePur Start...");
		int result = 0;
		
		result = chPurDao.completePur(purchase);
		
		return result;
	}

	@Override
	public int deletePur(Purchase purchase) {
		System.out.println("ChPurServiceImpl deletePur Start...");
		int result = 0;
		
		result = chPurDao.deletePur(purchase);
		
		return result;
	}

	@Override
	public int purUpdate(Purchase purchase) {
		System.out.println("ChPurServiceImpl purUpdate Start...");
		int result = 0;
		
		result = chPurDao.purUpdate(purchase);
		
		return result;
	}

	@Override
	public int deletePurDet(PurDetail purDetail) {
		System.out.println("ChPurServiceImpl deltePurDet Start...");
		int result = 0;
		
		result = chPurDao.deletePurDet(purDetail);
		
		return result;
	}

}
