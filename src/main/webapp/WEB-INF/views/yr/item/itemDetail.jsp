<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<script>
	// 삭제 기능은 일단 보류
	/* 
	function deleteItem(p_index) {
		var returnValue = confirm("해당 제품을 삭제하시겠습니까?");
		if(returnValue == true) location.href = "/item/delete?code=" + p_index;
		else 					alert("취소되었습니다");
	 }
	 */
</script>
<h6 class="fw-bold py-3 mb-4">
	<span class="text-muted fw-light">제품명: </span>${i.name }
</h6>
<c:choose>
	<c:when test="${sessionScope.mem_dept_md != 104 && sessionScope.mem_dept_md != 105 && sessionScope.mem_dept_md != 999}">
		<!-- input X (물류팀 제외한 다른 팀 view) -->
		<table class="table table-bordered mb-4 fixedTable">
		
		    <tr>
		      <th class="table-primary fixedCol15">제품코드</th>
		      <td class="fixedCol35">${i.code }</td>
		      <th class="table-primary fixedCol15">거래처</th>
		      <td class="fixedCol35">${i.company }</td>
		    </tr>
		    
		    <tr>
		      <th class="table-primary">카테고리</th>
		      <td>${i.com_cn }</td>
		      <th class="table-primary">등록일</th>
		      <td>${i.reg_date }</td>
		    </tr>
		    
		    <tr>
				<th class="table-primary">판매여부</th>
				
			    <c:choose>
			    	<c:when test="${i.deleted == '1' }">
						<td>판매종료</td>
						<th class="table-primary">판매종료일</th>
						<td>${i.delete_date }</td>
		  			</c:when>
		  	
					<c:otherwise>
						<td colspan="3">정상</td>
		  			</c:otherwise>
		  		</c:choose>
			</tr>
			
		    <tr>
		    	<th class="table-primary">제품명</th>
		      	<td colspan="3">${i.name }</td>
		    </tr>
		    
		    <tr>
		      <th class="table-primary">제품내용</th>
		      <td colspan="3"><c:out value="${i.item_cn }"/></td>    	
		    </tr>
		    
		    <tr>
		      <th class="table-primary">매입가격</th>
		      <fmt:formatNumber value="${i.input_price }" pattern="#,###" var="input_price"/>
		      <td>${input_price }원</td>
		      
		      <th class="table-primary">매출가격</th>
			  <fmt:formatNumber value="${i.output_price }" pattern="#,###" var="output_price"/>
		      <td>${output_price }원</td>
		    </tr>
		</table>
		<!-- / input X (물류팀 제외한 다른 팀 view) -->
	
	</c:when>
	
	<c:otherwise>
		<!-- input O (물류팀 view) -->
		<form method="post" action="/item/update">
			<input type="hidden" name="code" value="${i.code }">
			<table class="table table-bordered mb-4 fixedTable">
			    <tr>
			      <th class="table-primary fixedCol15">제품코드</th>
			      <td class="fixedCol35">${i.code }</td>
			      <th class="table-primary fixedCol15">거래처</th>
			      <td class="fixedCol35">
			      	<select class="form-select" name="custcode">
		              <option selected value="${i.custcode }">${i.company }</option>
		              <c:forEach items="${cs }" var="cs">
			              <option value="${cs.custcode }">${cs.company }</option>              
		              </c:forEach>
		            </select>
			      </td>
			    </tr>
			    
			    <tr>
			      <th class="table-primary">카테고리</th>
			      <td>
			      	<select class="form-select" name="cate_md">
		              <option selected value="${i.cate_md }">${i.com_cn }</option>
			              <c:forEach items="${cm }" var="cm">
				              <option value="${cm.ct_md }">${cm.com_cn }</option>
			              </c:forEach>
		            </select>
			      </td>
			      <th class="table-primary">등록일</th>
			      <td><input type="date" class="form-control" name="reg_date" value="${i.reg_date }"/></td>
			    </tr>
			    
			    <tr>
			    	<th class="table-primary">판매여부</th>
					<td>
						<select class="form-select" name="deleted">
							<c:choose>
								<c:when test="${i.deleted == '0'}">
									<!-- 판매여부 = 정상 -->
									<option selected value="0">정상</option>
									<option value="1">판매종료</option>
								</c:when>
		
								<c:otherwise>
									<!-- 판매여부 = 판매종료 -->
									<option value="0">정상</option>
									<option selected value="1">판매종료</option>
								</c:otherwise>
							</c:choose>
						</select>
					</td>
					<th class="table-primary">판매종료일</th>
			    	<td><input type="date" class="form-control" name="delete_date" value="${i.delete_date }"/></td>
			    </tr>
		
				<tr>
					<th class="table-primary">제품명</th>
					<td colspan="3"><input type="text" class="form-control" value="${i.name }" name="name"></td>
				</tr>
		
				<tr>
					<th class="table-primary">제품내용</th>
					<td colspan="3"><textarea class="form-control" rows="3" name="item_cn"><c:out value="${i.item_cn }"></c:out></textarea></td>
				</tr>
		
				<tr>
					<th class="table-primary">매입가격</th>
					<td><input type="number" class="form-control" value="${i.input_price }" name="input_price" /></td>
		
					<th class="table-primary">매출가격</th>
					<td><input type="number" class="form-control" value="${i.output_price }" name="output_price" /></td>
				</tr>
		
			</table>
			
			<div class="d-flex justify-content-end">
				<%-- <button type="button" onclick="deleteItem(${i.code})" class="btn btn-outline-secondary" style="margin-right: 10px;">삭제</button> --%>
				<button type="submit" class="btn btn-outline-primary">저장</button>
			</div>
		</form>
		<!-- / input O (물류팀 view) -->
	
	</c:otherwise>
</c:choose>

