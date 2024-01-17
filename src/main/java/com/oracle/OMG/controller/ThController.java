package com.oracle.OMG.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.oracle.OMG.dto.Board;
import com.oracle.OMG.service.thService.ThQnAService;
import com.oracle.OMG.service.yaService.Paging;

import lombok.Data;
import lombok.extern.slf4j.Slf4j;

@Controller
@Data
@Slf4j
public class ThController {
	
	private final ThQnAService qs;
	
	@GetMapping("/qna")
	public String QnAList(Board board, String currentPage, Model model, HttpSession session){
		System.out.println("ThController QnAList Start...");
		// QnA 게시글 수
		int totalQnA = 0;
		totalQnA = qs.totalQnA();
		
		// Pagination								페이지당 가져올 게시글수
		Paging page = new Paging(totalQnA, currentPage, 3);
		System.out.println("page --> " + page);
		
		// board DTO에 담음(조회용변수 start, end 존재)
		board.setStart(page.getStart());
		board.setEnd(page.getEnd());
		
		// QnA 게시글 10개씩 가져오기
		List<Board> QnAList = qs.selectQnAList(board);
		
		// model에 저장
		model.addAttribute("QnAList", QnAList);
		model.addAttribute("page", page);
		
		return "th/QnAList";
	}	
	
	@GetMapping("/qna/write")
	public String QnAWriteForm(){
		System.out.println("ThController QnAWriteForm Start...");
		return "th/QnAWriteForm";
	}
	
	// URI 변경 예정
	@GetMapping("/qna/detail")
	public String QnADetail(Board board, Model model){
		System.out.println("ThController QnADetail Start...");
		System.out.println("ThController QnADetail brd_id -->" + board.getBrd_id());
		System.out.println("ThController QnADetail pageNum -->" + board.getPageNum());
		Board boardResult = qs.selectQnADetail(board);
		
		model.addAttribute("QnA", boardResult);
		model.addAttribute("pageNum", board.getPageNum());
		
		return "th/QnADetail";
	}
	
	// URI 변경 예정
	@GetMapping("/qna/update")
	public String QnAUpdateForm(){
		System.out.println("ThController QnAUpdateForm Start...");
		return "th/QnAUpdateForm";
	}
	
	
}
