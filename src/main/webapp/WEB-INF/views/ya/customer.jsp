<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>    


<!DOCTYPE html>
<html>
<head>
<style type="text/css">
 	   .fixed-thead {
            position: sticky;
            top: 0;
            background-color: #f8f9fa;
            z-index: 1;
             white-space: nowrap;
        }
</style>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<meta charset="UTF-8">
<title>거래처관리</title>
<%@ include file="/WEB-INF/views/common/menu.jsp"%>    
</head>
<body>
<div class="container">
<div class="col-lg-12">
<div class="card">
     <h5 class="card-header" >거래처조회</h5>
     		<div class="text-end mx-5" >
     		<p class="demo-inline-spacing">
                  <button class="btn btn-sm btn-primary me-1" type="button"  data-bs-toggle="collapse"
                  data-bs-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample">거래처등록 </button>
           </p>
           </div>
<!----------------------------------거래처 등록 -------------------------------------------------------------->           
<div class="collapse" id="collapseExample">
   <div class="row  mx-5">
        <!-- 첫 번째 열 -->
        <div class="col-md-6">
            <form>
                <div class="row mb-3">
                    <label class="col-sm-2 col-form-label" for="company">상호명</label>
                    <div class="col-sm-10">
                         <input type="text" class="form-control" id="in_company"/>
                    </div>
                </div>
                <div class="row mb-3">
                    <label class="col-sm-2 col-form-label" for="busiNum">사업자번호 </label>
                    <div class="col-sm-10">
                       <input type="text" class="form-control" id="in_busiNum"/>
                    </div>
                </div>                         
				<div class="row mb-3">
					<label class="col-sm-2 col-form-label" for="custStyle">유형</label>
					<div class="col-sm-10">
						<select class="form-select" id="in_custStyle">
						    <option value="0">매입</option>
						    <option value="1">매출</option>
						</select>
						    </div>
				</div>
				<div class="row mb-3">
					<label class="col-sm-2 col-form-label" for="cust_md">구분</label>
					<div class="col-sm-10">
						<select class="form-select" id="in_cust_md">
						     <option value="101">매입처</option>
						     <option value="102">매출처</option>
						</select>
					</div>
				</div>  
                <div class="row mb-3">
                    <label class="col-sm-2 col-form-label" for="ceo">대표자</label>
                    <div class="col-sm-10">
                         <input type="text" class="form-control" id="in_ceo"/>
                    </div>
               </div>        
              </form>
        </div>
        <!-- 두 번째 열 -->
        <div class="col-md-6">
            <form>
             <div class="row mb-3">
                  <label class="col-sm-2 col-form-label" for="busiType">업태</label>
                  <div class="col-sm-10">
                      <input type="text" class="form-control" id="in_busiType"/>
                   </div>
            </div>  
            <div class="row mb-3">
                 <label class="col-sm-2 col-form-label" for="busiItems">종목</label>
                 <div class="col-sm-10">
                      <input type="text" class="form-control" id="in_busiItems"/>
                  </div>
            </div>  
            <div class="row mb-3">
                 <label class="col-sm-2 col-form-label" for="tel">전화번호</label>
                 <div class="col-sm-10">
                       <input type="text" class="form-control" id="in_tel"/>
                </div>
            </div>  
            <div class="row mb-3">
                 <label class="col-sm-2 col-form-label" for="email">이메일</label>
                 <div class="col-sm-10">
                      <input type="text" class="form-control" id="in_email"/>
                 </div>                                                                                                                                                                                     
            </div>
            <div class="row mb-3">
                 <label class="col-sm-2 col-form-label" for="mem_id">담당직원</label>
                 <div class="col-sm-10">
                 	<select class="form-select" id="in_mem_id"></select>
                 </div>                                                                                                                                                                                     
            </div>                                              
            </form>
        </div>
        <div class="text-end mx-3" >
        <p class="demo-inline-spacing">
        <button class="btn btn-sm  btn-primary btn-show-insert" type="button" data-bs-toggle="" data-bs-target="l"
               data-custcode="${customer.custcode}">등록 </button>
        </p>
       </div>               			
    </div>
</div>


<script type="text/javascript">
$(document).ready(function () {
    // 사원리스트
    $.ajax({
        url: '/memberList',
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify({
            mem_id: $('#mem_id').val(),
        }),
        success: function (response) {
        	 console.log('Response:', response);
            var memberList = response.memberList;
            for (var i = 0; i < memberList.length; i++) {
                $('#in_mem_id').append('<option value="' + memberList[i].mem_id + '">' + memberList[i].mem_id +
                    '  ' + memberList[i].mem_name + ' [' + memberList[i].com_cn + ']</option>');
            }
        },
        error: function () {
            console.error('서버 오류');
        }
    });
});

