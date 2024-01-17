package com.oracle.OMG.service.yrService;

import java.util.List;

import org.springframework.stereotype.Service;

import com.oracle.OMG.dao.yrDao.YrItemDao;
import com.oracle.OMG.dto.Item;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@RequiredArgsConstructor
public class YrItemServiceImpl implements YrItemService {

	private final YrItemDao yid;
	
	@Override
	public List<Item> itemList(Item item) {
		log.info("itemList start");
		List<Item> itemList = yid.itemList(item);
		return itemList;
	}

	@Override
	public Item selectItem(int code) {
		log.info("selectItem start");
		Item itemDetail = yid.selectItem(code);
		return itemDetail;
	}

	@Override
	public int insertItem(Item item) {
		log.info("insertItem start");
		int result = yid.insertItem(item);
		return result;
	}

	@Override
	public int updateItem(Item item) {
		log.info("updateItem start");
		int result = yid.updateItem(item);
		return result;
	}

	// 삭제 기능은 일단 보류
//	@Override
//	public int deleteItem(int code) {
//		System.out.println("YrItemServiceImpl deleteItem start");
//		int result = yid.deleteItem(code);
//		return result;
//	}

}
