package com.oracle.OMG.controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.oracle.OMG.dto.Member;
import com.oracle.OMG.dto.Paging;
import com.oracle.OMG.dto.Warehouse;
import com.oracle.OMG.service.shService.ShMemberService;

import lombok.Data;
import lombok.extern.slf4j.Slf4j;

@Controller
@Data
@Slf4j
public class ShController {
	
	private final ShMemberService ms;
	
	/* 메인 화면용 컨트롤러 */
	@RequestMapping(value = "/")
	public String main() {
		
		return "main";
	}
	
	//메인화면 개인정보 출력
	@ResponseBody
	@RequestMapping(value = "mainMember", method = RequestMethod.POST)
	public Member mainMember(@RequestParam("memId") int memId) {
		System.out.println("shController mainMember() Start");
		Member member = new Member();
		member = ms.mainMember(memId);
		System.out.println(member);
		return member;
	}
	
	//메인화면 재고리스트 출력
	@ResponseBody
	@RequestMapping(value = "mainInventory", method = RequestMethod.POST)
	public Map<String, Object> mainInventory(String currentPage) {
		System.out.println("shController mainInventory() Start");
		Warehouse warehouse = new Warehouse();
		//paging 작업
		int listTotal = ms.mainInventoryCount();
		Paging page = new Paging(listTotal, currentPage);
		warehouse.setStart(page.getStart());
		warehouse.setEnd(page.getEnd());
		System.out.println("page->"+page);
		Map<String, Object> response = new HashMap<String, Object>();
		List<Warehouse> warehouseList = ms.mainInventory(warehouse);
		response.put("warehouseList", warehouseList);
		return response;
	}
	
	//메인화면 해당 월 매입 출력
	@ResponseBody
	@RequestMapping(value = "thisMonthPurchase", method = RequestMethod.POST)
	public Map<String, Object> thisMonthPurchase() {
		System.out.println("shController monthTotalPurchase() Start");
		Map<String, Object> response = new HashMap<String, Object>();
		int thisMonthPurchase = ms.thisMonthPurchase();
		int exMonthPurchase   = ms.exMonthPurchase();
		float purchase = (float)(thisMonthPurchase - exMonthPurchase)/exMonthPurchase* 100;
		int purchaseCrease = (int)purchase;
		response.put("thisMonthPurchase", thisMonthPurchase);
		response.put("purchaseCrease", purchaseCrease);
		return response;
	}
	
	//메인화면 해당 월 매출 출력
	@ResponseBody
	@RequestMapping(value = "thisMonthSale", method = RequestMethod.POST)
	public Map<String, Object> thisMonthSale() {
		System.out.println("shController monthTotalSale() Start");
		Map<String, Object> response = new HashMap<String, Object>();
		int thisMonthSale = ms.thisMonthSale();
		int exMonthSale   = ms.exMonthSale();
		float sale = (float)(thisMonthSale - exMonthSale)/exMonthSale* 100;
		int saleCrease = (int)sale;
		System.out.println("thisMonthPurchase->"+thisMonthSale);
		System.out.println("exMonthPurchase->"+exMonthSale);
		System.out.println("purchaseCrease->"+saleCrease);
		response.put("thisMonthSale", thisMonthSale);
		response.put("saleCrease", saleCrease);
		return response;
	}
	
	//팀원 리스트 출력
	@ResponseBody
	@RequestMapping(value = "mainTeamList")
	public Map<String, Object> mainTeamList(@RequestParam("memId") int memId,  Model model) {
		System.out.println("shController teamList() Start");
		System.out.println(memId);
		Map<String, Object> response = new HashMap<String, Object>();
		List<Member> teamMember = ms.mainTeamList(memId);
		response.put("teamMember", teamMember);
		return response;
	}
	/*/메인 화면용 컨트롤러 */
	
	//사원등록 페이지
	@RequestMapping(value = "memberR")
	public String memberRegistration() {
		return "sh/memberRegistration";
	}
	
