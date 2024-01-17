package com.oracle.OMG.service.bkService;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.oracle.OMG.domain.Member;
import com.oracle.OMG.repository.BkMemberJpaRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
@Transactional
public class BkMemberJpaService {
	
	private final BkMemberJpaRepository bMemberJpaR;

	public Member login(Member member) {
		
		System.out.println("BkMemberJpaService login Start...");
		Member loginManager = bMemberJpaR.login(member);
		System.out.println("BkMemberJpaService login member -> " + member);
		
		return loginManager;
	}


}
