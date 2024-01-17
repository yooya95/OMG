package com.oracle.OMG.dao.chDao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.OMG.dto.Item;
import com.oracle.OMG.dto.Purchase;

import lombok.Data;
@Repository
@Data
public class ChitemDaoImpl implements ChItemDao {
	
	private final SqlSession session;
	
	@Override
	public List<Item> cItemList(int custcode) {
		System.out.println("ChitemDaoImpl cItemList start...");
		
		List<Item> cItemList = null;
		
		try {
			cItemList = session.selectList("cItemList",custcode);
			System.out.println(cItemList.size());
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("ChitemDaoImpl cItemList e.getMessage()" + e.getMessage());
		}
		return cItemList;
	}

}
