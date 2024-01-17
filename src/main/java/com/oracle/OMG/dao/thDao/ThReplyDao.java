package com.oracle.OMG.dao.thDao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.oracle.OMG.dto.Criteria;
import com.oracle.OMG.dto.Reply;

public interface ThReplyDao {
	
	public int insert(Reply rep);
	
	public Reply read(int rep_id);
	
	public int delete(int rep_id);
	
	public int update(Reply rep);
	
	public List<Reply> GetListWithPaging(Criteria cri, int brd_id);
	
	public int getCountByBrd_id(int brd_id);
	
}
