package com.oracle.OMG.dao.chDao;

import java.util.List;

import com.oracle.OMG.dto.Item;

public interface ChItemDao {
	List<Item> cItemList(int custcode);
}
