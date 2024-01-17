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
<body>
	<div class="conatiner">
		<form action="writePurchase" method="POST">
			<div class="row">
				<div class="col-12">
					<h2>발주 작성</h2>
				</div>
				<div class="col-12 text-end"><button type="button" onclick="location.href='purList'" class="btn btn-outline-primary">목록</button></div>
				<input name="rownum" type="hidden" id="rownum" value="0">
				<div class="col-12">
					<div class="row text-center bg-white">
						
						<table class="table">
							<tr>
								<td class="table-primary">제목: </td>
								<td class="text-center"><input type="text" name="title" placeholder="발주전표_YYYYMMDD_회사명" required="required" class="form-control"></td>
								<td class="table-primary">담당자:</td>
								<td><span id="mgr_name"></span></td>
							</tr>
							<tr>
								<td class="table-primary">발주자 : </td>
								<td>${member.mem_name }<input type="hidden" name="mem_id" value="${member.mem_id }"></td>
								<td class="table-primary">회사명:</td>
								<td id="selectCustcode">
									<div class="d-flex justify-content-between">
										<div class="col-8">
											<select id="custcode" class="form-select">
												<c:forEach items="${pur_custList }" var="pur_custList">
													<option value="${pur_custList.custcode }" data-name=${pur_custList.company } data-mgr_name=${pur_custList.mem_name }>${pur_custList.company }</option>
												</c:forEach>
											</select>
										</div>
										<div><button type="button" onclick="saveCustcode()" class="btn btn-outline-primary">확인</button></div>
									</div>
								</td>
								<td id="inputCustCode" style="display: none;">
									회사명:<input type="hidden" id="inputCode" name="custcode" disabled="disabled">
									<span id="company_name"></span>
									<button type="button" onclick="saveCustcode()" class="btn btn-outline-primary">취소</button>
								</td>
							</tr>
							<tr>
								<td colspan="4">비고 </td>
							</tr>
							<tr>
								<td colspan="4"><textarea rows="10" cols="100" name="ref" id="ref" class="form-control"></textarea></td>
							</tr>
						</table>
					</div>
				</div>
				
				<div class="col-12 text-center">
						<span id="selectItems"></span>
				</div>
				
				<div class="col-12" id="d_tble">
					<table class="table">
						<thead>
							<tr>
								<td>제품명</td>
								<td>단가</td>
								<td>수량 </td>
								<td>공급가액</td>
							</tr>
						</thead>
						<tbody id="pur_body">
							
						</tbody>
					</table>
					<div class="col-12 text-end"><input type="submit" id="smtbtn" value="발주완료" class="text-end btn btn-outline-primary" disabled="disabled"></div>
				</div>
				
			</div>
		</form>
	</div>
<%@ include file="../common/footer.jsp" %>
<script type="text/javascript">
	var rownum = 0;
	function chkduplication(data){
		var chkdupli = $('[id^="chkDupli"]'); // id가 chkDupli 인 항목들 선택 
		var values = []; // 위에 선택된 항목들의 값을 담을 배열 
		var result = true; // 성공
		//chkdupli의 값들을 values에 넣는다.
		chkdupli.each(function(){
			values.push($(this).val());
		})
		// 만약 들어온 data값(제품 코드(code))과 values의 값이 같으먼 false
		for(var i in values){
			if(values[i] == data){
				result= false;
			}
		}
		
		return result;
	}
	// 발주서 작성 (발주서Detail Input )
	function wirteDetail(){
		var pur_body = $("#pur_body");
		var code = $("#code").val();
		var qty = $("#qty").val();
		var chk = chkduplication(code);
		if(qty == ""){
			alert("수량을 입력해 주세요");
			$("#qty").focus();
		} else if(chk == true){
			$.ajax({
				data:{code : code, rownum : rownum, qty : qty},
				url: "wirteDetail",
				success: function(data){
					pur_body.append(data);
					rownum +=1;
				}
			});
			$("#rownum").val(rownum);
		} else {
			alert("이미 추가된 제품입니다.");
		}
		
		$("#qty").val("");
		
	}
	function getItems(){
		var custcode = $("#custcode").val();
		$.ajax({
			data:{custcode : custcode},
			url: "getItems",
			success: function(data){
				$("#selectItems").html(data);
			}
		});
	}
	function saveCustcode(){
		var company_name = $("#custcode option:selected").data("name");
		var mgr_name = $("#custcode option:selected").data("mgr_name");
		var custcode = $("#custcode").val();
		if($("#inputCustCode").css("display") == "none"){
			$("#inputCustCode").show();
			$("#inputCode").prop("disabled",false);
			$("#inputCode").val(custcode);
			$("#company_name").html(company_name);
			$("#mgr_name").html(mgr_name);
			$("#selectCustcode").hide();
			$("#smtbtn").prop("disabled",false);
			getItems();
		}else{
			$("#inputCustCode").hide();
			$("#inputCode").prop("disabled",true);
			$("#selectCustcode").show();
			$("#mgr_name").empty();
			$("#pur_body").empty();
			$("#smtbtn").prop("disabled",true);
			$("#selectItems").empty();
		}
		
	}
	
	function cancelItem(data){
		$("#row"+data).remove();
	}
	
	function price_cal(rownum){
		var price = $("#price"+rownum).val();
		var qty   = $("#qty"+rownum).val();
		price = parseFloat(price);
		qty = parseFloat(qty);
		
		var totalPrice = new Intl.NumberFormat('en-US').format(price * qty);
		$("#totalPrice"+rownum).html(totalPrice);
	}
</script>
</body>
</html>