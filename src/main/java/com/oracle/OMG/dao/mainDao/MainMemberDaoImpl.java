package com.oracle.OMG.dao.mainDao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.OMG.dto.Member;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class MainMemberDaoImpl implements MainMemberDao {
	
	private final SqlSession session;
	
	@Override
	public Member memSelectById(int mem_id) {
		
		Member mem = new Member();
		
		try {
			System.out.println("MainMemberDaoImpl memSelectById mem_id -> " + mem_id);
			mem = session.selectOne("memSelectById", mem_id);
			System.out.println("mem -> " + mem);
		} catch (Exception e) {
			System.out.println("MainMemberDaoImpl memSelectById Exception -> " + e.getMessage());
		}
		return mem;
		// 수정 test
	}
	
	
	
	@Override
	public Member memSelectByMem(Member member) {
		
		System.out.println("MainMemberDaoImpl memSelectByMem Start...");
		Member memResult = null;
		
		try {
			memResult = session.selectOne("memSelectByMem", member);
		} catch (Exception e) {
			System.out.println("MainMemberDaoImpl memSelectByMem Exception -> " + e.getMessage());
		}
		return memResult;
	}

}
