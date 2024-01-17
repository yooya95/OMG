package com.oracle.OMG.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.json.simple.parser.JSONParser;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.oracle.OMG.dto.Sales;
import com.oracle.OMG.dto.SalesDetail;
import com.oracle.OMG.service.joService.JoSalService;
import com.oracle.OMG.service.joService.Paging;

import lombok.Data;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Data
@Slf4j
@RequestMapping(value = "/sales")
public class JoController {
	
	private final JoSalService jss;
	
	// 판매서 조회
	@RequestMapping(value = "salesInquiry")
	public String salesInquiry(SalesDetail sales, String currentPage, Model model) {
		UUID transactionId = UUID.randomUUID();
		
		try {
			log.info("[{}]{}:{}", transactionId, "salesInquiry", "Start");
			int totalSalesInquiry = jss.getTotalSalesInquiry();
			
			Paging page = new Paging(totalSalesInquiry, currentPage);
			sales.setStart(page.getStart());
			sales.setEnd(page.getEnd());
			
			List<SalesDetail> listSalesInquiry = jss.getListSalesInquiry(sales);
			
			model.addAttribute("totalSalesInquiry", totalSalesInquiry);
			model.addAttribute("page", page);
			model.addAttribute("listSalesInquiry", listSalesInquiry);
			model.addAttribute("currentPage", currentPage);
			
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "salesInquiry", e.getMessage());
		} finally {
			log.info("[{}]{}:{}", transactionId, "salesInquriry", "End");
		}
				
