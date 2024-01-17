package com.oracle.OMG.controller;



import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.oracle.OMG.dto.Board;
import com.oracle.OMG.dto.Criteria;
import com.oracle.OMG.dto.PageDTO;
import com.oracle.OMG.service.thService.ThNoticeService;

import lombok.Data;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@Data
@RequestMapping("/notice/*")
public class ThNoticeController {
	
	private final ThNoticeService ns;
	
	@GetMapping("/list")
	public void list(Criteria cri, Model model) {
		log.info("list...");
		
		int total = ns.getNoticeTot(cri);
		
		model.addAttribute("noticeList", ns.getNoticeList(cri));
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		model.addAttribute("cri", cri);
		log.info("list: " + cri);

	}
	
	@GetMapping("/register")
	public void register() {	
		
	}
	
	@PostMapping("/register")
	public String register(Board board, RedirectAttributes rttr) {
		
		// 입력받은 값 확인
		log.info("register: " + board);
		
		// 게시글 등록
		ns.registerNotice(board);
		
		// 새로 등록된 게시물 번호 전달하기 위해 사용
		rttr.addFlashAttribute("result", board.getBrd_id());
		log.info("board.getBrd_id(): " + board.getBrd_id());
		
		return "redirect:/notice/list";
	}

	// @RequestParam("brd_id") 생략 or 명시적용도로 사용
	// @ModelAttribute 생략 or 명시적용도로 사용
	@GetMapping("/get")
	public void get(int brd_id, Model model, @ModelAttribute("cri") Criteria cri) {
		
		log.info("/get");
		model.addAttribute("notice", ns.getNotice(brd_id));
	}
	
	@GetMapping("/modify")
	public void modify(int brd_id, Model model, @ModelAttribute("cri") Criteria cri) {
		log.info("/modify");
		model.addAttribute("notice", ns.modifyNoticeView(brd_id));
	}
	
	@PostMapping("/modify")
	public String modify(Board board, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		
		log.info("modify"+ board);
		log.info("cri.getListLink() : " + cri.getListLink());
		if(ns.modifyNotice(board) > 0) {
			rttr.addFlashAttribute("result", "success");
		}
	
		
		return "redirect:/notice/list" + cri.getListLink(); 
	}
	
	@PostMapping("/remove")
	public String remove(@RequestParam("brd_id") int brd_id, @ModelAttribute("cri") Criteria cri, RedirectAttributes rttr) {
		
		log.info("remove ..." + brd_id);
		log.info("cri.getListLink() : " + cri.getListLink());
		if(ns.removeNotice(brd_id) > 0) {
			rttr.addFlashAttribute("result", "success");
		}
		
		return "redirect:/notice/list" + cri.getListLink();
	}
	

}
