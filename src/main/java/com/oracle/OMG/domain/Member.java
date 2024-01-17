package com.oracle.OMG.domain;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.Data;

@Entity
@Table(name = "Member")
@Data
public class Member {
	
	@Id
	// 보경: 사원 등록 담당이 아니라서 시퀀스 어노테이션은 추가하지 않았습니다. 필요하면 추가바랍니다.
	private int	mem_id;
	
	private String 	mem_img;
    private String 	mem_name;
    private String 	mem_pw;
    private String 	mem_bd;
    private String 	mem_sex;
    private String 	mem_email;
    private int 	mem_mailcode;
    private String 	mem_address;
    private String 	mem_hiredate; // Date를 String으로 변경
    private String 	mem_dept;
    private String 	mem_position1;
    private String 	mem_position2;
    private int 	mem_position3;
    private String 	mem_phone;
    private String 	mem_leave; // Date를 String으로 변경
    private String 	mem_rein; // Date를 String으로 변경
    private String 	mem_resi; // Date를 String으로 변경
    private int 	mem_right;
    private int 	mem_status;
    private String 	reg_date; // Date를 String으로 변경
	
	

}