	//사원 정보 생성
	@RequestMapping(value = "createMember", method = RequestMethod.POST)
	public String createMember( @RequestParam("mem_address1") 	   String address1,
								@RequestParam("mem_address2")  String address2,
								@RequestParam("mem_address3") String address3,
								
								@RequestParam("mem_email1") String email1,
								@RequestParam("mem_email2") String email2,
								
								@ModelAttribute Member member,
							    @RequestParam("img") 	 MultipartFile img,
							    @RequestParam("defaultImg") 	 String img2,
							   HttpServletRequest 		 request,
							   Model 					 model) throws IOException {
		System.out.println("shController createMember() Start");
		System.out.println("Received member: " + member);
		int result = 0;
		String address = address1 + "/" + address2 + "/" + address3;
		String email   = email1 + "@" + email2;
		member.setMem_address(address);
		member.setMem_email(email);
		member.setMem_img(img2);
		if(!img.isEmpty()) {
		//multipartFile 경로 설정
		String path 		  = request.getSession().getServletContext().getRealPath("upload");
		
		//경로 내 파일 생성
		String root = path +"\\sh";
		File file = new File(root);
		if(!file.exists()) file.mkdir();	//만약 파일이 존재하지 않으면 생성한다.
		
		//업로드할 폴더 설정
		String originFileName = img.getOriginalFilename();
		String ext 			  = originFileName.substring(originFileName.lastIndexOf("."));
		String ranFileName 	  = UUID.randomUUID().toString() + ext;
		
		File changeFile 	  = new File(root + "\\" + ranFileName);
		
			try {
				img.transferTo(changeFile);
				System.out.println("파일 업로드 성공");
				member.setMem_img(ranFileName);
			} catch (Exception e) {
				System.out.println("shController createMember Exception ->" + e.getMessage());
			}
		}
		System.out.println("Received member: " + member);
			
		result = ms.createMember(member);
	
		
		return "redirect:/memberL";
 	}	
	
	//인사부 사원정보 수정
	@RequestMapping(value = "memberU")
	public String memberUpdate(@RequestParam("mem_id") int mem_id, Model model) {
		System.out.println("shController memberUpdate() Start");
		//특정 사원 정보
		Member member = new Member();
		member = ms.searchMemberDetail(mem_id);
		
		model.addAttribute("member",member);
		return "sh/memberUpdate";
	}
	
	@RequestMapping(value = "updateMember", method = RequestMethod.POST)
	public String updateMember( @RequestParam("mem_address1")  String address1,
								@RequestParam("mem_address2")  String address2,
								@RequestParam("mem_address3")  String address3,
								
								@RequestParam("mem_email1")    String email1,
								@RequestParam("mem_email2")    String email2,
								
								
							    @RequestParam(name="img1", required=false) 	 MultipartFile img1,
							    @RequestParam("img2") 	 String img2,
							    
							    @RequestParam(name="leave", required=false)	String leave,
							    @RequestParam(name="rein" , required=false)	String rein,
							    @RequestParam(name="resi" , required=false)	String resi,
	
							    @ModelAttribute 		 Member member,
							    HttpServletRequest 		 request) throws IOException {
		System.out.println("shController updateMember() Start");
		System.out.println("Received member1: " + member);
		int result = 0;
		
		String address = address1 + "/" + address2 + "/" + address3;
		String email   = email1 + "@" + email2;
		member.setMem_address(address);
		member.setMem_email(email);
		member.setMem_img(img2);
		
		if(!img1.isEmpty()) {
			try {
				//multipartFile 경로 설정
				String path 		  = request.getSession().getServletContext().getRealPath("upload");
				
				//경로 내 파일 생성
				String root = path +"\\sh";
				
				//업로드할 폴더 설정
				String originFileName = img1.getOriginalFilename();
				String ext 			  = originFileName.substring(originFileName.lastIndexOf("."));
				String ranFileName 	  = UUID.randomUUID().toString() + ext;
				
				File changeFile 	  = new File(root + "\\" + ranFileName);
				
				img1.transferTo(changeFile);
				
				System.out.println("파일 업로드 성공");
				member.setMem_img(ranFileName);
			} catch (Exception e) {
				System.out.println("shController updateMember Exception ->" + e.getMessage());
			}
		}
		System.out.println("Received member2: " + member);
		
		if(leave!=null && !leave.trim().isEmpty()) {
			member.setMem_leave(leave);
			result = ms.updateLeaveMember(member);
		} else if (rein!=null && !rein.trim().isEmpty()) {
			member.setMem_rein(rein);
			result = ms.updateReinMember(member);
		} else if (resi!=null && !resi.trim().isEmpty()) {
			member.setMem_resi(resi);
			result = ms.updateResiMember(member);
		} else {
			result = ms.updateMember(member);
		}
		
		return "redirect:/memberL";
 	}	
	
