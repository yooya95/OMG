package com.oracle.OMG.dto;

import lombok.Data;

@Data
public class Board {
	private int 	brd_id;
	private int 	mem_id;
	private int 	brd_lg;
	private int 	brd_md;
	private int 	qna_stts;
	private String 	title;
	private String	brd_cn;
	private String	atch_file;
	private int		view_cnt;
	private String	reg_date;
	private int		brd_group;
	private int		brd_step;
	private String	mod_date;
	private int		replyCnt;
	
	// 페이징 조회용    //검색타입						 //검색 내용
	private String search;   	private String keyword;
	private String pageNum;
	private int start; 		 	private int end;
	
	// member 조회용
	private String mem_name;
}
