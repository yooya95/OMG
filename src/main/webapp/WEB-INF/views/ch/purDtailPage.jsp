<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="../common/header.jsp" %>
<%@ include file="../common/menu.jsp" %>
</head>
<body onload="item_chk()">
	<div class="conatiner">
		<div class="row">
			<div class="col-12">
				<h2>발주 상세</h2>
			</div>
			
				<div class="col-12 text-end"><button type="button" onclick="location.href='purList'" class="btn btn-outline-primary">목록</button></div>
			<div class="row">
				<c:if test="${(mem_id == pc.mgr_id || mem_dept_md == 999) && pc.pur_status == 0}">
					<div class="col-2" style="width: 110px;">
						
							<form action="completePur" method="POST">
								<input type="hidden" name="pur_date" value="${pc.pur_date }">
								<input type="hidden" name="custcode" value="${pc.custcode }">
								<input type="hidden" name="mgr_id" value="${pc.mgr_id}">
								<input type="submit" class="btn btn-outline-primary" value="발주 완료">
							</form>
						
					</div>
				</c:if>
				<div class="col-2">
				<c:if test="${(pc.pur_status == 0 &&(mem_id == pc.mem_id || mem_id == pc.mgr_id)) || mem_dept_md == 999}">
					<form action="deletePur" method="POST">
						<input type="hidden" name="pur_date" value="${pc.pur_date }">
						<input type="hidden" name="custcode" value="${pc.custcode }">
						<input type="hidden" name="mgr_id" value="${pc.mgr_id}">
						<input type="submit" class="btn btn-outline-primary" value="발주 취소">
					</form>
				</c:if>
				</div>
			</div>
			
			
			
			<div class="text-center"><h3>정보</h3></div>
			<div class="col-12">
				<div class="row text-center bg-white">
					<table class="table">
						<tr>
							<td class="table-primary">제목</td><td><input type="text" id="title" value="${pc.title}" class="form-control" disabled="disabled"></td>
							<td class="table-primary">상태</td>
							<td>
								 <c:choose>
									<c:when test="${pc.pur_status == 0}">진행중</c:when>
									<c:when test="${pc.pur_status == 1}">완료</c:when>
									<c:when test="${pc.pur_status == 2}">입고완료</c:when>
								</c:choose>
							</td>
						</tr>
						<tr>
							<td class="table-primary">날짜</td><td>${pc.pur_date }</td>
							<td class="table-primary">회사명</td><td>${pc.company }</td>
						</tr>
						<tr>
							<td class="table-primary">발주자</td><td>${pc.appli_name }(${pc.mem_id })</td>
							<td class="table-primary">담당자</td><td> ${pc.mgr_name } (${pc.mgr_id })</td>
						</tr>
						<tr>
							<td colspan="4">비고 </td>
						</tr>
						<tr>
							<td colspan="4">
								<div class="row justify-content-center">
									<div class="col-12"><textarea rows="10" cols="100" class="form-control" disabled="disabled" id="ref">${pc.ref }</textarea></div>
								</div>
							</td>
						</tr>
					</table>
					<c:if test="${pc.pur_status == 0 &&(mem_id == pc.mem_id || mem_id == pc.mgr_id || mem_dept_md == 999)}">
						<div class="col-12">
							<div>
								<button type="button" class="btn btn-outline-primary" onclick="refUpdateBtn()" id="updateBtn">수정</button>
								<button type="button" class="btn btn-outline-primary" id="updateStart" style="display: none;" onclick="refUpStart()">수정완료</button>
							</div>
						</div>
					</c:if>
				</div>
			</div>
			
			<hr>
			
			<div class="text-center"><h3>발주 상품</h3></div>
			<div class="col-12 d-flex justify-content-between align-items-center">
				<input type="hidden" id="pur_date" value="${pc.pur_date }">
				<input type="hidden" id="custcode" value="${pc.custcode}">
				<c:if test="${(mem_id == pc.mem_id || mem_id == pc.mgr_id || mem_dept_md == 999) && pc.pur_status == 0}">
					<input type="hidden" id="pur_date" value="${pc.pur_date }">
					<div class="col-5 d-flex justify-content-between align-items-center">
						<div class="col-3 text-end">
							제품:	
						</div>
						<div class="col-9">
							<select id="code" onchange="item_chk()" class="form-select">
								<c:forEach items="${itemList }" var="itemList">
									<option value="${itemList.code }">${itemList.name }</option>
								</c:forEach>
							</select>
						</div>
					</div>
					<div class="col-5 d-flex justify-content-between align-items-center">
						<div class="col-3 text-end">
							수량:
						</div>
						<div class="col-9">
							<input type="number" id="qty" class="form-control">
						</div>
					</div>
					<div class="col-2 m-2">
						<button type="button" onclick="inSertDetail()" id="insertBtn" class="btn btn-outline-primary">추가</button>
					</div>
				</c:if>
			</div>
			
			<div class="col-12" id="d_tble">
				<table class="table">
					<thead>
						<tr>
							<td>제품명</td>
							<td>제품코드</td>
							<td>단가</td>
							<td class="text-center">수량 </td>
							<td class="text-end">공급가액</td>
						</tr>
					</thead>
					<c:forEach items="${pdList }" var="pdList" varStatus="status">
						<tr id="row${status.index }">
							<td>
								${pdList.item_name }
								<c:if test="${(mem_id == pc.mem_id || mem_id == pc.mgr_id || mem_dept_md == 999) && pc.pur_status == 0}">
									<a href="javascript:void(0);" onclick="deletePurDet(${status.index})"><i class='bx bx-x'></i></a>
								</c:if>
							</td>
							<td>${pdList.code }</td>
							<td><fmt:formatNumber value="${pdList.price }" pattern="#,###"/>원</td>
							<td id="td${status.index }" class="text-center">
								${pdList.qty }개
								<c:if test="${pc.pur_status == 0 &&(mem_id == pc.mem_id || mem_id == pc.mgr_id || mem_dept_md == 999)}">
									<button type="button" onclick="changeQtyBtn(${status.index})" id="btn${status.index }" class="btn btn-outline-primary">변경</button>
								</c:if>
							</td>
							<td id="inputTd${status.index }" style="display: none;" class="text-center">
									<input type="number" name="qty${status.index }" value="${pdList.qty }" id="qty${status.index }" disabled="disabled">
									<input type="hidden" name="code${status.index }" value="${pdList.code }" id="code${status.index }" disabled="disabled">
									<button type="button" onclick="changeQty(${status.index })" class="btn btn-outline-primary">완료</button>
									<button type="button" onclick="changeQtyBtn(${status.index })" class="btn btn-outline-primary">취소</button>
							</td>
							<td class="text-end"><fmt:formatNumber value="${pdList.price_sum }" pattern="#,###"/>원</td>
						</tr>					
					</c:forEach>
					<tr>
						<td></td>
						<td></td>
						<td>합계</td>
						<td class="text-center">${totalQty }개</td>
						<td class="text-end"><fmt:formatNumber value="${totalPrice }" pattern="#,###"/>원</td>
					</tr>
				</table>
			</div>
			
		</div>
	</div>
