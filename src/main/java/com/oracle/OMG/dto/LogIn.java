package com.oracle.OMG.dto;

import lombok.Data;

@Data
public class LogIn {
	private int 	history_id;
    private int 	mem_id;
    private String 	ip;
    private String 	crt_dt; // Date를 String으로 변경
    private String 	url;
    private String 	action_code;
    private String 	description;
}