		return "jo/salesInquiry";
	}
	
	
	// 판매서 정보
	@RequestMapping("salesInquiryDetail")
	public String salesInquiryDetail(SalesDetail sales, Model model) {
		UUID transactionId = UUID.randomUUID();
		
		try {
			log.info("[{}]{}:{}", transactionId, "salesInquiryDetail", "Start");

			SalesDetail salesDetail = jss.getSalesData(sales);					
			List<SalesDetail> salesDetailList = jss.getSalesDetail(sales);
						
			int custstyle = 1;
			List<SalesDetail> listCustCode = jss.getListCustCode(custstyle);
			
			model.addAttribute("salesDetail", salesDetail);
			model.addAttribute("salesDetailList", salesDetailList);
			model.addAttribute("listCustCode", listCustCode);
						
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "salesInquiryDetail Exception", e.getMessage());
		
		} finally {
			log.info("[{}]{}:{}", transactionId, "salesInquiryDetail", "End");
			
		}
		return "jo/salesInquiryDetail";
	}
	
	
	// 판매서 검색 -> 거래처 or 제품
	@RequestMapping("salesInquirySearch")
	public String salesInquirySearch(SalesDetail sales, String currentPage, Model model) {
		UUID transactionId = UUID.randomUUID();
		
		try {
			log.info("[{}]{}:{}", transactionId, "salesInquirySearch", "Start");
			String search  = sales.getSearch();
			String keyword = sales.getKeyword();
			
			int SearchTotalSalesInquiry = jss.getSearchTotalSalesInquiry(sales);
			
			Paging page = new Paging(SearchTotalSalesInquiry, currentPage); 
			sales.setStart(page.getStart());
			sales.setEnd(page.getEnd());
			
			List<SalesDetail> salesInquirySearch = jss.searchSalesInquiry(sales);
			
			model.addAttribute("search", search);
			model.addAttribute("keyword", keyword);
			model.addAttribute("SearchTotalSalesInquiry", SearchTotalSalesInquiry);
			model.addAttribute("page", page);
			model.addAttribute("salesInquirySearch", salesInquirySearch);
			model.addAttribute("currentPage", currentPage);
		
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "salesInquirySearch", e.getMessage());
		} finally {
			log.info("[{}]{}:{}", transactionId, "salesInqurirySearch", "End");
		}

		return "jo/salesInquirySearch";
	}
	
	
	// 판매서 분류 -> 전체,진행,취소,완료,출고등록
	@RequestMapping("salesInquirySort")
	public String salesInquirySort(SalesDetail sales, String currentPage, Model model, HttpServletRequest request) {
		UUID transactionId = UUID.randomUUID();
		
		try {
			log.info("[{}]{}:{}", transactionId, "salesInquirySort", "Start");
						
			int SortTotalSalesInquiry = jss.getSortTotalSalesInquiry(sales.getSales_status());
								
			Paging page = new Paging(SortTotalSalesInquiry, currentPage); 
			sales.setStart(page.getStart());
			sales.setEnd(page.getEnd());
			
			List<SalesDetail> salesInquirySort = jss.sortSalesInquiry(sales);
			
			model.addAttribute("sortTotalSalesInquiry", SortTotalSalesInquiry);
			model.addAttribute("page", page);
			model.addAttribute("salesInquirySort", salesInquirySort);
			model.addAttribute("sales_status", sales.getSales_status());
			model.addAttribute("currentPage", currentPage);
		
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "salesInquirySort", e.getMessage());
		} finally {
			log.info("[{}]{}:{}", transactionId, "salesInqurirySort", "End");
		}

		return "jo/salesInquirySort";
	}

	
	@RequestMapping("salesDetailDelete")
	public String salesDetailDelete(@RequestParam(value = "salesDates") List<String> salesDates,
	                                @RequestParam(value = "custcodes") List<String> custcodes,
	                                String currentPage, Model model) {
	    UUID transactionId = UUID.randomUUID();

	    try {
	        log.info("[{}]{}:{}", transactionId, "salesInquiryDelete", "Start");

	        // salesDates와 custcodes의 길이는 같다고 가정하고, 반복문을 통해 삭제 로직 수행
	        for (int i = 0; i < salesDates.size(); i++) {
	            
	        	SalesDetail sales = new SalesDetail();
	            sales.setSales_date(salesDates.get(i));
	            sales.setCustcode(Integer.parseInt(custcodes.get(i)));
	            	            
	            int result = jss.deleteSalesDetail(sales);
	        }
	        

	    } catch (Exception e) {
	        log.error("[{}]{}:{}", transactionId, "salesDetailDelete Exception", e.getMessage());
	        
	    } finally {
	        log.info("[{}]{}:{}", transactionId, "salesDetailDelete", "End");
	    }

	    return "redirect:salesInquiry";
	}
	
	
	@PostMapping("salesDelete")
	 @ResponseBody
	 public String salesDelete(@RequestBody @Valid ArrayList<SalesDetail> salesDetails) { 
		  UUID transactionId = UUID.randomUUID(); 
	 
		  int salesDeleteResult = 0;
		  log.info("[{}]{}:{}", transactionId, "salesDelete", "Start");
		  	      
		  try {
			  for (SalesDetail salesDetail : salesDetails) {
				  log.info("salesDelete -> " + salesDetail);
				  // salesDeleteResult = jss.salesDelete(salesDetail);
			  }
			  log.info("[{}]{}:{}", transactionId, "salesDetailInsert", "Success"); 
			  return "1";
			  
		  } catch (Exception e) { 
			  log.info("[{}]{}:{}", transactionId, "salesDetailInsert Exception", e.getMessage()); 
			  return "0";
		  
		  } finally { 
			  log.info("[{}]{}:{}", transactionId, "salesDetailInsert", "End"); 
		  } 
	  }
	

	// 판매서 입력
	@RequestMapping("salesInsertForm")
	public String salesInsertForm(SalesDetail sales, String currentPage, Model model) {
		UUID transactionId = UUID.randomUUID();
		
		try {
			log.info("[{}]{}:{}", transactionId, "salesInsertForm", "Start" );
			
			int custstyle = 1;
			List<SalesDetail> listCustCode = jss.getListCustCode(custstyle);
			
			List<SalesDetail> listProduct  = jss.getListProduct();
			
			model.addAttribute("listCustCode", listCustCode);
			model.addAttribute("listProduct", listProduct);
			model.addAttribute("currentPage", currentPage);
			
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "salesInsertForm Exception", e.getMessage());
			
		} finally {
			log.info("[{}]{}:{}", transactionId, "salesInsertForm", "End" );
		}
		
		return "jo/salesInsertForm";
	}
	
			
	 @PostMapping("salesInsert")
	 @ResponseBody
	 public String salesInsert(@RequestBody @Valid Sales sales) { 
		  UUID transactionId = UUID.randomUUID(); 
		  int salesResult = 0; 
		  
		  log.info("[{}]{}:{}", transactionId, "salesInsert", "Start");
		  
		  try {
			  log.info("sales -> " + sales); 
			
			  salesResult = jss.insertSales(sales);
			  
			  log.info("[{}]{}:{}", transactionId, "salesInsert", "Success"); 
			  return "1";
			  
		  } catch (Exception e) { 
			  log.info("[{}]{}:{}", transactionId, "salesInsert Exception", e.getMessage()); 
			  return "0";
		  
		  } finally { 
			  log.info("[{}]{}:{}", transactionId, "salesInsert", "End"); 
		  } 
	  }

	 
	 @PostMapping("salesDetailInsert")
	 @ResponseBody
	 public String salesDetailInsert(@RequestBody @Valid ArrayList<SalesDetail> salesDetails) { 
		  UUID transactionId = UUID.randomUUID(); 
	 
		  int salesDetailResult = 0;
		  log.info("[{}]{}:{}", transactionId, "salesDetailInsert", "Start");
		  	      
		  try {
			  for (SalesDetail salesDetail : salesDetails) {
				  log.info("salesDetailInsert -> " + salesDetail);
				  salesDetailResult = jss.insertSalesDetail(salesDetail);
			  }
			  log.info("[{}]{}:{}", transactionId, "salesDetailInsert", "Success"); 
			  return "1";
			  
		  } catch (Exception e) { 
			  log.info("[{}]{}:{}", transactionId, "salesDetailInsert Exception", e.getMessage()); 
			  return "0";
		  
		  } finally { 
			  log.info("[{}]{}:{}", transactionId, "salesDetailInsert", "End"); 
		  } 
	  }
	 	 
	  
	// 판매서 수정
	@RequestMapping("salesUpdateForm")
	public String salesUpdateForm(SalesDetail sales, String currentPage, Model model, HttpServletRequest request) {
		UUID transactionId = UUID.randomUUID();
		System.out.println("JoController salesUpdateForm Start...");
		
		try {
			log.info("[{}]{}:{}", transactionId, "salesUpdateForm", "Start");
			System.out.println("JoController salesUpdateForm Start..." + sales);
			
			SalesDetail salesDetail = jss.getSalesData(sales);
							
			int custstyle = 1;
			List<SalesDetail> listCustCode = jss.getListCustCode(custstyle);
			
			List<SalesDetail> listProduct  = jss.getListProduct();
						
			int totalSalesDetail = jss.getTotalSalesDetail(sales); 
			
			Paging page = new Paging(totalSalesDetail, currentPage);
			sales.setStart(page.getStart());
			sales.setEnd(page.getEnd());
			
			List<SalesDetail> salesDetailList = jss.getSalesDetail(sales);
			
			model.addAttribute("salesDetail", salesDetail);
			model.addAttribute("page", page);
			model.addAttribute("listCustCode", listCustCode);
			model.addAttribute("listProduct", listProduct);
			model.addAttribute("salesDetailList", salesDetailList);
			model.addAttribute("currentPage", currentPage);
		
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "salesUpdateForm Exception", e.getMessage());
		} finally {
			log.info("[{}]{}:{}", transactionId, "salesUpdateForm", "End");		
		}
		return "jo/salesUpdateForm";
	
	}

	 // 판매서 수정
	 @PostMapping("salesUpdate")
	 @ResponseBody
	 public String salesUpdate(@RequestBody @Valid Sales sales) { 
		  UUID transactionId = UUID.randomUUID(); 
		  int salesResult = 0; 
		  
		  log.info("[{}]{}:{}", transactionId, "salesUpdate", "Start");
		  
		  try {
			  log.info("sales -> " + sales); 
			
			  salesResult = jss.updateSales(sales);
			  
			  log.info("[{}]{}:{}", transactionId, "salesUpdate", "Success"); 
			  return "1";
			  
		  } catch (Exception e) { 
			  log.info("[{}]{}:{}", transactionId, "salesUpdate Exception", e.getMessage()); 
			  return "0";
		  
		  } finally { 
			  log.info("[{}]{}:{}", transactionId, "salesUpdate", "End"); 
		  } 
	  }

	 
	 @PostMapping("salesDetailUpdate")
	 @ResponseBody
	 public String salesDetailUpdate(@RequestBody ArrayList<SalesDetail> salesDetails) { 
		  UUID transactionId = UUID.randomUUID(); 
	 
		  int salesDetailResult = 0;
		  log.info("[{}]{}:{}", transactionId, "salesDetailUpdate", "Start");
		  	      
		  try {
			  for (SalesDetail salesDetail : salesDetails) {
				  log.info("salesDetailInsert -> " + salesDetail);
				  salesDetailResult = jss.updateSalesDetail(salesDetail);
			  }
			  log.info("[{}]{}:{}", transactionId, "salesDetailUpdate", "Success"); 
			  return "1";
			  
		  } catch (Exception e) { 
			  log.info("[{}]{}:{}", transactionId, "salesDetailUpdate Exception", e.getMessage()); 
			  return "0";
		  
		  } finally { 
			  log.info("[{}]{}:{}", transactionId, "salesDetailUpdate", "End"); 
		  } 
	  }

	 
}
