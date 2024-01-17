package com.oracle.OMG.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.oracle.OMG.dto.Customer;
import com.oracle.OMG.dto.Item;
import com.oracle.OMG.dto.Member;
import com.oracle.OMG.dto.Warehouse;
import com.oracle.OMG.service.thService.Paging;
import com.oracle.OMG.service.yaService.YaCustomerService;
import com.oracle.OMG.service.yaService.YaWareHouseService;

import lombok.Data;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Data
@Slf4j
@RequiredArgsConstructor
public class YaController {
	private final YaCustomerService ycs;
	private final YaWareHouseService yws;

	// 거래처 전체조회
	@RequestMapping(value = "/customerList")
	public String customerList(Customer customer, Model model, String currentPage) {
		System.out.println("YaController customerList start...");

		int totalCustomer = 0;
		totalCustomer = ycs.totalCustomer(customer);
		System.out.println("YaContorller totalCustomer->" + totalCustomer);

		Paging custPage = new Paging(totalCustomer, currentPage, 10);
		customer.setStart(custPage.getStart());
		customer.setEnd(custPage.getEnd());

		List<Customer> customerList = null;
		customerList = ycs.customerList(customer);

		model.addAttribute("totalCustomer", totalCustomer);
		model.addAttribute("custPage", custPage);
		model.addAttribute("customerList", customerList);

		return "ya/customer";
	}

	// 거래처 상세보기
	@GetMapping("/customerDetail")
	@ResponseBody
	public Map<String, Object> customerDetail(@RequestParam("custcode") int custcode,HttpSession session) {
		System.out.println("YaController Start customerDetail start...");

		Map<String, Object> result = new HashMap<>();
		
		int mem_id=0;
		if(session.getAttribute("mem_id") !=null ) {
			mem_id=(int)session.getAttribute("mem_id");		
		}
		
		Customer customer = ycs.customerDetail(custcode);
		System.out.println("YaConroller detailCustomer custcode:" + customer.getCustcode());
		System.out.println("YaConroller detailCustomer company:" + customer.getCompany());

		result.put("customer", customer);
		result.put("mem_id", mem_id);
		return result;
	}

	// 직원 전체조회 ( 거래처수정용)
	@PostMapping("/memberList")
	@ResponseBody
	public Map<String, Object> memberList(@RequestBody Member member,HttpSession session) {
		
		Map<String, Object> result = new HashMap<>();
		
		//session에서 mem_id속성을 가져옴 
		int mem_id=0;
		if(session.getAttribute("mem_id") !=null ) {
			mem_id=(int)session.getAttribute("mem_id");		
		}
		//session에서  mem_dept_md속성을 가져옴 
	    int mem_dept_md = 0;
	    if (!"999".equals(session.getAttribute("mem_dept_md"))) {
	        mem_dept_md = (int) session.getAttribute("mem_dept_md");
	    }
		
		List<Member> memberList = null;
		memberList = ycs.memberList(member);
		result.put("memberList", memberList);
		result.put("mem_id", mem_id);
		result.put("mem_dept_md", mem_dept_md);

		return result;
	}

	// 거래처 전체조회
	@PostMapping("/customerListSelect")
	@ResponseBody
	public Map<String, Object> customerListSelect(@RequestBody Customer customer) {
		Map<String, Object> result = new HashMap<>();

		List<Customer> customerListSelect = null;
		customerListSelect = ycs.customerListSelect(customer);
		result.put("customerListSelect", customerListSelect);

		return result;
	}

	// 거래처 정보수정
	@PostMapping("/updateCustomer")
	@ResponseBody
	public Map<String, Object> updateCustomer(@RequestBody Customer customer) {
		Map<String, Object> result = new HashMap<>();
		

		customer = ycs.updateCustomer(customer);
		result.put("success", true);

		return result;

	}

	// 거래처 등록
	@RequestMapping(value = "/insertCustomer")
	@ResponseBody
	public Map<String, Object> insertCustomer(@RequestBody Customer customer ) {
		Map<String, Object> result = new HashMap<>();

		customer = ycs.insertCustomer(customer);
		result.put("success", true);

		return result;

	}

	// 거래처삭제
	@GetMapping("/deleteCustomer")
	public String deleteCustomer(int custcode, Model model, HttpSession session) {
	    int deleteResult = ycs.deleteCustomer(custcode);
	    System.out.println("YaController ycs.deleteCustomer start...");
	    
	    int mem_dept_md = 0;
	    //Object로 먼저 받아오고,  적절한 자료형으로 변환
	    Object memDeptMd = session.getAttribute("mem_dept_md");

	    if (memDeptMd != null) {
	        String memDeptMdString = memDeptMd.toString();
	        if ("100".equals(memDeptMdString) || "999".equals(memDeptMdString)) {
	            mem_dept_md = Integer.parseInt(memDeptMdString);
	        }
	    }
	    
	    return "redirect:customerList";
	}

	// 거래처 검색
	@GetMapping("/customerSearch")
	@ResponseBody
	public Map<String, Object> customerSearch(HttpServletRequest request, HttpSession session) {
		
		System.out.println("YaController ycs.customerSearch Start...");
		String keyword = request.getParameter("keyword");
		String currentPage = request.getParameter("currentPage");

		System.out.println("kewyord?:" + keyword);

		int totalSearch = ycs.totalSearch(keyword);
		System.out.println("YaController totalSearch(keyword):" + totalSearch);

	    
		int mem_dept_md = 0;
	    //Object로 먼저 받아오고,  적절한 자료형으로 변환
	    Object memDeptMd = session.getAttribute("mem_dept_md");

	    if (memDeptMd != null) {
	        String memDeptMdString = memDeptMd.toString();
	        if ("100".equals(memDeptMdString) || "999".equals(memDeptMdString)) {
	            mem_dept_md = Integer.parseInt(memDeptMdString);
	        }
	    }	        
		
		Paging paging = new Paging(totalSearch, currentPage);
		List<Customer> customerSearchList = ycs.customerSearch(keyword, paging.getStart(), paging.getEnd());

		Map<String, Object> result = new HashMap<>();
		result.put("customerSearchList", customerSearchList);
		result.put("paging", paging);
		result.put("mem_dept_md", mem_dept_md);

		return result;
	}

