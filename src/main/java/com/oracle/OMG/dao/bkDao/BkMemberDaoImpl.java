package com.oracle.OMG.dao.bkDao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.OMG.dto.Item;
import com.oracle.OMG.dto.Member;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class BkMemberDaoImpl implements BkMemberDao {
	
	// Mybatis DB 연동
	private final SqlSession session;

	@Override
	public Member login(Member member) {
		
		System.out.println("BkMemberDaoImpl login Start...");
		Member loginUser = null;
		
		try {
			loginUser = session.selectOne("bkLogin", member);
		} catch (Exception e) {
			System.out.println("BkMemberDaoImpl login Exception -> " + e.getMessage());
		}
		
		return loginUser;
	}

	
	
	@Override
	public Member checkNameAndMail(Member member) {
		
		System.out.println("BkMemberDaoImpl checkNameAndMail Start...");
		Member checkResult = null;
		
		System.out.println("member.getMem_name() -> " + member.getMem_name());
		System.out.println("member.getMem_email() -> " + member.getMem_email());
		
		try {
			checkResult = session.selectOne("com.oracle.OMG.dto.Member.bkCheckNameAndMail1", member);
			System.out.println("DAO checkNameAndMail checkResult -> " + checkResult);
		} catch (Exception e) {
			System.out.println("BkMemberDaoImpl checkNameAndMail Exception -> " + e.getMessage());
		}
		
		return checkResult;
	}



	@Override
	public int updateTempPw(Map<String, Object> tempPwByName) {
		
		System.out.println("BkMemberDaoImpl updateTempPw Start...");
		int updateResult = 0;
		
		try {
			
			updateResult = session.update("bkUpdateTempPw", tempPwByName);
			System.out.println("BkMemberDaoImpl updateTempPw updateResult -> " + updateResult);
			
		} catch (Exception e) {
			System.out.println("BkMemberDaoImpl updateTempPw Exception -> " + e.getMessage());
		}
		return updateResult;
	}


}
