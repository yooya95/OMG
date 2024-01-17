package com.oracle.OMG.controller;

import java.security.SecureRandom;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.ResponseEntity;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.oracle.OMG.dto.Member;
import com.oracle.OMG.service.bkService.BkMemberService;
import com.oracle.OMG.service.main.MainMemberService;
import com.sun.mail.iap.Response;

import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.exception.NurigoMessageNotReceivedException;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.service.DefaultMessageService;


@Controller
@Data
@Slf4j
public class BkController {
	
	private final BkMemberService		bMemberS;
	private final MainMemberService		MMemberS;
	private final JavaMailSender		mailSender;
	
	
	
	@RequestMapping(value = "logIn")
	public String logIn() {
		
		MMemberS.getLoggedInId();
		
		System.out.println("BkController logIn Start...");
		log.info("BkController logIn Start...");
		
		return "logIn";
	}
	
	
	
	@RequestMapping(value = "/logOut")
	public String logOut(Member member, HttpSession session) {
		
		System.out.println("BkController logOut Start...");
		System.out.println("BkController logOut session -> " + session);
		session.invalidate();
		System.out.println("BkController logOut session -> " + session);
		
		return "redirect:/logIn";
	}
	
	
	
	@RequestMapping(value = "/forgotPassword")
	public void forgotPassword() {
		
		System.out.println("BkController forgotPassword Start...");
		
		
	}
	
	
	
	@RequestMapping(value = "/403forbidden")
	public String forbidden() {
		
		System.out.println("BkController 403forbidden Start...");
		
		return "/bk/403forbidden";
	}

	
	
	@RequestMapping(value = "/errorLogin")
	public String errorPage() {
		
		System.out.println("BkController errorLogin Start...");
		
		return "bk/errorLogin";
	}
	
	
	
	@RequestMapping(value = "/myApproval")
	public String myApproval() {
		
		System.out.println("BkController myApproval Start...");
		
		return "bk/myApproval";
	}
	
	
	
	@RequestMapping(value = "/viewApproval")
	public String viewApproval() {
		
		System.out.println("BkController viewApproval Start...");
		
		return "bk/viewApproval";
	}
	
	
	
	@RequestMapping(value = "/newApproval")
	public String newApproval() {
		
		System.out.println("BkController newApproval Start...");
		
		return "bk/newApproval";
	}
	
	
	
	@RequestMapping(value = "/editApproval")
	public String editApproval() {
		
		System.out.println("BkController editApproval Start...");
		
		return "bk/editApproval";
	}
	
	
	
	
	
	@RequestMapping(value = "/login")
	public String login(Member member, HttpSession session, HttpServletRequest request, Model model) {
		
		System.out.println("BkController login Start...");
		System.out.println("BkController login member.getMem_id() -> " + member.getMem_id());
		System.out.println("BkController login member.getMem_pw() -> " + member.getMem_pw());
		
		// mapper key:	bkLogin		해당 ID와 PW가 맞는 사원의 정보 모두 조회
		Member loginResult = bMemberS.login(member);
		System.out.println("BkController login loginResult -> " + loginResult);
		
		// 회원 정보가 존재 하는 경우
		if (loginResult != null) {
			
			// 1. 근무 중 사원 -> 로그인 처리
			if(loginResult.getMem_resi() == null) {
				// ?: 인터셉터가 아니라 일반 로그인이면 여기서 세션 담아야 
				session = request.getSession();
				session.setAttribute("login", true);	// "login" 속성을 설정
				session.setAttribute("mem_id", loginResult.getMem_id());
				session.setAttribute("mem_name", loginResult.getMem_name());
				session.setAttribute("mem_dept_lg", loginResult.getMem_dept_lg());
				session.setAttribute("mem_dept_md", loginResult.getMem_dept_md());
				session.setAttribute("mem_right", loginResult.getMem_right());
				session.setAttribute("mem_img", loginResult.getMem_img());
				
				
				// 세션에 관리자 권한 추가할 지 -> 보류

				
				System.out.println("BkController login session -> " + session);
				// 메인 페이지로 
				return "redirect:/";
				
			} else {
				// 2. 퇴사한 사원
				System.out.println("BkController login loginResult.getMem_resi() -> " + loginResult.getMem_resi());
				
				model.addAttribute("message", "퇴사한 사원입니다");
				return "logIn";
				
			}
			
		} else {
			
			// 3. 회원 정보 없는 경우 (아이디, 비밀번호 틀린 경우)
			model.addAttribute("message", "아이디 또는 비밀번호를 확인해주세요");
			return "logIn";
			
		}
	}
	
	
	
