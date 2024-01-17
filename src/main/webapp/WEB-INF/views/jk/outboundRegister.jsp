<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>입고등록</title>

</head>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

<script>
$(document).ready(function () {
    // 페이지 로드 시 초기 데이터 로딩

    // 입고 버튼 클릭 이벤트 핸들러
    $('button.outbound-btn').on('click', handleOutboundButtonClick);

    // 기준년월 변경 이벤트 핸들러
    $('#outboundMonth').on('change', handleOutboundMonthChange);
});

function handleOutboundMonthChange() {
    // 선택한 기준년월 가져오기
    var outboundMonth = $('#outboundMonth').val();

    // Ajax 요청을 통해 서버에 기준년월 전송
    $.ajax({
        url: '/monthOutbound',
        method: 'GET',
        data: { 'outboundMonth': outboundMonth },
        dataType: 'html',
        success: function (response) {
            console.log('서버 응답:', response);
            
            // 서버 응답에 따른 후속 처리
            // 받아온 데이터를 JSON으로 파싱
            var outboundData = JSON.parse(response);

            // 테이블의 tbody에 데이터 추가
            var tbody = $('#inventoryTable tbody');
            tbody.empty(); // 기존 내용 삭제

            // 데이터 순회하며 행 추가
            $.each(outboundData, function (index, outboundItem) {
                var newRow = '<tr>' +
                '<td class="text-center">' + (outboundData.length - index) + '</td>' + // 역순으로 번호 부여
                    '<td class="text-center">' + outboundItem.sales_date + '</td>' +
                    '<td class="text-center"><span class="badge bg-label-success me-1">출고</span></td>' +
                    '<td class="text-center">' + outboundItem.code + '</td>' +
                    '<td class="text-center">' + outboundItem.name + '</td>' +
                    '<td class="text-center">' + outboundItem.company + '</td>' +
                    '<td class="text-center">' + outboundItem.qty + '</td>' +
                    '<td class="text-center">' + outboundItem.reg_date + '</td>' +
                    '</tr>';
                tbody.append(newRow);
            });
        },
        error: function (error) {
            console.error('서버 요청 중 오류 발생:', error);
        }
    });
}


function handleOutboundButtonClick() {
    // 선택한 특정 데이터 가져오기 (예: 특정 발주서의 pur_date 및 custcode)
    var sales_date = $(this).data('sales_date');
    var custcode = $(this).data('custcode');
    console.log('sales_date:', sales_date);
    console.log('custcode:', custcode);

    // Ajax 요청을 통해 서버에 데이터 전송
    $.ajax({
        url: '/outboundRegister', // 실제 서버 측 엔드포인트로 수정
        method: 'POST', // 또는 'GET' 등 필요에 따라 변경
        contentType: 'application/json', // JSON 형식으로 데이터 전송
        data: JSON.stringify({ sales_date: sales_date, custcode: custcode }),
        dataType: 'html', // 서버 응답 형식을 JSON으로 처리
        success: function (response) {
            console.log('서버 응답:', response);
            // 서버 응답에 따른 후속 처리 (예: 페이지 리로드 또는 알림 메시지 표시)
            location.reload(); // 페이지 리로드
        },
        error: function (error) {
            console.error('서버 요청 중 오류 발생:', error);
            // 오류 처리 로직 추가 (예: 사용자에게 오류 메시지 표시)
        }
    });
}



