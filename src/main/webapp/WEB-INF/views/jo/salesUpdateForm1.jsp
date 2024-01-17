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
	<script>
		// 체크박스 전체 선택/해제 함수
		function checkAll(source) {
	    	var checkboxes = document.getElementsByName('rowCheck');
	    	for (var i = 0; i < checkboxes.length; i++) {
	        	checkboxes[i].checked = source.checked;
	    	}
		}
		
		// 드롭다운 선택 시 "code"와 "price"를 업데이트
		function updateCodeAndPrice(selectElement) {
		    var selectedOption = selectElement.options[selectElement.selectedIndex];
		    var row = selectElement.parentNode.parentNode;
		    var codeInput = row.cells[2].getElementsByTagName('input')[0]; // 열 위치 수정
		    var priceInput = row.cells[5].getElementsByTagName('input')[0]; // 열 위치 수정
	
		    codeInput.value = selectedOption.getAttribute('data-code');
		    priceInput.value = selectedOption.getAttribute('data-price');
		}
		
		// 수량 입력 시 총 금액 계산
		function calculateTotalPrice(inputElement) {
		    var row = inputElement.parentNode.parentNode;
		    var qty = row.cells[4].getElementsByTagName('input')[0].value; // 열 위치 수정
		    var price = row.cells[5].getElementsByTagName('input')[0].value;
		    var totalPriceInput = row.cells[6].getElementsByTagName('input')[0]; // 열 위치 수정
	
		    var total_price = parseInt(qty) * parseInt(price);
		    totalPriceInput.value = isNaN(total_price) ? '' : '￦' + total_price.toFixed();
		}
	
		// 저장시 update
		function updateData() {
		    // Sales 객체 생성
		    var salesData = {
		        sales_date:document.getElementById("sales_date").value,
		        title: document.getElementById("title").value,
		        custcode: document.querySelector('[name="custcode"]').value,
		        ref: document.getElementById("ref").value
		    };
			
		    console.log(salesData);
		    
		    // SalesDetails 배열 생성
		    var salesDetailsData = [];
		    
		    // SalesDetails 데이터 수집
		    var rows = document.querySelectorAll("#itemTable tbody tr");
		    
		    
		    rows.forEach(function(row) {
		    	var salesDate = document.getElementById("sales_date").value;
		    	var custCode = document.querySelector('[name="custcode"]').value;
		        var beforeCode = row.querySelector('input[name="beforeCode"]').value; // 수정된 부분
		    	var afterCode = row.querySelector('input[name="afterCode"]').value; // 수정된 부분
		    	var quantity = row.querySelector('input[name="qty"]').value;
		        var price = row.querySelector('input[name="price"]').value;

		        var salesDetailData = {
		        	sales_date: salesDate,
		        	custcode: custCode,
		        	beforeCode: beforeCode, 
		            afterCode: afterCode,
		            qty: quantity,
		            price: price
		        };

		        salesDetailsData.push(salesDetailData);
		    });
		    
		    console.log(salesDetailsData);
				
		    // 서버로 전송할 데이터 객체 생성
		    var sendData1 = {
		        sales: salesData,
		    };
		    var sendData2 = {
			        salesDetails: salesDetailsData
			    };
			
		    
		    
		    // AJAX를 사용하여 서버로 데이터 전송
		    $.ajax({
		        type: "POST",
		        url: "salesUpdate",
		        contentType: "application/json",
		        data: JSON.stringify(salesData),
		        success: function (response) {
		            // 서버 응답에 따른 처리
		            console.log(response);
		            if (response == 1) {
			            // alert("성공");
	
					    $.ajax({
					        type: "POST",
					        url: "salesDetailUpdate",
					        contentType: "application/json",
					        data: JSON.stringify(salesDetailsData),
					        success: function (response) {
					            // 서버 응답에 따른 처리
					            console.log(response);
					            if (response == 1) {
						            location.href="/sales/salesInquiry";
					            	
					            }
					        },
					        error: function (error) {
					        	alert("다시 한번 입력정보를 확인바랍니다" + error);
					            
					        }
					    });		            
			            
			            
			            
		            }
		        },
		        error: function (error) {
		            console.error("데이터 전송 중 오류 발생:", error);
		        }
		    });
		}
		
		// 삭제시 delete
		function deleteData(){
			// 체크된  체크박스 개수 확인
			var checkedCount = ${"input[name='rowCheck']:checked"}.length;
			
			if(checkedCount > 0 ){
				var confirmation = confirm("정말로 삭제하시겠습니까?");
				
				if(confirmation){
					// SalesDetails 배열 생성
				    var salesDetailsData = [];
				    
				    // SalesDetails 데이터 수집
				    var rows = document.querySelectorAll("#itemTable tbody tr");
				    				    
				    rows.forEach(function(row) {
				    	var salesDate = document.getElementById("sales_date").value;
				    	var custCode = document.querySelector('[name="custcode"]').value;
				        var code = row.querySelector('input[name="code"]').value;
				    	var quantity = row.querySelector('input[name="qty"]').value;
				        var price = row.querySelector('input[name="price"]').value;

				        var salesDetailData = {
				        	sales_date: salesDate,
				        	custcode: custCode,
				        	code: code, 
				            qty: quantity,
				            price: price
				        };

				        salesDetailsData.push(salesDetailData);
				    });
				    
				    console.log(salesDetailsData);
						
				   /* var sendData2 = {
					        salesDetails: salesDetailsData
					    };
					 */
				    
				    
				    // AJAX를 사용하여 서버로 데이터 전송
				    $.ajax({
				        type: "POST",
				        url: "salesDelete",
				        contentType: "application/json",
				        data: JSON.stringify(salesDetailsData),
				        success: function (response) {
				            // 서버 응답에 따른 처리
				            console.log(response);
				            if (response == 1) {
					            location.href="/sales/salesInquiry";
				            	
				            }
				        },
				        error: function (error) {
				        	alert("다시 한번 입력정보를 확인바랍니다" + error);
				            
				        }
				     });		            
					
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
				<h1>판매수정</h1>
			</div>
			
			<!-- Section1: Table -->
			<div>
				<div>	
					<div>
					<form action="salesUpdate" method="post">
						<div class="mb-3 ">
						  <label for="sales_date" class="form-label" style="font-size: 15px;">매출일자</label>
						  <input type="text" class="form-control" name="sales_date" id="sales_date" value="${salesDetail.sales_date}" required="required" disabled>
						  <input type="hidden" name="sales_date" value="${salesDetail.sales_date}">
						</div>
						<div class="mb-3 ">
						  <label for="title" class="form-label" style="font-size: 15px;">제목</label>
						  <input type="text" class="form-control" name="title" id="title" value="${salesDetail.title}" required="required" >
						</div>
						<div class="mb-3 ">
						  <label for="company" class="form-label"  style="font-size: 15px;">거래처명</label>
						  <input type="hidden" name="custcode" value="${salesDetail.custcode}">
						  <input type="hidden" name="custstyle" value="1">
						  <select class="form-select" aria-label="custcode" name="custcode" required="required" disabled>
							<c:forEach var="custCode" items="${listCustCode}">
								<option value="${custCode.custcode}" ${custCode.custcode == salesDetail.custcode? 'selected' : ''} >${custCode.company}</option>
							</c:forEach>
						  </select>
						</div>
						<div class="mb-3 ">
						  <label for="ref" class="form-label" style="font-size: 15px;">비고</label>
						  <textarea class="form-control" name="ref" id="ref" rows="5">${salesDetail.ref}</textarea>
						</div>
						<div class="mb-3 ">
						  <label for="sales_status" class="form-label"  style="font-size: 15px;">상태</label>
						  <select class="form-select" aria-label="sales_status" name="sales_status" required="required">
								<option value="0" ${0 == salesDetail.sales_status? 'selected' : ''} >진행</option>
						  		<option value="1" ${1 == salesDetail.sales_status? 'selected' : ''} >완료</option>
						  		<option value="2" ${2 == salesDetail.sales_status? 'selected' : ''} >취소</option>
						  </select>
						</div>
																													
						<hr class="hr" />			
						
						<table id="itemTable" class="table table-md text-center p-3">
							<thead>
								<tr style="border: 2px solid black; background-color: #E1E2FF; color: #fff;">
									<th scope="col" style="text-align: center;"><input type="checkbox" name="allCheck" id="allCheck" onchange="checkAll(this)"/></th>
									<th scope="col" style="text-align: center;">No.</th>
									<th scope="col" style="text-align: center;">제품코드</th>
									<th scope="col" style="text-align: center;">제품명</th>
									<th scope="col" style="text-align: center;">수량</th>
									<th scope="col" style="text-align: center;">가격</th>
									<th scope="col" style="text-align: center;">총 금액</th>
								</tr>
							</thead>
							<tbody>
								<c:set var="num" value="${page.start}"/>   
								<c:forEach var="salesDetail" items="${salesDetailList}">
								   <tr>
										<td style="text-align: center"><input type="checkbox" name="rowCheck" value=""></td>
										<td style="text-align: center">${num}</td>
										<td style="text-align: center">
											<input type="text" name="code" value="${salesDetail.code}" readonly style="background-color: #f2f2f2; border: 1px solid #000;">
										</td>
										<td>
											<select name="name" onchange="updateCodeAndPrice(this)">
												<option>선택</option>
												<c:forEach var="listProduct" items="${listProduct}">
													<option data-code="${listProduct.code}" data-price="${listProduct.output_price}" ${listProduct.code == salesDetail.code? 'selected' : ''}>${listProduct.name}</option>
												</c:forEach>	
											</select>
										</td>										
										<td style="text-align: center"><input type="text" name="qty" value="${salesDetail.qty}" oninput="calculateTotalPrice(this)"></td>
										<td style="text-align: center"><input type="text" name="price" value="${salesDetail.price}"readonly style="background-color: #f2f2f2; border: 1px solid #000;"></td>
										<td style="text-align: center"><input type="text" name="total_price" value="${salesDetail.total_price}"></td>
								   </tr>
								 <c:set var="num" value="${num+1}"/>  
			                    </c:forEach>
							</tbody>
						 </table>
							
					<div class="button-group">
						<button type="button" class="btn btn-primary btn-sm mb-4" onclick="updateData()">저장</button>
						<button type="button" class="btn btn-primary btn-sm mb-4" onclick="deleteData()">삭제</button>
						<!-- <input type=submit id="regist-btn" class="btn btn-primary btn-sm mb-4" value="저장"> -->
						<button id="regist-btn" type="button" class="btn btn-primary btn-sm mb-4" onclick="location.href='salesInquiry'">리스트</button>
					</div>
					
					</form>
					</div>
				</div>
			</div>
			</main>
		</div>
	</div>		
<%@ include file="../common/footer.jsp" %>	
</body>
</html>