	// 비밀번호 찾기 Ajax
	@ResponseBody
	@PostMapping("/sendCode")
		// Json 형태 반환할 때 사용
	public Map<String, String> sendCode(@RequestBody Member member) {
		
		System.out.println("BkController sendCode Start...");
		System.out.println("BkController sendCode member.getMem_name() -> " + member.getMem_name());
		System.out.println("BkController sendCode member.getMem_email() -> " + member.getMem_email());
		
		// String mem_name = member.getMem_name();
		// int tel = formData.getMem_tel();
		
		// DB에서 name, email 확인 후 일치 여부 판단		mapper key:	bkCheckNameAndMail
		Member checkResult = bMemberS.checkNameAndMail(member);
		System.out.println("checkResult -> " + checkResult);
		
		Map<String, String> response = new HashMap<>();
		
		// 회원 정보가 일치하는 경우 -> 랜덤 숫자 생성 후 발송
		if(checkResult != null) {
			
			// 임시 비밀번호 생성
			String randomPw = bMemberS.PwGenerator();
			Map<String, Object> TempPwByName = new HashMap<String, Object>();
			TempPwByName.put("mem_name", checkResult.getMem_name());
			TempPwByName.put("RandomPw", randomPw);
			System.out.println("RandomPw -> " + randomPw);
			
			// 임시 비밀번호로 변경
			int updateResult = bMemberS.updateTempPw(TempPwByName);
			System.out.println("BkController sendCode updateResult -> " + updateResult);
			
			// String randomCode = generateRandomCode();	// 여기에서 랜덤 코드를 생성하는 메소드 호출
			// System.out.println("randomCode -> " + randomCode);
			
			// 해당 랜덤 문자를 발송 - 이메일
			System.out.println("mail Sending...");
			
			// 받는 사람 메일 주소
			String recvMail = member.getMem_email();
			System.out.println("recvMail -> " + recvMail);
			
			// 보내는 사람 메일 주소
			String sendMail = "teamssj02@gmail.com";
			System.out.println("sendMail -> " + sendMail);
			
			// 제목
			String title = "OMG 비밀번호 찾기";
			
			// int result = 0;
			
			try {
				
				// Mime 전자 우편 Internet 표준 Format
				MimeMessage msg = mailSender.createMimeMessage();
				MimeMessageHelper msgHelper = new MimeMessageHelper(msg, true, "UTF-8");
				msgHelper.setFrom(sendMail); 	// 보내는 사람: 생략하거나 하면 정상 작동을 안함
				msgHelper.setTo(recvMail);		// 받는 사람
				msgHelper.setSubject(title); 	// 메일 제목:	생략 가능하지만 스팸 메일 분류 때문에 가급적 넣음
				msgHelper.setText("임시 비밀번호 입니다: " + randomPw);
				
				mailSender.send(msg);
				// result = 1;		// 정상 전달
				// 클라이언트에 응답
				response.put("status", "success");
				response.put("message", "인증번호가 전송되었습니다.");
				System.out.println("response -> " + response);
				
			} catch (Exception e) {
				System.out.println("sendCode e.getMessage() -> " + e.getMessage());
				// result = 2;	// 메일 전달 실패
				response.put("status", "error");
				response.put("message", "메일 발송 오류");
				System.out.println("response -> " + response);
				
			}
			
			// 해당 랜덤 문자를 발송
			// sendSms("formData.getNumber() 라던지 여기에 mem 전화번호 넣어야 함", randomCode);	// sms 발송 메서드 호출
			
			// 클라이언트에 응답
			// response.put("status", "success");
			// response.put("message", "인증번호가 전송되었습니다.");
		// 일치하지 않는 경우 -> alert
		} else {
			System.out.println("checkResult -> null");
			response.put("status", "error");
			response.put("message", "이름과 이메일이 일치하지 않습니다.");
			System.out.println("response -> " + response);
		}
		System.out.println("response return 직전..... ");
		return response;
	}
	
	
	
	//  보류 중 - 랜덤 코드를 생성하는 메소드:	인증 번호 대신 임시 비밀번호 방식으로 바꿈
	private String generateRandomCode() {
		
		System.out.println("BkController generateRandomCode Start...");
		
		// 랜덤 숫자 6자리 생성하는 로직을 구현하세요
		Random random = new Random();
		int randomNumber = 100000 + random.nextInt(900000);	// 100000에서 999999 사이의 랜덤 숫자
		
		System.out.println("BkController generateRandomCode randomNumber -> " + randomNumber);
		return String.valueOf(randomNumber);
		
	}
	
	
	
	// 보류 중 - sms 발송 메서드:	문자 대신 이메일로 우선 대체 
	private void sendSms(String phoneNumber, String randomCode) {
		
		
		System.out.println("Sending SMS to " + phoneNumber + ": Your verification code is " + randomCode);
		
		DefaultMessageService messageService =  NurigoApp.INSTANCE.initialize("API 키 입력", "API 시크릿 키 입력", "https://api.coolsms.co.kr");
		// Message 패키지가 중복될 경우 net.nurigo.sdk.message.model.Message로 치환하여 주세요
		Message message = new Message();
		message.setFrom("계정에서 등록한 발신번호 입력");
		message.setTo("수신번호 입력");
		message.setText("SMS는 한글 45자, 영자 90자까지 입력할 수 있습니다.");

		try {
		  // send 메소드로 ArrayList<Message> 객체를 넣어도 동작합니다!
		  messageService.send(message);
		} catch (NurigoMessageNotReceivedException exception) {
		  // 발송에 실패한 메시지 목록을 확인할 수 있습니다!
		  System.out.println(exception.getFailedMessageList());
		  System.out.println(exception.getMessage());
		} catch (Exception exception) {
		  System.out.println(exception.getMessage());
		}
		
	}
	
	

}
