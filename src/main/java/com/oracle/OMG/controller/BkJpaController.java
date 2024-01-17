package com.oracle.OMG.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.oracle.OMG.domain.Member;
import com.oracle.OMG.repository.BkMemberJpaRepository;
import com.oracle.OMG.service.bkService.BkMemberJpaService;
import com.oracle.OMG.service.main.MainMemberService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class BkJpaController {
	
	
	private final BkMemberJpaService	BMemberJpaS;
	
	
	
	
	@PostMapping("/loginManager")					// member 객체가 HTML form 데이터로 자동으로 매핑됨
	public String loginMember(@ModelAttribute Member member) {
		System.out.println("BkJpaRestApiController loginManager Start...");
		System.out.println("BkJpaRestApiController loginManager member.getMem_id() -> " + member.getMem_id());
		
		
		// 사용자 검증 로직 수행 (아이디, 비밀번호 확인)
		Member foundMember = BMemberJpaS.login(member);
		
		
		
		
		// 조회된 사용자가 존재하고, 입력된 비밀번호가 저장된 비밀번호와 일치하는 경우
		if (foundMember != null) {
			
			// 1. 근무 중 사원인지 확인
			if(foundMember.getMem_resi() == null) {
				
				// 2. 권한이 있는지 -> 로그인 처리
				if(foundMember.getMem_right() == 1) {
					System.out.println("BkJpaRestApiController login foundMember.getMem_right() -> " + foundMember.getMem_right());
					System.out.println("BkJpaRestApiController login ResponseEntity.ok().build() -> " + ResponseEntity.ok().build());
					// 세션? 핸들러에서 ?
					// 이 경우에만 main 가도록
					return "/main";
					
				} else {
					// 3. 일반 사원	"권한이 없습니다"
					return "logIn";
				}
				
				// 4. 퇴사한 사원	"퇴사한 사원입니다"
			} else {
				return "logIn";
			}
			
			// 로그인 성공 응답 반환		
		} else {
			// 사용자 이름 또는 비밀번호가 잘못된 경우, UNAUTHORIZED(401) 상태와 함께 메시지 반환
			// UNAUTHORIZED -> 권한 없음		"잘못된 사용자 이름 또는 비밀번호 입니다"
			return "logIn";
		}
	}

}
