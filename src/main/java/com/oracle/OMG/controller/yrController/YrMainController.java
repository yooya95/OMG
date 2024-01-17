package com.oracle.OMG.controller.yrController;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.oracle.OMG.dto.Criteria;
import com.oracle.OMG.service.thService.ThNoticeService;

import lombok.Data;
import lombok.extern.slf4j.Slf4j;

@Controller
@Data
@Slf4j
@RequestMapping("/main")
public class YrMainController {
	private final ThNoticeService ns;
	
	@GetMapping("/loginNotice")
	public String loginNotice(Criteria cri, Model model) {
		log.info("/main/loginNotice");
		cri.setAmount(7);
		model.addAttribute("noticeList", ns.getNoticeList(cri));
		log.info("loginNotice: " + cri);
		return "yr/main/loginNotice";
	}
	
	@GetMapping("/mainNotice")
	public String mainNotice(Criteria cri, Model model) {
		log.info("/main/mainNotice");
		cri.setAmount(8);
		model.addAttribute("noticeList", ns.getNoticeList(cri));
		log.info("mainNotice: " + cri);
		return "yr/main/mainNotice";
	}
	
	
}
