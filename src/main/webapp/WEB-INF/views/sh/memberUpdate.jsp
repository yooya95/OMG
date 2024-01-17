<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript" src="js/jquery.js"></script>
<script>
//주소 API
function sample6_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr !== ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                document.getElementById("sample6_extraAddress").value = extraAddr;
            
            } else {
                document.getElementById("sample6_extraAddress").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('sample6_postcode').value = data.zonecode;
            document.getElementById("sample6_address").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("sample6_detailAddress").focus();
        }
    }).open();
};
</script>
<script type="text/javascript">
	function updateValidCheck(){
		var isValid = true;
		nameCheck();
		emailCheck();
		birthdayCheck();
		hiredateCheck();
		deptCheck();
		posiCheck();
		dutyCheck();
		passwordValid();
		
		// 폼 제출 여부 결정
	    if (!isValid) {
	    	alert("등록에 실패하였습니다.");
	        return false; // 유효성 검사에서 실패한 경우 폼 제출 중단
	    } else{
	    	// 유효성 검사 통과 시  폼 제출
	    	alert("등록에 성공하였습니다.");
	    	return true;
	    	}
	    
	  //이름 유효성검사
		function nameCheck(){
			var name = document.getElementById("mem_name").value;
			
			var koreanNameRegex = /^[가-힣]+$/;
			var englishNameRregex = /^[a-zA-Z]+$/;
			
			if(!koreanNameRegex.test(name)){
				if(!englishNameRregex.test(name)){
					formAccountSettings.name.value= "";
					isValid = false;
				}
			}
		}
		
		//이메일 유효성 검사
		function emailCheck(){
			var email1 = document.getElementById("mem_email1").value;
			var email2 = document.getElementById("mem_email2").value;
			var email = email1 + "@" + email2;
			
			var emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
			
			if(!emailRegex.test(email)){
				isValid = false;
			}
		}
		
		//입사일자 유효성 검사
		function hiredateCheck(){
			var hiredate = document.getElementById("mem_hiredate").value;;
			if(!hiredate || !hiredate.trim()){
				isValid = false;
			}
		}
		
		//생일 유효성 검사
		function birthdayCheck(){
			var birthday = document.getElementById("mem_bd").value;
			
			if(!birthday || !birthday.trim()){
				isValid = false;
			}
		}
		
		//부서 체크 유무
		function deptCheck(){
			var dept = 	document.getElementById("mem_dept_md").value;
			
			if(!dept || !dept.trim()){
				isValid = false;
			}
		}
		
		//직위 체크 유무
		function posiCheck(){
			var posi = 	document.getElementById("mem_posi_md").value;
			
			if(!posi || !posi.trim()){
				isValid = false;
			}
		}
		
		//직급 체크 유무
		function dutyCheck(){
			var duty = 	document.getElementById("mem_duty_md").value;
			
			if(!duty || !duty.trim()){
				isValid = false;
			}
		}
		
		function passwordValid(){
			var pw1 = document.getElementById("basic-default-password1").value;
			var pw2 = document.getElementById("basic-default-password2").value;
			var pwValid = true;
			var cnt = 0;
			var pwRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,20}$/;
			
			if(pw1 == pw2){
				//유효성 검사	
				if(!pwRegex.test(pw1)){
					pwValid = false;
				}
			} else {
				pwValid = false;
			}
			
			if(!pwValid){
				isValid = false;
			}
		}
	}
    
