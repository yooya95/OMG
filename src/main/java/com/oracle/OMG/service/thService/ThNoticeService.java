package com.oracle.OMG.service.thService;

import java.util.List;

import com.oracle.OMG.dto.Board;
import com.oracle.OMG.dto.Criteria;

public interface ThNoticeService {
	int					getNoticeTot(Criteria cri);
	//List<Board> 		getNoticeList(Board board);
	List<Board>			getNoticeList(Criteria cri);
	int					registerNotice(Board board);
	Board				getNotice(int brd_id);
	int					removeNotice(int brd_id);
	Board 				modifyNoticeView(int brd_id);
	int					modifyNotice(Board board);
	
}
