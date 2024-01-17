package com.oracle.OMG.service.thService;


import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.oracle.OMG.dao.thDao.ThNoticeDao;
import com.oracle.OMG.dao.thDao.ThReplyDao;
import com.oracle.OMG.dto.Criteria;
import com.oracle.OMG.dto.Reply;
import com.oracle.OMG.dto.ReplyPage;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
@RequiredArgsConstructor
public class ThReplyServiceImpl implements ThReplyService {
	
	private final PlatformTransactionManager transactionManager;
	private final ThReplyDao  rd;
	private final ThNoticeDao nd;
	
	
	                                                                         
	@Override
	public int register(Reply rep){
		
		TransactionStatus txStatus = transactionManager.getTransaction(new DefaultTransactionDefinition());
		int result = 0;
		try {
			
			nd.updateReplyCnt(rep.getBrd_id(), 1);
			result = rd.insert(rep);
			
			transactionManager.commit(txStatus);
			
		} catch (Exception e) {
			
			log.info("예외 발생: " +e.getMessage());
			transactionManager.rollback(txStatus);
			
		}
		return result;
	}

	@Override
	public Reply get(int rep_id) {
		log.info("get..." + rep_id);
		return rd.read(rep_id);
	}

	@Override
	public int modify(Reply rep) {
		log.info("modify..." + rep);
		return rd.update(rep);
	}
	
	
	@Override
	public int remove(int rep_id){
//		log.info("remove..." + rep_id);
		
		int result = 0;
		// 해당 댓글의 게시물(brd_id) 조회용
		Reply reply = rd.read(rep_id);
		
		TransactionStatus txStatus = transactionManager.getTransaction(new DefaultTransactionDefinition());
		
		try {
			nd.updateReplyCnt(reply.getBrd_id(), -1);			
			result = rd.delete(rep_id);
			transactionManager.commit(txStatus);
		} catch (Exception e) {
			log.info("예외 발생: " + e.getMessage());
			transactionManager.rollback(txStatus);
		}
		
		return result;
	}

	@Override
	public List<Reply> getList(Criteria cri, int brd_id) {
//		log.info("get Reply List of a Board brd_id: " + brd_id);		
		return rd.GetListWithPaging(cri, brd_id);
	}

	@Override
	public ReplyPage getListPage(Criteria cri, int brd_id) {
//		log.info("getListPage");
		return new ReplyPage(rd.getCountByBrd_id(brd_id), rd.GetListWithPaging(cri, brd_id));
	}
	
	




	
	
}
