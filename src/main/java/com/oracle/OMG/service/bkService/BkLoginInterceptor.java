package com.oracle.OMG.service.bkService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.oracle.OMG.dto.Member;

import lombok.extern.slf4j.Slf4j;

@Slf4j
// 로그인 인터셉터: url 주소창에 입력했을  때, 로그인 한 사용자가 맞는지 확인하고, 아니면 로그인 페이지가 뜨는 인터셉터
public class BkLoginInterceptor implements HandlerInterceptor {
	
	private static final String LOGIN = "login";
	private static final Logger logger = LoggerFactory.getLogger(BkLoginInterceptor.class);
	
	
	
	@Override
	public boolean preHandle (HttpServletRequest request, 
							  HttpServletResponse response, 
							  Object handler)
			throws Exception {
		
		System.out.println("BkLoginInterceptor preHandle Start...");
		
		// 클라이언트 요청에 대한 세션을 가져오거나, 세션이 없을 경우 새로 생성
		HttpSession session = request.getSession();
		
		if (session.getAttribute("login") != null) {
			
			// 기존 HttpSession 에 남아있는 정보가 있는 경우, 이를 삭제
			logger.info("clear login data before");
			session.removeAttribute(LOGIN);
			
		}
		
		return true;
	}
	
	
	
	@Override
	public void postHandle(HttpServletRequest request 
						  ,HttpServletResponse response 
						  ,Object handler
						  ,ModelAndView modelAndView
						   )
				throws Exception {
		
		System.out.println("BkLoginInterceptor postHandle Start...");
		HttpSession session = request.getSession();
		
		System.out.println("modelAndView -> " + modelAndView);
		ModelMap	modelMap = modelAndView.getModelMap();
		Object	member	=	modelMap.get("member");
		System.out.println("BkLoginInterceptor postHandle modelMap.get(\"member\") -> " + modelMap.get("member"));
		
		if(member != null) {
			
			// 로그인 성공 시, Session 에 저장 후, 초기 화면 이동
			logger.info("new login success");
			session.setAttribute(LOGIN, member);
			
			
			// 이전 페이지 불러오기
			Object page = session.getAttribute("page");
			
			// dest 값이 null 이 아니면 이전 주소로, null 이면 메인페이지로 이동
			response.sendRedirect(page != null ? (String) page : "/");
		}
	}
	
	

}
