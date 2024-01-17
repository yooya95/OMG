package com.oracle.OMG.controller.yrController;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.oracle.OMG.dto.Comm;
import com.oracle.OMG.dto.Customer;
import com.oracle.OMG.dto.Item;
import com.oracle.OMG.service.yrService.YrCommService;
import com.oracle.OMG.service.yrService.YrCustomerService;
import com.oracle.OMG.service.yrService.YrItemService;

import lombok.Data;
import lombok.extern.slf4j.Slf4j;

@Controller
@Data
@Slf4j
@RequestMapping("/item")
public class YrItemController {
	private final YrItemService 	yis;
	private final YrCommService 	ycms;
	private final YrCustomerService ycss;
	
	@GetMapping("/list")
	public String itemList(Model model
			            , @RequestParam(value = "deleted", required = false) String deleted
			            , @RequestParam(value = "cate_md", required = false) String cate_md
			            , @RequestParam(value = "keyword", required = false) String keyword
			               ) {
		log.info("itemList start");
		
		Item item = new Item();
		int cate_md_int = 0;
		
		if(deleted != null) {
			item.setDeleted(deleted);
		}
		if(cate_md != null ) {
			cate_md_int = Integer.parseInt(cate_md);
			item.setCate_md(cate_md_int);
		}
		if(keyword != null) {
			item.setKeyword(keyword);
		}
		
		// 제품 전체 리스트 가져오기
		List<Item> itemList = yis.itemList(item);
		
		// 카테고리 전체 리스트
		List<Comm> comm = ycms.commList();
		
		model.addAttribute("itemList", itemList);
		model.addAttribute("cm", comm);
		model.addAttribute("deleted", deleted);
		model.addAttribute("cate_md", cate_md);
		
		return "yr/item/itemList";
	}

	// 아이템 상세보기
	@GetMapping("/detail")
	public String itemDetail(@RequestParam("code") int code, Model model) {
		log.info("itemDetail start");
		
		// 제품 상세정보
		Item itemDetail = yis.selectItem(code);
		
		// 거래처 전체 리스트
		List<Customer> customer = ycss.customerList();
		
		// 카테고리 전체 리스트
		List<Comm> comm = ycms.commList();
		
		model.addAttribute("i", itemDetail);
		model.addAttribute("cs", customer);
		model.addAttribute("cm", comm);
		
		return "yr/item/itemDetail";
	}
	
	@PostMapping("/update")
	public String itemUpdate(Item item, RedirectAttributes rttr) {
		// RedirectAttributes: redirect로 보낼 때, 값을 담아서 보낼 수 있다
		log.info("itemUpdate start");
		
		int result = yis.updateItem(item);
		
		if(result > 0) rttr.addFlashAttribute("msg", "수정 완료");
		else 		   rttr.addFlashAttribute("msg", "수정 실패");
		
		return "redirect:/item/list";
	}
	
	@GetMapping("/create")
	public String itemCreate(Model model) {
		log.info("itemCreate start");
		
		// 거래처 전체 리스트
		List<Customer> customer = ycss.customerList();
		
		// 카테고리 전체 리스트
		List<Comm> comm = ycms.commList();
		
		model.addAttribute("cs", customer);
		model.addAttribute("cm", comm);
		
		return "yr/item/itemCreate";
	}
	
	@PostMapping("/createPro")
	public String itemCreatePro(Item item, RedirectAttributes rttr) {
		// RedirectAttributes: redirect로 보낼 때, 값을 담아서 보낼 수 있다
		log.info("itemCreatePro start");
		
		int result = yis.insertItem(item);
		
		if(result > 0) rttr.addFlashAttribute("msg", "등록 완료");
		else 		   rttr.addFlashAttribute("msg", "등록 실패");
		
		return "redirect:/item/create"; // forward:yr/item/itemCreate 에서 수정함
	}
	
	// 삭제 기능은 일단 보류
//	@PostMapping("/delete")
//	public String itemDelete(@RequestParam("code") int code, RedirectAttributes rttr) {
//		System.out.println("YrItemController itemDelete start");
//		
//		int result = yis.deleteItem(code);
//		if(result > 0) rttr.addFlashAttribute("delete", "삭제 완료");
//		else 		   rttr.addFlashAttribute("delete", "삭제 실패");
//		return "redirect:/item/list"; // forward:yr/item/itemCreate 에서 수정함
//	}
	
}
