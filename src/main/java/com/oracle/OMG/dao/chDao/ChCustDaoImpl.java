package com.oracle.OMG.dao.chDao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.OMG.dto.Customer;

import lombok.Data;

@Repository
@Data
public class ChCustDaoImpl implements ChCustDao {
	private final SqlSession session; 
	
	@Override
	public List<Customer> custList() {
		System.out.println("ChCustDaoImpl custList Start...");
		List<Customer> custList = null;
		
		try {
			custList = session.selectList("ChcustList");
		} catch (Exception e) {
			// TODO: handle exception
		}
		return custList;
	}

}
