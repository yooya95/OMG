package com.oracle.OMG.service.yaService;

import java.util.List;


import org.springframework.stereotype.Service;

import com.oracle.OMG.dao.yaDao.YaCustomerDao;
import com.oracle.OMG.dto.Customer;
import com.oracle.OMG.dto.Member;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class YaCustomerServiceImpl implements YaCustomerService {
	private final YaCustomerDao ycd;

	@Override
	//거래처 전체조회
	public List<Customer> customerList(Customer customer) {
		System.out.println("YaCustomerService CustomerList List<Customer> customerList start....");
		
		List<Customer> customerList = ycd.customerList(customer);
		System.out.println("YaCustomerServiceImpl YaCustomerList.size()?"+customerList.size());
		return customerList;
	}
	
	@Override
	//거래처 수
	public int totalCustomer(Customer customer) {
		System.out.println("YaCustomerService totalCustomer start....");
		int totalCustomer = ycd.totalCustomer(customer);
		System.out.println("YaCustomerServiceImpl totalCustoemr start....");
		
		
		return totalCustomer;
	}

	@Override
	//거래처 상세보기
	public Customer customerDetail(int custcode) {
		System.out.println("YaCustomerService customerDetail start...");
		Customer customer = null;
		customer = ycd.customerDetail(custcode);
		return customer;
	}

	@Override
	//거래처 수정
	public Customer updateCustomer(Customer customer) {
		System.out.println("YaCustomerService updateCustomer start...");
		customer = ycd.updateCustomer(customer);
		return customer;
	}

	@Override
	//사원조회
	public List<Member> memberList(Member member) {
		System.out.println("YaCustomerService memberList start...");
		List<Member> memberList = ycd.memberList(member);
		return memberList;
	}
	
	//거래처등록
	@Override
	public Customer insertCustomer(Customer customer) {
		System.out.println("YaCustomerService insertCustomer start...");
		customer = ycd.insertCustomer(customer);
		return customer;
		
	}
	
	//거래처 삭제
	@Override
	public int deleteCustomer(int custcode) {
		System.out.println("YaCustomerService deleteCustomer start...");
		int deleteResult=0;
		System.out.println("YaCustomerServiceImpl delete Start...");
		deleteResult = ycd.deleteCustomer(custcode);
		return  deleteResult;
	}
	//거래처검색
	@Override
	public List<Customer> customerSearch(String keyword, int start, int end) {
		List<Customer> customerSearch = null;
		System.out.println("YaCustomerServiceImpl search start...");
		customerSearch = ycd.customerSearch(keyword, start, end);
		return customerSearch;
	}
	//검색결과 수
	@Override
	public int totalSearch(String keyword) {
		System.out.println("YaCustomerService totalSearch start....");
		int totalSearch = ycd.totalSearch( keyword);
		System.out.println("YaCustomerServiceImpl  totalSearch start....");
		return  totalSearch;
	}
	//월별실적조회리스트 
	@Override
	public List<Customer> customerSalesList(Customer customer) {
		System.out.println("YaCustomerService customerSalesList start....");
		List<Customer> customerSalesList = ycd.customerSalesList(customer);
		return customerSalesList;
	}
	//거래처실적조회 리스트 거래처 선택
	@Override
	public List<Customer> customerListSelect(Customer customer) {
		System.out.println("YaCustomerService customerListSelectstart...");
		List<Customer> customerListSelect = ycd.customerListSelect(customer);
		return customerListSelect;
	}
	
	//거래처 실적조회(검색)
	@Override
	public List<Customer> customerSalesSearch(int custcode, String month, String purDate) {
		System.out.println("YaCustomerService customerSalesSearch start...");
		List<Customer> customerSalesSearch = null;
		customerSalesSearch = ycd.customerSalesSearch(custcode, month, purDate);
		
		return customerSalesSearch;
	}
	
	//거래처전체조회
	@Override
	public List<Customer> SearchAllCustomer( String month) {
		System.out.println("YaCustomerService SearchAllCustomer start...");
		 List<Customer> SearchAllCustomer = null;
		 SearchAllCustomer= ycd.SearchAllCustomer(month);
		return SearchAllCustomer;
	}
	
	//전체월조회
	@Override
	public List<Customer> SearchForAllMonths( int custcode) {
		System.out.println("YaCustomerServiceSearchForAllMonths start...");
		List<Customer> SearchForAllMonths = null;
		SearchForAllMonths = ycd.SearchForAllMonths(custcode);
		return SearchForAllMonths;
	}
	
	//거래처,월 모두 전체조회
	@Override
	public List<Customer> SearchAll(int custcode, String month) {
		System.out.println("YaCustomerServiceSearchAll start...");
		List<Customer> SearchAll = null;
		SearchAll = ycd.SearchForAll(custcode,month);
		return SearchAll;
	}



}