$(document).ready(function () {
    // 등록 
    $(document).on('click', '.btn-show-insert', function () {
        // 입력된 데이터를 가져옴
        var insertData = {
            company: $('#in_company').val(),
            businum: $('#in_busiNum').val(),
            custstyle: $('#in_custStyle').val(),           
            cust_md: $('#in_cust_md').val(),
            ceo: $('#in_ceo').val(),
            busitype: $('#in_busiType').val(),
            busiitems: $('#in_busiItems').val(),
            tel: $('#in_tel').val(),
            email: $('#in_email').val(),
            mem_id: $('#in_mem_id').val(),
        };

        // 서버로 데이터를 전송
        $.ajax({
            url: '/insertCustomer',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(insertData),
            success: function (data) {
                if (data.success) {
                	console.log('거래처 등록 성공');  
                    // 페이지 새로고침
                    location.reload();
                } else {
                    alert('거래처 등록 실패');
                }
            },
            error: function () {
                alert('서버 오류');
            }
        });
    });
});

</script>
<!-----------------검색--------------------------------------------------------->     
		<div class="row mx-3">
		    <div class="col-8 mb-3 d-flex">
		        <div class="col-4">
		            <input class="form-control" id="keyword"  type="search" placeholder="거래처검색" aria-label="Search"  value="${keyword}"/>
		        </div>
		        <div class="col-4">
		            <button class="btn btn-outline-primary" id="searchButton" type="button">검색</button>
		        </div>
		    </div>
		</div>
 
<!-- 검색 결과 표시 -->
<div id="searchResults" class="table-responsive text-nowrap mx-3">
    <!-- 검색 결과가 없을 경우 표시할 메시지 -->
    <p id="noResultsMessage" style="display:none;">검색 결과가 없습니다.</p>
</div>
 
 
<script type="text/javascript">
    $(document).ready(function () {
    	
        // 검색 버튼 클릭 시 페이지 1로 검색 요청
        $("#searchButton").on("click", function () {
            searchWithPage(1);
        });
    	
        function searchWithPage(pageNumber) {
            var keyword = $("#keyword").val();   
            $.ajax({
                type: "GET",
                url: "/customerSearch",
                data: {
                    keyword: keyword,
                    currentPage: pageNumber,
                    mem_dept_md: ${sessionScope.mem_dept_md} 
                },
                success: function (data) {
                    console.log("서버 응답 데이터:", data);
                    var customerSearchList = data.customerSearchList;
                    var paging = data.paging;
                    var mem_dept_md = data.mem_dept_md;
                    

                    // 검색 결과가 없을 경우
                    if (customerSearchList.length === 0) {
                        $("#noResultsMessage").show();
                        $("#searchResultsTable").hide();
                        $("#staticPagination").hide();
                        $(".ajaxPagination").hide();
                    } else {
                        $("#noResultsMessage").hide();

                        // 검색 결과가 있을 경우
                        $("#searchResultsTable tbody").empty();
                        $.each(customerSearchList, function (index, customer) {
                            console.log("customer.mem_dept_md type:", typeof customer.mem_dept_md);
                            console.log("customer.mem_dept_md value:", customer.mem_dept_md);
                            console.log("customer.custcodevalue:", customer.custcode);    
                            var row = "<tr>" +
                                "<td><strong>" + customer.custcode + "</strong></td>" +
                                "<td>" + (customer.cust_md == 101 ? '매입처' : '매출처') + "</td>" +
                                "<td>" + customer.company + "</td>" +
                                "<td>" + customer.ceo + "</td>" +
                                "<td>" + customer.businum + "</td>" +
                                "<td>" + customer.busitype + "</td>" +
                                "<td>" + customer.busiitems + "</td>" +
                                "<td><button class='btn btn-xs btn-primary btn-show-detail' type='button' " +
                                "data-bs-toggle='offcanvas' data-bs-target='#offcanvasScroll' " +
                                "data-custcode='" + customer.custcode + "' aria-controls='offcanvasScroll'>상세</button></td>" +
                                "<td><button class='btn btn-xs btn-primary' type='button' " +
                                "onclick='confirmDelete(\"" + customer.custcode + "\", \"" + customer.mem_dept_md + "\")'" +
                                ((mem_dept_md === 999 || mem_dept_md === 100) ? '' : ' disabled') +
                                ">삭제</button></td>" +
                                "</tr>";
                            $("#searchResultsTable tbody").append(row);
                        });

                        // 검색 결과를 표시& 기존 페이징 숨기기
                        $("#searchResultsTable").show();
                        $("#staticPagination").hide();
                        
                        //아작스페이징 생성
                        updateAjaxPagination(paging);
                        $(".ajaxPagination").show();
                    }
                },
                error: function (error) {
                    console.log("에러:", error);
                }
            });
        }


        // 페이징 처리 업데이트
        function updateAjaxPagination(paging) {
            console.log(paging); 
            $(".ajaxPagination").empty();
            if (paging.totalPage > 0) {
                var paginationList = $("<ul class='pagination pagination-sm justify-content-center'></ul>");
                for (let i = paging.startPage; i <= paging.endPage; i++) {
                    var link = $("<a class='page-link' href='#'></a>").text(i).on("click", (function (page) {
                        return function () {
                            searchWithPage(page);
                        };
                    })(i));
                    var listItem = $("<li class='page-item'></li>").append(link);
                    paginationList.append(listItem);
                }
                $(".ajaxPagination").append(paginationList);
            }
        }



        // 검색창 엔터버튼
        $("#keyword").keypress(function(e){	
            if(e.keyCode && e.keyCode == 13){
                $("#searchButton").trigger("click");
                return false;
            }
        });
        
    });
