package com.oracle.OMG.dao.thDao;

import java.util.List;

import com.oracle.OMG.dto.Board;

public interface ThQnADao {

	int 				totalQnA();
	List<Board> 		selectQnAList(Board board);
	Board 				selectQnADetail(Board board);

}
