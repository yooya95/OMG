package com.oracle.OMG.dto;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class Member {
	private int 	mem_id;
    private String 	mem_img;
    private String 	mem_name;
    private String 	mem_pw;
    private String 	mem_bd;
    private String 	mem_sex;
    private String 	mem_email;
    private int 	mem_mailcode;
    private String 	mem_address;
    private String 	mem_hiredate; // Date를 String으로 변경
    private int 	mem_dept_lg;
    private int 	mem_posi_lg;
    private int 	mem_duty_lg;
    private String 	mem_phone;
    private String 	mem_leave; 
    private String 	mem_rein;
    private String 	mem_resi; 
    private int 	mem_right;
    private int 	mem_status;
    private Date 	reg_date;
    private int 	mem_dept_md;
    private int 	mem_posi_md;
    private int 	mem_duty_md;
    private String  mem_position3;
    private String  mem_dept;
    private String  mem_position1;
    private String  mem_position2;
    
    //리스트용
    private int rn;
    private int start;
    private int end;
    private String keyword;
    //날짜 타입 변환용
    private Date mem_hiredate_d;
    //업데이트용
    private MultipartFile mem_img_f;
    private String oldPw;
    //join
    private String com_cn;     //분류 내용
}
