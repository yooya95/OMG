<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<!-- =========================================================
* Sneat - Bootstrap 5 HTML Admin Template - Pro | v1.0.0
==============================================================

* Product Page: https://themeselection.com/products/sneat-bootstrap-html-admin-template/
* Created by: ThemeSelection
* License: You must have a valid license purchased in order to legally use the theme for your project.
* Copyright ThemeSelection (https://themeselection.com)

=========================================================
 -->
<!-- beautify ignore:start -->
<html
  lang="en"
  class="light-style customizer-hide"
  dir="ltr"
  data-theme="theme-default"
  data-assets-path="../assets/"
  data-template="vertical-menu-template-free"
>
  <head>
    <meta charset="utf-8" />
    <meta
      name="viewport"
      content="width=device-width, initial-scale=1.0, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0"
    />

    <title>Forgot Password Basic - Pages | Sneat - Bootstrap 5 HTML Admin Template - Pro</title>

    <meta name="description" content="" />

    <!-- Favicon -->
    <link rel="icon" type="image/x-icon" href="../assets/img/favicon/favicon.ico" />

    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">

    <!-- Icons. Uncomment required icon fonts -->
    <link rel="stylesheet" href="../assets/vendor/fonts/boxicons.css" />

    <!-- Core CSS -->
    <link rel="stylesheet" href="../assets/vendor/css/core.css" class="template-customizer-core-css" />
    <link rel="stylesheet" href="../assets/vendor/css/theme-default.css" class="template-customizer-theme-css" />
    <link rel="stylesheet" href="../assets/css/demo.css" />

    <!-- Vendors CSS -->
    <link rel="stylesheet" href="../assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.css" />

    <!-- Page CSS -->
    <!-- Page -->
    <link rel="stylesheet" href="../assets/vendor/css/pages/page-auth.css" />
    <!-- Helpers -->
    <script src="../assets/vendor/js/helpers.js"></script>

    <!--! Template customizer & Theme config files MUST be included after core stylesheets and helpers.js in the <head> section -->
    <!--? Config:  Mandatory theme config file contain global vars & default theme options, Set your preferred theme option in this file.  -->
    <script src="../assets/js/config.js"></script>
    <style>
  	body {
		font-family: 'Noto Sans KR', sans-serif;
	}
  </style>
  	<script type="text/javascript">
  	
  	
  	
  		function sendCode() {
  			
  			var mem_name	=	$('#name').val();
  			var mem_email	=	$('#email').val();
  			
  			//var number		= 	$('#number').val();
  			
  			
  			/* var formData = {
				  name	:	$('#name').val()
  				 ,number:	$('#number').val()
  			}; */
  			
  			// alert("이름: " 		+ mem_name 
  			// 	+ "\n이메일: "	+ mem_email
  			// 		); 
  			
  			// 로딩 인디케이터 표시
  			showLoader();
  			
  			$.ajax({
               type	:   'POST'
              ,url	:   '/sendCode'
              // ,data	:	{  mem_name	: mem_name
            	  		//,  number	: number
            	  		//}
              ,contentType: 'application/json;charset=UTF-8' 
  			  ,dataType	:	'json'
  			  ,async    :   false	// 메일 보내는데 시간이 걸리기 때문에 동기로 바꿈
  			  // dataType 이란, 서버로부터 받아올 응답 데이터의 타입
  			  // 서버로 데이터를 전송할 때는 영향 X
              ,data	:	JSON.stringify({
            	   	//	키	:		값
            	    mem_name:	mem_name
            	   ,mem_email:	mem_email
            	   //formData
            	   })
              ,success:	function (response) {
            	  
            	  
            	  //console.log(response);
            	  console.log('Ajax 요청이 완료되었습니다...');
            	  
            	  
            	  if (response.status === 'success') {
            		  console.log('Ajax 요청이 완료되었습니다.');
	            	  // 회원 정보가 일치하는 경우
	            	  alert("인증번호가 전송되었습니다.");
	            	  
            	  } else if (response.status === 'error') {
            		  
            		  // 일치하지 않는 경우
            		  alert("이름과 전화번호가 일치하지 않습니다.");
            	  }
              },
              error: function () {
            	  alert("비밀번호 찾기 에러");
              },
              complete: function() {
            	  // 로딩 인디케이터 숨김 처리
            	  hideLoader();
              }
              
              });
  			
  		}
  		
  		
  		function showLoader() {
  			// 로딩 인디케이터를 보이게 하는 로직을 구현
  			$('#loading-spinner').show();
  		}
  		
  		function hideLoader() {
  			// 로딩 인디케이터를 숨기는 로직을 구현
  			$('#loading-spinner').hide();
  		}
  	
  	
  	
  	</script>
  </head>
  

  <body>
    <!-- Content -->

    <div class="container-xxl">
      <div class="authentication-wrapper authentication-basic container-p-y"">
        <div class="authentication-inner py-4">
          <!-- Forgot Password -->
          <div class="card mx-auto" style="width: 430px;">
            <div class="card-body">
              <!-- Logo -->
              <div class="app-brand justify-content-center">
                <a href="index.html" class="app-brand-link gap-2">
                  <span class="app-brand-logo demo">
                    <img src="assets/img/logo2.png" alt="logo">
                  </span>
                </a>
              </div>
              <!-- /Logo -->
              <h4 class="mb-2">비밀번호 찾기</h4>
              <p class="mb-4">입력한 성명과 ID에 등록되어 있는 복구Email이 일치할 경우, <br>임시 비밀번호가 발송됩니다.</p>
              <form id="formAuthentication" class="mb-3" method="POST">
              	<div class="row">
	                <div class="mb-3">
	                  <label for="name" class="form-label">성명</label>
	                  <input
	                    type="text"
	                    class="form-control"
	                    id="name"
	                    name="name"
	                    placeholder=""
	                    autofocus
	                  />
	                </div>
	                <div class="mb-3">
	                  <label for="email" class="form-label">복구 Email</label>
	                  <input
	                    type="text"
	                    class="form-control"
	                    id="email"
	                    name="email"
	                    placeholder=""
	                    autofocus
	                  />
	                </div>
                </div>
                <div class="mb-3">
                	<button class="btn btn-primary d-flex align-items-center justify-content-center w-100" onclick="sendCode()">
                		<span class="mrgin-right: 8px;">임시 비밀번호 발송</span>
                		<!-- <div class="spinner-border spinner-border-sm text-secondary" role="status">
                          <span id="loading-spinner" class="visually-hidden">Loading...</span>
                        </div> -->
                	</button>
                </div>
              </form>
              <div class="text-center">
                <a href="/logIn" class="d-flex align-items-center justify-content-center">
                  <i class="bx bx-chevron-left scaleX-n1-rtl bx-sm"></i>
                 	돌아가기
                </a>
              </div>
            </div>
          </div>
          <!-- /Forgot Password -->
        </div>
      </div>
    </div>

    <!-- / Content -->



    <!-- Core JS -->
    <!-- build:js assets/vendor/js/core.js -->
    <script src="../assets/vendor/libs/jquery/jquery.js"></script>
    <script src="../assets/vendor/libs/popper/popper.js"></script>
    <script src="../assets/vendor/js/bootstrap.js"></script>
    <script src="../assets/vendor/libs/perfect-scrollbar/perfect-scrollbar.js"></script>

    <script src="../assets/vendor/js/menu.js"></script>
    <!-- endbuild -->

    <!-- Vendors JS -->

    <!-- Main JS -->
    <script src="../assets/js/main.js"></script>

    <!-- Page JS -->

    <!-- Place this tag in your head or just before your close body tag. -->
    <script async defer src="https://buttons.github.io/buttons.js"></script>
  </body>
</html>
