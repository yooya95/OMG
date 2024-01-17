<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
</head>
<body>
	<%@ include file="/WEB-INF/views/common/menu.jsp"%>
	<h4 class="fw-bold py-3 mb-4">
		<span class="text-muted fw-light">고객지원/</span> 공지사항
	</h4>
	<div class="card">
		<!-- 검색 필터 부분 -->
		<div class="row mx-1 mt-2">
			<div class="col-12 col-md-6 d-flex align-items-center justify-content-center justify-content-md-start gap-3">
<!-- 				<div class="dataTables_length" id="DataTables_Table_0_length"> -->
<!-- 					<label> -->
<!-- 						<select name="DataTables_Table_0_length" aria-controls="DataTables_Table_0" class="form-select"> -->
<!-- 							<option value="10">10</option> -->
<!-- 							<option value="25">25</option> -->
<!-- 							<option value="50">50</option> -->
<!-- 							<option value="100">100</option> -->
<!-- 						</select> -->
<!-- 					</label> -->
<!-- 				</div> -->
				<div class="dt-action-buttons text-xl-end text-lg-start text-md-end text-start mt-md-0 mt-3">
					<div class="dt-buttons">
						<c:if test="${sessionScope.mem_dept_md == 101 || sessionScope.mem_dept_md == 999}">
							<button id="regBtn" class="dt-button btn btn-primary my-1" tabindex="0" aria-controls="DataTables_Table_0" type="button">
								<span><i class="bx bx-plus me-md-1"></i><span class="d-md-inline-block d-none">공지글 작성</span></span>
							</button>
						</c:if>
					</div>
				</div>
			</div>
			<div class="col-12 col-md-6 d-flex align-items-center justify-content-end flex-column flex-md-row pe-3 gap-md-3">
				<form id="searchForm" class="my-1" action="/notice/list" method="get" >				
					<div id="DataTables_Table_0_filter col-auto" class="dataTables_filter">
						<label>
							<select name="type" aria-controls="DataTables_Table_0" class="form-select">
								<option value=""    <c:out value="${pageMaker.cri.type == null?'selected':''}"/>>--</option> 
								<option value="T"   <c:out value="${pageMaker.cri.type eq 'T'?'selected':''}"/>>제목</option>
								<option value="C"   <c:out value="${pageMaker.cri.type eq 'C'?'selected':''}"/>>내용</option>
<%-- 								<option value="W"   <c:out value="${pageMaker.cri.type eq 'W'   ? 'selected' : '' }"/>>작성자</option> --%>
								<option value="TC"  <c:out value="${pageMaker.cri.type eq 'TC'?'selected':''}"/>>제목/내용</option>
