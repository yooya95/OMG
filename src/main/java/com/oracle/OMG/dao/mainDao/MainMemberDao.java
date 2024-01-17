package com.oracle.OMG.dao.mainDao;

import com.oracle.OMG.dto.Member;

public interface MainMemberDao {

	Member memSelectById(int mem_id);

	Member memSelectByMem(Member member);

}
