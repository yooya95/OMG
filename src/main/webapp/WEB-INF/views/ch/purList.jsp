<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="../common/header.jsp" %>
</head>
<body>
<%@ include file="./../common/menu.jsp" %>
	<div class="conatiner">
		<div class="row">
			<div class="col-12">
				<h2>발주 리스트</h2>
				<hr>
			</div>
			<div class="col-12">
				<table style="width: 100%">
					<tr class="text-end">
						<td colspan="5"><a href="purWriteForm" class="btn btn-outline-primary mb-4">발주 신청</a></td>
					</tr>
					<tr>
						<td>
							 <div class="d-flex justify-content-between align-items-center">
							 	<span class="col-3 text-end">날짜 선택 :</span>
							 	<input type="date" id="srchDate" value="${srchDate }" pattern="YY/MM/DD" class="form-control">
							 </div> 
						</td>
						<td>
							<div class="d-flex justify-content-between align-items-center">
								<span class="col-3 text-end">회사 선택 :</span>
								<select id="srchCompany" class="form-select">
									<option value="all" selected="selected">전체</option>
									<c:forEach items="${pur_custList }" var="pur_custList">
										<c:choose>
											<c:when test="${pur_custList.custcode == srchCompany }">
												<option value="${pur_custList.custcode }" selected="selected">${pur_custList.company }</option>
											</c:when>
											<c:otherwise>
												<option value="${pur_custList.custcode }">${pur_custList.company }</option>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</select>
							</div>
						</td>
						<td class="text-end">
							<button type="button" onclick="srch()" class="btn btn-outline-primary">검색</button>
							<button type="button" onclick="location.href='purList'" class="btn btn-outline-primary">초기화</button>
						</td>
					</tr>
				</table>
			</div>
			<div class="col-12">
				<a href="/purWriteForm"></a>
				<div class="table-responsive">
				  <table class="table bg-white bordered">
				    <thead class="table-primary">
				      <tr>
				        <td>No.</td>
						<td>제목</td>
						<td>회사명</td>
						<td>발주일</td>
						<td>발주자</td>
						<td>상품수</td>
						<td>총수량</td>
						<td>총금액</td>
						<td>상태</td>
				      </tr>
				    </thead>
				    <tbody>
				    	<c:set value="${totalPur }" var="num"/>
				    	<c:forEach items="${purList }" var="purList">
							<tr>
								<td>${num }</td>
								<td class="text-start"><a href="/purDtail?pur_date=${purList.pur_date }&custcode=${purList.custcode }">${purList.title }</a></td>
								<td>${purList.company }</td>
								<td>${purList.pur_date }</td>
								<td>${purList.appli_name}</td>
								<td>${purList.totalType}</td>
								<td>${purList.totalQty}개</td>
								<td><fmt:formatNumber value="${purList.totalPrice}" pattern="#,###"/>원</td>
								<td>
									<c:choose>
										<c:when test="${purList.pur_status == 0}">진행중</c:when>
										<c:when test="${purList.pur_status == 1}">완료</c:when>
										<c:when test="${purList.pur_status == 2}">입고완료</c:when>
									</c:choose>
								</td>
							</tr>
							<c:set var="num" value="${num-1 }"></c:set>
						</c:forEach>
				    </tbody>
				  </table>
					<div class="text-center">
						<c:if test="${page.startPage > page.pageBlock }">
							<a href="javascript:void(0);" onclick="paging(${page.startPage - page.pageBlock })">[이전]</a>		
						</c:if>
						<c:forEach var="i" begin="${page.startPage }" end="${page.endPage}">
							<a href="javascript:void(0);" onclick="paging(${i})">[${i }]</a><!-- 바꾸고 싶다면 currentPage와 keyword를 가져가는 알고리즘을 짜면 될 듯  -->
						</c:forEach>
						<c:if test="${page.endPage < page.totalPage }">
							<a href="javascript:void(0);" onclick="paging(${page.startPage+page.pageBlock })">[다음]</a>
						</c:if>
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
		//검색 구현
		var srchcompany = $("#srchCompany").val();  // 회사
		var srchDate = $("#srchDate").val();		// 날짜
		var moveUrl = "purList";
		// 날짜가 선택 됐을 때 
		if(srchDate != null && srchDate != ""){
			var subDate = dateFormatt(srchDate);
			moveUrl += "?pur_date="+subDate;
			// 회사도 선택 됐을 때 
			if(srchcompany != "all"){
				moveUrl += "&custcode="+srchcompany;
			}
		} else if(srchcompany != "all"){ // 회사만 선택 됐을 때
			moveUrl += "?custcode="+srchcompany;
		}
		
		location.href=moveUrl;
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