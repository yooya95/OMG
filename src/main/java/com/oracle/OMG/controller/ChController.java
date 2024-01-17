package com.oracle.OMG.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.oracle.OMG.dto.Customer;
import com.oracle.OMG.dto.Item;
import com.oracle.OMG.dto.Member;
import com.oracle.OMG.dto.PurDetail;
import com.oracle.OMG.dto.Purchase;
import com.oracle.OMG.service.chService.ChCustService;
import com.oracle.OMG.service.chService.ChItemService;
import com.oracle.OMG.service.chService.ChPurService;
import com.oracle.OMG.service.chService.Paging;
import com.oracle.OMG.service.main.MainMemberService;
import com.oracle.OMG.service.yrService.YrItemService;

import lombok.Data;
import lombok.extern.slf4j.Slf4j;

@Controller
@Data
@Slf4j
public class ChController {
	
	private final ChPurService 	chPurService;
	private final ChItemService chItemService;
	private final ChCustService	chCustService;
	private final YrItemService itemService;
	private final MainMemberService mainMemberService;
	
	
	@RequestMapping("purList")
	public String purList(Model model, String currentPage, Purchase purchase) {
		
		int totalPur = 0;
		List<Purchase> purList = null;
		Paging page = null;
		System.out.println("ChController purList Start...");
		// 검색(custcode가 있을 때 )
		if(purchase.getCustcode() > 0) {
			model.addAttribute("srchCompany", purchase.getCustcode());
		}
		//검색(날짜가 있을 때)
		if(purchase.getPur_date() != null) {
			String purDate = purchase.getPur_date();
			DateTimeFormatter formmater = DateTimeFormatter.ofPattern("yy/MM/dd");
			LocalDate ldt = LocalDate.parse(purDate, formmater);
			model.addAttribute("srchDate", ldt);
		}
		
		totalPur = chPurService.totalPur(purchase);
		
		
		page = new Paging(totalPur, currentPage);
		
		purchase.setStart(page.getStart());
		purchase.setEnd(page.getEnd());
		
		//발주서 전체 리스트
		purList = chPurService.purList(purchase);
		// 발주서 리스트 소환 성공시 
		if(purList != null) {
			// purList 조회 성공 시
			for(Purchase p: purList) {
				// 제품 종류			총수량		총가격(전체 가격)
				int totalType = 0; int totalPrice = 0;
				
				// 발주서 상세 내용 불러오기 
				List<PurDetail> pd = chPurService.purDList(p);
				totalType = pd.size(); // row 수 = 발주서 내 물품 수
				// 상세 내용의 물품 항목별 수량과 결제액 
				for(PurDetail pd2 : pd) {
					totalPrice += pd2.getQty() * pd2.getPrice();
				}
				p.setTotalType(totalType);
				p.setTotalQty(pd.stream().mapToInt(m->m.getQty()).sum());
				p.setTotalPrice(totalPrice);
//				p.setTotalPrice(pd.stream().mapToInt(pd2 -> pd2.getQty() * pd2.getPrice()).sum());
			}
		}
		List<Customer> pur_custList = chCustService.custList();
		
		model.addAttribute("pur_custList", pur_custList);
		model.addAttribute("purList",purList);
		model.addAttribute("totalPur",totalPur);
		model.addAttribute("page",page);
		
		return "ch/purList";
	}
	// 발주신청 페이지로 이동
	@RequestMapping("purWriteForm")
	public String purWriteForm(Model model, HttpSession session) {
		List<Customer> pur_custList = null; // 매입처 List
		System.out.println("ChController purWriteForm Start...");
		if(session.getAttribute("mem_id") != null) {
			
			//회원 정보 조회 넣기, 로그인 여부 확인하기 
			int mem_id = (int) session.getAttribute("mem_id");
			Member member = mainMemberService.memSelectById(mem_id);
			pur_custList = chCustService.custList();
			
			model.addAttribute("pur_custList", pur_custList);
			model.addAttribute("member", member);
			
			
			return "ch/purWriteForm";
		}
		
		return "redirect:logOut";
	}
	
