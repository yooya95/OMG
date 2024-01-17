package com.oracle.OMG.service.thService;

import java.util.List;

import com.oracle.OMG.dto.Board;

public interface ThQnAService {

	int 				totalQnA();
	List<Board> 		selectQnAList(Board board);
	Board 				selectQnADetail(Board board);

}
