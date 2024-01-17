package com.oracle.OMG.service.bkService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;


//특정 경로에 로그인 안한 사용자가 접근했는지 체크하는 
public class BkAuthInterceptor implements HandlerInterceptor {
	
	private static final Logger logger = LoggerFactory.getLogger(BkAuthInterceptor.class);
	
	// 로그인 페이지 이동 전, 현재 페이지를 Session 에 저장
	private void savePage(HttpServletRequest req) {
		
		// 현재 요청된 URI를 가져옵니다.
		String uri		= req.getRequestURI();
								// 웹 요청에서 URL 뒷부분에 위치하는 파라미터들을 포함하는 문자열
		String query	= req.getQueryString();
		
		// 기존 URI 에 parameter가 있을 경우, 이를 포함
		if (query == null || query.equals("null")) {
			query = "";
		} else {
			query = "?" + query;
		}
		
		// 현재 요청이 GET 방식(페이지 이동)일 때만 세션에 페이지 정보를 저장합니다.
		if (req.getMethod().equals("GET")) {
			
			logger.info("page: " + (uri + query));
			req.getSession().setAttribute("page", uri + query);
			
		}
	}
	
	
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		System.out.println("BkAuthInterceptor preHandle Start...");
		
		//  세션을 생성하거나 기존 세션을 가져오는
		HttpSession session = request.getSession();
		
		// 로그인 하지 않은 사용자일 경우, 
		if (session.getAttribute("login") == null) {
			
			logger.info("User is not logined.");
			
			// 이전 페이지 경로 저장
			savePage(request);
			
			// 로그인 페이지로 이동
			response.sendRedirect("/errorLogin");
			return false;
		}
		
		// 로그인한 사용자일 경우, Controller 호출
		return true;
	}
	
	
	
	@Override
	public void postHandle (HttpServletRequest request, HttpServletResponse response, Object Handler,
			ModelAndView modelAndView) throws Exception {
		
		System.out.println("BkAuthInterceptor postHandle Start...");
		
		
	}
	

}
