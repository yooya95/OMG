<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<%@ include file="../common/header.jsp" %>
	<style>
		 #itemTable {
            border: 2px double black; /* 이중 실선 */
            width: 100%;
            border-collapse: collapse;
        }

        #itemTable thead tr {
            color: white;
            border-bottom: 2px solid black; /* 굵은 실선 */
        }

        #itemTable tbody tr {
            border-bottom: 1px solid black; /* 실선 */
        }

        #itemTable th, #itemTable td {
            border-right: 1px solid black; /* 실선 */
            padding: 8px;
            text-align: center;
        }
        
        .button-group {
       		 margin-top: -10px; /* 버튼을 위로 올리기 위해 음수 값으로 설정 */
    	}
    	
	</style>
	
</head>
<body>
<%@ include file="../common/menu.jsp" %>
	<div class="container-fluid">
		<div class="row">
			<main>
			<div>
				<h1>판매정보</h1>
			</div>
			
			<!-- Section1: Table -->
			<div>
				<div>
					<div>
						<div class="mb-3 ">
						  <label for="sales_date" class="form-label" style="font-size: 15px;">매출일자</label>
						  <input type="text" class="form-control" name="sales_date" id="sales_date" value="${salesDetail.sales_date}" required="required" disabled>
						</div>
						<div class="mb-3 ">
						  <label for="title" class="form-label" style="font-size: 15px;">제목</label>
						  <input type="text" class="form-control" name="title" id="title" value="${salesDetail.title}" required="required" disabled>
						</div>
						<div class="mb-3 ">
						  <label for="company" class="form-label" style="font-size: 15px;">거래처명</label>
						  <input type="hidden" name="custstyle" value="1">
						  <select class="form-select" aria-label="custcode" name="custcode" required="required" disabled>
							<c:forEach var="custCode" items="${listCustCode}">
								<option value="${custCode.custcode}" ${custCode.custcode == salesDetail.custcode? 'selected' : ''} >${custCode.company}</option>
							</c:forEach>
						  </select>
						</div>
						<div class="mb-3 ">
						  <label for="ref" class="form-label" style="font-size: 15px;">비고</label>
						  <textarea class="form-control" name="ref" id="ref" rows="5" disabled>${salesDetail.ref}</textarea>
						</div>
						<div class="mb-3 ">
						  <label for="sales_status" class="form-label"  style="font-size: 15px;">상태</label>
						  <select class="form-select" aria-label="sales_status" name="sales_status" disabled>
								<option value="0" ${0 == salesDetail.sales_status? 'selected' : ''} >진행</option>
						  		<option value="1" ${1 == salesDetail.sales_status? 'selected' : ''} >완료</option>
						  		<option value="2" ${2 == salesDetail.sales_status? 'selected' : ''} >취소</option>
						  </select>
						</div>
																							
						<hr class="hr" />			
						
						<table id="itemTable" class="table table-md text-center p-3">
							<thead>
								<tr style="border: 2px solid black; background-color: #E1E2FF; color: #fff;">
									<th scope="col">No.</th>
									<th scope="col">제품코드</th>
									<th scope="col">제품명</th>
									<th scope="col">수량</th>
									<th scope="col">가격</th>
									<th scope="col">총 금액</th>
								</tr>
							</thead>
							<tbody>
								<c:set var="num" value="1"/>   
								<c:forEach var="salesDetail" items="${salesDetailList}">
								   <tr>
										<td style="text-align: center">${num}</td>
										<td style="text-align: center">${salesDetail.code}</td>
										<td style="text-align: center">${salesDetail.name}</td>
										<td style="text-align: center">${salesDetail.qty}</td>
										<td style="text-align: center">${salesDetail.price}</td>
										<td style="text-align: center">${salesDetail.total_price}</td>
								   </tr>
								 <c:set var="num" value="${num+1}"/>  
			                    </c:forEach>
							</tbody>
						 </table>
							
					<div class="button-group">
						<button id="regist-btn" type="button" class="btn btn-primary btn-sm mb-4" onclick="location.href='salesUpdateForm?sales_date=${salesDetail.sales_date}&custcode=${salesDetail.custcode}&code=${salesDetail.code}'">수정</button>
						<button id="regist-btn" type="button" class="btn btn-primary btn-sm mb-4" onclick="location.href='salesInquiry'">리스트</button>
					</div>
								
					</div>
				</div>
			</div>
		</main>
	</div>
	</div>			
<%@ include file="../common/footer.jsp" %>	
</body>
</html>