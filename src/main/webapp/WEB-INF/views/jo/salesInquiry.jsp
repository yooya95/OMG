<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>salesInquiry content</title>
	<%@ include file="../common/header.jsp" %>
	<style>
	.button-table-gap {
        margin-top: 10px; /* 여백 크기 조정 */
        margin-bottom: 0;
    }
	
	.table-button-gap {
		margin-top: 0;
		margin-bottom: 0;
	
	}
	
	.button-group {
        margin-top: -10px; /* 버튼을 위로 올리기 위해 음수 값으로 설정 */
    }
    	
	</style>
	<script>
	// 체크박스 전체 선택/해제 함수
	function checkAll(source) {
    	var checkboxes = document.getElementsByName('rowCheck');
    	for (var i = 0; i < checkboxes.length; i++) {
        	checkboxes[i].checked = source.checked;
    	}
	}
	
	function deleteSelected() {
	    // 선택된 체크박스의 sales_date, custcode, code 값들을 배열에 담기
	    const selectedSalesInfos = [];
	    const checkboxes = document.querySelectorAll('input[name="rowCheck"]:checked');
	    for (const checkbox of checkboxes) {
	        const custcode = checkbox.value;
	        const salesDate = checkbox.parentElement.nextElementSibling.nextElementSibling.innerText;
	        const code = checkbox.parentElement.nextElementSibling.nextElementSibling.nextElementSibling.nextElementSibling.nextElementSibling.nextElementSibling.innerText;
	        selectedSalesInfos.push({ salesDate, custcode, code });
	    }
	    console.log(selectedSalesInfos);
		
	 // sales_date, custcode, code 값들을 서버로 전송하여 삭제 요청
	    if (selectedSalesInfos.length > 0) {
	        // 확인 대화상자 표시
	        if (confirm("선택된 항목을 삭제하시겠습니까?")) {
	            // 폼 생성 및 값 전송
	            const form = document.createElement("form");
	            form.action = "/sales/salesDetailDelete"; // 삭제 처리 서블릿 주소
	            form.method = "POST";

	            for (const salesInfo of selectedSalesInfos) {
	                const hiddenFieldSalesDate = document.createElement("input");
	                hiddenFieldSalesDate.type = "hidden";
	                hiddenFieldSalesDate.name = "salesDates"; // 서버에서 받을 파라미터 이름
	                hiddenFieldSalesDate.value = salesInfo.salesDate;
	                form.appendChild(hiddenFieldSalesDate);

	                const hiddenFieldCustCode = document.createElement("input");
	                hiddenFieldCustCode.type = "hidden";
	                hiddenFieldCustCode.name = "custcodes"; // 서버에서 받을 파라미터 이름
	                hiddenFieldCustCode.value = salesInfo.custcode;
	                form.appendChild(hiddenFieldCustCode);
	                
	                const hiddenFieldCode = document.createElement("input");
	                hiddenFieldCode.type = "hidden";
	                hiddenFieldCode.name = "codes"; // 서버에서 받을 파라미터 이름
	                hiddenFieldCode.value = salesInfo.code;
	                form.appendChild(hiddenFieldCode);
	            }

	            document.body.appendChild(form);
	            form.submit();
	        }
	    } else {
	        alert("삭제할 항목을 선택해주세요.");
	    }

		
	}
		
   	    

    	
	</script>	
