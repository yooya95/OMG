<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>OMG</title>
</head>
<script type="text/javascript"></script>
<style>
    .table-responsive {
        overflow-y: auto;
    }
</style>
<%@ include file="common/header.jsp" %>
<body>
<%@ include file="common/menu.jsp" %>

            <!-- Content -->
              <div class="row">
              	<!-- Welcome Card -->
                <div class="col-12 col-lg-8 order-0 order-md-0 order-lg-0 mb-4">
                  <div class="card">
                    <div class="d-flex align-items-end row" >
                      <div class="col-sm-7" style="max-height: 189px;">
                        <div class="card-body" style="margin-bottom: 12px;">
                          <h5 class="card-title text-primary"><a href="memberD?mem_id=${sessionScope.mem_id}"><span class="fw-bold"></span></a>님 환영합니다 🎉</h5>
                          <p class="mt-4"><strong></strong>
                          </p>
                        </div>
                      </div>
                      <div class="col-sm-5 text-center text-sm-left">
                        <div class="card-body pb-0 px-0 px-md-4">
                          <img
                            src="../assets/img/illustrations/man-with-laptop-light.png"
                            height="140"
                            alt="View Badge User"
                            data-app-dark-img="illustrations/man-with-laptop-dark.png"
                            data-app-light-img="illustrations/man-with-laptop-light.png"
                            style="margin-top: 25px;"
                          />
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <!--/ Welcome Card --> 
                <!-- Team List --> 
                <div class="col-12 col-lg-4 order-2 mb-4"> 
                  <div class="card"> 
                    <div class="table-responsive text-nowrap" style="max-height: 189px;"> 
	                  <table class="table"> 
	                    <thead class="fixed-header"> 
	                      <tr> 
	                      	<th></th>
	                        <th>이름</th> 
	                        <th>직위</th> 
	                        <th>직책</th> 
	                      </tr> 
	                    </thead> 
	                    <tbody class="table-border-bottom-0" id="teamTableBody"> 
	                    </tbody> 
	                  </table> 
	                </div> 
	              </div> 
                  </div>  
                </div>
                <!--/Team List -->
               
                <div class="row">
                	<!-- Total Revenue -->
	                <div class="col-12 col-lg-8 order-2 order-md-3 order-lg-2 mb-4">
	                  <div class="card">
	                    <div class="row row-bordered g-0">
	                      	<h5 class="card-header m-0 me-2 pb-3"><a href="/item/list" style="color: black;">재고현황</a></h5>
	                      	<!-- Small table -->
					        <div class="table-responsive text-nowrap" style="max-height: 395px;">
					            <table class="table table-sm">
					               	<thead class="fixed-thead">
					                   	<tr>
						         	       <th class='text-center'>제품코드</th>
						                   <th >제품명</th>
						                   <th class='text-center'>수량</th>
						                   <th class='text-center'>가격</th>
					                	</tr>
					                </thead>
					                <tbody class="table-border-bottom-0" id="invenTableBody">
					                </tbody>
					         	</table>
					      	</div>
					        <!--/ Small table -->
	                    </div>
	                  </div>
	                </div>
	                <!--/ Total Revenue -->
	                <!-- Notice --> 
	                <div class="col-12 col-lg-4 order-2 mb-4" id="notice"> 
	                   
	                </div>
	                <!--/ Notice -->
                </div>
                
			  
			  <div class="row">
				  <!-- Sales -->
				  <div class="col-12 col-lg-6 mb-4">
				    <div class="card">
				      <div class="card-body">
				        <div class="d-flex justify-content-between flex-sm-row flex-column align-items-start gap-3">
				          <div class="d-flex align-items-start">
				            <div class="avatar flex-shrink-0 mt-4">
				              <img src="../assets/img/icons/unicons/cc-primary.png" alt="Credit Card" class="rounded" />
				            </div>
				            <div class="card-title ms-3">
				              <span class="badge bg-label-warning rounded-pill" id="saleYear"></span>
				              <div class="d-flex align-items-start" style="margin-top: 10px; ">
				                <h5 class="text-nowrap mb-0" id="saleTitle"></h5>
				              </div>
				              
				            </div>
				          </div>
				          <div class="mt-4">
				          	<div class="mt-sm-auto">
				              <small id="saleCrease"></small>
				            </div>
				          	<h3 class="mb-2" id="monthSale"></h3>
				          </div>
				        </div>
				      </div>
				    </div>
				  </div>
				  <!--/Sales -->
				  <!-- Purchase -->
				  <div class="col-12 col-lg-6 order-3 order-md-2">
				    <div class="card">
				      <div class="card-body">
				        <div class="d-flex justify-content-between flex-sm-row flex-column align-items-start gap-3">
				          <div class="d-flex align-items-start">
				            <div class="avatar flex-shrink-0 mt-4">
				              <img src="../assets/img/icons/unicons/wallet-info.png" alt="Credit Card" class="rounded" />
				            </div>
				            <div class="card-title ms-3">
				              <span class="badge bg-label-warning rounded-pill" id="purchaseYear"></span>
				              <div class="d-flex align-items-start" style="margin-top: 10px; margin-bottom: 10px;">
				                <h5 class="text-nowrap mb-0" id="purchaseTitle"></h5>
				              </div>
				            </div>
				          </div>
				          <div class="mt-4">
				          	<div class="mt-sm-auto">
				              <small id="purCrease"></small>
				            </div>
				          	<h3 class="mb-2" id="monthPurchase"></h3>
				          </div>
				        </div>
				      </div>
				    </div>
				  </div>
				</div>
				<!--/Purchase -->
            <!--/ Content -->

