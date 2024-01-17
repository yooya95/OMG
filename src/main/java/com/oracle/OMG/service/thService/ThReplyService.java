package com.oracle.OMG.service.thService;

import java.util.List;



import com.oracle.OMG.dto.Criteria;
import com.oracle.OMG.dto.Reply;
import com.oracle.OMG.dto.ReplyPage;

public interface ThReplyService {
	    
	public int register(Reply rep);

	public Reply get(int rep_id);

	public int modify(Reply rep);
	
	public int remove(int rep_id);

	public List<Reply> getList(Criteria cri, int brd_id);
	
	public ReplyPage getListPage(Criteria cri, int brd_id);
}
