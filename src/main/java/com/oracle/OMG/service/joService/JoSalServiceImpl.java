package com.oracle.OMG.service.joService;

import java.util.List;

import javax.validation.Valid;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import com.oracle.OMG.dao.joDao.JoSalDao;
import com.oracle.OMG.dto.Sales;
import com.oracle.OMG.dto.SalesDetail;

import lombok.Data;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Data
@Slf4j
public class JoSalServiceImpl implements JoSalService {
	
	private final JoSalDao jsd;
	
	@Override
	public List<SalesDetail> getListSalesInquiry(SalesDetail sales) {
		List<SalesDetail> getListSalesInquiry = jsd.getListSalesInquiry(sales);
		
		if(getListSalesInquiry == null) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "Sales 리스트가 존재하지 않습니다.");
		}
		
		return getListSalesInquiry;
		
	}

	
	@Override
	public List<SalesDetail> searchSalesInquiry(SalesDetail sales) {
		List<SalesDetail> searchSalesInquiry = jsd.searchSalesInquiry(sales);
		
		if(searchSalesInquiry == null) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "검색리스트가 존재하지 않습니다");
		}
				
		return searchSalesInquiry;
	}


	@Override
	public int getTotalSalesInquiry() {
		int getTotalSalesInquiry = 0;
		getTotalSalesInquiry = jsd.getTotalSalesInquiry();
		return getTotalSalesInquiry;

	}


	@Override
	public int getSearchTotalSalesInquiry(SalesDetail sales) {
		int getSearchTotalSalesInquiry = 0;
		getSearchTotalSalesInquiry = jsd.getSearchTotalSalesInquiry(sales);
		return getSearchTotalSalesInquiry;
	
	}


	@Override
	public int getSortTotalSalesInquiry(int sales_status) {
		int getSortTotalSalesInquiry = 0;
		getSortTotalSalesInquiry = jsd.getSortTotalSalesInquiry(sales_status);
		return getSortTotalSalesInquiry;
	}


	@Override
	public List<SalesDetail> sortSalesInquiry(SalesDetail salesDetail) {
		List<SalesDetail> sortSalesInquiry = jsd.sortSalesInquiry(salesDetail);
		
		if(sortSalesInquiry == null) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "검색리스트가 존재하지 않습니다");
		}
				
		return sortSalesInquiry;
	}


	
	  @Override 
	  public int deleteSalesDetail(SalesDetail sales) { 
		  int result = jsd.deleteSalesDetail(sales);
	  
	  if(result <= 0 ) { 
		  throw new ResponseStatusException(HttpStatus.NOT_FOUND, "판매 정보 삭제에 실패하였습니다."); 
	  }
	  
	  return result; }
	 

	@Override
	public List<SalesDetail> getListCustCode(int custstyle) {
		List<SalesDetail> getListCustCode = null;
		getListCustCode = jsd.getListCustCode(custstyle);
		
		if(getListCustCode == null) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "custcode 리스트가 존재하지 않습니다");
		}
		return getListCustCode;
	}


	@Override
	// public int insertSales(SalesDetail sales) {
	public int insertSales(Sales sales) {
		int result = 0;
		result = jsd.insertSales(sales);
		
		if(result <= 0) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "판매 입력에 실패하였습니다");
		}
		
		return result;
	}


	@Override
	public List<SalesDetail> getSalesDetail(SalesDetail sales) {
		List<SalesDetail> getSalesDetail = null;
		getSalesDetail = jsd.getSalesDetail(sales);
		
		if(getSalesDetail == null) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "판매 상세정보를 불러오는데 실패하였습니다.");
		}
		return getSalesDetail;
	}


	@Override
	public int getTotalSalesDetail(SalesDetail sales) {
		int getTotalSalesDetail = 0;
		getTotalSalesDetail = jsd.getTotalSalesDetail(sales);
		
		if(getTotalSalesDetail == 0) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "판매 상세정보의 총 갯수를 불러오는데 실패하였습니다.");
		}
		
		return getTotalSalesDetail;
	}


	@Override
	public SalesDetail getSalesData(SalesDetail sales) {
		SalesDetail salesDetail = null;
		salesDetail = jsd.getSalesData(sales);
		
		if(salesDetail == null) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "판매 데이터를 불러오는데 실패하였습니다.");
		}
		
		return salesDetail;
		
	}


	@Override
	public int updateSalesDetail(SalesDetail sales) {
		int result = 0;
		result = jsd.updateSalesDetail(sales);
		
		if(result == 0) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "판매 데이터를 수정하는데 실패하였습니다.");
		}
		
		return result;
		
		
	}


	@Override
	public List<SalesDetail> getListProduct() {
		List<SalesDetail> getListProduct = null;
		getListProduct = jsd.getListProduct();
		
		if(getListProduct == null) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "제품 데이터를 불러오는데 실패하였습니다.");
		}
		return getListProduct;
	}


	@Override
	public int insertSalesDetail(SalesDetail sales) {
		int insertSalesDetail = jsd.insertSalesDetail(sales);
		
		if(insertSalesDetail == 0 ) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "판매 상세데이터를 저장하는데 실패하였습니다.");
		}
		
		return insertSalesDetail;
	}


	@Override
	public int updateSales(@Valid Sales sales) {
		int result = 0;
		result = jsd.updateSales(sales);
		
		if(result == 0) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "판매 업데이트 하는데 실패하였습니다");
		}
		
		return result;
	}


	
}
