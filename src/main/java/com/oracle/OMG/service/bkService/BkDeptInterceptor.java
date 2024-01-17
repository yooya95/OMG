package com.oracle.OMG.service.bkService;

import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.util.AntPathMatcher;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

// HandlerInterceptor 인터페이스를 구현한 BkAuthInterceptor 클래스
// 부서별 인터셉터: 해당 부서 사원이 맞는지 확인하고, 아니면 접근 제한 페이지가 뜨는 인터셉터
public class BkDeptInterceptor implements HandlerInterceptor {
	
	
	// 각 권한에 대한 허용된 페이지를 매핑하는 Map
	private static final Map<Integer, String[]> DEPT_PAGE_MAP = new HashMap<>();
	
	// AntPathMatcher는 스프링 프레임워크에서 제공하는 클래스로, 문자열 기반의 경로 패턴을 처리하는 데 사용됩니다
	private static final AntPathMatcher pathMatcher = new AntPathMatcher();
	
	static {
		 // 각 권한에 대한 허용된 부서별 페이지 등록		   /**: 와일드카드 패턴. 특정 경로 및 하위 경로에 대한 일치
		 DEPT_PAGE_MAP.put(999, new String[] {"/**"});					// 관리자 - 모든 페이지에 대한 권한
		 DEPT_PAGE_MAP.put(100, new String[] {"/customerSales"});	// 연아 - 거래처관리
		 DEPT_PAGE_MAP.put(101, new String[] {"/memberL/**", "/memberR/**", "/memberU/**", "/notice/register"});	// 승현 - 사원관리, 태현 - 공지사항 작성
		 DEPT_PAGE_MAP.put(104, new String[] {"/item/create", "/sales/salesInsertForm", "/sales/salesInquiry"});	// 유림 - 제품관리, 준오 - 판매서 등록 및 조회
		 DEPT_PAGE_MAP.put(105, new String[] {"/item/create"});			// 유림 - 제품관리
	}
	
	
	
	// 컨트롤러 메소드가 실행되기 전
	@Override
	public boolean preHandle(HttpServletRequest request, 
							  HttpServletResponse response, 
							  Object handler) throws Exception {
		
		System.out.println("BkDeptInterceptor preHandler Start...");
		System.out.println("[Controller Method 호출 전]");
		System.out.println("[" + request.getMethod() + "]");
		System.out.println("[" + request.getRequestURL() + "]");
		System.out.println("[" + request.getRequestURI() + "]");
		
		HttpSession session = request.getSession();
		int mem_dept_md = (int) request.getSession().getAttribute("mem_dept_md");
		String requestUri = request.getRequestURI();
		
		// 사용자의 권한에 해당하는 허용된 페이지를 가져오기
		String[] allowedPages = DEPT_PAGE_MAP.get(mem_dept_md);
		
		// 로그인 여부 확인 -> 로그인 전이면 로그인 페이지로 이동
		System.out.println("session.getAttribute(\"mem_dept_lg\") -> " + session.getAttribute("mem_dept_lg"));
		System.out.println("session.getAttribute(\"mem_dept_md\") -> " + session.getAttribute("mem_dept_md"));
		System.out.println("session.getAttribute(\"mem_id\") -> " + session.getAttribute("mem_id"));
		System.out.println("allowedPages -> " + Arrays.toString(allowedPages));
		
		
		// 세션에 담긴 사원 번호가 없다면 홈으로 이동
		if(session.getAttribute("mem_id") == null) {
			System.out.println("세션에 담긴 사원 정보 없음");
			response.sendRedirect("/logIn");
			return false;
			
		// 세션에 담긴 사원 정보가 있다면
		} else {
			
			// 세션에 담긴 유저 부서 확인: 허용된 페이지가 없거나, 현재 요청한 페이지가 허용된 페이지 목록에 포함되어 있지 않으면 
			if(allowedPages == null || !isPageAllowed(requestUri, allowedPages)) {
				response.sendRedirect("/403forbidden");	// 403 페이지로 리다이렉트
				return false;	// 컨트롤러 메소드 실행 중지
				
			// 권한이 있으면 정상적으로 진행
			} else {
				System.out.println("부서 권한 확인됨");
				return true;
			}
			
		} 
	}
	
	
	
	// 주어진 페이지가 허용된 페이지 목록에 매칭되는지 확인하는 메서드
	// requestedPage: 사용자가 요청한 페이지의 실제 경로
	// allowedPages: 허용된 페이지의 패턴 목록
	private boolean isPageAllowed(String requestedPage, String[] allowedPages) {
		
		// allowedPages 배열을 순회하면서 각 패턴과  requestedPage를 비교하여 매칭 여부를 확인합니다
		for (String allowedPage : allowedPages) {	// 향상된 for문
			// pathMatcher.match 메서드는 와일드카드를 사용한 패턴 매칭을 수행합니다	<->  단순 문자열일 경우, startsWith 사용
			// 예를 들어, "/memberL/**"와 같은 패턴은 "/memberL/somePage"와 매칭됩니다
			if (pathMatcher.match(allowedPage, requestedPage)) {
				return true;	// 매칭되는 패턴이 발견되면 true를 반환하고 메서드 종료
			}
		}
		
		// 모든 허용된 페이지 패턴과 매칭되지 않으면 false를 반환합니다
		return false;
	}
	
	
	
	@Override
	public void postHandle(HttpServletRequest request, 
							HttpServletResponse response,
							Object handler,
							ModelAndView modelAndView) throws Exception {
		
		System.out.println("BkDeptInterceptor postHandler Start...");
		
	}

}