</script>
 
       
<!-----------------거래처 전체조회--------------------------------------------------------->   
         <div class="table-responsive text-nowrap mx-3">
         <input type="hidden" name="user_num" value="${sessionScope.mem_dept_md}">	
           <c:set var="num" value="${custPage.total - custPage.start+1 }"></c:set> 
             <table id="searchResultsTable"class="table table-hover">
              <thead class="fixed-thead" style="background: #e1e2ff;"> 
                   <tr>
                     <th>거래처코드</th>
                     <th style="width: 100px;">구분</th>
                     <th>상호명</th>
                     <th>대표자</th>
                     <th>사업자번호</th>
                     <th>업태</th>
                     <th>업종</th>
                     <th style="width: 90px;">상세</th>
                     <th style="width: 90px;">삭제</th>
                    </tr>
               </thead>
               <tbody class="table-border-bottom-0" style="font-size: 12px;">
               <c:forEach var="customer" items="${customerList}">
                    <tr>
                      <td><strong>${customer.custcode}</strong></td>
                        <td>${customer.cust_md == 101? '매입처' : '매출처'}</td>
                        <td>${customer.company }</td>
                        <td>${customer.ceo }</td>
                        <td>${customer.businum}</td>
                        <td>${customer.busitype}</td>
                        <td>${customer.busiitems}</td>
                        <td><button class="btn btn-xs  btn-primary btn-show-detail" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasScroll"
                          			data-custcode="${customer.custcode}"  aria-controls="offcanvasScroll">상세 </button></td>                      
                         <td><button class="btn btn-xs btn-primary deleteBtn"  data-mem_dept_md="${sessionScope.mem_dept_md}" type="button" 
                         														onclick="confirmDelete('${customer.custcode}')">삭제</button></td>	 
                      </tr>
                </c:forEach>
                </tbody>
              </table>
              
			<script>
			
			    document.addEventListener('DOMContentLoaded', function() {
			        var mem_dept_md = ${sessionScope.mem_dept_md};
			        console.log('mem_dept_md:', mem_dept_md);
			        disableButton();
			    });
			    /*부서번호 100(회계팀),999(전체권한자)만 삭제 가능  */
			    function disableButton() {
			        var mem_dept_md = ${sessionScope.mem_dept_md};

			        if (mem_dept_md !== 100 && mem_dept_md !== 999) {
			            var buttons = document.querySelectorAll('.deleteBtn');
			            buttons.forEach(function(button) {
			                button.disabled = true;
			            });
			        }
			    }
			</script>
              

<script>
$(document).ready(function () {
	//사원리스트
    $.ajax({
        url: '/memberList',
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify({
        	mem_id: $('#mem_id').val(),
        }),
        success: function (response) {
        	var memberList = response.memberList;
        	var loginMemId= '${sessionScope.mem_id}';
            for (var i = 0; i < memberList.length; i++) {
            	$('#mem_id').append('<option value="' + memberList[i].mem_id + '">' + memberList[i].mem_id + 
            			'  ' + memberList[i].mem_name + ' [' + memberList[i].com_cn + ']</option>');
            }
        },
        error: function () {
            console.error('서버 오류');
        }
    });
});