<%-- 								<option value="TW"  <c:out value="${pageMaker.cri.type eq 'TW'  ? 'selected' : '' }"/>>제목/작성자</option> --%>
<%-- 								<option value="TWC" <c:out value="${pageMaker.cri.type eq 'TWC' ? 'selected' : '' }"/>>제목/내용/작성자</option> --%>
							</select>
						</label>
						<label><input type="text"   name='keyword' value='<c:out value="${pageMaker.cri.keyword }"/>' class="form-control" placeholder="검색" aria-controls="DataTables_Table_0"></label>
						<label><input type="hidden" name='pageNum' value='<c:out value="${pageMaker.cri.pageNum }"/>'></label> 
						<label><input type="hidden" name='amount'  value='<c:out value="${pageMaker.cri.amount }"/>'></label>
						<label><button class="btn btn-primary mb-1">검색</button></label>
					</div>
				</form>
			</div>
		</div>
		<div class="table-responsive mt-2 mb-3">
			<table class="table table-hover border-top">
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>날짜</th>
						<th>조회수</th>
					</tr>
				</thead>

				<c:forEach var="notice" items="${noticeList }">
					<tbody>
						<tr>
							<td class="col-md-2">${notice.brd_id }</td>
							<td class="col-md-3">
								<a class='text-Secondary fw-bold move' href='<c:out value="${notice.brd_id }"></c:out>'>
									<c:out value="${notice.title }"/>  <b> [<c:out value="${notice.replyCnt }"/>]</b>
								</a> 
							</td>
							<td class="col-md-3">${notice.mem_name }</td>
							<td class="col-md-3">${notice.reg_date }</td>
							<td class="col-md-1">${notice.view_cnt }</td>
						</tr>
					</tbody>
				</c:forEach>
			</table>




			<!-- Modal -->
			<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title" id="exampleModalLabel">결과창</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
						</div>
						<div class="modal-body">처리 완료되었습니다</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-primary" data-bs-dismiss="modal">Close</button>
						</div>
					</div>
				</div>
			</div>
			
			
		</div>

		<!-- 페이지 네이션 -->
		<form id='actionForm' action="/notice/list" method="get">
			<input type="hidden" name='pageNum' value='<c:out value="${pageMaker.cri.pageNum }"></c:out>'>
			<input type="hidden" name='amount' 	value='<c:out value="${pageMaker.cri.amount }"></c:out>'>
			<input type="hidden" name='type' 	value='<c:out value="${pageMaker.cri.type }"></c:out>'>
			<input type="hidden" name='keyword' value='<c:out value="${pageMaker.cri.keyword }"></c:out>'>
		</form>
		<div class="row mx-2">
			<div class="col-sm-12 col-md-6">
				<div class="dataTables_info" id="DataTables_Table_0_info" role="status" aria-live="polite">Showing 1 to 10 of 50 entries</div>
			</div>
			<div class="col-sm-12 col-md-6 d-flex justify-content-end">
				<div class="dataTables_paginate paging_simple_numbers" id="DataTables_Table_0_paginate">
					<ul class="pagination">
						<!-- 이전 이동 -->
						<c:if test="${pageMaker.prev }">
							<li class="paginate_button previous">
								<a href="${pageMaker.startPage - 1}" aria-controls="DataTables_Table_0" role="link" aria-current="page" data-dt-idx="0" tabindex="0" class="page-link"> 
									이전 
								</a>
							</li>
						</c:if>

						<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }" varStatus="status">
							<li class='paginate_button page-item ${pageMaker.cri.pageNum == num ? "active" : ""} '>
								<a href="<c:out value="${num}"/>" aria-controls="DataTables_Table_0" role="link" aria-current="page" data-dt-idx="0" tabindex="0" class="page-link">
									<c:out value="${num}"/>
								</a>
							</li>
						</c:forEach>

						<!-- 다음 이동 -->
						<c:if test="${pageMaker.next }">
							<li class="paginate_button next">
								<a href="${pageMaker.endPage + 1}" aria-controls="DataTables_Table_0" role="link" aria-current="page" data-dt-idx="0" tabindex="0" class="page-link"> 
									다음 
								</a>
							</li>
						</c:if>
					</ul>
				</div>
			</div>
		</div>
	</div>
	



	<%@ include file="/WEB-INF/views/common/footer.jsp"%>
	
	<!-- JS: body 태그 닫히기 바로전에 두는게 좋음 jQuery 라이브러리도 마찬가지-->
	<script type="text/javascript">
		$(document).ready(function() {
			
			var result = '<c:out value="${result}"/>';
			
			checkModal(result);
			
			function checkModal(result) {
				
				if (result ==='') {
					return;
				}
				
				if (parseInt(result) > 0){
					$(".modal-body").html("게시글 " + parseInt(result) + " 번이 등록되었습니다.");
				}
				
				$("#exampleModal").modal("show");
			}
			
			$("#regBtn").on("click", function() {
				window.location.href = "/notice/register";
			});
			
			
			// Pagination Form
			var actionForm = $('#actionForm');
			
			$(".paginate_button.page-item a").on("click", function(e){
				
				e.preventDefault();
				
				console.log('click');
				
				actionForm.find("input[name='pageNum']").val($(this).attr("href"));
				actionForm.submit();
			});
			
			$(".move").on("click", function(e){
				
				e.preventDefault();
				actionForm.append("<input type='hidden' name='brd_id' value='" + $(this).attr("href") + "'>");
				actionForm.attr("action", "/notice/get");
				actionForm.submit();
				
			});
			
			// 검색버튼 이벤트 처리
			var searchForm = $("#searchForm");
			
			$("#searchForm button").on("click", function(e){
			
				if(!searchForm.find("option:selected").val()){
					alert("검색종류를 입력하세요");
					return false;
				}
				
				if(!searchForm.find("input[name='keyword']").val()){
					alert("검색어를 입력하세요")
					return false;
				}
				
				searchForm.find("input[name='pageNum']").val("1");
				e.preventDefault();
				searchForm.submit();
			});
			
			
		});
		
	</script>

</body>

</html>