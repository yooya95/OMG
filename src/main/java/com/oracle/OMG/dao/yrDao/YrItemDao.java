package com.oracle.OMG.dao.yrDao;

import java.util.List;

import com.oracle.OMG.dto.Item;

public interface YrItemDao {
	List<Item> 	itemList(Item item);
	Item 		selectItem(int code);
	int 		insertItem(Item item);
	int 		updateItem(Item item);
//	int 		deleteItem(int code);
}
