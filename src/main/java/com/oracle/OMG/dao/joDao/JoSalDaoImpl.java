package com.oracle.OMG.dao.joDao;

import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.oracle.OMG.dto.Sales;
import com.oracle.OMG.dto.SalesDetail;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Repository
@RequiredArgsConstructor
@Slf4j
public class JoSalDaoImpl implements JoSalDao {
	
	private final SqlSession session;
	private final PlatformTransactionManager transactionManager; 
		
	@Override
	public List<SalesDetail> getListSalesInquiry(SalesDetail sales) {
		
		List<SalesDetail> getListSalesInquiry = null;
		
		try {
			log.info("JoSalDaoImpl getListSalesInquiry Start");
			getListSalesInquiry = session.selectList("joListSalesInquiry", sales);
			log.info("JoSalDaoImpl getListSalesInquiry.size() -> " + getListSalesInquiry.size());
			
		} catch (Exception e) {
			log.error("JoSalDaoImpl getListSalesInquiry e.getMessage() -> " + e.getMessage());
		}
		
		return getListSalesInquiry;
		
	}

	
	@Override
	public List<SalesDetail> searchSalesInquiry(SalesDetail sales) {
		List<SalesDetail> searchSalesInquiry = null;
		
		try {
			log.info("JosalDaoImpl searchSalesInquiry Start");
			searchSalesInquiry = session.selectList("joSearchSalesInquiry", sales);
			log.info("JosalDaoImpl searchSalesInquiry.size() -> " + searchSalesInquiry.size());
			
		} catch (Exception e) {
			log.info("JosalDaoImpl searchSalesInquiry Exception -> " + e.getMessage());
		}
		
		return searchSalesInquiry;
	}


	@Override
	public int getTotalSalesInquiry() {
		int getTotalSalesInquiry = 0;
		
		try {
			log.info("JosalDaoImpl getTotalSalesInquiry Start");
			getTotalSalesInquiry = session.selectOne("joGetTotalSalesInquiry");
			log.info("JosalDaoImpl getTotalSalesInquiry -> " + getTotalSalesInquiry);
			
		} catch (Exception e) {
			log.info("JosalDaoImpl getTotalSalesInquiry Exception -> " + e.getMessage());
		
		}
		return getTotalSalesInquiry;
	
	}


	@Override
	public int getSearchTotalSalesInquiry(SalesDetail sales) {
		int getSearchTotalSalesInquiry = 0;
		
		try {
			log.info("JosalDaoImpl getSearchTotalSalesInquiry Start");
			getSearchTotalSalesInquiry = session.selectOne("joGetSearchTotalSalesInquiry", sales);
			log.info("JosalDaoImpl getSearchTotalSalesInquiry -> " + getSearchTotalSalesInquiry);
			
		} catch (Exception e) {
			log.info("JosalDaoImpl getSearchTotalSalesInquiry Exception -> " + e.getMessage());
		
		}
		return getSearchTotalSalesInquiry;
	
	}


	@Override
	public int getSortTotalSalesInquiry(int sales_status) {
		int getSortTotalSalesInquiry = 0;
		
		try {
			log.info("JosalDaoImpl getSortTotalSalesInquiry Start");
			getSortTotalSalesInquiry = session.selectOne("joGetSortTotalSalesInquiry", sales_status);
			log.info("JosalDaoImpl getSortTotalSalesInquiry -> " + getSortTotalSalesInquiry);
			
		} catch (Exception e) {
			log.info("JosalDaoImpl getSearchTotalSalesInquiry Exception -> " + e.getMessage());
		
		}
		return getSortTotalSalesInquiry;
	
	}


	@Override
	public List<SalesDetail> sortSalesInquiry(SalesDetail salesDetail) {
		List<SalesDetail> sortSalesInquiry = null;
		
		try {
			log.info("JosalDaoImpl sortSalesInquiry Start");
			sortSalesInquiry = session.selectList("joSortSalesInquiry", salesDetail);
			log.info("JosalDaoImpl sortSalesInquiry.size() -> " + sortSalesInquiry.size());
			
		} catch (Exception e) {
			log.info("JosalDaoImpl sortSalesInquiry Exception -> " + e.getMessage());
		}
		
		return sortSalesInquiry;
	
	}
	
	
	  @Override 
	  public int deleteSalesDetail(SalesDetail sales) { 
		  int result = 0;
		  TransactionStatus txStatus = 
				  transactionManager.getTransaction(new DefaultTransactionDefinition());
	  
	  try { 
		  log.info("JoSalDaoImpl deleteSalesDetail Start"); 
		  result = session.delete("joDeleteSalesDetail", sales);
		  log.info("JoSalDaoImpl deleteSalesDetail result -> " + result); 
		  result = session.delete("joDeleteSales", sales);
		  log.info("JoSalDaoImpl deleteSales result -> " + result);
		  transactionManager.commit(txStatus);
	  
	  } catch (Exception e) { 
		  transactionManager.rollback(txStatus);
		  log.info("JoSalDaoImpl deleteSalesDetail Exception ->" + e.getMessage());
		  result = -1; 
	  }
	  
	  return result; 
	  }

		

