package com.oracle.OMG.dto;

import lombok.Data;

@Data
public class PageDTO {

		private int startPage;
		private int endPage;
		private boolean prev, next;
		
		private int total;
		private Criteria cri;
		
		public PageDTO(Criteria cri, int total) {
			this.cri 	= cri;
			this.total 	= total;
			
			// 구해둔 끝페이지
			this.endPage = (int)(Math.ceil(cri.getPageNum() / 10.0)) * 10;
			// 무조건 10페이지란 가정
			this.startPage = this.endPage - 9;
			
			// 진짜 끝페이지
			int realEnd = (int)(Math.ceil((total * 1.0) / cri.getAmount()));
			
			if (realEnd < this.endPage) {
				this.endPage = realEnd;
			}
			
			this.prev = this.startPage > 1;
			this.next = this.endPage < realEnd;
			
		}
}
