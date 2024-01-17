package com.oracle.OMG.dto;

import lombok.Data;

@Data
public class Item {
	private int 	code;
    private int 	custcode;
    private int 	cate_lg;
    private int 	cate_md;
    private String 	name;
    private int 	input_price;
    private int 	output_price;
    private String 	item_cn;
    private String 	reg_date;
    private String 	deleted;
    private String 	delete_date;
    
    // comm 명칭 가져오기
    private String	com_cn;
    
    // company 명칭 가져오기
    private String 	company;
    
    // 검색 키워드
    private String keyword;
}
