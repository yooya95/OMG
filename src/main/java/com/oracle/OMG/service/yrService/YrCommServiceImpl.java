package com.oracle.OMG.service.yrService;

import java.util.List;

import org.springframework.stereotype.Service;

import com.oracle.OMG.dao.yrDao.YrCommDao;
import com.oracle.OMG.dto.Comm;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@RequiredArgsConstructor
public class YrCommServiceImpl implements YrCommService {
	private final YrCommDao ycmd;
	
	@Override
	public List<Comm> commList() {
		log.info("commList start");
		List<Comm> comm = ycmd.commList();
		return comm;
	}
	
	
}
