<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>        
<!DOCTYPE html>
<html>
<head>
    <style>
        /* 스크롤 테이블 관련 스타일 */
        .table-container {
            overflow-x: auto; /*좌우스크롤  */
            overflow-y: auto; /* 세로 스크롤 추가 */
            max-height: 600px; 
            position: relative; 
        }
        
        #tableBody {
        white-space: nowrap;
        }
 
		 .fixed-tfoot {
		    position: sticky;
		    bottom: 0;
		    background-color: #f8f9fa;
		    z-index: 1;
		    white-space: nowrap;
		
		}

 	   .fixed-thead {
            position: sticky;
            top: 0;
            background-color: #f8f9fa;
            z-index: 1;
             white-space: nowrap;
        }

        /* 추가: THEAD 내 TH에도 백그라운드 색상 지정 */
        .fixed-thead th {
            background-color: #f8f9fa;
             position: sticky;
              background-color:#e1e2ff;
        }
       
    .hidden-row {
        display: none;
    }
    </style>

<meta charset="UTF-8">
<title>거래처별판매실적조회</title>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<%@ include file="/WEB-INF/views/common/menu.jsp"%>    
</head>

    <!-- 스크롤 코드 -->
    <script>
        $(document).ready(function () {
            // 스크롤  고정 thaed 
            $(".table-container").scroll(function () {
                $(".fixed-thead").css("left", -$(".table-container").scrollLeft());
            });
        });
    </script>
    
<body>
<div class="container">
<div class="col-lg">
<div class="card">
 <h5 class="card-header">월별실적조회</h5>
   <div class="row mx-3" >	   
		<div class="col-12 mb-3 d-flex ">	  		   
		    <label for="month">
		    <input class="form-control" type="month" id="monthSelect" name="month">
		    </label>			
				<select class="form-select" id="in_custcode" style="width: 200px; " ></select>
			<button class="btn btn-outline-primary" id="searchButton" type="button" onclick="search()" >검색</button>
		</div>	
    </div>

 <script>
 $(document).ready(function () {
	
	//거래처리스트  조회
    $.ajax({
        url: '/customerListSelect',
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify({
        	custcode: $('#in_custcode').val(),
        }),
        success: function (response) {
        	var customerListSelect = response.customerListSelect;
        	
        	  // "전체" 옵션 추가
            $('#in_custcode').append('<option value="0">전체</option>');
            for (var i = 0; i < customerListSelect.length; i++) {
            	$('#in_custcode').append('<option value="' +  customerListSelect[i].custcode + '">' +  customerListSelect[i].custcode + 
            			'  ' +  customerListSelect[i].company + '</option>');
            }
        },
        error: function () {
            console.error('서버 오류');
        }
    });
});


function search() {
   
	// 선택한 월을 추출
    var selectedMonth = document.getElementById("monthSelect").value;
    var month = selectedMonth ? selectedMonth.split("-")[1] : "0"; 
    var selectedCustcodes = parseInt($('#in_custcode').val());
    console.log("Selected Month:", month);
    console.log("SelectedselectedCustcodes:", selectedCustcodes);
    
    // Ajax 요청
    $.ajax({
        url: '/customerSalesSearch',
        type: 'GET',
        data: {
	            custcode: selectedCustcodes,
	            month:  month,
        },
        success: function (data) {
            var customerSalesSearch = data.customerSalesSearch;

        // 검색결과 
            $("#searchResultsTable tbody").empty();
            $.each(customerSalesSearch, function (index, customer) {
                var row = "<tr>" +
                    "<td>" + customer.month + "</td>" +
                    "<td>" + customer.purDate + "</td>" +
                    "<td>" + (customer.custstyle == 0 ? '매입' : '매출') + "</td>" +
                    "<td>" + customer.custcode + "</td>" +
                    "<td>" + customer.company + "</td>" +
                    "<td>" + customer.businum + "</td>" +
                    "<td>" + customer.purCode + "</td>" +
                    "<td>" + customer.itemName + "</td>" +
                    "<td>" + customer.purQty + "</td>" +
                    "<td style='text-align: right;'>" + customer.purPrice.toLocaleString()  + "</td>" +
                    "<td style='text-align: right;'>" + (customer.custstyle == 0 ? (customer.purQty * customer.purPrice).toLocaleString() : '-') + "</td>" +
                    "<td style='text-align: right;'>" + (customer.custstyle == 1 ? (customer.purQty * customer.purPrice).toLocaleString() : '-') + "</td>" +
                    "</tr>";

                // 월별 소계 행 추가
                if (index === customerSalesSearch.length - 1) {
                    var monthlyPurTotal = 0;
                    var monthlySalesTotal = 0;

                    $.each(customerSalesSearch, function (innerIndex, innerCustomer) {
                        if (innerCustomer.custstyle == 0) {
                            monthlyPurTotal += innerCustomer.purQty * innerCustomer.purPrice;
                        } else if (innerCustomer.custstyle == 1) {
                            monthlySalesTotal += innerCustomer.purQty * innerCustomer.purPrice;
                        }
                    });

                    row += "<tr style='background-color: #f2f2f2;'>" +
                        "<td colspan='6'></td>" +
                        "<th colspan='4'>" +  "소 계</th>" +
                        "<th style='text-align: right;'>" + formatAmount(monthlyPurTotal) + "</th>" +
                        "<th style='text-align: right;'>" + formatAmount(monthlySalesTotal) + "</th>" +
                        "</tr>";
                }

                $("#searchResultsTable tbody").append(row);
            });
        },
        error: function () {
            console.error('서버 오류');
        }
    });
}

