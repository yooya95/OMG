<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<h5 class="card-header d-flex justify-content-between align-items-center">
	<strong>공지사항</strong>
</h5>
<div class="table-responsive text-nowrap">
	<table class="table table-hover">
		<thead>
			<tr>
				<th>제목</th>
				<th class="text-end">날짜</th>

			</tr>
		</thead>
		<tbody class="table-border-bottom-0">
			<c:forEach var="notice" items="${noticeList }">
				<tr>
					<td><i class="fab fa-angular fa-lg text-danger me-3"></i><c:out value="${notice.title }"/></td>
					<td class="text-end">
						<c:set var="date" value="${notice.reg_date }" />
						${fn:substring(date,0,10) }
					</td>
				</tr>
			</c:forEach>				
		</tbody>
	</table>
</div>