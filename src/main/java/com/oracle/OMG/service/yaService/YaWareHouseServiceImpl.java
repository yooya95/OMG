package com.oracle.OMG.service.yaService;

import java.util.List;

import org.springframework.stereotype.Service;

import com.oracle.OMG.dao.yaDao.YaWareHouseDao;
import com.oracle.OMG.dao.yaDao.YaWareHouseDaoImpl;
import com.oracle.OMG.dto.Customer;
import com.oracle.OMG.dto.Item;
import com.oracle.OMG.dto.Warehouse;

import lombok.RequiredArgsConstructor;
@Service
@RequiredArgsConstructor
public class YaWareHouseServiceImpl implements YaWareHouseService {
	private final YaWareHouseDao ywd;

	@Override
	public List<Warehouse> inventoryList(Warehouse warehouse) {
		System.out.println("YaWareHouseDaoImpl  inventoryList start....");
		List<Warehouse> inventoryList = ywd.inventoryList(warehouse);
		return inventoryList;
	}

	@Override
	public List<Item> itemListSelect(Item item) {
		System.out.println("YaWareHouseDaoImpl  itemListSelect start....");
		List<Item> itemListSelect= ywd.itemListSelect(item);
		return itemListSelect;
	}
	//월, 제품 모두 전체조회
	@Override
	public List<Warehouse> SearchAll(int code, String month) {
		System.out.println("YaWareHouseDaoImpl   SearchAll start....");
		 List<Warehouse> SearchAll = null;
		 SearchAll = ywd.SearchAll(code, month);
		return SearchAll;
	}
	//전체제품조회
	@Override
	public List<Warehouse> SearchAllInventory(String month) {
		System.out.println("YaWareHouseDaoImpl    SearchAllInventory start....");
		List<Warehouse> SearchAllInventory = null;
		SearchAllInventory = ywd.SearchAllInventory(month);
		return SearchAllInventory;
	}
	//전체월조회
	@Override
	public List<Warehouse> SearchForAllMonths(int code) {
		System.out.println("YaWareHouseDaoImpl   SearchForAllMonths start....");
		List<Warehouse> SearchForAllMonths = null;
		SearchForAllMonths = ywd.SearchForAllMonths(code);
		return SearchForAllMonths;
	}
	//재고조건조회
	@Override
	public List<Warehouse> inventorySearch(int code, String month) {
		System.out.println("YaWareHouseDaoImpl inventorySearch start....");
		List<Warehouse> inventorySearch = null;
		inventorySearch = ywd.inventorySearch(code, month);
		return  inventorySearch;
	}


}
