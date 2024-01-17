package com.oracle.OMG.configuration;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.oracle.OMG.service.bkService.BkAuthInterceptor;
import com.oracle.OMG.service.bkService.BkDeptInterceptor;
import com.oracle.OMG.service.bkService.BkLoginInterceptor;

@Configuration
public class WebMvcConfiguration implements WebMvcConfigurer {

	// addInterceptors 메서드 오버라이드: 이 메서드를 사용하여 인터셉터를 등록합니다.
	// 								알아서 떠서 bean 안해도 됨
	@Override										// 인터셉터 하는 저장소
	public void addInterceptors(InterceptorRegistry registry) {
		// 누군가 URL	/	interCeptor -> BkAuthInterceptor() 처리해줌
		
									// 로그인 인터셉터: url 주소창에 입력했을  때, 로그인 한 사용자가 맞는지 확인하고, 아니면 로그인 페이지가 뜨는 인터셉터 
		registry.addInterceptor(new BkAuthInterceptor()).addPathPatterns("/")
														.addPathPatterns("/replies/**")		// 태현 - 댓글
				                                        .addPathPatterns("/notice/**")		// 태현 - 공지사항
				                                        .addPathPatterns("/item/**")		// 유림 - 제품 관리
				                                        .addPathPatterns("/memberR")		// 승현 - 사원관리
				                                        .addPathPatterns("/memberL")		// 승현 - 사원관리
				                                        .addPathPatterns("/memberU")		// 승현 - 사원관리
				                                        .addPathPatterns("/memberD")		// 승현 - 사원관리
				                                        .addPathPatterns("/customerList")	// 연아 - 거래처관리
				                                        .addPathPatterns("/customerSales")	// 연아 - 거래처관리
				                                        .addPathPatterns("/sales/**")		// 준오 - 판매처관리
				                                        ;
		
									// 로그인 성공 시 이전 페이지 돌아가기
		// registry.addInterceptor(new BkLoginInterceptor()).addPathPatterns("/logIn");
		
									// 부서별 인터셉터: 해당 부서 사원이 맞는지 확인하고, 아니면 접근 제한 페이지가 뜨는 인터셉터 
		 registry.addInterceptor(new BkDeptInterceptor()).addPathPatterns("/memberL/**")		// 승현 - 사원 목록 조회		200 - 101 (인사팀)
														 .addPathPatterns("/memberR/**")		// 승현 - 사원 등록			200 - 101 (인사팀)
														 .addPathPatterns("/memberU/**")		// 승현 - 사원 정보			200 - 101 (인사팀)
														 .addPathPatterns("/notice/register")	// 태현 - 공지사항 작성		200 - 101 (인사팀)
														 .addPathPatterns("/customerSales")		// 연아 - 월별실적조회		200 - 100 (회계팀)
														 .addPathPatterns("/item/create")		// 유림 - 제품 등록			200 - 104, 105 (물류 1, 2팀)
														 .addPathPatterns("/sales/salesInsertForm")			// 준오 - 판매서 등록			200 - 104 (물류1팀)
														 .addPathPatterns("/sales/salesInquiry")			// 준오 - 판매서 조회			200 - 104 (물류1팀)
														 ;
		
	}
}
