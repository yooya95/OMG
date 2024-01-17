package com.oracle.OMG.repository;

import com.oracle.OMG.domain.Member;

public interface BkMemberJpaRepository {

	Member login(Member member);

}
