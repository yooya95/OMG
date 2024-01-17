package com.oracle.OMG.service.chService;

import java.util.List;

import com.oracle.OMG.dto.Item;

public interface ChItemService {
	List<Item>		cItemList(int custcode);
}
