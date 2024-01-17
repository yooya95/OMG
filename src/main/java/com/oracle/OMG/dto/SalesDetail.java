package com.oracle.OMG.dto;

import lombok.Data;

@Data
public class SalesDetail {
	private String 	sales_date;
    private int 	custcode;
	private int 	code;
    private int 	qty;
    private int 	price;
    
    
	// Sales
    private int 	sales_status;
    private String 	title;
    private String	ref;
    
    
    // Join(SalesInquiry)
    private String company_name;
    private String item_name;
    private String total_price;
        
    private String company;
    private String name;
    private int    output_price;
    
    
    // Search
    private String search;
    private String keyword;
    
    
    // Paging
    private String pageNum;
	private int    start;
	private int    end;
	
	// Update
	private int beforeCode; 
	private int afterCode;
	 
	
}