</script>
<body>
    <%@ include file="../common/header.jsp" %>
    <%@ include file="../common/menu.jsp" %>

    <div class="container-xxl flex-grow-1 container-p-y">
        <h4 class="fw-bold py-3 mb-4">
            <span class="text-muted fw-light">재고관리 /</span>출고등록
        </h4>

        <!-- 재고리스트 -->
        <div class="demo-inline-spacing mt-3">
            <div class="list-group list-group-horizontal-md text-md-center">
                
                <a class="list-group-item list-group-item-action" id="messages-list-item" href="/inboundRegister">입고등록</a>
                <a class="list-group-item list-group-item-action active" id="home-list-item" data-bs-toggle="list" href="#horizontal-home">출고등록</a>
            </div>

            <div class="tab-content px-0 mt-0" style="padding-top: 0px;padding-bottom: 0px;margin-top: 1px;">
                <div class="tab-pane fade active show" id="horizontal-home">
                    <div class="card">
                
                        <h5 class="card-header">발주서 선택</h5>
                          <div class="card-body">
                            <form action="salesInquirySearch" method="GET">	
                            <div class="row align-items-end" style="padding-left: 23px;">
                                <div class="mb-3 col-md-3">
                                    <label for="thtml5-date-input" class="col-md-2 col-form-label">조회필터</label>
                                    <select name="search" class="form-select" style="margin-left: 0px;">
								<option value="s_company">거래처별</option>
								<option value="s_item">제품별</option>
							</select> 
                              </div>
                                <div class="mb-3 col-md-3">
                                    <label for="html5-date-input" class="col-md-2 col-form-label">키워드</label>
                         	<input type="text" name="keyword" class="form-control" placeholder="keyword를 입력하세요">
						 
                                </div>
                                <div class="mb-3 col-md-3">
                                    <button class="btn btn-outline-primary" type="submit">검색</button>
                                </div>
                            </div>
                            </form>
                            <h5 class="card-header">판매리스트</h5>
                            <div class="card-body">
                                <div class="table-responsive text-nowrap" style="height:500px;">
                                    <table class="table table-bordered" id="purListTable">
                                        <thead class="table-primary">
                                            <tr>
                                               	<td class="text-center">No.</td>
												<td class="text-center">제목</td>
												<td class="text-center">업체명</td>
												<td class="text-center">발주일</td>
												<td class="text-center">상품명</td>
												<td class="text-center">코드</td>
												<td class="text-center">총금액</td>
												<td class="text-center">상태</td>
                                            </tr>
                                        </thead>
                                     
				   <tbody>
						<c:set var="num" value="${page.start}"/>
						<c:forEach var="listSalesInquiry" items="${listSalesInquiry}">
							<tr>
								<td style="text-align: center">${num}</td>
								<td style="text-align: center"><a href="sales/salesInquiryDetail?sales_date=${listSalesInquiry.sales_date}&custcode=${listSalesInquiry.custcode}">${listSalesInquiry.title}</a></td>
								<td style="text-align: center">${listSalesInquiry.company}</td>
								<td style="text-align: center">${listSalesInquiry.sales_date}</td>
								<td style="text-align: center">${listSalesInquiry.name}</td>
								<td style="text-align: center">${listSalesInquiry.code}</td>
								<td style="text-align: center">${listSalesInquiry.total_price}</td>
								<td style="text-align: center">
									<c:if test="${listSalesInquiry.sales_status == 0}"><span class="badge bg-label-primary me-1">진행중</span></c:if>
									<c:if test="${listSalesInquiry.sales_status == 1}">  <button class="btn btn-outline-primary outbound-btn" type="button" data-sales_date="${listSalesInquiry.sales_date}" data-custcode="${listSalesInquiry.custcode}">
					                                  출고
					                </button></c:if>
									<c:if test="${listSalesInquiry.sales_status == 2}"><span class="badge bg-label-danger  me-1">취소</span></c:if>
									<c:if test="${listSalesInquiry.sales_status == 3}"><span class="badge bg-label-success me-1">출고완료</span></c:if>
								</td>
							 </tr>
						 <c:set var="num" value="${num + 1}"/>
						</c:forEach>
					</tbody>
					<tbody id ="searchResults">
						<c:set var="num" value="${page.start}"/>
						<c:forEach var="salesInquirySearch" items="${salesInquirySearch}">
							<tr>
								<td style="text-align: center">${num}</td>
								<td><a href="sales/salesInquiryDetail?sales_date=${salesInquirySearch.sales_date}&custcode=${salesInquirySearch.custcode}">${salesInquirySearch.title}</a></td>
								<td style="text-align: center">${salesInquirySearch.company}</td>
								<td style="text-align: center">${salesInquirySearch.sales_date}</td>
								<td style="text-align: center">${salesInquirySearch.name}</td>
								<td style="text-align: center">${salesInquirySearch.code}</td>
								<td style="text-align: center">${salesInquirySearch.total_price}</td>
								<td style="text-align: center">
									<c:if test="${salesInquirySearch.sales_status == 0}"><span class="badge bg-label-primary me-1">진행중</span></c:if>
									<c:if test="${salesInquirySearch.sales_status == 1}">  <button class="btn btn-outline-primary outbound-btn" type="button" data-pur_date="${listSalesInquiry.sales_date}" data-custcode="${listSalesInquiry.custcode}">
					                                  출고
					                </button></c:if>
									<c:if test="${salesInquirySearch.sales_status == 2}"><span class="badge bg-label-danger  me-1">취소</span></c:if>
									<c:if test="${salesInquirySearch.sales_status == 3}">입고완료</c:if>
								</td>
							</tr>
						<c:set var="num" value="${num + 1}"/>
						</c:forEach>
					</tbody>
			
                                      
                                    </table>
                                    
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="tab-pane fade" id="horizontal-profile">
                    입출고관리폼
                </div>

                <div class="tab-pane fade" id="horizontal-messages">
                    입고조정폼
                </div>

                <div class="tab-pane fade" id="horizontal-settings">
                    출고조정폼
                </div>
            </div>
        </div>
    </div>
    <div class="container-xxl flex-grow-1 container-p-y">
        <div class="card mb-4">
            <h5 class="card-header">출고관리</h5>
            <div class="card-body">
                <div class="row">
                    <div class="mb-3 col-md-6">
                        <label for="html5-date-input" class="col-md-2 col-form-label">기준년월</label>
                        <input class="form-control" type="month" id="outboundMonth" name="outboundMonth" >
                    </div>