	@GetMapping("purDtail")
	public String purDtail(Model model,Purchase purchase, HttpSession session) {
		
		int mem_id = session.getAttribute("mem_id") != null? (int) session.getAttribute("mem_id") : 0;
		int mem_dept_md = 0;
		if(mem_id > 0) {
			mem_dept_md = (int) session.getAttribute("mem_dept_md"); 
		}
		
		System.out.println("mem_id------------------------------------------>" + mem_id);
		
		
		System.out.println("purchase.getPur_date()->" + purchase.getPur_date());
		System.out.println("purchase.getCustcode()->" + purchase.getCustcode());
		
		// PK를 이용한 단일 발주서 확인
		Purchase pc = chPurService.onePur(purchase);
		// 해당 발주서의 상세 항목 출력 
		List<PurDetail> pdList = chPurService.purDList(pc);
		// 해당 회사의 item List
		List<Item> itemList = chItemService.cItemList(purchase.getCustcode());
		// 람다 이용 총 합계 구하기 
		int totalPrice = pdList.stream().mapToInt(m->m.getPrice() * m.getQty()).sum();
		int totalQty   = pdList.stream().mapToInt(m->m.getQty()).sum();
		
		
		model.addAttribute("pc",pc);
		model.addAttribute("pdList",pdList);
		model.addAttribute("totalPrice", totalPrice);
		model.addAttribute("totalQty", totalQty);
		model.addAttribute("itemList", itemList);
		model.addAttribute("mem_id", mem_id);
		model.addAttribute("mem_dept_md", mem_dept_md);
		
		return "ch/purDtailPage";
	}
	
	// 발주서 작성 
	@PostMapping("writePurchase")
	public String writePurchase(Purchase purchase, @RequestParam Map<String, Object> detailMap, int rownum) {
		System.out.println("ChController writePurchase Start...");
		
		int resultPur = 0;
		int resultDetail = 0;
		// Purchase 테이블 작성
		resultPur = chPurService.writePur(purchase);
		// 성공시 detail 작성 (fk 때문)
		if(resultPur>0) {
			List<PurDetail> detailList = new ArrayList<PurDetail>();
			for(String key : detailMap.keySet()) {
				for(int i = 0; i<=rownum; i++) {
					if(key.contentEquals("code"+i)) {
						int code = Integer.parseInt((String) detailMap.get("code"+i));
						int qty = Integer.parseInt((String) detailMap.get("qty"+i));
						int price = Integer.parseInt((String) detailMap.get("price"+i));
						
						PurDetail purDetail = new PurDetail();
						purDetail.setCode(code);
						purDetail.setQty(qty);
						purDetail.setPrice(price);
						purDetail.setCustcode(purchase.getCustcode());
						detailList.add(purDetail);
					}
				}
			} 
			if(detailList.size() > 0) {
				resultDetail = chPurService.detailWrite(detailList);
			}
			
		} else if( resultPur == -1) {
			return "";
		}
		
		return "redirect:purList";
	}
	// 발주 완료 
	@PostMapping("completePur")
	public String completePur(Purchase purchase, HttpSession session) {
		System.out.println("ChController writePurchase Start");
		
		int result = 0;
		
		result = chPurService.completePur(purchase);
		
		if(result > 0) {
			return "redirect:purDtail?pur_date="+purchase.getPur_date() + "&custcode="+purchase.getCustcode();
		}
		
		return "redirect:purDtail";
	}
	
	// 발주 삭제 
	@PostMapping("deletePur")
	public String deletePur(Purchase purchase, HttpSession session ) {
		System.out.println("ChController writePurchase Start");
		
		int result = 0;
		
		result = chPurService.deletePur(purchase);
		
		
		return "redirect:purList";
	}
	
	// 발주서 ref 수정 
	@ResponseBody
	@PostMapping("refUpdate")
	public int refUpdate(Purchase purchase) {
		int result = chPurService.purUpdate(purchase);
		
		return result;
	}
	