	@Override
	public List<SalesDetail> getListCustCode(int custstyle) {
		List<SalesDetail> getListCustCode = null;
		
		try {
			log.info("JoSalDaoImpl getListCustCode Start");
			getListCustCode = session.selectList("joGetListCustCode", custstyle);
			log.info("JoSalDaoImpl getListCustCode.size() -> " + getListCustCode.size());
			
		} catch (Exception e) {
			log.error("JoSalDaoImpl getListCustCode Exception" + e.getMessage());
			
		}
		return getListCustCode;
	}


	@Override
	public int insertSales(Sales sales) {
		int result = 0;
		
		try {
			log.info("JoSalDaoImpl InsertSales Start");
			result = session.insert("joInsertSales", sales);
			log.info("JoSalDaoImpl InsertSales Result -> " + result);
					
		} catch (Exception e) {
			log.info("JoSalDaoImpl InsertSales Exception -> " + e.getMessage());
		
		}
		return result;
	}


	@Override
	public List<SalesDetail> getSalesDetail(SalesDetail sales) {
		List<SalesDetail> getSalesDetail = null;
		
		try {
			log.info("JoSalDaoImpl getSalesDetail Start");
			getSalesDetail = session.selectList("joGetSalesDetail", sales);
			log.info("JoSalDaoImpl getSalesDetail.size() -> " + getSalesDetail.size());
		
		} catch (Exception e) {
			log.error("JoSalDaoImpl getSalesDetail Exception -> " + e.getMessage());
		}
		return getSalesDetail;
	}


	@Override
	public int getTotalSalesDetail(SalesDetail sales) {
		int getTotalSalesDetail = 0;
		
		try {
			log.info("JoSalDaoImpl getTotalSalesDetail Start");
			getTotalSalesDetail = session.selectOne("joGetTotalSalesDetail", sales);
			log.info("JoSalDaoImpl getTotalSalesDetail -> " + getTotalSalesDetail);
		
		} catch (Exception e) {
			log.error("JoSalDaoImpl getTotalSalesDetail Exception -> " + e.getMessage());
		}
		
		return getTotalSalesDetail;
	}


	@Override
	public SalesDetail getSalesData(SalesDetail sales) {
		SalesDetail salesDetail = null;
		
		try {
			log.info("JoSalDaoImpl getSalesData Start");
			salesDetail = session.selectOne("joGetSalesData", sales);
			log.info("JoSalDaoImpl salesDetail -> " + salesDetail);
		
		} catch (Exception e) {
			log.error("JoSalDaoImpl getSalesData Exception -> " + e.getMessage());
		}
		
		return salesDetail;
	
	
	}


	@Override
	public int updateSalesDetail(SalesDetail sales) {
		int result = 0;
						
		try {
			log.info("JoSalDaoImpl updateSalesDetail Start");
			result = session.update("joUpdateSalesDetail", sales);
			log.info("JoSalDaoImpl updateSalesDetail reuslt -> " + result);
						
		} catch (Exception e) {
			log.error("JoSalDaoImpl updateSales Exception -> " + e.getMessage());
		
		}
		return result;
		
	}


	@Override
	public List<SalesDetail> getListProduct() {
		List<SalesDetail> getListProduct = null;
		
		try {
			log.info("JoSalDaoImpl getListProduct Start");
			getListProduct = session.selectList("joGetListProdcut");
			log.info("JoSalDaoImpl getListProduct.size -> " + getListProduct.size());
			
		} catch (Exception e) {
			log.info("JoSalDaoImpl getListProduct Exception -> " + e.getMessage());
			
		}
		return getListProduct;
	}
	

	@Override
	public int insertSalesDetail(SalesDetail sales) {
		int result = 0;
		
		try {
			log.info("JoSalDaoImpl insertSalesDetail Start");
			result = session.insert("joInsertSalesDetail", sales);
			log.info("JoSalDaoImpl insertSalesDetail Result -> " + result);
			
		} catch (Exception e) {
			log.error("JoSalDaoImpl getInsertSalesDetail Exception -> " + e.getMessage());
		}
		
		return result;
	}


	@Override
	public int updateSales(@Valid Sales sales) {
		int result = 0;
		
		try {
			log.info("JoSalDaoImpl updateSales Start");
			result = session.update("joUpdateSales", sales);
			log.info("JoSalDaoImpl updateSales Result -> " + result);
		
		} catch (Exception e) {
			log.error("JoSalDaoImpl updateSales Exception -> " + e.getMessage());
		
		}
		
		return result;
	}




}



	
