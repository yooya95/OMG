package com.oracle.OMG.service.chService;

import java.util.List;

import org.springframework.stereotype.Service;

import com.oracle.OMG.dao.chDao.ChItemDao;
import com.oracle.OMG.dto.Item;

import lombok.Data;

@Service
@Data
public class ChItemServiceImpl implements ChItemService {
	
	private final ChItemDao chItemDao;
	
	@Override
	public List<Item> cItemList(int custcode) {
		System.out.println("ChItemServiceImpl cItemList");
		List<Item> itemList = chItemDao.cItemList(custcode);
		
		return itemList;
	}

}