	@ResponseBody
	@PostMapping("deletePurDet")
	public int deltePurDet(PurDetail purDetail) {
		int result = chPurService.deletePurDet(purDetail);
		
		return result;
	}
	
	
	@ResponseBody
	@PostMapping("insertDetail")
	public ModelAndView insertDetail(PurDetail pd,ModelAndView mav, HttpSession session) {
		int result = 0;
		int mem_id = session.getAttribute("mem_id") != null ? (int)session.getAttribute("mem_id") : 0;
		
		int mem_dept_md = 0;
		if(mem_id > 0) {
			mem_dept_md = (int) session.getAttribute("mem_dept_md"); 
		}
		
		
		System.out.println("ChController insertDetail Start...");
		// custcode와 price를 가져오기 위한 조회
		Item item = itemService.selectItem(pd.getCode());
		pd.setCustcode(item.getCustcode());
		pd.setPrice(item.getInput_price());
		result = chPurService.insertDetail(pd);
		if(result > 0) {
			// PK를 이용한 단일 발주서 확인
			Purchase pc = new Purchase();
			pc.setCustcode(pd.getCustcode());
			pc.setPur_date(pd.getPur_date());
			pc = chPurService.onePur(pc);
			// 해당 발주서의 상세 항목 출력 
			List<PurDetail> pdList = chPurService.purDList(pc);
			// 람다 이용 총 합계 구하기 
			int totalPrice = pdList.stream().mapToInt(m->m.getPrice() * m.getQty()).sum();
			int totalQty   = pdList.stream().mapToInt(m->m.getQty()).sum();
			mav.addObject("pdList",pdList);
			mav.addObject("totalPrice", totalPrice);
			mav.addObject("totalQty", totalQty);
			mav.addObject("mem_id", mem_id);
			mav.addObject("mem_dept_md", mem_dept_md);
			mav.addObject("pc", pc);
			
			mav.setViewName("ch/purDtable");
		}
		
		return mav;
	}
	
	@ResponseBody
	@PostMapping("qtyUpdate")
	public ModelAndView qtyUpdate(PurDetail pd, ModelAndView mav, HttpSession session) {
		System.out.println("ChController qtyUdate Start...");
		int mem_id = session.getAttribute("mem_id") != null ? (int)session.getAttribute("mem_id") : 0;
		
		int mem_dept_md = 0;
		if(mem_id > 0) {
			mem_dept_md = (int) session.getAttribute("mem_dept_md"); 
		}
		
		
		Item item = itemService.selectItem(pd.getCode());
		pd.setCustcode(item.getCustcode());
		int result = chPurService.qtyUpdate(pd);
		if(result > 0) {
			// PK를 이용한 단일 발주서 확인
			Purchase pc = new Purchase();
			pc.setCustcode(pd.getCustcode());
			pc.setPur_date(pd.getPur_date());
			pc = chPurService.onePur(pc);
			// 해당 발주서의 상세 항목 출력 
			List<PurDetail> pdList = chPurService.purDList(pc);
			// 람다 이용 총 합계 구하기 
			int totalPrice = pdList.stream().mapToInt(m->m.getPrice() * m.getQty()).sum();
			int totalQty   = pdList.stream().mapToInt(m->m.getQty()).sum();
			mav.addObject("pdList",pdList);
			mav.addObject("totalPrice", totalPrice);
			mav.addObject("totalQty", totalQty);
			mav.addObject("mem_id", mem_id);
			mav.addObject("mem_dept_md", mem_dept_md);
			mav.addObject("pc", pc);
			
			mav.setViewName("ch/purDtable");
		}
		mav.setViewName("ch/purDtable");
		return mav;
	}
	
	@ResponseBody
	@RequestMapping("chkDItem")
	public int chkDItem(PurDetail purDetail) {
		int result = 0;
		System.out.println("ChController chkDItem Start..............");
		result = chPurService.countDitem(purDetail);
		
		return result; 
	}
	
	@ResponseBody
	@RequestMapping("getItems")
	public ModelAndView getItems(int custcode, ModelAndView mav) {
		List<Item> itemList= null;
		System.out.println("ChController getItems Start..............");
		itemList = chItemService.cItemList(custcode);
		
		mav.addObject("itemList",itemList);
		
		mav.setViewName("ch/pur_selectItems");
		
		return mav; 
	}
	
	@ResponseBody
	@RequestMapping("wirteDetail")
	public ModelAndView itemDetail(PurDetail purDetail,String rownum ,ModelAndView mav) {
		System.out.println("ChController itemDetail Start...");
		Item item = itemService.selectItem(purDetail.getCode());
		
		mav.addObject("item",item);
		mav.addObject("qty",purDetail.getQty());
		mav.addObject("rownum",rownum);
		mav.setViewName("ch/wirteBodyRow");
		
		return mav;
	}
}