$(document).on('click', '.btn-show-detail', function () {
    var selectedCustCode = $(this).data('custcode');
	
        $.ajax({
          url: '/customerDetail',
          type: 'GET',
          data: { custcode: selectedCustCode},
          success: function (data) {
            // 받은 데이터
            $('#custCode').val(data.customer.custcode);
            $('#company').val(data.customer.company);
            $('#busiNum').val(data.customer.businum);
            $('#custStyle').val(data.customer.custstyle);
            $('#cust_md').val(data.customer.cust_md);
            $('#ceo').val(data.customer.ceo);
            $('#busiType').val(data.customer.busitype);
            $('#busiItems').val(data.customer.busiitems);
            $('#tel').val(data.customer.tel);
            $('#email').val(data.customer.email);
            $('#mem_id').val(data.customer.mem_id);
            $('#mem_dept').val(data.customer.mem_dept);
            $('#mem_dept_md').val(data.customer.mem_dept_md);
            $('#mem_name').val(data.customer.mem_name);
               
            // 담당직원(mem_id) 설정
            var memId = $('#mem_id');
            memId.val(data.customer.mem_id);
       	    //부서번호(mem_dept_md)999일 경우 항상 활성화, 그 외의 경우는 mem_id가 같을 때만 활성화
            var loggedInMemId = ${sessionScope.mem_id};
            var memDeptMd = ${sessionScope.mem_dept_md};
            console.log('memDeptMd:', memDeptMd);       	 
            memId.prop('disabled', memDeptMd !== 999 && loggedInMemId !== data.customer.mem_id);
        },
        error: function () {
            console.error('Error customer detail.');
        }
    });
});
function confirmDelete(custcode) {
  var result = confirm("삭제하시겠습니까?");
  if (result) {
    location.href = '/deleteCustomer?custcode=' + custcode;
  } 
}
</script>