<%@ include file="common/footer.jsp" %>    
<script type="text/javascript">
	
	$(document).ready(function(){
		memberInfo();
		teamList();
		//공지사항 메소드
		showNotice(); 	
		invenList();
		monthPurchase();
		monthSale();
		//매출매입 div 날짜 정보 받는 함수
		thisDate();
		
		// 스크롤 고정 thaed
   	    $(".table-responsive").on('scroll', { passive: true }, function () {
   	        var scrollLeft = $(this).scrollLeft();
   	        $(".fixed-thead").css("left", -scrollLeft);
     	});
		
	});
	
	//개인 정보 출력
	function memberInfo(){
		var memId = ${sessionScope.mem_id}
		
		$.ajax({
			url:"mainMember",
			data : {memId : memId},
			dataType : "json",
			type : "POST",
			success : function(member){
				updateProfileCard(member);
			},
			//에러 메시지 출력
			error:function(request, status, error){
				console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
	}
	
	//팀원리스트
	function teamList(){
		var memId = ${sessionScope.mem_id}
		$.ajax({
			url:"mainTeamList",
			data : {memId : memId},
			dataType : "json",
			type : "POST",
			success : function(response){
				var teamList = response.teamMember;
				$("#teamTableBody").empty();
				for (var i = 0; i < teamList.length; i++) {
	                   var team = teamList[i];
	                   console.log(team.mem_posi_md);
	                   $("#teamTableBody").append(
	                       "<tr>" +
	                       "<td> <img id='imgView' src='${pageContext.request.contextPath}/upload/sh/" +  team.mem_img + "' style='height: 30px; width: 30px;'></td>" +
	                       "<td>" + team.mem_name + "</td>" +
	                       "<td>" + positionMd(team.mem_posi_md) + "</td>" +
	                       "<td>" + dutyMd(team.mem_duty_md) + "</td>" +
	                       "</tr>"
	                   );
	               }
			},
			//에러 메시지 출력
			error:function(request, status, error){
				console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
	}
	
	//재고리스트
	function invenList(){
		$.ajax({
			url:"mainInventory",
			dataType : "json",
			type : "POST",
			success : function(response){
				var wareList = response.warehouseList;
				$('#invenTableBody').empty();
				for(var i = 0; i < wareList.length; i++){
					var ware = wareList[i];
					var price = ware.price.toLocaleString();
					$('#invenTableBody').append(
							"<tr>"+
							"<td class='text-center'>" + ware.code + "</td>" +
							"<td>" + ware.name + "</td>" +
							"<td class='text-center'>" + ware.cnt + "</td>" +
							"<td class='text-center'>" + price + "</td>" +
							"</tr>"
					);
				}
			},
			error:function(request, status, error){
				console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
			}
		});
	}
	
	// 공지사항 출력 
	function showNotice() { 
		$.ajax({ 
			url: "/main/mainNotice", 
			dataType: "html", 
			success: function(data) { 
				$("#notice").html(data); 
			} 
		}) 
	}
	
	//인화면 매입 div 출력
	function monthPurchase(){
		var purchase = document.getElementById("monthPurchase");
		$.ajax({
			url:"thisMonthPurchase",
			dataType : "json",
			//async - "true" : 비동기화, "false" : "동기화"
			async : true,
			type : "POST",
			success : function(response){
					var thisMonthPurchase = response.thisMonthPurchase;
					var purCrease = response.purchaseCrease;
					//이번달 매입 총 금액
					// 서버에서 받은 데이터를 원화 형식으로 변환하여 업데이트
					var thisMonthPurchaseAmount = formatCurrency(thisMonthPurchase);
					purchase.innerText = thisMonthPurchaseAmount;
					
					//매입 증감률 출력
					if(purCrease >= 0) {
						$('#purCrease').append("<i class='bx bx-chevron-up'></i>+"+purCrease+"%");
						$('#purCrease').addClass('text-success text-nowrap fw-semibold');
					} else{
						$('#purCrease').append("<i class='bx bx-down-arrow-alt'></i>"+purCrease+"%");	
						$('#purCrease').addClass('text-danger fw-semibold');
					}
					
			},
			error : function(request, status, error){
  			console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
	      }
		});
	}
	
	//메인화면 매출 div 출력
	function monthSale(){
		var sale = document.getElementById("monthSale");
		$.ajax({
			url:"thisMonthSale",
			type : 'POST',
			async : true,
			dataType : "json",
			success : function(response){
				//이번달 매출 총 금액
				var thisMonthSale = response.thisMonthSale;
				var saleCrease = response.saleCrease;
				//이번달 총매출
				var thisMonthSaleAmount = formatCurrency(thisMonthSale);
				sale.innerText = thisMonthSaleAmount;
				//매출 증감률 출력
				if(saleCrease >= 0) {
					$('#saleCrease').append("<i class='bx bx-chevron-up'></i>+"+saleCrease+"%");
					$('#saleCrease').addClass('text-success text-nowrap fw-semibold');
				} else{
					$('#saleCrease').append("<i class='bx bx-down-arrow-alt'></i>"+saleCrease+"%");	
					$('#saleCrease').addClass('text-danger fw-semibold');
				}
		},
		//에러 메시지 출력
		error:function(request, status, error){
			console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
		}
		});
	}
	
	function updateProfileCard(member){
			$(".card-body h5 .fw-bold").text(member.mem_name + " " + positionMd(member.mem_posi_md));
			$(".card-body p strong").html("사원번호: " + member.mem_id + "<br>&nbsp;&nbsp;&nbsp;&nbsp;부서" + "&nbsp;&nbsp;&nbsp;:&nbsp;" + deptMd(member.mem_dept_md));
	}
	
	//aJax 서포트 함수 
	
	//숫자를 원화 형식으로 변환하는 함수
	function formatCurrency(amount) {
		return new Intl.NumberFormat('ko-KR', { style: 'currency', currency: 'KRW' }).format(amount);
		};

	function deptMd(memDeptMd){ 
		if(memDeptMd === 100){ 
			return "회계팀"; 
	    } else if (memDeptMd === 101) { 
	        return "인사팀"; 
	    } else if (memDeptMd === 102) { 
	        return "영업1팀"; 
	    } else if (memDeptMd === 103) { 
	        return "영업2팀"; 
	    } else if (memDeptMd === 104) { 
	        return "물류1팀"; 
	    } else if (memDeptMd === 105) { 
	        return "물류2팀"; 
	    } else if (memDeptMd === 106) { 
	        return "CS1팀"; 
	    } else if (memDeptMd === 107) { 
	        return "CS2팀"; 
	    } else if (memDeptMd === 999) { 
	        return "관리자"; 
	    } else { 
	        return ""; // 다른 처리가 필요할 경우 추가 
	    } 
	};	 
		 
	function positionMd(teamPosiMd){ 
		 if (teamPosiMd === 100) { 
		        return "대표이사"; 
		    } else if (teamPosiMd === 101) { 
		        return "상무"; 
		    } else if (teamPosiMd === 102) { 
		        return "차장"; 
		    } else if (teamPosiMd === 103) { 
		        return "과장"; 
		    } else if (teamPosiMd === 104) { 
		        return "팀장"; 
		    } else if (teamPosiMd === 105) { 
		        return "팀원"; 
		    } else { 
		        return ""; 
		    } 
	}; 
	 
	function dutyMd(teamDutyMd){ 
		 if (teamDutyMd === 100) { 
		        return "CEO"; 
		    } else if (teamDutyMd === 101) { 
		        return "CFO"; 
		    } else if (teamDutyMd === 102) { 
		        return "본부장"; 
		    } else if (teamDutyMd === 103) { 
		        return "실장"; 
		    } else if (teamDutyMd === 104) { 
		        return "팀장"; 
		    } else if (teamDutyMd === 105) { 
		        return "팀원"; 
		    } else { 
		        return ""; 
		    } 
	}; 
	
	function thisDate(){
		var currentDate = new Date();
		
		var year = currentDate.getFullYear();
		var thisYear = "YEAR " +year 
		
		var month = currentDate.getMonth() + 1;
		
		$('#purchaseTitle').append("<a href='/inventoryList' style='color: black;'>" + month + "월 매입</a>");
		$('#saleTitle').append("<a href='/inventoryList' style='color: black;'>" +  month + "월 매출</a>");
		$('#saleYear').text(thisYear);
		$('#purchaseYear').text(thisYear);
		
	}
	


</script>    
</body>
</html>    