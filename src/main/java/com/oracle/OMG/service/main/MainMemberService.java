package com.oracle.OMG.service.main;

import com.oracle.OMG.dto.Member;

public interface MainMemberService {

	Member memSelectById(int mem_id);

	Member memSelectByMem(Member member);

	int getLoggedInId();
	
	Member getLoggedInMember();
}
