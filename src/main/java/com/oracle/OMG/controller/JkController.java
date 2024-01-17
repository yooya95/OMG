package com.oracle.OMG.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import java.sql.SQLIntegrityConstraintViolationException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import com.oracle.OMG.dto.Customer;
import com.oracle.OMG.dto.PurDetail;
import com.oracle.OMG.dto.Purchase;
import com.oracle.OMG.dto.SalesDetail;
import com.oracle.OMG.dto.Warehouse;
import com.oracle.OMG.service.chService.ChCustService;
import com.oracle.OMG.service.chService.ChPurService;
import com.oracle.OMG.service.chService.Paging;
import com.oracle.OMG.service.jkService.JkWareService;
import com.oracle.OMG.service.joService.JoSalService;
import com.oracle.OMG.service.yrService.YrItemService;

import lombok.Data;
import lombok.extern.slf4j.Slf4j;

@Controller
@Data
@Slf4j
public class JkController {
	private static final Logger logger = LoggerFactory.getLogger(JkController.class);
	private final JkWareService jws;
	private final YrItemService	yis;
	private final ChCustService	ccs;
	private final ChPurService	cps;
	private final JoSalService jss;
	
	// 기초재고등록
	@RequestMapping(value="/invRegister")
	public String invRegister(@RequestParam(value = "monthSelect1", required = false)  String selectedMonth,  @RequestParam(value = "in_itemcode", required = false)  List<Integer> selectedCodes ,HttpSession session, Warehouse warehouse, Model model) {
	    System.out.println("JkController invRegister start...");

	    
	    // 클라이언트에서 전송된 월 값의 형식 변경 (YYYYMM 형식으로)
	    if (selectedMonth != null) {
	        selectedMonth = selectedMonth.replace("-", "");
	        warehouse.setYm(selectedMonth);
	        System.out.println("selectedMonth: " + selectedMonth);
	    }
	        System.out.println("selectedMonth"+selectedMonth);
	    
	    try {
	        int result = jws.insertInv(warehouse);
	        System.out.println("result: " + result);

	        // 성공적으로 처리된 경우
	        model.addAttribute("successMessage", "정상적으로 등록되었습니다."); 
	        System.out.println("model"+model);
	        return "jk/invRegister";
	    } catch (DuplicateKeyException e) {
	        // 중복 등록 오류가 발생한 경우
	        String errorMessage = "재고 등록에 실패했습니다. 이미 등록된 기초재고가 있습니다.";
	        model.addAttribute("errorMessage", errorMessage);
	        e.printStackTrace();
	        // 사용자에게 오류 메시지를 보여줄 수 있는 페이지로 이동
	        return "errorPage";
	    } catch (Exception e) {
	        // 기타 오류 처리
	        throw new RuntimeException("서버 오류가 발생했습니다.", e);
	    }
	}

	// 기초재고 조정
	@RequestMapping(value="/updateInv")
	public ResponseEntity<String> updateInv(@RequestParam(value = "monthSelect2", required = false) String selectedMonth,
			 @RequestParam(value = "in_itemcode2", required = false)  List<Integer> code,
	                        @RequestParam(value = "cnt") int cnt,
	                        Warehouse warehouse) {
	    System.out.println("JkController updateInv start...");

	    // 클라이언트에서 전송된 월 값의 형식 변경 (YYYYMM 형식으로)
	    if (selectedMonth != null) {
	        selectedMonth = selectedMonth.replace("-", "");
	        warehouse.setYm(selectedMonth);
	        System.out.println("selectedMonth: " + selectedMonth);
	    }

	    try {
	    	 int result = jws.updateInv(warehouse);
		     System.out.println("result: " + result);

		   // 성공적으로 처리된 경우
		     return ResponseEntity.ok("정상적으로 수정되었습니다.");
	   
	    } catch (Exception e) {
	        // 오류 처리
	        e.printStackTrace();
	        // 오류가 발생한 경우
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("삭제 중 오류가 발생했습니다.");
	    }
	}

	// 기초재고 삭제
	@RequestMapping(value="/deleteInv")
	public ResponseEntity<String> deleteInv(@RequestParam(value = "monthSelect2", required = false) String selectedMonth,
	                        @RequestParam(value = "code") int code, Model model,
	                        Warehouse warehouse) {
	    System.out.println("JkController deleteInv start...");
	
	    if (selectedMonth != null) {
	        selectedMonth = selectedMonth.replace("-", "");
	        warehouse.setYm(selectedMonth);
	        System.out.println("selectedMonth: " + selectedMonth);
	    }

	    try {
	        int result = jws.deleteInv(warehouse);
	        System.out.println("result: " + result);

	        // 성공적으로 처리된 경우
	        return ResponseEntity.ok("정상적으로 삭제되었습니다.");

	    } catch (Exception e) {
	        // 오류 처리
	        e.printStackTrace();
	        // 오류가 발생한 경우
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("삭제 중 오류가 발생했습니다.");
	    }
	}

		
	// 제품정보 조회(업데이트용)
	   @GetMapping("/getItemDetails")
	   @ResponseBody
	   public Map<String, Object> getItemDetails(@RequestParam("code") int code, @RequestParam("ym") String ym ) {
	       logger.info("Fetching item details for product code: {}", code, "ym",ym);

	       Map<String, Object> response = jws.selectItem(code, ym);
	       
	       logger.info("Response: {}", response);
	       return response;
	   }