<!-----------------거래처 상세조회---------------------------------------------------------> 
             <div class="offcanvas offcanvas-end"  data-bs-scroll="true" data-bs-backdrop="false" 
             		tabindex="-1"  id="offcanvasScroll" aria-labelledby="offcanvasScrollLabel" >
                 <div class="offcanvas-header">
                      <h5 id="offcanvasScrollLabel" class="offcanvas-title">거래처조회</h5>
                       <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
                 </div>
                 
              	 <div class="offcanvas-body my-auto mx-0 flex-grow-0 ">           
          		 <div class="row">
                 <div class="col-xxl">
                 <div class="card mb-4">
                    <div class="card-header d-flex align-items-center justify-content-between">
	                      <h5 class="mb-0">싱세정보</h5>
                    </div>
                    
                    <div class="card-body">
                      <form style="width: 350px;">
                        <div class="row mb-3">
                          <label class="col-sm-2 col-form-label" for="custCode">거래처코드 </label>
                          <div class="col-sm-8">
                            <input type="text" class="form-control" id="custCode" readonly="readonly"/>
                          </div>
                        </div>
                        <div class="row mb-3">
                          <label class="col-sm-2 col-form-label" for="company">상호명</label>
                          <div class="col-sm-8">
                            <input type="text" class="form-control" id="company"/>
                          </div>
                        </div>
                        <div class="row mb-3">
                          <label class="col-sm-2 col-form-label" for="busiNum">사업자번호 </label>
                          <div class="col-sm-8">
                            <input type="text" class="form-control" id="busiNum"/>
                          </div>
                        </div>                         
						<div class="row mb-3">
						    <label class="col-sm-2 col-form-label" for="custStyle">유형</label>
						    <div class="col-sm-8">
						        <select class="form-select" id="custStyle">
						            <option value="0">매입</option>
						            <option value="1">매출</option>
						        </select>
						    </div>
						</div>
						<div class="row mb-3">
						    <label class="col-sm-2 col-form-label" for="cust_md">구분</label>
						    <div class="col-sm-8">
						        <select class="form-select" id="cust_md">
						            <option value="101">매입처</option>
						            <option value="102">매출처</option>
						        </select>
						    </div>
						</div>  
                         <div class="row mb-3">
                          <label class="col-sm-2 col-form-label" for="ceo">대표자</label>
                          <div class="col-sm-8">
                            <input type="text" class="form-control" id="ceo"/>
                          </div>
                          </div> 
                        <div class="row mb-3">
                          <label class="col-sm-2 col-form-label" for="busiType">업태</label>
                          <div class="col-sm-8">
                            <input type="text" class="form-control" id="busiType"/>
                          </div>
                         </div>  
                        <div class="row mb-3">
                          <label class="col-sm-2 col-form-label" for="busiItems">종목</label>
                          <div class="col-sm-8">
                            <input type="text" class="form-control" id="busiItems"/>
                          </div>
                         </div>  
                        <div class="row mb-3">
                          <label class="col-sm-2 col-form-label" for="tel">전화번호</label>
                          <div class="col-sm-8">
                            <input type="text" class="form-control" id="tel"/>
                          </div>
                         </div>  
                        <div class="row mb-3">
                          <label class="col-sm-2 col-form-label" for="email">이메일</label>
                          <div class="col-sm-8">
                            <input type="text" class="form-control" id="email"/>
                          </div>                                                                                                                                                                                     
                        </div>
                        <div class="row mb-3">
                          <label class="col-sm-2 col-form-label" for="mem_info">담당직원</label>
                          <div class="col-sm-8">
								<select class="form-select" id="mem_id"></select>
                         </div>                                                                                                                                                                                     
                        </div>                                                   
                      	</form>
                 	  </div>
                  	  </div>
                	  </div>
               	      <button type="button" class="btn btn-primary mb-2 d-grid w-100" id="updateBtn">수정</button>
                     <button type="button" class="btn btn-outline-secondary d-grid w-100" data-bs-dismiss="offcanvas"> 확인 </button>
                   </div>
                 </div>
 				 </div>
 				 
 				 
    <script type="text/javascript">
           $(document).on('click', '#updateBtn', function () {
            	 console.log('Update button clicked');

                // 수정된 데이터
                var updatedData = {
                    custcode: $('#custCode').val(),
                    company: $('#company').val(),
                    businum: $('#busiNum').val(),
                    custstyle: $('#custStyle').val(),
                    cust_md: $('#cust_md').val(),
                    ceo: $('#ceo').val(),
                    busitype: $('#busiType').val(),
                    busiitems: $('#busiItems').val(),
                    tel: $('#tel').val(),
                    email: $('#email').val(),
                    mem_id: $('#mem_id').val(),
	                mem_dept: $('#mem_dept').val(),
	                mem_name: $('#mem_name').val(),
                };

                // 서버전송
                $.ajax({
                    url: '/updateCustomer', 
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify(updatedData),
                    success: function (data) {
                        if (data.success) {
                            console.log('업데이트 성공');   
                            $('#offcanvasScroll').offcanvas('hide');
                            location.reload();
                        } else {
                            console.error('업데이트 실패');
                        }
                    },
                    error: function () {
                        console.error('서버 오류');
                    }
                });
            });                     
                   
	</script>


				<!--검색 결과에 따른 페이징  ------->
				<div class="ajaxPagination container text-center">
					 <ul class="pagination pagination-sm justify-content-center">
					 	 <li class="page-item">
				    	<c:if test="${paging.totalPage > 1}">
				        	<c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="pageNumber">
				            <a href="#" onclick="searchWithPage(${pageNumber})">${pageNumber}</a>
				       	 </c:forEach> 
				 	   </c:if>
				 	   </li> 	  
				 	</ul>   
				</div>

              	<!-- 전체 리스트 페이징 ----------> 
 				<div class=" container text-center" id="staticPagination">
				     <ul class="pagination pagination-sm justify-content-center">
				        <c:if test="${custPage.startPage > custPage.pageBlock}">
				            <li class="page-item">
				                <a class="page-link page-link-arrow" href="customerList?currentPage=${custPage.startPage-custPage.pageBlock}">
				                    <i class="fa fa-caret-left"></i>
				                </a>
				            </li>
				        </c:if>
				
				        <c:forEach var="i" begin="${custPage.startPage}" end="${custPage.endPage}">
				            <li class="page-item <c:if test='${custPage.currentPage == i}'>active</c:if>">
				                <a class="page-link" href="customerList?currentPage=${i}">${i}</a>
				            </li>
				        </c:forEach>
				
				        <c:if test="${custPage.endPage < custPage.totalPage}">
				            <li class="page-item">
				                <a class="page-link page-link-arrow" href="customerList?currentPage=${custPage.startPage+custPage.pageBlock}">
				                    <i class="fa fa-caret-right"></i>
				                </a>
				            </li>
				        </c:if>
				    </ul>
				</div>		             
         
</div>
</div>
</div>
</div>






</body>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>    
</html>