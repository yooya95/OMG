<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
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
				<c:if test="${(mem_id == pc.mem_id || mem_id == pc.mgr_id || mem_id == 1025) && pc.pur_status == 0}">
					<a href="javascript:void(0);" onclick="deletePurDet(${status.index})"><i class='bx bx-x'></i></a>
				</c:if>
			</td>
			<td>${pdList.code }</td>
			<td><fmt:formatNumber value="${pdList.price }" pattern="#,###"/>원</td>
			<td id="td${status.index }" class="text-center">
				${pdList.qty }개
				<c:if test="${pc.pur_status == 0 &&(mem_id == pc.mem_id || mem_id == pc.mgr_id || mem_id == 1025)}">
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