	// 제품정보 조회(등록용)
	@GetMapping("/getItemDetails2")
	@ResponseBody
	public Map<String, Object> getItemDetails2(@RequestParam("code") int code ) {
	    logger.info("Fetching item details for product code: {}", code);

	    Map<String, Object> response = jws.selectItem2(code);
	    
	    logger.info("Response: {}", response);
	    return response;
	}

	// 입고관리
	@RequestMapping(value="/inboundRegister")
	public String invPurList(Purchase purchase, String currentPage, Model model, Warehouse warehouse, @RequestParam(value = "inboundMonth", required = false) String inboundMonth) {
	    System.out.println("JkController invPurList start....");
	    logger.info("Received month: {}", inboundMonth);
    
	    int totalPur = 0;
	    int inboundTotal =0;
	    
		List<Purchase> purList = null;
		Paging page = null;
		System.out.println("ChController purList Start...");
		// 검색(custcode가 있을 때 )
		if(purchase.getCustcode() >0) {
			model.addAttribute("srchCompany", purchase.getCustcode());
		}
		//검색(날짜가 있을 때)
		if(purchase.getPur_date() != null) {
			String purDate = purchase.getPur_date();
			DateTimeFormatter formmater = DateTimeFormatter.ofPattern("yy/MM/dd");
			LocalDate ldt = LocalDate.parse(purDate, formmater);
			model.addAttribute("srchDate", ldt);
		}
		
		totalPur = cps.totalPur(purchase);
		inboundTotal = jws.inboundTotal(warehouse);
		page = new Paging(999);
		
		purchase.setStart(page.getStart());
		purchase.setEnd(page.getEnd());	
		
		//발주서 전체 리스트
		purList = cps.purList(purchase);
		System.out.println("purList: " + purList);
		// 발주서 리스트 소환 성공시 
		if(purList != null) {
			// purList 조회 성공 시
			for(Purchase p: purList) {
				// 제품 종류			총수량		총가격(전체 가격)
				int totalType = 0; int totalPrice = 0;
				
				// 발주서 상세 내용 불러오기 
				List<PurDetail> pd = cps.purDList(p);
				totalType = pd.size(); // row 수 = 발주서 내 물품 수
				System.out.println();
				// 상세 내용의 물품 항목별 수량과 결제액 
				for(PurDetail pd2 : pd) {
					totalPrice += pd2.getQty() * pd2.getPrice();
				}
				p.setTotalType(totalType);
				p.setTotalQty(pd.stream().mapToInt(m->m.getQty()).sum());
				p.setTotalPrice(totalPrice);
			}
		}
		
		List<Customer> pur_custList = ccs.custList();
		List<Warehouse> inboundList = jws.inboundList();
		
		
		model.addAttribute("pur_custList", pur_custList);
		model.addAttribute("purList",purList);
		model.addAttribute("totalPur",totalPur);
		model.addAttribute("inboundTotal",inboundTotal);
		model.addAttribute("page",page);
		model.addAttribute("inboundList",inboundList);
		
	
		System.out.println("model"+model);
		System.out.println("total"+inboundTotal);
	    return "jk/inboundRegister";
		
		
	}
	
	 // 발주 조회
	@RequestMapping(value = "/inboundRegister", method = RequestMethod.POST)
	public String invPurList(@RequestBody PurDetail requestData, Model model) {
	    System.out.println("Received data from client: " + requestData);

	    // requestData에서 pur_date와 custcode를 꺼내서 사용
	    String purDate = requestData.getPur_date();
	    int custCodeStr = requestData.getCustcode();
	    System.out.println("Received data from client: " + requestData);
	    System.out.println("Received pur_date: " + purDate);
	    System.out.println("Received custcode: " + custCodeStr);

	    // 정상적으로 변환된 경우에만 계속 진행
	    Map<String, String> response = jws.callInboundPD(purDate, custCodeStr);

	    // 모델에 결과 데이터 추가
	    model.addAttribute("response", response);

	    // 뷰로 이동
	    return "jk/inboundRegister";
	}