	// 거래처판매실적 전체조회
	@GetMapping("/customerSales")
	public String customerSalesList(Customer customer, Model model) {
		System.out.println("YaController ycs.custoemrSales start...");
		List<Customer> customerSalesList = ycs.customerSalesList(customer);
		model.addAttribute("customerSalesList", customerSalesList);

		return "ya/salesByCustomer";
	}
	
	
	/*
	 * // 거래처판매실적 전체조회
	 * 
	 * @GetMapping("/customerSales")
	 * 
	 * @ResponseBody public Map<String, Object> customerSalesList(Customer customer)
	 * { System.out.println("YaController ycs.custoemrSales start...");
	 * 
	 * 
	 * List<Customer> customerSalesList = ycs.customerSalesList(customer);
	 * Map<String, Object> result = new HashMap<>();
	 * model.addAttribute("customerSalesList", customerSalesList);
	 * result.put("customerSalesList", customerSalesList); return result; }
	 */

	// 거래처,월별,유형별 판매실적 검색
	@GetMapping("/customerSalesSearch")
	@ResponseBody
	public Map<String, Object> customerSalesSearch(HttpServletRequest request, Customer customer) {
		System.out.println("YaController ycs.customerSearch Start...");
		List<Customer> customerSalesSearch = null;

		String custcodeParam = request.getParameter("custcode");
		int custcode = Integer.parseInt(custcodeParam);
		String month = request.getParameter("month");
		String purDate = request.getParameter("purDate");

		// 모두 전체일 경우 조회
		if ("0".equals(custcodeParam) && "0".equals(month)) {
			customerSalesSearch = ycs.SearchAll(custcode, month);
			System.out.println("모두 전체일 경우 조회");
		}
		// 월만 전체일 경우 조회
		else if ("0".equals(custcodeParam) && !"0".equals(month)) {
			customerSalesSearch = ycs.SearchAllCustomer(month);
			System.out.println("월만 전체일 경우 조회");
		}
		// 거래처만 전체일 경우 조회
		else if (!"0".equals(custcodeParam) && "0".equals(month)) {
			customerSalesSearch = ycs.SearchForAllMonths(custcode);
			System.out.println("거래처만  전체일 경우 조회 ");
		}
		// 조건충족일경우
		else {
			customerSalesSearch = ycs.customerSalesSearch(custcode, month, purDate);
			System.out.println(" 조건충족일경우 조회 ");
		}

		Map<String, Object> result = new HashMap<>();
		result.put("customerSalesSearch", customerSalesSearch);

		System.out.println("customerSalesSearch size:" + customerSalesSearch.size());
		System.out.println("customerSalesSearch custcode:" + custcode);
		System.out.println("customerSalesSearch  month:" + month);

		return result;

	}
	
	//재고조회
	@GetMapping("/inventoryList")
	public String inventoryList(Warehouse warehouse, Model model) {
		System.out.println("YaController yws.inventoryList start...");
		List<Warehouse> inventoryList = yws.inventoryList( warehouse);
		model.addAttribute("inventoryList", inventoryList);

		return "ya/inventoryList";
	}
	
	// 제품  전체조회
	@PostMapping("/itemListSelect")
	@ResponseBody
	public Map<String, Object> itemListSelect(@RequestBody Item item) {
		Map<String, Object> result = new HashMap<>();

		List<Item> itemListSelect = null;
		itemListSelect = yws.itemListSelect(item);
		result.put("itemListSelect", itemListSelect);

		return result;
	}
	
	//재고조회 조건별 조회 
	@GetMapping("/inventoryListSearch")
	@ResponseBody
	public Map<String, Object> inventoryListSearch(HttpServletRequest request, Warehouse warehouse) {
		System.out.println("YaController inventoryListSearch Start...");
		List<Warehouse> inventoryListSearch = null;

		String codeParam = request.getParameter("code");
		int code = Integer.parseInt(codeParam);
		String month = request.getParameter("month");

		// 모두 전체일 경우 조회
		if ("0".equals(codeParam) && "0".equals(month)) {
			inventoryListSearch = yws.SearchAll(code, month);
			System.out.println("모두 전체일 경우 조회");
		}

		// 월만 전체일 경우 조회
		else if ("0".equals(codeParam) && !"0".equals(month)) {
			inventoryListSearch = yws.SearchAllInventory(month);
			System.out.println("월만 전체일 경우 조회");
		}
		// 제품만만 전체일 경우 조회
		else if (!"0".equals(codeParam) && "0".equals(month)) {
			inventoryListSearch = yws.SearchForAllMonths(code);
			System.out.println("거래처만  전체일 경우 조회 ");
		}
		// 제품의 수량이 0일 경우 조회
		
		
		// 조건충족일경우
		else {
			inventoryListSearch = yws.inventorySearch(code, month);
			System.out.println(" 조건충족일경우 조회 ");
		}

		Map<String, Object> result = new HashMap<>();
		result.put("inventoryListSearch", inventoryListSearch);

		System.out.println("inventoryListSearch size:" + inventoryListSearch.size());
		System.out.println("inventoryListSearch code:" + code);
		System.out.println("inventoryListSearch  month:" + month);

		return result;

	}
	
}