</script>
</head>
<%@ include file="../common/header.jsp" %>
<body>
<%@ include file="../common/menu.jsp" %>
<c:set var="member" value="${member }"></c:set>
	<h4 class="fw-bold py-3"><span class="text-muted fw-light">인사 /</span> 사원 상세</h4>
              <!-- Content -->
              <div class="row">
                <div class="col-md-12">
                  <div class="card mb-4">
                    <h5 class="card-header"><i class="bx bx-user me-1"></i> Account Detail</h5>
                    <form id="formAccountSettings" action="updateMember" method="post" enctype="multipart/form-data" onsubmit="return updateValidCheck();">
                    <input type="hidden" id="mem_status" name="mem_status" value="${member.mem_status }">
                    <!-- Account -->
                    <div class="card-body">
                      <div class="d-flex align-items-start align-items-sm-center gap-4">
                        <img id="imgView" class="d-block rounded" src="${pageContext.request.contextPath}/upload/sh/${member.mem_img }" style="height: 150px; width: 150px; display: none"/>
                        <div class="button-wrapper">
                          <label for="upload" class="btn btn-primary me-2 mb-4" tabindex="0">
                            <span class="d-none d-sm-block">Upload</span>
                            <i class="bx bx-upload d-block d-sm-none"></i>
                            <input type="file" id="upload" name="img1" class="account-file-input" aria-label="upload" accept="image/png, image/jpeg, image/jpg" hidden />
                            <input type="hidden" name="img2" value="image.jpg">
                          </label>
                          <button type="button" id="reset" class="btn btn-outline-secondary account-image-reset mb-4">
                            <i class="bx bx-reset d-block d-sm-none"></i>
                            <span class="d-none d-sm-block">Reset</span>
                          </button>
                         <div class="form-check col-mb-2">
                        	  <div class="form-check mt-3">
		                            <input
		                              class="form-check-input"
		                              type="radio"
		                              value="0"
		                              id="mem_right_employee"
		                              name="mem_right"
		                              <c:if test="${member.mem_right eq 0}">checked="checked"</c:if>
		                            />
		                            <label class="form-check-label" for="mem_right_employee"> 사원 권한</label>
		                      </div>
		                      <div class="form-check">
		                        <input
		                          class="form-check-input"
		                          type="radio"
		                          value="1"
		                          id="mem_right_manager"
		                          name="mem_right"
		                          <c:if test="${member.mem_right eq 1}">checked="checked"</c:if>
		                        />
		                        <label class="form-check-label" for="mem_right_manager"> 관리자 권한</label>
		                      </div>
                      	  </div>
                        </div>
                      </div>
                    </div>
                    <hr class="my-0" />
                    <div class="card-body">
                        <div class="row">
                          <!-- mem_id -->
                          <div class="mb-3 col-md-6">
                            <label for="mem_id" class="form-label">사원번호</label>
                            <input
                              class="form-control"
                              type="text"
                              id="mem_id"
                              name="mem_id"
                              value="${member.mem_id }"
                              readonly="readonly"
                              autofocus
                            />
                          </div>
                          
                          <!-- mem_hiredate -->
                          <div class="mb-3 col-md-6">
	                        <label for="mem_hiredate" class="col-md-2 col-form-label">입사 일자</label>
	                        <div class="col-md-10">
	                          <fmt:parseDate var="parsedDate" value="${member.mem_hiredate}" pattern="yyyy-MM-dd HH:mm:ss" />
							  <fmt:formatDate var="formattedDate" value="${parsedDate}" pattern="yyyy-MM-dd" />
	                          <input class="form-control" type="date" id="mem_hiredate" name="mem_hiredate" value="${formattedDate}"/>
	                        </div>
	                      </div>
                      	  
                      	  <!-- mem_name -->
                          <div class="mb-3 col-md-6">
                            <label for="mem_name" class="form-label">성명</label>
                            <input
                              class="form-control"
                              type="text"
                              id="mem_name"
                              name="mem_name"
                              value="${member.mem_name }"
                            />
                          </div>
                           
                           <!-- mem_leave -->
                           <div class="mb-3 col-md-6">
	                         <label for="mem_leave" class="col-md-2 col-form-label">휴직 일자</label>
	                         <div class="col-md-10">
	                           <input class="form-control" type="date" id="mem_leave" name="leave" value="${member.mem_leave}"/>
	                         </div>
	                       </div>
                      
                           <!-- mem_duty -->
		                  <div class="mb-3 col-md-6">
		                        <label for="mem_bd" class="form-label">생년월일</label>
		                       	<div class="input-group">
			              	     	<input
				                     type="text"
				                     class="form-control"
				                     id="mem_bd"
				                     name="mem_bd"
				                     placeholder="yyyyMMdd"
				                     aria-label="Recipient's username with two button addons"
				                     maxlength="8"
				                     min="19000101"
				                     value="${member.mem_bd }"
				                     pattern="\d*"
				                   />
				                <!-- mem_sex -->
				                <div class="col-md-3" style="margin: 5px 100px 0 50px;">
			                	    <input
			                         name="mem_sex"
			                         class="form-check-input"
			                         type="radio"
			                         value="M"
			                         id="mem_sex_m"
			                         <c:if test="${member.mem_sex eq 'M'}">checked="checked"</c:if>
			                        />남
			                       <input
			                         name="mem_sex"
			                         class="form-check-input"
			                         type="radio"
			                         value="F"
			                         id="mem_sex_f"
			                          <c:if test="${member.mem_sex eq 'F'}">checked="checked"</c:if>
			                       />여
		                        	</div>
				               </div>
				         </div>
                          <!-- mem_rein -->
                          <div class="mb-3 col-md-6">
	                        <label for="mem_rein" class="col-md-2 col-form-label">복직 일자</label>
	                        <div class="col-md-10">
	                          <input class="form-control" type="date" id="mem_rein" name="rein" value="${member.mem_rein}"/>
	                        </div>
                      	 </div>
                      
                         <!-- mem_email -->
                      <div class="mb-3 col-md-6" id="mem_email">
                        <label for="mem_email" class="form-label">이메일</label>
                        <span id="emailMsg"  aria-live="assertice" style="display: none; font-size: 10px;  margin-left: 10px; color: red; font-weight: bold; width: 140px;">유효한 이메일 주소를 입력해주세요.</span>
                        <div class="input-group">
                        	<c:set var="emailParts" value="${fn:split(member.mem_email, '@')}" />
	                        <input class="form-control" type="text" id="mem_email1" name="mem_email1" value="${emailParts[0]}"/>
	                            <span class="input-group-text">@</span>
	                            <input class="form-control" type="text" id="mem_email2" name="mem_email2" value="${emailParts[1]}"/>
	                            <select id="mem_email3" class="select2 form-select">
		                            <option value="" >직접입력</option>
		                            <option value="naver.com">네이버</option>
		                            <option value="gmail.com">지메일</option>
		                            <option value="daum.net">다음</option>
		                        	<option value="hotmail.com">핫메일</option>
		                        </select>
                            </div>
                       	</div>
                         
                         <!-- mem_resi -->
                         <div class="mb-3 col-md-6">
	                        <label for="mem_resi" class="col-md-2 col-form-label">퇴직 일자</label>
	                        <div class="col-md-10">
	                          <input class="form-control" type="date" id="mem_resi" name="resi" value="${member.mem_resi}"/>
	                        </div>
                      	 </div>
                      
                        <!-- mem_phone -->  
                     	<div class="mb-3 col-md-6">
                            <label class="form-label" for="mem_phone">전화번호</label>
                            <div class="input-group input-group-merge">
                              <span class="input-group-text">KR (+82)</span>
                              <input type="tel" id="mem_phone" name="mem_phone" class="form-control" placeholder="휴대폰 번호(-제외)" maxlength="11" value="${member.mem_phone }"/>
                        	</div>
                     	</div>
                          
                          <div class="mb-3 col-md-6" >
                            <label class="form-label" for="mem_dept">부서</label>
                            <div class="input-group">
	                            <select id="mem_dept" class="select2 form-select">
	                              <option value="">Select</option>
	                              <option value="100" <c:if test="${member.mem_dept_md eq 100}"> selected="selected"</c:if>>회계팀</option>
	                              <option value="101" <c:if test="${member.mem_dept_md eq 101}"> selected="selected"</c:if>>인사팀</option>
	                              <option value="102" <c:if test="${member.mem_dept_md eq 102}"> selected="selected"</c:if>>영업1팀</option>
	                              <option value="103" <c:if test="${member.mem_dept_md eq 103}"> selected="selected"</c:if>>영업2팀</option>
	                              <option value="104" <c:if test="${member.mem_dept_md eq 104}"> selected="selected"</c:if>>물류1팀</option>
	                              <option value="105" <c:if test="${member.mem_dept_md eq 105}"> selected="selected"</c:if>>물류2팀</option>
	                              <option value="106" <c:if test="${member.mem_dept_md eq 106}"> selected="selected"</c:if>>CS1팀</option>
	                              <option value="107" <c:if test="${member.mem_dept_md eq 107}"> selected="selected"</c:if>>CS2팀</option>
	                            </select>
                            <input type="text"class="form-control" id="mem_dept_md" name="mem_dept_md" aria-label="Text input with dropdown button" value="${member.mem_dept_md}" readonly="readonly"/>
	                          </div>
                          </div>
                          
                          <div class="mb-3 col-md-6">
                            <label class="form-label" for="memb_posi">직위</label>
                            <div class="input-group">
                            <select id="mem_posi"class="select2 form-select">
                              <option value="">Select</option>
                              <option value="100" <c:if test="${member.mem_posi_md eq 100}"> selected="selected"</c:if>>대표이사</option>
                              <option value="101" <c:if test="${member.mem_posi_md eq 101}"> selected="selected"</c:if>>상무</option>
                              <option value="102" <c:if test="${member.mem_posi_md eq 102}"> selected="selected"</c:if>>차장</option>
                              <option value="103" <c:if test="${member.mem_posi_md eq 103}"> selected="selected"</c:if>>과장</option>
                              <option value="104" <c:if test="${member.mem_posi_md eq 104}"> selected="selected"</c:if>>대리</option>
                              <option value="105" <c:if test="${member.mem_posi_md eq 105}"> selected="selected"</c:if>>사원</option>
                            </select>
                            <input type="text" class="form-control" id="mem_posi_md"  name="mem_posi_md" aria-label="Text input with dropdown button" value="${member.mem_posi_md}" readonly="readonly"/>
	                          </div>
                          </div>
                          
                          <div class="mb-3 col-md-6">
                            <label for="memb_duty" class="form-label">직책</label>
                            <div class="input-group">
                            <select id="mem_duty" class="select2 form-select">
                              <option value="">Select</option>
                              <option value="100" <c:if test="${member.mem_duty_md eq 100}"> selected="selected"</c:if>>CEO</option>
                              <option value="101" <c:if test="${member.mem_duty_md eq 101}"> selected="selected"</c:if>>CFO</option>
                              <option value="102" <c:if test="${member.mem_duty_md eq 102}"> selected="selected"</c:if>>본부장</option>
                              <option value="103" <c:if test="${member.mem_duty_md eq 103}"> selected="selected"</c:if>>실장</option>
                              <option value="104" <c:if test="${member.mem_duty_md eq 104}"> selected="selected"</c:if>>팀장</option>
                              <option value="105" <c:if test="${member.mem_duty_md eq 105}"> selected="selected"</c:if>>팀원</option>
                            </select>
                            	<input type="text" class="form-control" id="mem_duty_md" name="mem_duty_md" aria-label="Text input with dropdown button" value="${member.mem_duty_md}" readonly="readonly" />
	                      	</div>
                          </div>
                          
                          <!-- mem_address -->
                          <div class="mb-3 col-md-6">
                            <label for="exampleFormControlInput1" class="form-label">주소</label>
                            <div class="row">
                            <c:set var="addressParts" value="${fn:split(member.mem_address, '/')}" />
						        <div class="mb-2 col-md-4">
						            <input type="text" class="form-control" name="mem_mailcode" id="sample6_postcode" placeholder="우편번호" maxlength="6" value="${member.mem_mailcode }">
						        </div>
						        <div class="mb-1 col-md-2">
						            <input type="button" class="form-control" onclick="sample6_execDaumPostcode()" value="주소 검색">
						        </div>
						    </div>
	                        <div class="mb-2 col-md-8">
								<input type="text" class="form-control" name="mem_address1" id="sample6_address" value="${addressParts[0]}" placeholder="주소"><br>
							</div>
							<div class="mb-2 col-md-6">
								<input type="text" class="form-control" name="mem_address2" id="sample6_extraAddress"  value="${addressParts[1]}"  placeholder="참고항목"><br>
								<input type="text" class="form-control" name="mem_address3" id="sample6_detailAddress" value="${addressParts[2]}"  placeholder="상세주소">
							</div>
                          </div>
                          
                          
                           
                           <!-- mem_pw -->
                           <div class="mb-2 col-md-4">
	                          <div class="form-password-toggle">
	                        	<label class="form-label" for="basic-default-password1">비밀번호</label>
	                        	<span id="pswd1Msg" aria-live="assertive" style="font-size: 10px;   margin-left: 10px; color: red; font-weight: bold; width: 170px;"></span>
	                       		<div class="input-group">
	                       		<span class="ps_box int_pass"></span>
	                          	<input type="text"	class="form-control" name="mem_pw" id="basic-default-password1" maxlength="20"	aria-describedby="basic-default-password1" value="${member.mem_pw }"/>
		                          <span id="basic-default-password1" class="input-group-text cursor-pointer"
		                            ><i class="bx bx-hide"></i
		                          ></span>
	                       		</div>
	                       	  </div>
                       	 
	                        <div class="form-password-toggle">
	                        	<div style="display: flex; align-items: center;">
			                        <label class="form-label" for="basic-default-password2">비밀번호 재확인</label>
			                        <span id="pswd2Msg1"  aria-live="assertice" style="display: none; font-size: 10px;  margin-left: 10px; color: green; font-weight: bold; width: 140px;">비밀번호가 일치합니다.</span>
				                     <span id="pswd2Msg2"  aria-live="assertice" style="display: none; font-size: 10px;   margin-left: 10px; color: red; font-weight: bold; width: 170px;">비밀번호가 일치하지 않습니다.</span>
		                        </div>
		                        <div class="input-group">
		                        <span class="ps_box int_pass"></span>
		                          <input type="password" class="form-control" name="mem_pw_check" id="basic-default-password2" maxlength="20" aria-describedby="basic-default-password2" width="200px;"/>
		                          <span id="basic-default-password2" class="input-group-text cursor-pointer"
		                            ><i class="bx bx-hide"></i
		                          ></span>
		                        </div>
		                      </div>
	                      </div>
                        </div>
                        <div class="mt-2">
                          <button type="submit" class="btn btn-primary me-2" <c:if test="${mem_right != 1}">disabled="disabled"</c:if>>Update</button>
                          <button type="reset" class="btn btn-outline-secondary">Cancel</button>
                        </div>
                    </div>
                    <!-- /Account -->
                    </form>
                  </div>
                </div>
              </div>
            <!-- / Content -->
		
