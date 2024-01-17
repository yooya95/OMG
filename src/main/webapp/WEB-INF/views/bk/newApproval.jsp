<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>기안서작성</title>
		<style type="text/css">
			.table tbody tr {
				background-color: white;
			}
			
			
		</style>
		<script type="text/javascript">
		 $(document).ready(function () {
		        // 이벤트 리스너 등록
		        $(".table").on("click", ".editable-cell", function () {
		            // 클릭된 셀에 대한 처리
		            var cell = $(this);
		            var newRow = $("<tr>");
		            var cols = "";

		            // 체크박스 열
		            cols += '<td><input class="form-check-input" type="checkbox" value="" /></td>';

		            // 사용처 열
		            cols += '<td><input type="text" class="form-control" placeholder="" aria-describedby="defaultFormControlHelp" /></td>';

		            // 금액 열
		            cols += '<td><div class="input-group"><span class="input-group-text">₩</span><input type="text" class="form-control" placeholder="" aria-label="Amount (to the nearest dollar)" /><span class="input-group-text">.00</span></div></td>';

		            // 비고 열
		            cols += '<td><input type="text" class="form-control" id="defaultFormControlInput" placeholder="" aria-describedby="defaultFormControlHelp" /></td>';

		            newRow.append(cols);
		            cell.closest("tr").after(newRow);
		        });
		    });
		 
		 
		 
		 
		 function newApproval() {
			 
			 // alert("newApproval");
			 
			  var table = document.getElementById("newApproval"); // 테이블의 ID를 지정해주세요.
			  var newRow = table.insertRow(-1); // 맨 뒤에 행을 추가합니다.

			  // Checkbox 열
			  var cell1 = newRow.insertCell(0);
			  var checkbox = document.createElement("input");
			  checkbox.type = "checkbox";
			  checkbox.className = "form-check-input";
			  cell1.appendChild(checkbox);

			  // 사용처 열
			  var cell2 = newRow.insertCell(1);
			  var input1 = document.createElement("input");
			  input1.type = "text";
			  input1.className = "form-control";
			  input1.placeholder = "";
			  input1.setAttribute("aria-describedby", "defaultFormControlHelp");
			  cell2.appendChild(input1);

			  // 금액 열
			    var cell3 = newRow.insertCell(2);
  var input2 = document.createElement("input");
  input2.type = "text";
  input2.className = "form-control";
  input2.placeholder = "₩ Amount";
  cell3.appendChild(input2);

			  // 비고 열
			  var cell4 = newRow.insertCell(3);
			  var input3 = document.createElement("input");
			  input3.type = "text";
			  input3.className = "form-control";
			  input3.placeholder = "";
			  input3.setAttribute("aria-describedby", "defaultFormControlHelp");
			  cell4.appendChild(input3);
			}
		</script>
	</head>
	<%@ include file="../common/header.jsp" %>
	<body>
	
		<!-- Content wrapper -->
		<div class="content-wrapper">
		
			<!-- Content -->
			<div class="container-xxl flex-grow-1 container-p-y">
			
				<h4 class="fw-bold py-3 mb-4">지출결의서</h4>
				
				
				
				<div class="card mb-5">
				
					<div class="card-body" >
					
						<div class="mb-3 row">
	                        <label for="html5-date-input" class="col-md-2 col-form-label">일자</label>
	                        <div class="col-md-10">
	                          <input class="form-control" type="date" value="2021-06-18" id="html5-date-input" />
	                        </div>
	                      </div>
	                      
	                      <div class="input-group input-group-merge mb-3">
	                      	<label for="html5-date-input" class="col-md-2 col-form-label">결재라인</label>
	                        <span class="input-group-text" id="basic-addon-search31"><i class="bx bx-search"></i></span>
	                        <input
	                          type="text"
	                          class="form-control"
	                          placeholder="Search..."
	                          aria-label="Search..."
	                          aria-describedby="basic-addon-search31"
	                        />
	                      </div>
	                      
	                      <div class="mb-3">
	                        <label for="formFile" class="form-label">첨부</label>
	                        <input class="form-control" type="file" id="formFile" />
	                      </div>
                      
                      </div>
					
				</div>
				
				
				
				<!-- Bordered Table -->
                <div class="card-body">
                  <div class="table-responsive text-nowrap">
                    <table class="table table-bordered" id="newApproval">
                      <thead>
                        <tr>
                          <th>
                          	<input class="form-check-input" type="checkbox" value="" />
                          </th>
                          <th>사용처</th>
                          <th>금액</th>
                          <th>비고</th>
                        </tr>
                      </thead>
                      <tbody>
                        <tr>
                          <td>
                            <input class="form-check-input" type="checkbox" value="" />
                          </td>
                          <td>
                            <input
	                          type="text"
	                          class="form-control"
	                          id="defaultFormControlInput"
	                          placeholder=""
	                          aria-describedby="defaultFormControlHelp"
	                        />
                          </td>
                          <td>
                          	<div class="input-group">
	                        <span class="input-group-text">₩</span>
	                        <input
	                          type="text"
	                          class="form-control"
	                          placeholder=""
	                          aria-label="Amount (to the nearest dollar)"
	                        />
	                        <span class="input-group-text">.00</span>
	                      </div>
                          </td>
                          <td>
                            <input
	                          type="text"
	                          class="form-control"
	                          id="defaultFormControlInput"
	                          placeholder=""
	                          aria-describedby="defaultFormControlHelp"
	                        />
                          </td>
                        </tr>
                        <tr>
                          <td>
                            <input class="form-check-input" type="checkbox" value="" />
                          </td>
                          <td>
                            <input
	                          type="text"
	                          class="form-control"
	                          id="defaultFormControlInput"
	                          placeholder=""
	                          aria-describedby="defaultFormControlHelp"
	                        />
                          </td>
                          <td>
                          	<div class="input-group">
	                        <span class="input-group-text">₩</span>
	                        <input
	                          type="text"
	                          class="form-control"
	                          placeholder=""
	                          aria-label="Amount (to the nearest dollar)"
	                        />
	                        <span class="input-group-text">.00</span>
	                      </div>
                          </td>
                          <td>
                            <input
	                          type="text"
	                          class="form-control"
	                          id="defaultFormControlInput"
	                          placeholder=""
	                          aria-describedby="defaultFormControlHelp"
	                        />
                          </td>
                        </tr>
                        <tr>
                          <td>
                            <input class="form-check-input" type="checkbox" value="" />
                          </td>
                          <td>
                            <input
	                          type="text"
	                          class="form-control"
	                          id="defaultFormControlInput"
	                          placeholder=""
	                          aria-describedby="defaultFormControlHelp"
	                        />
                          </td>
                          <td>
                          	<div class="input-group">
	                        <span class="input-group-text">₩</span>
	                        <input
	                          type="text"
	                          class="form-control"
	                          placeholder=""
	                          aria-label="Amount (to the nearest dollar)"
	                        />
	                        <span class="input-group-text">.00</span>
	                      </div>
                          </td>
                          <td>
                            <input
	                          type="text"
	                          class="form-control"
	                          id="defaultFormControlInput"
	                          placeholder=""
	                          aria-describedby="defaultFormControlHelp"
	                        />
                          </td>
                        </tr>
                        <tr>
                          <td>
                            <input class="form-check-input" type="checkbox" value="" id=""/>
                          </td>
                          <td>
                            <input
	                          type="text"
	                          class="form-control"
	                          id="defaultFormControlInput"
	                          placeholder=""
	                          aria-describedby="defaultFormControlHelp"
	                        />
                          </td>
                          <td>
                          	<div class="input-group">
	                        <span class="input-group-text">₩</span>
	                        <input
	                          type="text"
	                          class="form-control"
	                          placeholder=""
	                          aria-label="Amount (to the nearest dollar)"
	                        />
	                        <span class="input-group-text">.00</span>
	                      </div>
                          </td>
                          <td>
                            <input
	                          type="text"
	                          class="form-control"
	                          id="defaultFormControlInput"
	                          placeholder=""
	                          aria-describedby="defaultFormControlHelp"
	                        />
                          </td>
                        </tr>
                      </tbody>
                    </table>
                  </div>
                  
	              <div class="mt-2">
			          <button type="button" class="btn btn-primary me-2" onclick="newApproval()">신규</button>
			          <button type="reset" class="btn btn-outline-secondary">Cancel</button>
			        </div>
                </div>
              <!--/ Bordered Table -->
              
				
			</div>
			
		</div>
	</body>
</html>