	//사원 목록
	@RequestMapping(value = "memberL")
	public String memberList(String currentPage, Model model) {
		System.out.println("shController memberList() Start");
		Member member = new Member();
		//사원 총 인원수
		int memberTotal = ms.memberTotal();
		
		//리스트 페이지 세팅
		Paging page = new Paging(memberTotal, currentPage);
		int start = page.getStart();
		int end   = page.getEnd();
		member.setStart(start);
		member.setEnd(end);
		
		//사원 리스트 조회용
		List<Member> memberList = ms.memberList(member);
		
		model.addAttribute("memberTotal", memberTotal);
		model.addAttribute("memberList", memberList);
		model.addAttribute("page",page);
		return "sh/memberList";
	}
	
	@ResponseBody
	@PostMapping(value = "selectStatus")
	public HashMap<String, Object> selectStatus() {
		System.out.println("shController selectStatus() Start");
		HashMap<String, Object> result = new HashMap<String, Object>();
		List<Member> statusList = ms.selectStatus();
		System.out.println("statusList=>"+statusList);
		result.put("statusList", statusList);
		return result;
	}
	
	//사원 목록 검색창
	@RequestMapping(value = "memberRequirement", method = RequestMethod.GET)
	public String searchMemberRequirement(@RequestParam("keyword") String keyword, String currentPage, Model model) {
		System.out.println("shController searchMemberRequirement() Start");
		Member member = new Member();
		member.setKeyword(keyword);
		//사원 총 인원수
		int searchMemberTotal = ms.searchMemberTotal(member);
		System.out.println("searchMemberTotal->"+searchMemberTotal);
		
		//리스트 페이지 세팅		
		Paging page = new Paging(searchMemberTotal, currentPage);
		int start = page.getStart();
		int end   = page.getEnd();
		member.setStart(start);
		member.setEnd(end);
		
		List<Member> memberList = ms.memberSearchList(member);
		model.addAttribute("memberList",memberList);
		model.addAttribute("page",page);
		model.addAttribute("memberTotal", searchMemberTotal);
		System.out.println("memberList->"+memberList);

		return "/sh/memberList";
	}
	
	@RequestMapping(value = "pwdCheck")
	public String pwdCheck(@RequestParam("userPwd") String userPwd, Model model) {
		//결과값 들어갈 변수
		String result = "";
		
		//특정 문구 제한
		if(userPwd.contains("1004")||userPwd.contains("8282")||userPwd.contains("abc123")) {
			System.out.println("위험 - 특정 문구 포함 불가");
			result = "2";
		} else if(userPwd.matches("^[a-zA-Z]*$")||userPwd.matches("^[0-9]*$")){
			System.out.println("보통 - 영문자, 숫자만 있을 경우");
			result = "3";
		} else {
			System.out.println("안전 - 영문자, 숫자, 특수문자 중 2개 이상 조합");
			result = "4";
		}
		return result;
	}
	
	//개인 회원정보
	@RequestMapping(value = "memberD")
	public String memberDetail(@RequestParam("mem_id") int mem_id, Model model) {
		System.out.println("shController memberDetail() Start");
		Member member = new Member();
		
		member = ms.searchMemberDetail(mem_id);
		
		System.out.println("member->"+member);
		
		model.addAttribute("member",member);
		
		return "sh/memberDetail";
	}
	
	@RequestMapping(value = "detailMember", method = RequestMethod.POST)
	public String detailMember(@RequestParam("mem_address1")  String address1,
							   @RequestParam("mem_address2")  String address2,
							   @RequestParam("mem_address3")  String address3,
							
							   @RequestParam("mem_email1")    String email1,
							   @RequestParam("mem_email2")    String email2,
							
							   @RequestParam("oldPw")		  String oldPw,
							   @ModelAttribute Member member)throws IOException {
		System.out.println("shController detailMember() Start");
		System.out.println("Received member1: " + member);
		int result = 0;
		String address = address1 + "/" + address2 + "/" + address3;
		String email   = email1 + "@" + email2;
		member.setMem_address(address);
		member.setMem_email(email);
		System.out.println("Received member: " + member);
		String pw = member.getMem_pw();
		System.out.println("Received pw: " + pw);
		System.out.println("Received oldPw: " + oldPw);
		if(pw==null || pw.isEmpty()) {
			System.out.println("pw==null");
			member.setMem_pw(oldPw);
			System.out.println("Received pw: " + member.getMem_pw());
		} else {
			System.out.println("pw!=null");
		}
			result = ms.detailMember(member);
		return "redirect:/";
	}
}
