package com.oracle.OMG.configuration;

import java.util.UUID;

import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.stereotype.Component;

import com.oracle.OMG.service.main.MainMemberService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RequiredArgsConstructor
@Component
@Slf4j
public class CustomAuthenticationProvider  implements AuthenticationProvider {
	
	// MainMemberService는 사용자 정보를 가져오는 서비스입니다.
	private final MainMemberService MMemberS;
	
	// authenticate 메서드는 사용자의 인증을 처리합니다.
	@Override
    public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		
		// 고유한 트랜잭션 ID 생성
		UUID transactionId = UUID.randomUUID();
		String username = "";
		String password = "";
		try {
			log.info("[{}]{}:{}",transactionId, "AuthenticationProvider", "start");
			
			// 전달된 Authentication 객체로부터 사용자의 ID와 비밀번호를 추출
	        username = authentication.getName();
	        password = authentication.getCredentials().toString();
	        log.info("username:{}",username);
	        log.info("password:{}",password);
	        
	        
//	        MMemberS.memSelectById(mem_id);
//	        if (user == null) {
//	            throw new BadCredentialsException("username is not found. username=" + username);
//	        }
//	        if (!password.equals(user.get().getPassword())) {
//	        	throw new BadCredentialsException("password is not matched");        	
//	        }
	        /* 개발 단계에서는 패스워드 인코딩 생략.
			if (!this.passwordEncoder.matches(password, user.getPassword())) {
				throw new BadCredentialsException("password is not matched");
			}
			*/
//	        userService.updateUserPoint(user.getId(), 9);
		} catch (Exception e) {
			// 예외 발생 시 로그를 남기고 예외를 다시 던집니다.
			log.error("[{}]{}:{}",transactionId, "AuthenticationProvider", e.getMessage());
			 throw e;  // 추가된 부분
		} finally {
			// 로깅 및 정리 작업
			log.info("[{}]{}:{}",transactionId, "AuthenticationProvider", "end");
		}	        
		// 사용자 인증이 성공했을 경우, 새로운 UsernamePasswordAuthenticationToken을 반환합니다.
    	return new UsernamePasswordAuthenticationToken(username, password);
    }

	// supports 메서드는 이 AuthenticationProvider가 특정한 인증 토큰을 지원하는지 여부를 확인합니다.
	@Override
	public boolean supports(Class<?> authentication) {
		// 현재는 UsernamePasswordAuthenticationToken만 지원하도록 설정되어 있습니다.
		 return (UsernamePasswordAuthenticationToken.class.isAssignableFrom(authentication));
	}
	

}