</head>
<body>
<%@ include file="../common/menu.jsp" %>	
	<div class="container-fluid">
		<div class="row">
			<main>
			<div>
				<h1>판매조회</h1>
			</div>
			
			<!-- Section1: Search Form -->
			<div>
				<form action="salesInquirySearch" method="GET">	
					<div class="row align-items-left">
						 <div class="col-md-2">
							<select name="search" class="form-select" style="margin-left: 0px;">
								<option value="s_company">거래처조회</option>
								<option value="s_item">제품조회</option>
							</select> 
						 </div>	
						 <div class="col-md-2" style="margin-left: -20px">	
							<input type="text" name="keyword" class="form-control" placeholder="keyword를 입력하세요">
						 </div>
						 <div class="col-md-4" style="margin-left: -20px">
							<button type="submit" class="btn btn-primary">검색</button>
						</div>
					</div>
					<input type="hidden" name="currentPage" value="${page.currentPage}">	
				</form>
			</div>
												
			<!-- Section2: Table -->		
			<div>
				<div class="button-table-gap">
					<button id="regist-btn" type="button" class="btn btn-primary btn-sm mb-1" onclick="location.href='/sales/salesInquiry'">전체</button>
					<button id="regist-btn" type="button" class="btn btn-primary btn-sm mb-1" onclick="location.href='/sales/salesInquirySort?sales_status=0'">진행</button>
					<button id="regist-btn" type="button" class="btn btn-primary btn-sm mb-1" onclick="location.href='/sales/salesInquirySort?sales_status=1'">완료</button>
					<button id="regist-btn" type="button" class="btn btn-primary btn-sm mb-1" onclick="location.href='/sales/salesInquirySort?sales_status=2'">취소</button>
					<button id="regist-btn" type="button" class="btn btn-primary btn-sm mb-1" onclick="location.href='/sales/salesInquirySort?sales_status=3'">출고완료</button>
				</div>
			<div>
				<div class="table-button-gap">
				<table style="border: 2px solid black; width: 100%" id="userTable" class="table table-md text-center p-3">
					<thead>
						<tr style="border: 2px solid black; background-color: #E1E2FF; color: #fff;">
							<th scope="col" style="text-align: center;"><input type="checkbox" name="allCheck" id="allCheck" onchange="checkAll(this)"/></th>
							<th scope="col" style="text-align: center;">No.</th>
							<th scope="col" style="text-align: center;">매출일자</th>
							<th scope="col" style="text-align: center;">제목</th>
							<th scope="col" style="text-align: center;">거래처</th>
							<th scope="col" style="text-align: center;">제품</th>
							<th scope="col" style="width: 80px; text-align: center;">코드</th>
							<th scope="col" style="text-align: center;">총 금액</th>
							<th scope="col" style="width: 120px; text-align: center;">상태</th>
							
						</tr>
					</thead>
					<tbody>
						<c:set var="num" value="${page.start}"/>
						<c:forEach var="listSalesInquiry" items="${listSalesInquiry}">
							<tr>
								<td style="text-align: center"><input type="checkbox" name="rowCheck" value="${listSalesInquiry.custcode}"/></td>
								<td style="text-align: center">${num}</td>
								<td style="text-align: center">${listSalesInquiry.sales_date}</td>
						  		<td style="text-align: center"><a href="salesInquiryDetail?sales_date=${listSalesInquiry.sales_date}&custcode=${listSalesInquiry.custcode}">${listSalesInquiry.title}</a></td>
								<td style="text-align: center">${listSalesInquiry.company}</td>
								<td style="text-align: center">${listSalesInquiry.name}</td>
								<td style="text-align: center">${listSalesInquiry.code}</td>
								<td style="text-align: center">${listSalesInquiry.total_price}</td>
								<td style="text-align: center">
									<c:if test="${listSalesInquiry.sales_status == 0}">진행</c:if>
									<c:if test="${listSalesInquiry.sales_status == 1}">완료</c:if>
									<c:if test="${listSalesInquiry.sales_status == 2}">취소</c:if>
									<c:if test="${listSalesInquiry.sales_status == 3}">출고완료</c:if>
								</td>
							 </tr>
						 <c:set var="num" value="${num + 1}"/>
						</c:forEach>
					</tbody>
				</table>
				</div>
				</div>
				<div class="button-group">
					<button id="selectBtn" type="button" class="btn btn-primary btn-sm mb-1" onclick="location.href='salesInsertForm'">신규</button>
					<input type="button" value="삭제" class="btn btn-primary btn-sm mb-1" onclick="deleteSelected();">
					<!-- Section3: Paging -->
					<div class=" container text-center" id="staticPagination">
				     <ul class="pagination pagination-sm justify-content-center">
				        <c:if test="${page.startPage > page.pageBlock }">
				            <li class="page-item">
				                <a class="page-link page-link-arrow" href="salesInquiry?currentPage=${page.startPage-page.pageBlock }">
				                    <i class="fa fa-caret-left"></i>
				                </a>
				            </li>
				        </c:if>
				
				        <c:forEach var="i" begin="${page.startPage }" end="${page.endPage }">
				            <li class="page-item <c:if test='${page.currentPage == i}'>active</c:if>">
				                <a class="page-link" href="salesInquiry?currentPage=${i}">${i}</a>
				            </li>
				        </c:forEach>
				
				        <c:if test="${page.endPage > page.totalPage }">
				            <li class="page-item">
				                <a class="page-link page-link-arrow" href="salesInquiry?currentPage=${page.startPage+page.pageBlock }">
				                    <i class="fa fa-caret-right"></i>
				                </a>
				            </li>
				        </c:if>
				    </ul>
				</div>		             
							
				</div>
			</div>	
			
			
						
		</main>
 	 </div>
  </div>
<%@ include file="../common/footer.jsp" %>  
</body>
</html>