<%@ include file="../common/footer.jsp" %>	
<script type="text/javascript">
	function item_chk(){
		var code = $("#code").val();
		var i_date = $("#pur_date").val();
		// 중복검사
		$.ajax({
			data:{code : code, pur_date : i_date},
			url: "chkDItem",
			success: function(data){
				if(data > 0){
					// 추가 버튼 비활성화
					$("#insertBtn").prop("disabled", true);
				} else{
					// 추가 버튼 활성화 
					$("#insertBtn").prop("disabled", false);
				}
			}
			
		});
		
	}
	
	function inSertDetail(){
		var i_qty = $("#qty").val();
		
		if(i_qty <= 0 || i_qty == null){
			alert("수량을 선택하세요.");
		} else {
			var i_code = $("#code").val();
			var i_date = $("#pur_date").val();	
			
			$.ajax({
				type: "POST",
				data: {pur_date :i_date, code : i_code, qty : i_qty},
				url: "insertDetail",
				dataType: "html",
				success:function(data){
					$("#d_tble").html(data);
					$("#qty").val('');
					item_chk();
				}
			
			});
		}
	}
	
	function changeQtyBtn(index){
		if($("#td"+index).css("display") == "none"){
			$("#inputTd"+index).hide();
			$("#qty"+index).prop("disabled", true);
			$("#code"+index).prop("disabled", true);
			$("#td"+index).show();
		} else{
			$("#td"+index).hide();
			$("#inputTd"+index).show();
			$("#qty"+index).prop("disabled", false);
			$("#code"+index).prop("disabled", false);
		}
	}
	
	function changeQty(index){
		var i_date = $("#pur_date").val();
		var i_code = $("#code"+index).val();
		var i_qty = $("#qty"+index).val();
		$.ajax(
			{
				type:"POST",
				data:{pur_date : i_date, code : i_code, qty : i_qty},
				url: "qtyUpdate",
				success:function(data){
					$("#d_tble").html(data);
				}
			}
		);
	}
	
	function refUpdateBtn(){
		if($("#ref").prop("disabled")){
			$("#ref").prop("disabled", false);
			$("#title").prop("disabled", false);
			$("#updateBtn").html("수정취소");
			$("#updateStart").show();
		}else {
			$("#ref").prop("disabled", true);
			$("#title").prop("disabled", true);
			$("#updateBtn").html("수정");
			$("#updateStart").hide();
		}
	}
	
	function refUpStart(){
		var title 	 = $("#title").val();
		var ref 	 = $("#ref").val();
		var pur_date = $("#pur_date").val();
		var custcode = $("#custcode").val();
		$.ajax({
			type:"POST",
			data: {title : title, ref : ref, pur_date : pur_date, custcode : custcode},
			url: "refUpdate",
			success:function(result){
				if(result > 0){
					refUpdateBtn();
				}
			}
		});
	}
	
	function deletePurDet(index){
		var index = index;
		var i_date = $("#pur_date").val();
		var i_code = $("#code"+index).val();
		var custcode = $("#custcode").val();
		$.ajax({
			type:"POST",
			data:{pur_date : i_date, code : i_code},
			url:"deletePurDet",
			success:function(result){
				if(result > 0){
					window.location.href = "purDtail?pur_date=" + i_date + "&custcode=" + custcode;
				} else{
					alert("삭제에 실패했습니다!");
				}
			}
		});
		
	}
</script>	
</body>
</html>