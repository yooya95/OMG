package com.oracle.OMG.handler;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

//이 클래스는 Spring Security에서 로그인 성공 후의 동작을 커스터마이징하기 위한 핸들러입니다.
@Component	// 스프링이 이 클래스르 빈으로 관리하도록 하는 어노테이션
public class CustomAuthenticationSuccessHandler implements AuthenticationSuccessHandler {	// 인터페이스 구현, 시큐리티에서 로그인 성공 후 동작 정의하기 위한 인터페이스
	
	// onAuthenticationSuccess 메서드는 로그인 성공 시 호출됩니다.
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
										Authentication authentication) throws IOException, ServletException {
		
		// 로그인 성공 시에 실행되는 메서드입니다.
		System.out.println("CustomAuthenticationSuccessHandler onAuthenticationSuccess Start...");
		
		// 로그인 성공 후에 메인 페이지('/')로 리다이렉트합니다.
		response.sendRedirect(request.getContextPath() + "/");
	}
	
	
		
}
