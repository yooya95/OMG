package com.oracle.OMG.service.chService;

import java.util.List;

import org.springframework.stereotype.Service;

import com.oracle.OMG.dao.chDao.ChCustDao;
import com.oracle.OMG.dto.Customer;

import lombok.Data;

@Service
@Data
public class ChCustServiceImpl implements ChCustService {
	
	private final ChCustDao chCustDao;
	
	@Override
	public List<Customer> custList() {
		System.out.println("ChCustServiceImpl custList Start...");
		List<Customer> custList = null;
		
		custList = chCustDao.custList(); 
		
		return custList;
	}

}
