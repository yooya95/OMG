package com.oracle.OMG.dao.thDao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.OMG.dto.Board;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class ThQnADaoImpl implements ThQnADao {

	private final SqlSession session;
	
	@Override
	public int totalQnA() {
		System.out.println("ThQnADaoImpl totalQnA Start");
		int totQnA = 0;
		try {
			totQnA = session.selectOne("thTotQnA");
			System.out.println("ThQnADaoImpl totalQnA totQnA --> " + totQnA);
		} catch (Exception e) {
			System.out.println("ThQnADaoImpl totalQnA totQnA --> " + e.getMessage());
		}
		return totQnA;
	}

	@Override
	public List<Board> selectQnAList(Board board) {
		System.out.println("ThQnADaoImpl selectQnAList Start");
		List<Board> QnAList = null;
		try {
			QnAList = session.selectList("ThSelectQnAList", board);
			System.out.println("ThQnADaoImpl selectQnAList QnAList.size() --> " + QnAList.size());			
		} catch (Exception e) {
			System.out.println("ThQnADaoImpl selectQnAList Exception --> " + e.getMessage());
		}
		return QnAList;
	}

	@Override
	public Board selectQnADetail(Board board) {
		System.out.println("ThQnADaoImpl selectQnADetail Start");
		Board boardResult = null;
		try {
			boardResult = session.selectOne("ThSelectQnADetail", board);
		} catch (Exception e) {
			System.out.println("ThQnADaoImpl selectQnADetail Exception --> " + e.getMessage());
		}
		return boardResult;
	}

}
