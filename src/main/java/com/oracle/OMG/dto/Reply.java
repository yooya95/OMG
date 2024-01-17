package com.oracle.OMG.dto;

import java.util.Date;

import lombok.Data;


@Data
public class Reply {
	
	private int 	rep_id;
	private int 	brd_id;
	private int		mem_id;
	
	private String 	rep_cn;
	private String 	replyer;
	private Date	rep_date;
	private Date	mod_date;
	
	// 조회용 변수
	private String	mem_name;	//댓글 작성자
}