//0일경우 '-' 표기
function formatAmount(amount) {
    return amount !== 0 ? amount.toLocaleString() : '-';
}
</script>
  
    		
  <div class="table-responsive text-nowrap mx-3 ">
  <div class="table-container">
           <table id="searchResultsTable" class=" table table-hover">
           <thead class="fixed-thead"> 
                   <tr>
                     <th style="width: 60.508px;">월</th>
                     <th style="width: 119.508px;">거래일자</th> 
                     <th style="width: 100px;">유형</th>
                     <th style="width: 119.508px;">거래처코드</th>
                     <th style="width: 300px;" >거래처명</th>
                     <th style="width: 119.508px;">사업자번호</th>
                    
                     <th  style="width: 119.508px;">제품코드</th>
                     <th style="width: 300px;">제품</th>
                     <th style="width: 119.508px;">수량</th>
                     <th style="width: 119.508px;">단가</th>
                     <th style="width: 119.508px;">매입액</th>
                     <th style="width: 119.508px;">매출액</th>
                    </tr>
               </thead>
               <tbody class="table-border-bottom-0" id="tableBody" style="font-size: 12px;">
             
             
               <!-- 월별 소계 -->
		        <c:set var="currentMonth" value=" " />
		        <c:set var="monthlyPurTotal" value="0" />
		        <c:set var="monthlySalesTotal" value="0" />
			    <c:set var="firstMonth" value="true"/>
		
		   	    <c:forEach var="customer" items="${customerSalesList}" varStatus="loop">
		   	  		<!--customerSalesList의 index가 첫번째 & 월이 달라지는 index -1줄에 소계 부분 생김 -->
			        <c:if test="${loop.index == 0 || !customer.month.equals(customerSalesList[loop.index - 1].month)}">
			        	<!-- 첫 번째 월 소계 행에 hidden-row 클래스 추가 -->
			            <tr class="${firstMonth ? 'hidden-row' : ''}"  style="background-color: #f2f2f2;"> 
			                <td colspan="6"></td>
			                <th colspan="4">${currentMonth}월 소 계</th>
								<c:choose>
								    <c:when test="${monthlyPurTotal != 0}">
								        <th style="text-align: right;"><fmt:formatNumber value="${monthlyPurTotal}" pattern="#,##0" /></th>
								    </c:when>
								    <c:otherwise>
								        <th>-</th>
								    </c:otherwise>
								</c:choose>								
								<c:choose>
								    <c:when test="${monthlySalesTotal != 0}">
								        <th style="text-align: right;"><fmt:formatNumber value="${monthlySalesTotal}" pattern="#,##0" /></th>
								    </c:when>
								    <c:otherwise>
								        <th>-</th>
								    </c:otherwise>
								</c:choose>
	          			  </tr>	   
	          	<!--첫번째 월 소계 부분 숨김-->		  
	            <c:set var="firstMonth" value="false"/>	            
	            <!-- 월이 달라지기 때문에 monthlyPurTotal,monthlySalesTotal 총액을 초기화하고 현재 월 업데이트 -->
	            <c:set var="monthlyPurTotal" value="0" />
	            <c:set var="monthlySalesTotal" value="0"/>
	            <c:set var="currentMonth" value="${customer.month}" />
	       			 </c:if>
      			<!--전체거래처실적조회 -->        
					 <tr>
                     <td>${customer.month}</td>
                     <td>${customer.purDate}</td>
                  	 <td>${customer.custstyle == 0 ? '매입' : '매출'}</td>
                  	 <td>${customer.custcode }</td>
                     <td>${customer.company}</td>
                     <td>${customer.businum }</td>
                     <td>${customer.purCode}</td>
                     <td>${customer.itemName }</td>
                     <td>${customer.purQty}</td>
                     <td style="text-align: right;"><fmt:formatNumber value="${customer.purPrice}" pattern="#,##0" /></td>
			     
			        <!-- customer.custstyle에 따라 총 매입액(0) 또는 총 매출액(1) 표시 -->
			        <td style="text-align: right;">
				        <c:choose>
				            <c:when test="${customer.custstyle == 0}">
				                <fmt:formatNumber value="${customer.purQty * customer.purPrice}" pattern="#,##0" />
				            </c:when>
				            <c:otherwise>-</c:otherwise>
				        </c:choose>
			        </td>
			        <td style="text-align: right;">
				        <c:choose>
				            <c:when test="${customer.custstyle == 1}">
				                <fmt:formatNumber value="${customer.purQty * customer.purPrice}" pattern="#,##0" />
				            </c:when>
				            <c:otherwise>-</c:otherwise>
				        </c:choose>
			        </td>
                    </tr>
              <!--월별 소계 계산부분-->  
              <c:choose>
                <c:when test="${customer.custstyle == 0}">
                    <c:set var="monthlyPurTotal" value="${monthlyPurTotal + (customer.purQty * customer.purPrice)}" />
                </c:when>
                <c:when test="${customer.custstyle == 1}">
                    <c:set var="monthlySalesTotal" value="${monthlySalesTotal + (customer.purQty * customer.purPrice)}" />
                </c:when>
            </c:choose>                        	
			</c:forEach>
		
			<!-- 마지막 월에 대한 소계 행 표시 -->
	        <tr style="background-color: #f2f2f2;">
		        <td colspan="6"></td>
		        <th colspan="4">${currentMonth}월 소 계</th>
					<c:choose>
					    <c:when test="${monthlyPurTotal != 0}">
					        <th style="text-align: right;"><fmt:formatNumber value="${monthlyPurTotal}" pattern="#,##0" /></th>
					    </c:when>
					    <c:otherwise>
					        <th>-</th>
					    </c:otherwise>
					</c:choose>				
					<c:choose>
					    <c:when test="${monthlySalesTotal != 0}">
					        <th style="text-align: right;"><fmt:formatNumber value="${monthlySalesTotal}" pattern="#,##0" /></th>
					    </c:when>
					    <c:otherwise>
					        <th>-</th>
					    </c:otherwise>
					</c:choose>
	        </tr>
    		
                </tbody>
                <tfoot class="fixed-tfoot">			
					<c:set var="totalPurchaseAmount" value="0" />
					<c:set var="totalSalesAmount" value="0" />				
					<c:forEach var="customer" items="${customerSalesList}">
					    <c:choose>
					        <c:when test="${customer.custstyle == 0}">
					            <c:set var="totalPurchaseAmount" value="${totalPurchaseAmount + (customer.purQty * customer.purPrice)}"/>
					        </c:when>
					        <c:when test="${customer.custstyle == 1}">
					            <c:set var="totalSalesAmount" value="${totalSalesAmount + (customer.purQty * customer.purPrice)}" />
					        </c:when>
					    </c:choose>
					</c:forEach>
				    <!-- 누계 행 추가 -->			
					<tr style="background-color: #f2f2f2;">
						<td colspan="6"></td>
						<th colspan="4">누          계</th>
					    <th style="text-align: right;"><fmt:formatNumber value="${totalPurchaseAmount}" pattern="#,##0" /></th>
					    <th style="text-align: right;"><fmt:formatNumber value="${totalSalesAmount}" pattern="#,##0" /></th>
					</tr>
				
        	  </tfoot>
              </table>
              </div>
              
   </div>           
</div>
</div>

</div>

</body>
<%@ include file="/WEB-INF/views/common/footer.jsp"%>  
</html>