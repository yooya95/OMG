package com.oracle.OMG.dto;

import lombok.Data;

@Data
public class Sales {
	private String 	sales_date;
	private int 	custcode;
    private int 	sales_status;
    private String 	title;
    private String	ref;
}
