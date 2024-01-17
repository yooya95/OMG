package com.oracle.OMG.service.main;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import com.oracle.OMG.dao.mainDao.MainMemberDao;
import com.oracle.OMG.dto.Member;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MainMemberServiceImpl implements MainMemberService {
	
	private final MainMemberDao MMemberD;
	
	
	
	// 노보경
	// 사원 정보 불러오는 메소드
	@Override
	public Member memSelectById(int mem_id) {
		
		System.out.println("MemberServiceImpl memSelectById Start...");
		
		Member mem = MMemberD.memSelectById(mem_id);
		
		return mem;
		
	}
	
	
	
	// 노보경
	// 사원 정보 불러오는 메소드
	@Override
	public Member memSelectByMem(Member member) {
		
		System.out.println("MemberServiceImpl memSelectByMem Start...");
		
		Member memResult = MMemberD.memSelectByMem(member);
		
		return memResult;
		
	}

	
	
	// 노보경
	// 관리자 정보 불러오는 메소드
	@Override
	public int getLoggedInId() {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if (authentication != null && !authentication.getName().equals("anonymousUser") ){
			Member member = this.memSelectById(Integer.parseInt(authentication.getName()) );
			return member.getMem_id();
		}
		return 0;
	}
	
	
	
	// 노보경
	// 관리자 정보 불러오는 메소드
	@Override
	public Member getLoggedInMember() {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if (authentication != null && !authentication.getName().equals("anonymousUser") ){
			Member member = this.memSelectById(Integer.parseInt(authentication.getName()) );
			return member;
		}
		return null;
	}
	

}
