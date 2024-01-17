package com.oracle.OMG.dao.yaDao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.OMG.dto.Item;
import com.oracle.OMG.dto.Warehouse;

import lombok.RequiredArgsConstructor;
@Repository
@RequiredArgsConstructor
public class YaWareHouseDaoImpl implements YaWareHouseDao {	
	
	private final SqlSession session;

	@Override
	public List<Warehouse> inventoryList(Warehouse warehouse) {
		System.out.println("YaInventoryDaoImpl inventroyList start...");
		List<Warehouse> inventoryList = null;
		try {
			inventoryList = session.selectList("inventoryList", warehouse);
		} catch (Exception e) {
			System.out.println("YaInventoryDao inventroyList e.getMessage? " + e.getMessage());
		}
		
		return inventoryList;
	}

	public List<Item> itemListSelect(Item item) {
		System.out.println("YaInventoryDaoImpl  itemListSelect start...");
		List<Item> itemListSelect = null;
		try {
			itemListSelect = session.selectList("itemListSelectOne", item);
		} catch (Exception e) {
			System.out.println("YaInventoryDao itemListSelect e.getMessage? " + e.getMessage());
		}
		return itemListSelect;
	}

	@Override
	public List<Warehouse> SearchAll(int code, String month) {
		List<Warehouse> SearchAll=null;
		try {
		     Map<String, Object> parameters = new HashMap<>();
		        parameters.put("code",code);
		        parameters.put("month", month);
		        SearchAll = session.selectList("searchAll", parameters);
		} catch (Exception e) {
			System.out.println("YaWareHouseDaoImpl  SearchAll e.getMessage? " + e.getMessage());
		}
		
		return SearchAll;
	}

	@Override
	public List<Warehouse> SearchAllInventory(String month) {
		List<Warehouse> SearchAllInventory=null;
		try {

			SearchAllInventory = session.selectList("searchAllInventory", month);
		} catch (Exception e) {
			System.out.println("YaWareHouseDaoImpl  SearchAllInventory e.getMessage?:"+e.getMessage());
		}
		return SearchAllInventory;
	}

	@Override
	public List<Warehouse> SearchForAllMonths(int code) {
		List<Warehouse> SearchForAllMonths=null;
		try {
			SearchForAllMonths =  session.selectList("searchForAllMonth", code);
		} catch (Exception e) {
			System.out.println("YaWareHouseDaoImpl  SearchForAllMonths e.getMessage?:"+e.getMessage());
		}
				
		return SearchForAllMonths;
	}

	@Override
	public List<Warehouse> inventorySearch(int code, String month) {
		List<Warehouse> inventorySearch=null;
		try {
		     Map<String, Object> parameters = new HashMap<>();
		        parameters.put("code", code);
		        parameters.put("month", month);   
		        inventorySearch = session.selectList("inventorySearch", parameters);
		} catch (Exception e) {
			System.out.println("YaWareHouseDaoImpl  inventorySearch e.getMessage? " + e.getMessage());
		}
		return inventorySearch;
	}
}
