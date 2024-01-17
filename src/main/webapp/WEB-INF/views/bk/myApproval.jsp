<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>My Approval</title>
	</head>
	
	<script type="text/javascript">
	
		// 결재 보기 팝업창 띄우는 함수
		function viewApproval() {
			
			// 팝업 url 정의
			var popupURL = 'viewApproval';
			
			// 팝업 창 크기 설정
			var popupWidth = 800;
			var popupHeight = 800;
			
			// 화면 중앙에 위치할 좌표 계산
			var left = (window.innerWidth - popupWidth) / 2 + window.screenX;
			var top = (window.innerHeight - popupHeight) / 2 + window.screenY;
			
			// 팝업 창 열기
			window.open(popupURL, 'Popup', 'width=' + popupWidth + ', height=' + popupHeight +', left=' + left +', top=' + top);
		}
		
		
		// 결재 신규 팝업창을 띄우는 함수
		function newApproval() {
			
			// 팝업 url 정의
			var popupURL = 'newApproval';
			
			// 팝업 창 크기 설정
			var popupWidth = 800;
			var popupHeight = 800;
			
			// 화면 중앙에 위치할 좌표 계산
			var left = (window.innerWidth - popupWidth) / 2 + window.screenX;
			var top = (window.innerHeight - popupHeight) / 2 + window.screenY;
			
			// 팝업 창 열기
			window.open(popupURL, 'Popup', 'width=' + popupWidth + ', height=' + popupHeight +', left=' + left +', top=' + top);
			
		}
		
		
		// 결재 수정 팝업
		function editApproval() {
			
			// 팝업 url 정의
			var popupURL = 'editApproval';
			
			// 팝업 창 크기 설정
			var popupWidth = 800;
			var popupHeight = 800;
			
			// 화면 중앙에 위치할 좌표 계산
			var left = (window.innerWidth - popupWidth) / 2 + window.screenX;
			var top = (window.innerHeight - popupHeight) / 2 + window.screenY;
			
			// 팝업 창 열기
			window.open(popupURL, 'Popup', 'width=' + popupWidth + ', height=' + popupHeight +', left=' + left +', top=' + top);
			
		}
		
		
	</script>
	
	<%@ include file="../common/header.jsp" %>
	<body>
	<%@ include file="../common/menu.jsp" %>
		
		<!-- Content wrapper -->
		<div class="content-wrapper">
		
			<!-- Content -->
			<div class="container-xxl flex-grow-1 container-p-y">
			
				<h4 class="fw-bold py-3 mb-4">내결재관리</h4>
			
				<div class="row">
				
				<div class="col-md-12">
					
					<ul class="nav nav-pills flex-column flex-md-row mb-3">
	                    <li class="nav-item">
	                      <a class="nav-link active" href="javascript:void(0);"><i class="bx bx-user me-1"></i> Account</a>
	                    </li>
	                    <li class="nav-item">
	                      <a class="nav-link" href="pages-account-settings-notifications.html"
	                        ><i class="bx bx-bell me-1"></i> Notifications</a
	                      >
	                    </li>
	                    <li class="nav-item">
	                      <a class="nav-link" href="pages-account-settings-connections.html"
	                        ><i class="bx bx-link-alt me-1"></i> Connections</a
	                      >
	                    </li>
	                  </ul>
	                  
	                  <div class="card mb-4">
	                  
	                  
	                  <!-- Bordered Table -->
		              <div class="card">
		                <h5 class="card-header">Bordered Table</h5>
		                <div class="card-body">
		                  <div class="table-responsive text-nowrap">
		                    <table class="table table-bordered">
		                      <thead>
		                        <tr>
		                          <th>
		                          	<input class="form-check-input" type="checkbox" value="" />
		                          </th>
		                          <th>기안일자</th>
		                          <th>제목</th>
		                          <th>기안자</th>
		                          <th>결재자</th>
		                          <th>진행상태</th>
		                          <th>결재</th>
		                        </tr>
		                      </thead>
		                      <tbody>
		                      	<tr>
		                          <td>
		                          	<input class="form-check-input" type="checkbox" value="" />
		                          </td>
		                          <td onclick="editApproval()">2023/12/15-1</td>
		                          <td>김영희 법인카드 사용지출결의서입니다</td>
		                          <td>김영희</td>
		                          <td>이철수</td>
		                          <td>진행중</td>
		                          <td onclick="viewApproval()">보기</td>
		                        </tr>
		                      	<tr>
		                          <td>
		                          	<input class="form-check-input" type="checkbox" value="" />
		                          </td>
		                          <td onclick="editApproval()">2023/12/15-1</td>
		                          <td>김영희 법인카드 사용지출결의서입니다</td>
		                          <td>김영희</td>
		                          <td>이철수</td>
		                          <td>진행중</td>
		                          <td onclick="viewApproval()">보기</td>
		                        </tr>
		                      	<tr>
		                          <td>
		                          	<input class="form-check-input" type="checkbox" value="" />
		                          </td>
		                          <td onclick="editApproval()">2023/12/15-1</td>
		                          <td>김영희 법인카드 사용지출결의서입니다</td>
		                          <td>김영희</td>
		                          <td>이철수</td>
		                          <td>진행중</td>
		                          <td onclick="viewApproval()">보기</td>
		                        </tr>
		                      	<tr>
		                          <td>
		                          	<input class="form-check-input" type="checkbox" value="" />
		                          </td>
		                          <td onclick="editApproval()">2023/12/15-1</td>
		                          <td>김영희 법인카드 사용지출결의서입니다</td>
		                          <td>김영희</td>
		                          <td>이철수</td>
		                          <td>진행중</td>
		                          <td onclick="viewApproval()">보기</td>
		                        </tr>
		                      </tbody>
		                    </table>
		                    
		                    <div class="mt-2">
	                          <button type="button" class="btn btn-primary me-2" onclick="newApproval()">신규</button>
	                          <button type="reset" class="btn btn-outline-secondary">Cancel</button>
	                        </div>
                        
		                  </div>
		                </div>
		              </div>
		              <!--/ Bordered Table -->
				
					
					
					</div>
				
				</div>
				
				</div>
			
			</div>
		
		</div>
	
	</body>
</html>