	// 입고 조회
	@GetMapping("/monthInbound")
	@ResponseBody
	public List<Warehouse> monthInbound(@RequestParam("inboundMonth") String inboundMonth, Model model ) {
	    logger.info("년도: {}", inboundMonth );

	    List<Warehouse> monthInbound = jws.monthInbound(inboundMonth);
	    model.addAttribute("inboundList",monthInbound);
	    
	    logger.info("Response: {}", monthInbound);
	    
	    return monthInbound;
	}


	// 출고조회
	@GetMapping("/monthOutbound")
	@ResponseBody
	public List<Warehouse> monthOutbound(@RequestParam("outboundMonth") String outboundMonth, Model model ) {
	    logger.info("년도: {}", outboundMonth );

	    List<Warehouse> monthOutbound = jws.monthOutbound(outboundMonth);
	    model.addAttribute("inboundList",monthOutbound);
	    
	    logger.info("Response: {}", monthOutbound);
	    
	    return monthOutbound;
	}
	
	// 월별 재고리스트 조회

	@GetMapping("/monthData")
	@ResponseBody
	public List<Warehouse> monthData(@RequestParam(name = "month") String month, @RequestParam(name = "invType", required = false) String invType) {
	    System.out.println("JkController monthData start....");
	    logger.info("Received month: {}", month);
	    logger.info("Received invType: {}", invType);

	    Map<String, String> params = new HashMap<>();
	    params.put("month", month);
	    params.put("invType", invType);

	    List<Warehouse> monthData = jws.monthData(params);
	    
	    logger.info("JkController monthData.size(): {}", monthData.size());

	    return monthData;
	}
	
	// 출고관리
	@RequestMapping(value="/outboundRegister")
	public String invSellList(SalesDetail sales, Model model, Warehouse warehouse, @RequestParam(value = "inboundMonth", required = false) String inboundMonth) {
	    System.out.println("JkController invSellList start....");
		UUID transactionId = UUID.randomUUID();
	    logger.info("Received month: {}", inboundMonth);

	    int inboundTotal =0;
					
		try {
		
			Paging page = new Paging(999);
			
			sales.setStart(page.getStart());
			sales.setEnd(page.getEnd());
			
			List<SalesDetail> sellList = jss.getListSalesInquiry(sales);
			logger.info("start", page.getStart());
			
			
			model.addAttribute("page", page);
			model.addAttribute("listSalesInquiry", sellList);
			
			
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "salesInquiry", e.getMessage());
		} finally {
			log.info("[{}]{}:{}", transactionId, "salesInquriry", "End");
		}

	
		System.out.println("model"+model);
		System.out.println("total"+inboundTotal);
	    return "jk/outboundRegister";
				
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

			return "jk/outboundRegister";
		}
		
		
	// 출고 프로시져 호출

		@RequestMapping(value = "/outboundRegister", method = RequestMethod.POST)
		public String invSalList(@RequestBody SalesDetail requestData, Model model) {
		    System.out.println("Received data from client: " + requestData);

		    // requestData에서 pur_date와 custcode를 꺼내서 사용
		    String salesDate = requestData.getSales_date();
		    int custCodeStr = requestData.getCustcode();
		    System.out.println("Received data from client: " + requestData);
		    System.out.println("Received sales_date: " + salesDate);
		    System.out.println("Received custcode: " + custCodeStr);

		    // 정상적으로 변환된 경우에만 계속 진행
		    Map<String, String> response = jws.callOutboundPD(salesDate, custCodeStr);

		    // 모델에 결과 데이터 추가
		    model.addAttribute("response", response);

		    // 뷰로 이동
		    return "jk/outboundRegister";
		}
		
		// 마감 프로시져 호출

		@RequestMapping(value = "/callCloseMonth", method = RequestMethod.POST)
		public String callCloseMonth(@RequestParam("ym") String ym, Model model) {
		    // "-" 제거
			log.info("ym", ym);
		    String formattedMonth = ym.replace("-", "");
		    System.out.println("vvv"+formattedMonth);
		    // 정상적으로 변환된 경우에만 계속 진행
		    Map<String, String> response = jws.callCloseMonth(formattedMonth);

		    // 모델에 결과 데이터 추가
		    model.addAttribute("response", response);
		    logger.info("Response: {}", response);
		    // 뷰로 이동
		    return "jk/inboundRegister";
		}


		   
	


	
@ControllerAdvice
public class GlobalExceptionHandler {
  // 예외 처리 핸들러
	 @ExceptionHandler(SQLIntegrityConstraintViolationException.class)
	    public ResponseEntity<String> handleSQLIntegrityConstraintViolationException(SQLIntegrityConstraintViolationException e) {
	        String errorMessage = "재고 등록에 실패했습니다. 이미 등록된 기초재고가 있습니다.";
	        return new ResponseEntity<>(errorMessage, HttpStatus.CONFLICT); // 409 Conflict 상태 코드 사용
	    }
}
}
