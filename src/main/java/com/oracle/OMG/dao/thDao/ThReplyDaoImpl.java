package com.oracle.OMG.dao.thDao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.OMG.dto.Board;
import com.oracle.OMG.dto.Criteria;
import com.oracle.OMG.dto.Reply;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Repository
@RequiredArgsConstructor
@Slf4j
public class ThReplyDaoImpl implements ThReplyDao {

	private final SqlSession session;
	
	@Override
	public int insert(Reply rep) {
		int insertResult = 0;
		log.info("rep: " + rep);
		
			insertResult = session.insert("insertReply", rep);
		
		return insertResult;
	}

	@Override
	public Reply read(int rep_id) {
		Reply reply = null;
			try {
				reply = session.selectOne("readReply", rep_id);
			} catch (Exception e) {
				log.info(e.getMessage());
			}
			
		return reply;
	}

	@Override
	public int delete(int rep_id) {
		int deleteResult = session.delete("deleleReply", rep_id);
			log.info("deleteResult: " + deleteResult);
		return deleteResult;
	}

	@Override
	public int update(Reply rep) {
		int updateResult = 0;
		try {
			updateResult = session.update("updateReply", rep);
			log.info("updateResult: " + updateResult);
		} catch (Exception e) {
			log.info(e.getMessage());
		}
		return updateResult;
	}

	@Override
	public List<Reply> GetListWithPaging(Criteria cri, int brd_id) {
		List<Reply> replyList = null;
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("cri", cri);
			map.put("brd_id", brd_id);
			log.info("map: " + map);
			replyList = session.selectList("getListWithPagingReply", map);
			log.info("replyList.size() --> " + replyList.size());
		} catch (Exception e) {
			log.info(e.getMessage());
		}
		return replyList;
	}

	@Override
	public int getCountByBrd_id(int brd_id) {
		int	totCnt = 0;
		try {
			totCnt = session.selectOne("getCountByBrd_id", brd_id);
			log.info("totCnt: " + totCnt);
		} catch (Exception e) {
			log.info(e.getMessage());
		}
		
		return totCnt;
	}

}
