package com.oracle.OMG.dao.bkDao;

import java.util.Map;

import com.oracle.OMG.dto.Item;
import com.oracle.OMG.dto.Member;

public interface BkMemberDao {

	Member login(Member member);

	Member checkNameAndMail(Member member);

	int updateTempPw(Map<String, Object> tempPwByName);
}