<%@ include file="../common/footer.jsp" %>
<script type="text/javascript">
	$(document).ready(function(){
	    var memLeave = $('#mem_leave').val();
	    var memResi  = $('#mem_resi').val();
	    var memRein	 = $('#mem_rein');
	    // mem_rein 값이 있을 경우에만 input 요소의 값을 설정
	    if (memLeave || memResi) {
	    	memRein.prop('readonly', false);
	    } else{
	    	memRein.prop('readonly', true);
	    }
	});

	//input type=file upload 함수
	$(document).ready(function(){
		$('#upload').on('change',function(e){
			var files = e.target.files;
			var reader = new FileReader();
			//파일을 읽으면 함수 호출
			reader.onload = function(e){
				$('#imgView').attr("src", e.target.result);
				$('#imgView').css("display","block");
			}
			//파일을 데이터 URL로 읽어오기
			reader.readAsDataURL(files[0]);
		});
	});
	
	$(document).ready(function(){
		$('#reset').on('click',function(e){
			$("#imgView").attr("src", "${pageContext.request.contextPath}/upload/sh/${member.mem_img}");
			$('#imgView').css("display","block");
		});
	});
	
	//이메일 도메인 유효성 검사 //create 버튼 클릭시 체크 할 메소드 추가 예정
	$(document).ready(function(){
		$('#mem_email2').on('change',function(){
			//이메일 값
			var email = $('#mem_email1').val() + '@' + $('#mem_email2').val();	
			//이메일 유효성 검사할 변수 생성
			var emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
			if(!emailRegex.test(email)){
				$('#pswd2Msg2').css('display','block');
			} else {
				$('#pswd2Msg2').css('display','none');
			}
		});
	});
	
	//이메일 주소 설정
	$(document).ready(function(){
		$('#mem_email3').on('change',function(){
			var selected = $(this).val();
			var email2 = $('#mem_email2');
			if(selected||selected!=""){
				$('#mem_email2').val(selected);
				email2.prop('readonly', true);
			}else{
				email2.prop('readonly', false);
			}
		});
	});
	
	//휴직 설정
	$(document).ready(function(){
		$('#mem_leave').on('change',function(){
			var selected = $(this).val();
			var rein = $('#mem_rein');
			var resi = $('#mem_resi');
			if(selected!=""){
				rein.prop('readonly', true);
				rein.val(null);
				resi.prop('readonly', true);
				resi.val(null);
			}else{
				rein.prop('readonly', false);
				resi.prop('readonly', false);
			}
		});
	});
	
	//복직 설정
	$(document).ready(function(){
		$('#mem_rein').on('change',function(){
			var selected = $(this).val();
			var leave = $('#mem_leave');
			var resi  = $('#mem_resi');
			if(selected!=""){
				leave.prop('readonly', true);
				leave.val(null);
				resi.prop('readonly', true);
				resi.val(null);
			}else{
				leave.prop('readonly', false);
				resi.prop('readonly', false);
			}
		});
	});
	
	//퇴사 설정
	$(document).ready(function(){
		$('#mem_resi').on('change',function(){
			var selected = $(this).val();
			var rein = $('#mem_rein');
			var leave = $('#mem_leave');
			if(selected!=""){
				rein.prop('readonly', true);
				rein.val(null);
				leave.prop('readonly', true);
				leave.val(null);
			}else{
				rein.prop('readonly', false);
				leave.prop('readonly', false);
			}
		});
	});
	
	//생년월일 input 숫자만 입력 가능하게 하는 함수
	$(document).ready(function(){
		$('#mem_bd').on('input',function(){
			//숫자 이외의 문자 제거
			var sanitizedValue = $(this).val().replace(/[^0-9]/g, '');
			$(this).val(sanitizedValue);
		});
	});
	
	//우편번호 input 숫자만 입력 가능하게 하는 함수
	$(document).ready(function(){
		$('#sample6_postcode').on('input',function(){
			//숫자 이외의 문자 제거
			var sanitizedValue = $(this).val().replace(/[^0-9]/g, '');
			$(this).val(sanitizedValue);
		});
	});
	
	//전화번호 input 숫자만 입력 가능하게 하는 함수
	$(document).ready(function(){
		$('#mem_phone').on('input',function(){
			var sanitizedValue = $(this).val().replace(/[^0-9]/g,'');
			$(this).val(sanitizedValue);
		});
	});
	
	//이름 input 한글만 입력 가능하게 하는 함수
	$(document).ready(function(){
		$('#mem_name').on('input',function(){
			var sanitizedValue = $(this).val().replace(/[^ㄱ-ㅎ가-힣ㅏ-ㅣ]/g,'');
			$(this).val(sanitizedValue);
		});
	});
	
	//option 선택마다 input 값 노출(부서)
	$(document).ready(function(){
		$('#mem_dept').on('change',function(){
			var selected = $(this).val();
			$('#mem_dept_md').val(selected);
			
		});
	});
	
	//option 선택마다 input 값 노출(직위)
	$(document).ready(function(){
		$('#mem_posi').on('change',function(){
			var selected = $(this).val();
			$('#mem_posi_md').val(selected);
		});
	});
	
	//option 선택마다 input 값 노출(직급)
	$(document).ready(function(){
		$('#mem_duty').on('change',function(){
			var selected = $(this).val();
			$('#mem_duty_md').val(selected);
		});
	});
	
	//비밀번호 1,2 입력 값 비교 후 input 문장 출력
	$(document).ready(function(){
		$('#basic-default-password2').on('change',function(){
			var pw1 = $('#basic-default-password1').val();
			var pw2 = $('#basic-default-password2').val();
			
			if(isNaN(pw1) || pw1 != null){
				if(pw1 == pw2){
					$('#pswd2Msg1').css('display','block');
					$('#pswd2Msg2').css('display','none');
				} else {
					$('#pswd2Msg1').css('display','none');
					$('#pswd2Msg2').css('display','block');
				}
			} else {
			return false;
			}			
		});
	});
	
	//비밀번호 1,2 입력 값 비교 후 input 문장 출력
	$(document).ready(function(){
		$('#basic-default-password1').on('input',function(){
			validatePassword();
		});
	});
	
	function validatePassword(){
		var pw1 = $('#basic-default-password1').val();
		var pw2 = $('#basic-default-password2').val();
		
		// 최소 길이 검사
	    if (pw1.length < 8) {
	        displayError("비밀번호가 8자리보다 적습니다");
	        return;
	    }
		
	 // 최소 조합 검사
	    var regex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]+$/;
	    if (!regex.test(pw1)) {
	        displayError("8~20자의 영대,소문자, 숫자, 특수기호를 사용하여 만들어주세요.");
	        return;
	    }
	 	
	 // 모든 검사를 통과하면 성공 메시지 표시
	    displayError("사용가능한 비밀번호 입니다.", false);
	 
	    if(isNaN(pw2)){
			if(pw1 == pw2){
				$('#pswd2Msg1').css('display','block');
				$('#pswd2Msg2').css('display','none');
			} else {
				$('#pswd2Msg1').css('display','none');
				$('#pswd2Msg2').css('display','block');
			}
		} else {
			$('#pswd2Msg1').css('display','none	');
			$('#pswd2Msg2').css('display','none');
		}			
	}

		function displayError(message, isError = true) {
		    var errorDiv = $("#pswd1Msg");
		    errorDiv.css("color", isError ? "red" : "green");
		    errorDiv.text(message);
		}
</script>
</body>
</html>