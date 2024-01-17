<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>  
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<tr id="row${rownum }">
	<td><input type="hidden" name="code${rownum }" value="${item.code }" id="chkDupli${rownum }" class="form-control">${item.name }</td>
	<td><input type="number" id="price${rownum }" name="price${rownum }" value="${item.input_price }" onchange="price_cal(${rownum })" class="form-control"></td>
	<td><input type="number" id="qty${rownum }" name="qty${rownum }" value="${qty }" onchange="price_cal(${rownum })" class="form-control"></td>
	<td><span id="totalPrice${rownum }"><fmt:formatNumber value="${item.input_price * qty }" pattern="#,###"/></span>원</td>
	<td><button onclick="cancelItem(${rownum})" class="btn btn-outline-primary">삭제</button></td>
</tr>