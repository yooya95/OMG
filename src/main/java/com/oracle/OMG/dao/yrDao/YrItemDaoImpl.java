package com.oracle.OMG.dao.yrDao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.OMG.dto.Item;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
@RequiredArgsConstructor
public class YrItemDaoImpl implements YrItemDao {

	private final SqlSession session;
	
	@Override
	public List<Item> itemList(Item item) {
		List<Item> itemList = null;
		try {
			itemList = session.selectList("yrItemList", item);
			log.info("itemList.size() "+ itemList.size());
		} catch (Exception e) {
			log.info(e.getMessage());
		}
		
		return itemList;
	}

	@Override
	public Item selectItem(int code) {
		Item itemDetail = null;
		try {
			itemDetail = session.selectOne("yrSelectItem", code);
			log.info("selectItem: " + itemDetail);
		} catch (Exception e) {
			log.info(e.getMessage());
		}
		return itemDetail;
	}

	@Override
	public int insertItem(Item item) {
		int result = 0;
		try {
			result = session.insert("yrInsertItem", item);
			log.info("insert result: " + result);
		} catch (Exception e) {
			log.info(e.getMessage());
		}
		return result;
	}

	@Override
	public int updateItem(Item item) {
		int result = 0;
		try {
			result = session.update("yrUpdateItem", item);
			log.info("update result: " + result);
		} catch (Exception e) {
			log.info(e.getMessage());
		}
		return result;
	}

	// 삭제 기능은 일단 보류	
//	@Override
//	public int deleteItem(int code) {
//		System.out.println("YrItemDaoImpl deleteItem start");
//		int result = 0;
//		try {
//			result = session.delete("yrDeleteItem", code);
//		} catch (Exception e) {
//			System.out.println(e.getMessage());
//		}
//		return result;
//	}

}
