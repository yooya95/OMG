<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제품 등록</title>
<script type="text/javascript">
     // msg 값이 존재하면 alert 띄우기
     var msg = "${msg}";
     if(msg.length > 0)	alert(msg);
</script>
</head>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<body>
<%@ include file="/WEB-INF/views/common/menu.jsp" %>
	<h4 class="fw-bold py-3 mb-4">
		<span class="text-muted fw-light">제품 관리 / </span>
		<a href="/item/create" class="linkText">제품 등록</a>
	</h4>
	
	<div class="card">
	  <div class="card overflow-hidden">
	  
			<div class="card-body table-responsive text-nowrap">
			
				<!-- 제품 등록 -->
				<form method="post" action="/item/createPro">
					<table class="table table-bordered mb-4">
						<tr>
							<th class="table-primary">제품코드</th>
		      				<td><input type="text" class="form-control" placeholder="제품코드 자동생성" readonly /></td>
							<th class="table-primary">거래처</th>
							<td>
								<select class="form-select" name="custcode" id="custcode">
									<c:forEach items="${cs }" var="cs">
										<option value="${cs.custcode }">${cs.company }</option>
									</c:forEach>
								</select>
							</td>
						</tr>
	
						<tr>
							<th class="table-primary">카테고리</th>
							<td>
								<select class="form-select" name="cate_md" id="cate_md">
									<c:forEach items="${cm }" var="cm">
										<option value="${cm.ct_md }">${cm.com_cn }</option>
									</c:forEach>
								</select>
							</td>
							
							<jsp:useBean id="javaDate" class="java.util.Date"/>
							<fmt:formatDate value="${javaDate }" var="now" pattern="yyyy-MM-dd"/>
							<th class="table-primary">등록일</th>
							<td><input type="date" class="form-control" name="reg_date" id="reg_date" value="${now }"/></td>
						</tr>
						
						<tr>
							<th class="table-primary">판매여부</th>
							<td colspan="3">
								<select class="form-select" name="deleted" id="deleted">
									<option value="0">정상</option>
									<option value="1">판매종료</option>
								</select>
							</td>
						</tr>
	
						<tr>
							<th class="table-primary">제품명</th>
							<td colspan="3"><input type="text" class="form-control" name="name" id="name" /></td>
						</tr>
						
						<tr>
							<th class="table-primary">제품내용</th>
							<td colspan="3">
								<textarea class="form-control" rows="3" name="item_cn" id="item_cn"></textarea>
							</td>
						</tr>
						
						<tr>
							<th class="table-primary">매입가격</th>
							<td><input type="number" class="form-control" name="input_price" id="input_price" /></td>
							<th class="table-primary">매출가격</th>
							<td><input type="number" class="form-control" name="output_price" id="output_price" /></td>
						</tr>
	
					</table>
	
					<div class="d-flex justify-content-end">
						<button type="submit" class="btn btn-outline-primary">저장</button>
					</div>
				</form>
			</div>
		</div>
	</div>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>
</body>
</html>