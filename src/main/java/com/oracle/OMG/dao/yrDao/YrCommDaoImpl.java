package com.oracle.OMG.dao.yrDao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.OMG.dto.Comm;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Repository
@Slf4j
@RequiredArgsConstructor
public class YrCommDaoImpl implements YrCommDao {
	private final SqlSession session;
	
	@Override
	public List<Comm> commList() {
		log.info("commList start");
		List<Comm> comm = null;
		try {
			comm = session.selectList("yrCommItemSelectList");
		} catch (Exception e) {
			log.info(e.getMessage());
		}
		return comm;
	}

}
