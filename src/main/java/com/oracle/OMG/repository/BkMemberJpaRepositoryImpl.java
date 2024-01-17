package com.oracle.OMG.repository;

import java.util.Optional;

import javax.persistence.EntityManager;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Repository;

import com.oracle.OMG.domain.Member;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class BkMemberJpaRepositoryImpl implements BkMemberJpaRepository {
	
	// PasswordEncoder -> 입력된 비밀번호와 데이터 비밀번호 비교
	private final PasswordEncoder		passwordEncoder;
	private final EntityManager em;
	
	public Optional<Member> findByMemberId(int mem_id) {
		
		System.out.println("BkMemberJpaRepositoryImpl findByMemberId Start...");
		System.out.println("BkMemberJpaRepositoryImpl findByMemberId mem_id -> " + mem_id);
		
		// EntityManager를 사용하여 데이터베이스에서 Member 엔티티를 조회
		Member member =  em.find(Member.class, mem_id);
		
		// 조회된 Member가 존재하면 Optional로 감싸서 반환, 존재하지 않으면 빈 Optional 반환
		return Optional.ofNullable(member);
	}

	@Override
	public Member login(Member member) {
		
		System.out.println("BkMemberJpaRepositoryImpl login Start...");
		System.out.println("BkMemberJpaRepositoryImpl login member.getMem_id() -> " + member.getMem_id());
		
		Optional<Member> loginManager  = findByMemberId(member.getMem_id());
		
		// 회원 정보가 존재하고, 입력된 비밀번호가 저장된 비밀번호와 일치하는 경우
		if (loginManager.isPresent()) {
			
			// 데이터베이스에서 가져온 비밀번호
			String encodedPw = passwordEncoder.encode(loginManager.get().getMem_pw());
			
			// 사용자가 입력한 비밀번호
			String rawPw = member.getMem_pw();
			
			// 비밀번호 매칭 확인
			if(passwordEncoder.matches(rawPw, encodedPw)) {
				// 매칭 되면 로그인 성공 시 해당 Member 객체를 반환
				return loginManager.get();
			}
			
		} 
		
		// 로그인 실패 시 null 를 반환
		return null;
		
	}

}
