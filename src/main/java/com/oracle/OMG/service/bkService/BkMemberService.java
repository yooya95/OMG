package com.oracle.OMG.service.bkService;

import java.util.Map;

import com.oracle.OMG.dto.Member;

public interface BkMemberService {

	Member login(Member member);

	Member checkNameAndMail(Member member);

	String PwGenerator();

	int updateTempPw(Map<String, Object> tempPwByName);



}
