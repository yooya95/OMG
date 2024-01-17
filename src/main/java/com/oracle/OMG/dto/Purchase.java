package com.oracle.OMG.dto;

import lombok.Data;

@Data
public class Purchase {
	private String 	pur_date;
	private int 	custcode;
    private int 	pur_status;
    private String 	title;
    private int		mem_id;
    private String	ref;
    
    
    // 참조용
    private String 	appli_name; // 발주자(신청자)이름
    private String 	mgr_name; 	// 담당자 이름
    private String 	mgr_id; 	// 담당자 이름
    private String 	company; 	// 발주자(신청자)이름
    private int 	totalType;	// 상품수(발주서 내 제품 종류의 수)
    private int 	totalQty;	// 발주서 내 총 수량
    private int 	totalPrice;	// 발주서 내 총 결제액
    //paging
    private int 	start;	// 발주서 내 총 결제액
    private int 	end;	// 발주서 내 총 결제액
    private String	pageNum;
    private String 	keyword;
}
