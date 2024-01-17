package com.oracle.OMG.dao.shDao;

import java.util.List;

import com.oracle.OMG.dto.Member;
import com.oracle.OMG.dto.Paging;
import com.oracle.OMG.dto.Warehouse;

public interface ShMemberDao {

	int 	 	 createMember(Member member);
	List<Member> memberList(Member member);
	int 		 memberTotal();
	List<Member> memberSearchList(Member member);
	int 		 searchMemberTotal(Member member);
	Member 		 searchMemberDetail(int mem_id);
	int 		 updateLeaveMember(Member member);
	int 		 updateReinMember(Member member);
	int		 	 updateResiMember(Member member);
	int 		 updateMember(Member member);
	int 		 detailMember(Member member);
	List<Member> selectStatus();
	int 		 thisMonthSale();
	int 		 exMonthSale();
	int 		 thisMonthPurchase();
	int 		 exMonthPurchase();
	List<Member> mainTeamList(int memId);
	Member 		 mainMember(int memId);
	List<Warehouse> 	 mainInventory(Warehouse warehouse);
	int 		 mainInventoryCount();

}
