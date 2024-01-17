package com.oracle.OMG.service.bkService;

import java.security.SecureRandom;
import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import com.oracle.OMG.dao.bkDao.BkMemberDao;
import com.oracle.OMG.dto.Member;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BkMemberServiceImpl implements BkMemberService {
	
	private final BkMemberDao bMemberD;
	
	// Logger 가져오기
	private static final Logger log = LogManager.getLogger(BkMemberServiceImpl.class);
	
	
	// 비밀번호에 사용될 문자열들 정의
	private static final String CHAR_LOWER = "abcdefghijklmnopqrstuvwxyz";
	private static final String CHAR_UPPER = CHAR_LOWER.toUpperCase();
	private static final String NUMBER = "0123456789";
	private static final String OTHER_CHAR = "!@#$%&*()_+-=[]|,./?><";
	
	// 모든 문자열을 합친 문자열
	private static final String PW_ALLOW_BASE = CHAR_LOWER + CHAR_UPPER + NUMBER + OTHER_CHAR;
	
	// 랜덤 숫자 생성 위한 SecureRandom 객체 생성		RNG 난수 생성기
	private static SecureRandom random = new SecureRandom();
	

	@Override
	public Member login(Member member) {
		
		System.out.println("BkMemberServiceImpl login Start...");
		Member loginUser = bMemberD.login(member);
		System.out.println("BkMemberServiceImpl login loginUser -> " + loginUser);
		
		return loginUser;
	}

	
	
	@Override
	public Member checkNameAndMail(Member member) {
		
		System.out.println("BkMemberServiceImpl checkNameAndTel Start...");
		
		try {
			
			log.debug("Test debug Msg");
			
			log.debug("실행 전 - 쿼리 ID: {}, 파라미터: {}", "bkCheckNameAndMail", member);
			System.out.println("디버깅 메시지 확인");
			
			Member checkResult = bMemberD.checkNameAndMail(member);
			
			log.debug("실행 후 - 쿼리 ID: {}, 결과: {}", "bkCheckNameAndMail", checkResult);
			System.out.println("BkMemberServiceImpl checkNameAndMail checkResult -> " + checkResult);
			return checkResult;
			
		} catch (Exception e) {
			throw e;	// 예외를 던져서 호출자에게 전파
		}
		
	}
	
	
	
	// 임시 비밀번호 생성 메소드
	@Override
	public String PwGenerator() {
		
		System.out.println("BkController PwGenerator Start...");
		return generateRandomPw(8);	// 8은 비밀번호 길이, 필요에 따라 변경 가능
		
	}
			
			
			
	// 주어진 길이만큼의 랜덤 비밀번호를 생성하는 메서드
	private	String generateRandomPw(int length) {
		
		System.out.println("BkController generateRandomPw Start...");
		
		// 주어진 길이가 1보다 작으면 예외
		if (length < 1) throw new IllegalArgumentException();
		
		// 랜덤 비밀번호를 저장할 StringBuilder 객체 생성
		StringBuilder password = new StringBuilder(length);
		
		// 비밀번호의 첫 글자로 각각 하나로 문자를 추가
		password.append(CHAR_LOWER.charAt(random.nextInt(CHAR_LOWER.length())));
		password.append(CHAR_UPPER.charAt(random.nextInt(CHAR_UPPER.length())));
		password.append(NUMBER.charAt(random.nextInt(NUMBER.length())));
		password.append(OTHER_CHAR.charAt(random.nextInt(OTHER_CHAR.length())));
		
		
		// 나머지 글자들을 랜덤하게 생성하여 추가합니다.
		for (int i = 4; i < length; i++) {
			password.append(PW_ALLOW_BASE.charAt(random.nextInt(PW_ALLOW_BASE.length())));
		}
		
		// 생성된 비밀번호를 문자열로 반환합니다
		return password.toString();
	}



	@Override
	public int updateTempPw(Map<String, Object> tempPwByName) {
		
		System.out.println("BkMemberServiceImpl updateTempPw Start...");
		int updateResult = bMemberD.updateTempPw(tempPwByName);
		
		return updateResult;
	}
	
	

}
