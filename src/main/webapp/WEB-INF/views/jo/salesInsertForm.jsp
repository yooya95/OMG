<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
		// '제품추가'시 추가 행 생성
		function addRow() {
		    var table = document.getElementById("itemTable").getElementsByTagName('tbody')[0];
		    var newRow = table.insertRow(table.rows.length);
	
		    var cell1 = newRow.insertCell(0);
		    var cell2 = newRow.insertCell(1);
		    var cell3 = newRow.insertCell(2);
		    var cell4 = newRow.insertCell(3);
		    var cell5 = newRow.insertCell(4);
		    var cell6 = newRow.insertCell(5);
		    
	
		    cell1.innerHTML = '<input type="checkbox" name="rowCheck" value="rowCheck">';
		    cell2.innerHTML = '<input type="text" name="code">';
		    cell3.innerHTML = '<select name="name" onchange="updateCodeAndPrice(this)">' +
		        			  '<option>선택</option>' +
		        			  '<c:forEach var="listProduct" items="${listProduct}">' +
		        			  '<option data-code="${listProduct.code}" data-price="${listProduct.output_price}">${listProduct.name}</option>' +
		        			  '</c:forEach>' +
		        			  '</select>';
		    cell4.innerHTML = '<input type="text" name="qty" oninput="calculateTotalPrice(this)">';
		    cell5.innerHTML = '<input type="text" name="price">';
		    cell6.innerHTML = '<input type="text" name="total_price">';
			
			
	    }
		
		// 추가행 삭제
		function removeRow() {
			  var table = document.getElementById("itemTable").getElementsByTagName('tbody')[0];
			  var checkboxes = table.querySelectorAll('input[name="rowCheck"]');
			  var rowsToRemove = [];

			  // 체크된 체크박스를 찾아서 해당 행을 rowsToRemove 배열에 추가합니다.
			  checkboxes.forEach(function(checkbox) {
			    if (checkbox.checked) {
			      var row = checkbox.parentNode.parentNode;
			      rowsToRemove.push(row);
			    }
			  });

			  // rowsToRemove 배열에 있는 행을 테이블에서 제거합니다.
			  rowsToRemove.forEach(function(row) {
			    table.removeChild(row);
			  });
			}
		
		
		// 드롭다운 선택 시 "code"와 "price"를 업데이트
		function updateCodeAndPrice(selectElement) {
		    var selectedOption = selectElement.options[selectElement.selectedIndex];
		    var row = selectElement.parentNode.parentNode;
		    var codeInput = row.cells[1].getElementsByTagName('input')[0]; 
		    var priceInput = row.cells[4].getElementsByTagName('input')[0]; 
	
		    codeInput.value = selectedOption.getAttribute('data-code');
		    priceInput.value = selectedOption.getAttribute('data-price');
		       
		
		}
	
		// 수량 입력 시 총 금액 계산
		function calculateTotalPrice(inputElement) {
		    var row = inputElement.parentNode.parentNode;
		    var qty = row.cells[3].getElementsByTagName('input')[0].value; 
		    var price = row.cells[4].getElementsByTagName('input')[0].value;
		    var totalPriceInput = row.cells[5].getElementsByTagName('input')[0];
	
		    var total_price = parseInt(qty) * parseInt(price);
		    totalPriceInput.value = isNaN(total_price) ? '' : '￦' + total_price.toFixed();
		 	  
		
		}
	
		// 체크박스 전체 선택/해제 함수
		function checkAll(source) {
		    var checkboxes = document.getElementsByName('rowCheck');
		    for (var i = 0; i < checkboxes.length; i++) {
		        checkboxes[i].checked = source.checked;
		    }
		}
		
		function saveData() {
			
			// date형식 변경
			var dateInput = document.getElementById("sales_date");
		    var selectedDate = dateInput.value;
		    var parts = selectedDate.split("-");
		    var formattedDate = parts[0].slice(2) + "/" + parts[1] + "/" + parts[2]; // 수정된 부분
		    			
		    // Sales 객체 생성
		    var salesData = {
		        sales_date: formattedDate,
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
		    	// date형식 변경
		    	var salesDate = document.getElementById("sales_date").value;
		    	var salesDate2 = salesDate.split("-");
		    	var salesDate3 = parts[0].slice(2) + "/" + parts[1] + "/" + parts[2];
		    	
		    	var custCode = document.querySelector('[name="custcode"]').value;
		        var productCode = row.querySelector('input[name="code"]').value;
		        var quantity = row.querySelector('input[name="qty"]').value;
		        var price = row.querySelector('input[name="price"]').value;

		        var salesDetailData = {
		        	sales_date: salesDate3,
		        	custcode: custCode,
		            code: productCode,
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
		        url: "salesInsert",
		        contentType: "application/json",
		        data: JSON.stringify(salesData),
		        success: function (response) {
		            // 서버 응답에 따른 처리
		            console.log(response);
		            if (response == 1) {
			            // alert("성공");
	
					    $.ajax({
					        type: "POST",
					        url: "salesDetailInsert",
					        contentType: "application/json",
					        data: JSON.stringify(salesDetailsData),
					        success: function (response) {
					            // 서버 응답에 따른 처리
					            console.log(response);
					            if (response == 1) {
						            location.href="/sales/salesInquiry"
					            	
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
		
	</script>
</head>
<body>
<%@ include file="../common/menu.jsp" %>
	<div class="container-fluid">
		<div class="row">
			<main>
			<div>
		   		<h1>판매입력</h1>
			</div>
			
			<!-- Section1: Table -->
			<div>
				<div>
					<div>
					<form id="salesForm" action="salesInsert" method="post">
						<div class="mb-3 ">
						  <label for="sales_date" class="form-label" style="font-size: 15px;">매출일자</label>
						  <input type="date" class="form-control" name="sales_date" id="sales_date" required="required">
						  <!-- <input type="text" class="form-control" name="sales_date" id="sales_date" required="required" pattern="\d{2}/\d{2}/\d{2}" placeholder="23/MM/DD"> -->
						</div>
						<div class="mb-3 ">
						  <label for="title" class="form-label" style="font-size: 15px;">제목</label>
						  <input type="text" class="form-control" name="title" id="title" required="required" placeholder="판매전표_2024YYMM_(주)XXX">
						</div>
						<div class="mb-3 ">
						  <label for="company" class="form-label" style="font-size: 15px;">거래처명</label>
						  <input type="hidden" name="custstyle" value="1">
						  <select class="form-select" aria-label="custcode" name="custcode" required="required">
							<c:forEach var="custCode" items="${listCustCode}">
								<option value="${custCode.custcode}">${custCode.company}</option>
							</c:forEach>
						  </select>
						</div>
						<div class="mb-3 ">
						  <label for="ref" class="form-label" style="font-size: 15px;">비고</label>
						  <textarea class="form-control" name="ref" id="ref" rows="5" ></textarea>
						</div>
																							
						<hr class="hr" />			
						
						<table id="itemTable" class="table table-md text-center p-3">
							<thead>
								<tr style="border: 2px solid black; background-color: #E1E2FF; color: #566A7F;">
									<th scope="col"><input type="checkbox" name="allCheck" id="allCheck" onchange="checkAll(this)"/></th>
									<th scope="col">제품코드</th>
									<th scope="col">제품명</th>
									<th scope="col">수량</th>
									<th scope="col">가격</th>
									<th scope="col">총 금액</th>
								</tr>
							</thead>
							<tbody>
								<c:set var="num" value="1"/>
								<tr>
									<td><input type="checkbox" name="rowCheck" value="rowCheck"></td>
									<td><input type="text" name="code" readonly style="background-color: #f2f2f2; border: 1px solid #000;"></td>
									<td>
										<select name="name" onchange="updateCodeAndPrice(this)">
											<option>선택</option>
											<c:forEach var="listProduct" items="${listProduct}">
												<option data-code="${listProduct.code}" data-price="${listProduct.output_price}">${listProduct.name}</option>
											</c:forEach>	
										</select>
									</td>
									<td><input type="text" name="qty" oninput="calculateTotalPrice(this)"></td>
									<td><input type="text" name="price" readonly style="background-color: #f2f2f2; border: 1px solid #000;"></td>
									<td><input type="text" name="total_price"></td>
								</tr>
							</tbody>
						 </table>
					
					<div class="button-group">
						<button type="button" class="btn btn-primary btn-sm mb-1" onclick="addRow()">제품추가</button>
						<button type="button" class="btn btn-primary btn-sm mb-1" onclick="removeRow()">추가취소</button>
						<button type="button" class="btn btn-primary btn-sm mb-1" onclick="saveData()">저장</button>
						<button type="button" class="btn btn-primary btn-sm mb-1" onclick="location.href='salesInquiry'">리스트</button>
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