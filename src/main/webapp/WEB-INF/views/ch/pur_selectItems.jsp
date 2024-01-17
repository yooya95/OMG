<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<div class="d-flex justify-content-between align-items-center">
	<div class="col-5 d-flex justify-content-between align-items-center">
		<div class="col-3">
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
		<div class="col-3">
			수량:
		</div>
		<div class="col-9">
			<input type="number" id="qty" class="form-control">
		</div>
	</div>
	
	<div class="col-2">
		<button type="button" onclick="wirteDetail()" id="insertBtn" class="btn btn-outline-primary">추가</button>
	</div>
</div>