<!--                     <div class="mb-3 col-md-6">
                        <label for="html5-date-input" class="col-md-2 col-form-label">구분</label>
                        <select id="IO_Type" class="select2 form-select">
                            <option value="ALL">전체</option>
                            <option value="INBOUND">입고</option>
                            <option value="OUTBOUND">출고</option>
                        </select>
                    </div> -->
                </div>
            </div>

            <!-- 재고리스트 -->
            <div class="card">
                <h5 class="card-header">출고내역</h5>
                <div class="card-body">
                     <div class="table-responsive text-nowrap" style="height:500px;" >
                        <table class="table table-bordered" id="inventoryTable">
                            <thead class="table-secondary">
                                <tr>
                                    <td class="text-center">No.</td>
                                    <td class="text-center">수주일</td>
                                    <td class="text-center">구분</td>
                                    <td class="text-center">품번</td>
                                    <td class="text-center">품명</td>
                                    <td class="text-center">업체명</td>
                                    <td class="text-center">수량</td>
                                    <td class="text-center">등록일</td>
                                </tr>
                            </thead>
                         <tbody class="table-border-bottom-0" >
                         
						<c:set value="${inboundTotal}" var="num2" />
						<c:forEach items="${inboundList}" var="inboundItem" varStatus="loop">
						    <tr>
						        <td class="text-center">${inboundTotal - loop.index}</td>
						        <td class="text-center">${inboundItem.pur_date}</td>
						        <td class="text-center"><span class="badge bg-label-success me-1">입고</span></td>
						        <td class="text-center">${inboundItem.code}</td>
						        <td class="text-center">${inboundItem.name}</td>
						        <td class="text-center">${inboundItem.company}</td>
						        <td class="text-center">${inboundItem.qty}</td>
						        <td class="text-center">${inboundItem.mem_name}</td>
						         <td class="text-center">${inboundItem.reg_date}</td>
						    </tr>
						</c:forEach>


                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%@ include file="../common/footer.jsp" %>
    <script type="text/javascript">
    function paging(currentPage){
		var srchcompany = $("#srchCompany").val();
		var srchDate = $("#srchDate").val();
		var moveUrl = "purList?currentPage="+currentPage;
		
		// 검색 후 페이징(날짜 )
		if(srchDate != null && srchDate != ""){
			var subDate = dateFormatt(srchDate);
			moveUrl += "&pur_date="+subDate;
		}
		// 검색 후 페이징 (회사)
		if(srchcompany != "all"){
			moveUrl += "&custcode="+srchcompany;
		}
		
		location.href=moveUrl;
	}
	
	function srch(){
		// 검색 구현
	    var srchcompany = $("#srchCompany").val();  // 회사
	    var srchDate = $("#srchDate").val();        // 날짜
	    var moveUrl = "purList";

	    // 날짜가 선택 됐을 때
	    if (srchDate != null && srchDate != "") {
	        var subDate = dateFormatt(srchDate);
	        moveUrl += "?pur_date=" + subDate;

	        // 회사도 선택 됐을 때
	        if (srchcompany != "all") {
	            moveUrl += "&custcode=" + srchcompany;
	        }
	    } else if (srchcompany != "all") { // 회사만 선택 됐을 때
	        moveUrl += "?custcode=" + srchcompany;
	    }

	    // Ajax를 사용하여 서버에 검색 요청을 보냅니다.
	    $.ajax({
	        url: moveUrl, // 실제 서버 측 엔드포인트로 수정
	        method: 'GET', // 또는 'POST' 등 필요에 따라 변경
	        dataType: 'html',
	        success: function (response) {
	            // 서버 응답에 따라 테이블의 내용을 갱신
	            $('#searchResults').html(response);
	        },
	        error: function (error) {
	            console.error('서버 요청 중 오류 발생:', error);
	            // 오류 처리 로직 추가 (예: 사용자에게 오류 메시지 표시)
	        }
	    });
	}
	
	function dateFormatt(inputDate){
		var date = new Date(inputDate);
		var year = date.getFullYear().toString().substr(2,2);
		var month = ('0' + (date.getMonth() + 1)).slice(-2);
		var day = ('0' + date.getDate()).slice(-2);
		return year + '/' + month + '/' + day;
	}
</script>
</body>
</html>
