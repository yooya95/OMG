<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>전자결재</title>
		<style type="text/css">
		
			td {
				height: 50px;
			}
		
			.lined-div {
				border: 1px solid #d9dee3;
				padding: 10px;
			}
		
		</style>
	</head>
	<%@ include file="../common/header.jsp" %>
	<body>
		<div class="layout-wrapper layout-content-navbar  ">
	
			<div class="content-wrapper">
			
				<div class="container-xxl flex-grow-1 container-p-y">
				
			
					<!-- Bordered Table -->
			        <div class="card mb-4">
			          <h5 class="card-header text-center">김영희 법인카드 사용지출결의서입니다</h5>
			          
			          	<div class="card-body">
			          
				          	<table class="table table-bordered" style="width:100px; margin-left: auto; margin-right: 0;" >
				          		<tbody>
				          			<tr style="break-inside: auto;">
				          				<th rowspan="4">
				          					결
				          					<br>
				          					재
				          				</th>
				          				<th class="text-center">기안자</th>
				          				<th class="text-center">팀장</th>
				          			</tr>
			          				<tr style="break-inside: auto;">
			          					<td>
		          							<img src="img/bk/stamp.gif" alt="stamp">
			          					</td>
			          					<td>&nbsp;</td>
			          				</tr>
			          				<tr style="break-inside: auto;">
			          					<td>2023/12/01</td>
			          					<td></td>
			          				</tr>
				          		</tbody>
				          	</table>
			          	
			          	</div>
			          	
			          
			          <div class="card-body">
			          	<div class="lined-div">
				            <div class="table-responsive text-nowrap">
				            
				            
				            	<h3 class="card-header text-center">지출결의서</h3>
					              <table class="table table-bordered">
					                <tbody>
					                	<tr>
					                		<th>성명</th>
					                		<td>김영희</td>
					                		<th>부서</th>
					                		<td>인사팀</td>
					                		<th>직책</th>
					                		<td>팀원</td>
					                	</tr>
					                	<tr>
					                		<th>지출금액</th>
					                		<td colspan="5" class="text-center">168,000 원</td>
					                	</tr>
					                	<tr>
					                		<th rowspan="10">내역</th>
					                		<th colspan="2">사용처</th>
					                		<th>금액</th>
					                		<th colspan="2">비고</th>
					                	</tr>
					                	<tr>
					                		<td colspan="2">스타벅스</td>
					                		<td>8,000</td>
					                		<td colspan="2">고객사미팅 접대비</td>
					                	</tr>
					                	<tr>
					                		<td colspan="2">SK주유소</td>
					                		<td>8,000</td>
					                		<td colspan="2">주유비</td>
					                	</tr>
					                	<tr>
					                		<td colspan="2">을지인쇄</td>
					                		<td>8,000</td>
					                		<td colspan="2">제안서 500부 인쇄</td>
					                	</tr>
					                	<tr>
					                		<td colspan="2"></td>
					                		<td></td>
					                		<td colspan="2"></td>
					                	</tr>
					                	<tr>
					                		<td colspan="2"></td>
					                		<td></td>
					                		<td colspan="2"></td>
					                	</tr>
					                	<tr>
					                		<td colspan="2"></td>
					                		<td></td>
					                		<td colspan="2"></td>
					                	</tr>
					                	<tr>
					                		<td colspan="2"></td>
					                		<td></td>
					                		<td colspan="2"></td>
					                	</tr>
					                	<tr>
					                		<td colspan="2"></td>
					                		<td></td>
					                		<td colspan="2"></td>
					                	</tr>
					                	<tr>
					                		<td colspan="2"></td>
					                		<td></td>
					                		<td colspan="2"></td>
					                	</tr>
					                	<tr>
					                		<td colspan="6" rowspan="3" style="vertical-align: middle; text-align: center; height: 150px;">
					                			
					                			<p>
		                                           <span>2023년 12월 25일</span>
		                                        </p>
					                		</td>
					                	</tr>
					                </tbody>
					              </table>
				            </div>
			            </div>
			          </div>
			        </div>
			        <!--/ Bordered Table -->
		        
		        
				<div class="mt-2">
		          <button type="button" class="btn btn-primary me-2" onclick="newApproval()">신규</button>
		          <button type="reset" class="btn btn-outline-secondary">Cancel</button>
		        </div>
		        
		        </div>
	        
	        </div>
        
        </div>
        
	</body>
</html>