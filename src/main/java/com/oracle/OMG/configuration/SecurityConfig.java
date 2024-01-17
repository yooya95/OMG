package com.oracle.OMG.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import com.oracle.OMG.handler.CustomAuthenticationSuccessHandler;


//1. Spring Security 설정 클래스
@EnableWebSecurity
@Configuration
public class SecurityConfig {
	
	// 2. CustomAuthenticationProvider를 주입
	@Autowired
	private  CustomAuthenticationProvider authProvider;
	
	
	// 3. 로그인 성공 핸들러를 주입
	@Autowired
	private AuthenticationSuccessHandler authenticationSuccessHandler;
	
	// 생성자를 통해 AuthenticationSuccessHandler 주입
	public SecurityConfig(AuthenticationSuccessHandler authenticationSuccessHandler) {
		this.authenticationSuccessHandler = authenticationSuccessHandler;
	}
	
	// 4. 정적 자원 및 H2 데이터 베이스 콘솔 접근 허용 설정
    public WebSecurityCustomizer webSecurityCustomizer() {
        return ((web) -> web.ignoring()
    						//   정적 리소스(이미지, css, JS 파일)   H2 데이터 베이스: 개발 및 테스트 목적으로 주요 사용
        					.antMatchers("/static/**", "/h2-console/**"));	// 정적 리소스 및 H2 데이터베이스 콘솔 접근 허용
    }
	
	// 5. 패스워드 인코더 빈을 등록
	// PasswordEncoder -> 입력된 비밀번호와 데이터 비밀번호 비교
	@Bean
	public BCryptPasswordEncoder  encodePwd() {
		return new BCryptPasswordEncoder();
	}
	
	// 6. Spring Security 설정 메서드
	@Bean
	protected SecurityFilterChain filterChain(HttpSecurity http) throws Exception  {
		// 7. CSRF 보안 설정 비활성화
		http.csrf().disable();
		
		// 8. 권한 설정
//		http.authorizeRequests()
//		.antMatchers("/main").permitAll() 	// 임시로 모든 권한 허용
//		// hasAuthority("ROLE_USER") 	// "/main"에 대한 권한 설정
//		    .anyRequest()
//		    .permitAll();
		http.authorizeHttpRequests((requests) -> requests
				/* 개발단계에서는 역할에 따른 접근제한 해제.
				.antMatchers("/admin/**").hasRole(Role.ADMIN.getValue())
				.antMatchers("/user/myPage/**").hasRole(Role.USER.getValue())
				.antMatchers("/user/bizPage").hasRole(Role.BIZ.getValue())
				*/
				.antMatchers("/**").permitAll()		// 모든 경로에 대한 접근 허용
				.anyRequest().authenticated()
			);		
		
		// 9. 로그인 설정
		http.formLogin((form) -> form
				.loginPage("/logIn")			// 로그인 페이지 경로
				.loginProcessingUrl("/auth")	// 로그인 처리 URL
				.usernameParameter("username")	// login에 필요한 id값 설정 (default는 username)
                .passwordParameter("password")	// login에 필요한 password 값  (default password)
				.permitAll()
				.defaultSuccessUrl("/")			// 로그인 성공 후 기본적으로 이동할 페이지
				.successHandler(authenticationSuccessHandler)	// 로그인 성공 후 핸들러 등록
			);
//		http.formLogin()
//			.loginPage("/logIn")										// 로그인 페이지 경로
////			.loginProcessingUrl("/logIn")								// 로그인 처리 URL
//			.successHandler(authenticationSuccessHandler)	// 로그인 성공 후 핸들러 등록
//			.permitAll();
		
		// 10. 로그아웃 설정
		http.logout()
			.logoutUrl("/logout")		// 로그아웃 URL
			.permitAll();
		
		// 11. CustomAuthenticationProvider를 사용하여 사용자 인증 설정
		http.authenticationProvider(authProvider);
		
		return http.build();
		
	}
	
	// 12. AuthenticationManager 빈 등록
	@Bean
	AuthenticationManager authenticationManager(
		AuthenticationConfiguration authenticationConfiguration
	) throws Exception {
		return authenticationConfiguration.getAuthenticationManager();
	}
	
}
