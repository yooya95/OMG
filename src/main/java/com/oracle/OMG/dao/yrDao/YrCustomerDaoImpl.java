package com.oracle.OMG.dao.yrDao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.OMG.dto.Customer;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
@RequiredArgsConstructor
public class YrCustomerDaoImpl implements YrCustomerDao {
	private final SqlSession session;
	
	@Override
	public List<Customer> customerList() {
		log.info("customerList start");
		List<Customer> customer = null;
		try {
			customer = session.selectList("yrCustomerSelectList");
		} catch (Exception e) {
			log.info(e.getMessage());
		}
		return customer;
	}

	
}
