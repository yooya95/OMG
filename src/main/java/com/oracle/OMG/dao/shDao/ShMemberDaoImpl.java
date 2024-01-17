package com.oracle.OMG.dao.shDao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.OMG.dto.Member;
import com.oracle.OMG.dto.Paging;
import com.oracle.OMG.dto.Warehouse;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class ShMemberDaoImpl implements ShMemberDao {
	
	private final SqlSession session;
	
	@Override
	public Member mainMember(int memId) {
		System.out.println("memberDao mainMember() Start");
		Member member = null;
		try {
			member = session.selectOne("shMainMember",memId);
		} catch (Exception e) {
			System.out.println("memberDao mainMember() Exception ->" + e.getMessage());
		}
		return member;
	}
	
	@Override
	public int mainInventoryCount() {
		System.out.println("memberDao mainInventoryCount() Start");
		int listTotal = 0;
		try {
			listTotal = session.selectOne("shMainInventoryCount");
		} catch (Exception e) {
			System.out.println("memberDao mainInventoryCount() Exception ->" + e.getMessage());
		}
		return listTotal;
	}
	
	@Override
	public List<Warehouse> mainInventory(Warehouse warehouse) {
		System.out.println("memberDao mainInventory() Start");
		List<Warehouse> warehouseList = null;
		try {
			warehouseList = session.selectList("shMainInventory",warehouse);
		} catch (Exception e) {
			System.out.println("memberDao mainInventory() Exception ->" + e.getMessage());
		}
		return warehouseList;
	}
	
	@Override
	public int thisMonthSale() {
		System.out.println("memberDao thisMonthSale() Start");
		int thisMonthSale = 0;
		try {
			thisMonthSale = session.selectOne("shThisMonthSale");
		} catch (Exception e) {
			System.out.println("memberDao thisMonthSale() Exception ->" + e.getMessage());
		}
		return thisMonthSale;
	}
	
	@Override
	public int exMonthSale() {
		System.out.println("memberDao exMonthSale() Start");
		int exMonthSale = 0;
		try {
			exMonthSale = session.selectOne("shExMonthSale");
		} catch (Exception e) {
			System.out.println("memberDao exMonthSale() Exception ->" + e.getMessage());
		}
		return exMonthSale;
	}

	@Override
	public int thisMonthPurchase() {
		System.out.println("memberDao thisMonthPurchase() Start");
		int thisMonthPurchase = 0;
		try {
			thisMonthPurchase = session.selectOne("shThisMonthPurchase");
		} catch (Exception e) {
			System.out.println("memberDao thisMonthPurchase() Exception ->" + e.getMessage());
		}
		return thisMonthPurchase;
	}
	
	@Override
	public int exMonthPurchase() {
		System.out.println("memberDao exMonthPurchase() Start");
		int exMonthPurchase = 0;
		try {
			exMonthPurchase = session.selectOne("shExMonthPurchase");
		} catch (Exception e) {
			System.out.println("memberDao exMonthPurchase() Exception ->" + e.getMessage());
		}
		return exMonthPurchase;
	}
	
	@Override
	public List<Member> mainTeamList(int memId) {
		System.out.println("memberDao mainTeamList() Start");
		List<Member> teamMember = null;
		try {
			teamMember = session.selectList("shMainTeamList",memId);
		} catch (Exception e) {
			System.out.println("memberDao mainTeamList() Exception ->" + e.getMessage());
		}
		return teamMember;
	}
	
	//사원 등록 
	@Override
	public int createMember(Member member) {
		System.out.println("memberDao createMemeber() Start");
		int result = 0;
		try {
			result = session.insert("shCreateMember",member);
		} catch (Exception e) {
			System.out.println("memberDao createMember() Exception ->" + e.getMessage());
		}
		return result;
	}
	
	//멤버 리스트 조회용
	@Override
	public List<Member> memberList(Member member) {
		System.out.println("memberDao memberList() Start");
		List<Member> memberList = null;
		try {
			memberList = session.selectList("shMemberList",member);
		} catch (Exception e) {
			System.out.println("memberDao memberList() Exception ->" + e.getMessage());
		}
		return memberList;
	}
	
	//리스트 select option 출력 ajax
	@Override
	public List<Member> selectStatus() {
		System.out.println("memberDao selectStatus() Start");
		List<Member> statusList = null;
		try {
			statusList = session.selectList("shStatusList");
		} catch (Exception e) {
			System.out.println("memberDao selectStatus() Exception ->" + e.getMessage());
		}
		return statusList;
	}
	
	//멤버 총 인원수
	@Override
	public int memberTotal() {
		System.out.println("memberDao memberTotal() Start");
		int total = 0;
		try {
			total = session.selectOne("shMemberTotal");
		} catch (Exception e) {
			System.out.println("memberDao memberList() Exception ->" + e.getMessage());
		}
		return total;
	}
	
	//리스트 검색 조건
	@Override
	public List<Member> memberSearchList(Member member) {
		System.out.println("memberDao memberSearchList() Start");
		List<Member> memberList = null;
		try {
			memberList = session.selectList("shMemberSearchList",member);
		} catch (Exception e) {
			System.out.println("memberDao memberList() Exception ->" + e.getMessage());
		}
		return memberList;
	}
	
	//조건에 적합한 인원수
	@Override
	public int searchMemberTotal(Member member) {
		System.out.println("memberDao searchMemberTotal() Start");
		int total = 0;
		try {
			total = session.selectOne("shSearchMemberTotal",member);
		} catch (Exception e) {
			System.out.println("memberDao searchMemberTotal() Exception ->" + e.getMessage());
		}
		return total;
	}

	@Override
	public Member searchMemberDetail(int mem_id) {
		// TODO Auto-generated method stub
		System.out.println("memberDao searchMemberDetail() Start");
		Member member = null;
		try {
			member = session.selectOne("shSearchMemberDetail",mem_id);
		} catch (Exception e) {
			System.out.println("memberDao searchMemberTotal() Exception ->" + e.getMessage());
		}
		return member;
	}

	@Override
	public int updateLeaveMember(Member member) {
		System.out.println("memberDao updateLeaveMember() Start");
		int result = 0 ;
		try {
			result = session.update("shUpdateLeaveMember",member);
		} catch (Exception e) {
			System.out.println("memberDao updateLeaveMember() Exception ->" + e.getMessage());
		}
		return result;
	}

	@Override
	public int updateReinMember(Member member) {
		System.out.println("memberDao updateReinMember() Start");
		int result = 0 ;
		try {
			result = session.update("shUpdateReinMember",member);
		} catch (Exception e) {
			System.out.println("memberDao updateReinMember() Exception ->" + e.getMessage());
		}
		return result;
	}

	@Override
	public int updateResiMember(Member member) {
		System.out.println("memberDao updateResiMember() Start");
		int result = 0 ;
		try {
			result = session.update("shUpdateResiMember",member);
		} catch (Exception e) {
			System.out.println("memberDao updateResiMember() Exception ->" + e.getMessage());
		}
		return result;
	}

	@Override
	public int updateMember(Member member) {
		System.out.println("memberDao updateMember() Start");
		int result = 0 ;
		try {
			result = session.update("shUpdateMember",member);
		} catch (Exception e) {
			System.out.println("memberDao updateMember() Exception ->" + e.getMessage());
		}
		return result;
	}

	@Override
	public int detailMember(Member member) {
		System.out.println("memberDao detailMember() Start");
		int result = 0 ;
		try {
			result = session.update("shDetailMember",member);
		} catch (Exception e) {
			System.out.println("memberDao detailMember() Exception ->" + e.getMessage());
		}
		return result;
	}

}
