package com.oracle.OMG.dto;

import lombok.Data;

@Data
public class PurDetail {
	private String 	pur_date;
    private int 	custcode;
    private int 	code;
    private int 	qty;
    private int 	price;
    
    
    // 조회용
    private String	item_name;
    private int		price_sum;
}
